# https://github.com/mawww/kakoune/blob/master/doc/pages/commands.asciidoc
# https://github.com/mawww/kakoune/blob/master/doc/pages/expansions.asciidoc
# https://github.com/mawww/kakoune/blob/master/doc/pages/mapping.asciidoc
# https://github.com/mawww/kakoune/blob/master/doc/pages/commands.asciidoc
# TODO: Allow C-u to move cursor up at beginning of page, as it
# can at the end. Basically, assume we have ~~~~ at the *top* and the *bottom*
# add-highlighter global/ number-lines -hlcursor -separator ' '
# https://github.com/mawww/kakoune/commit/b0e12f2bcb5e94fc77c9510e1143a53e1a7473b8
colorscheme kaleidoscope-light

# https://discuss.kakoune.com/t/sublime-text-style-multiple-cursor-select-add-mapping/150
define-command -hidden -docstring \
"select a word under cursor, or add cursor on next occurrence of current selection" \
select-or-add-cursor %{
    try %{
        execute-keys "<a-k>\A.\z<ret>"
        execute-keys -save-regs '' "_<a-i>w*"
    } catch %{
        execute-keys -save-regs '' "_*<s-n>"
    } catch nop
}

map global normal '<s-d>' ': select-or-add-cursor<ret>' -docstring "add cursor on current word, and jump to the next match"

# https://github.com/mawww/kakoune/wiki/Avoid-the-escape-key
hook global InsertChar k %{ try %{
      exec -draft hH <a-k>jk<ret> d
        exec <esc>
}}

hook global KakEnd .* %{ echo -to-file ~/.kak_history -quoting kakoune reg : %reg{:} }
hook global KakBegin .* %{ try %{ source .kak_history } }

set global tabstop 2
set global indentwidth 2

# Plugins
source "%val{config}/plugins/plug.kak/rc/plug.kak"
plug "kak-lsp/kak-lsp" do %{
  cargo install --locked --force --path .
}

# LSP
lsp-enable
set global lsp_cmd "kak-lsp -s %val{session} -vvv --log /tmp/kak-lsp.log"

# <a-e> to go to definition
map global normal <a-e> ': lsp-definition<ret>vv'
# <a-w> and <a-q> for prev and next location
map global normal <a-w> '<c-o>vv'
map global normal <a-s-w> '<tab>vv'

# tab, ctrl-tab, ctrl-w for next, prev, close buffer
map global normal <tab> ': buffer-next<ret>'
map global normal <s-tab> ': buffer-previous<ret>'
map global normal <c-w> ': delete-buffer<ret>'

# Display line numbers in all newly created windows
add-highlighter global/ number-lines

# Minimal set of readline mappings
map -docstring "move the cursor to the start of the line"        global normal <c-a> 'gh'
map -docstring "move the cursor to the end of the line"          global normal <c-e> 'gll'
# map -docstring "delete the character under the anchor"           global normal <c-d> 'c'
#map -docstring "delete from the cursor to the start of the line" global normal <c-u> 'h<a-h>d'
map -docstring "delete from the cursor to the end of the line"   global normal <c-k> '<a-l>d'
map -docstring "delete until the next word boundary"             global normal <a-d> '<esc>ed'
map -docstring "delete until the previous word boundary"         global normal <c-w> 'bd'
map -docstring "paste before the cursor"                         global normal <c-y> 'P'


define-command -hidden oob-clipboard-paste-before %{
    execute-keys ! %sh{
        if command -v xsel >/dev/null; then
            printf 'xsel -ob'
        elif command -v xclip >/dev/null; then
            printf 'xclip -o'
        elif command -v pbcopy >/dev/null; then
            printf 'pbpaste'
        fi
    } <ret>

}
define-command -hidden oob-clipboard-paste-after %{
    execute-keys <a-!> %sh{
        if command -v xsel >/dev/null; then
            printf 'xsel -ob'
        elif command -v xclip >/dev/null; then
            printf 'xclip -o'
        elif command -v pbcopy >/dev/null; then
            printf 'pbpaste'
        fi
    } <ret>

}

map global user y '<a-|>xsel -i -b<ret>'
map global user p '!xsel  -o -p<ret>'

define-command line -params 1 %{
   execute-keys %arg[1] g 
}

# https://discuss.kakoune.com/t/rewrap-text-e-g-after-writing-and-switching-on-autowrap-after-the-fact-or-if-editing-a-paragraph/289https://discuss.kakoune.com/t/rewrap-text-e-g-after-writing-and-switching-on-autowrap-after-the-fact-or-if-editing-a-paragraph/289
map global user = '|fmt --width 80<ret>' -docstring "Wrap to 80 columns"

# 1. Case-insensitive search by default:
# # Just insert "(?i)" when opening the search prompt
map global normal "/" "/(?i)"
#
# # 2. Change to case-sensitive search:
# # Hit <c-u> to delete "(?i)" in the prompt
