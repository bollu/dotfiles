# vim old habits
map global normal D '<a-l>d' -docstring 'delete to end of line'
map global normal Y '<a-l>y' -docstring 'yank to end of line'
map global normal = :format<ret> -docstring 'format buffer'

map global normal '#' :comment-line<ret> -docstring 'comment line'
map global normal '<a-#>' :comment-block<ret> -docstring 'comment block'

map global goto m '<esc>m;' -docstring 'matching char'

# if you press 0 alone, it will echo "foo".
# if you press 0 after a number to express a count, like 10, it will work as usual.
map global normal 0 ':zero "echo foo"<ret>'
define-command zero -params 1 %{ %sh{
  if [ $kak_count = 0 ]; then
    echo "$1"
  else
    echo "exec ${kak_count}0"
  fi
}}

colorscheme solarized-dark
