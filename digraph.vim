"stolen from https://github.com/orac/vimrc/blob/master/digraphs.vim
" Contains digraphs and abbreviations for characters I often want to use.

" general punctuation
digraph `` 8220 " “ 66's
digraph '' 8221 " ” 99's
digraph `' 8216 " ‘ 6
digraph '` 8217 " ’ 9
digraph .. 8230 " … horiz ellipsis, RFC 1345 specifies ‥ two-dot leader instead

digraph ^+ 8314 " ⁺ superscript +
digraph ^- 8315 " ⁻ superscript -
digraph ^= 8316 " ⁼ superscript =
digraph ^n 8319 " ⁿ superscript n
digraph _x 8339 " ₓ subscript x



digraph EU 8364 " € Euro sign
digraph -^ 8593 " ↑ upwards arrow, RFC 1345 also specifies <- -> -v for similar arrows

" the following tall character digraphs are inspired by RFC1345 Iu and Il for
" upper- and lower-half integral sign ⌠ ⌡
digraph Im 9134 " ⎮ integral extension
digraph (u 9115 " ⎛ left paren upper hook
digraph (m 9116 " ⎜ left paren extension
digraph (l 9117 " ⎝ left paren lower hook
digraph )u 9118 " ⎞ right paren upper hook
digraph )m 9119 " ⎟ right paren extension
digraph )l 9120 " ⎠ right paren lower hook
digraph [u 9121 " ⎡ left square bracket upper corner
digraph [m 9122 " ⎢ left square bracket extension
digraph [l 9123 " ⎣ left square bracket lower corner
digraph ]u 9124 " ⎤ right square bracket upper corner
digraph ]m 9125 " ⎥ right square bracket extension
digraph ]l 9126 " ⎦ right square bracket lower corner
digraph {u 9127 " ⎧ left curly bracket upper hook
digraph {m 9128 " ⎨ left curly bracket middle piece
digraph {l 9129 " ⎩ left curly bracket lower hook
digraph }u 9127 " ⎫ left curly bracket upper hook
digraph }m 9128 " ⎬ left curly bracket middle piece
digraph }l 9129 " ⎭ left curly bracket lower hook
digraph {} 9136 " ⎰ upper left or lower right curly bracket section
digraph }{ 9137 " ⎱ upper right or lower left curly bracket section


" logical symbols: arrows and turnstiles
digraph := 8788 " ≔ colon equals
ia ::= ⩴
ia -/-> ↛
ia =/=> ⇏
ia \|> ↦
ia \|- ⊢
ia -\| ⊣
ia \|= ⊨
ia \|\|- ⊩
ia \|\|\|- ⊪
ia \|\|= ⊫
ia \|/- ⊬
ia \|/= ⊭
ia \|\|/- ⊮
ia \|\|/= ⊯


" you can never have too many types of brackets
digraph [- 8261 " ⁅ bracket with quill
digraph -] 8262 " ⁆ closing bracket with quill
digraph [[ 12314 " 〚 semantic (double) bracket
digraph ]] 12315 " 〛 closing semantic bracket

" add abbrs corresponding to some RFC1345 n-graphs
" paren'ed number
ia `(1) ⑴
ia `(2) ⑵
ia `(3) ⑶
ia `(4) ⑷
ia `(5) ⑸
ia `(6) ⑹
ia `(7) ⑺
ia `(8) ⑻
ia `(9) ⑼
ia `(10) ⑽
ia `(11) ⑾
ia `(12) ⑿
ia `(13) ⒀
ia `(14) ⒁
ia `(15) ⒂
ia `(16) ⒃
ia `(17) ⒄
ia `(18) ⒅
ia `(19) ⒆
ia `(20) ⒇
" number full stop
ia `1. ⒈
ia `2. ⒉
ia `3. ⒊
ia `4. ⒋
ia `5. ⒌
ia `6. ⒍
ia `7. ⒎
ia `8. ⒏
ia `9. ⒐
ia `10. ⒑
ia `11. ⒒
ia `12. ⒓
ia `13. ⒔
ia `14. ⒕
ia `15. ⒖
ia `16. ⒗
ia `17. ⒘
ia `18. ⒙
ia `19. ⒚
ia `20. ⒛


digraph a) 9372 " ⒜ paren'd Latin a
digraph b) 9373
digraph c) 9374
digraph d) 9375
digraph e) 9376
digraph f) 9377
digraph g) 9378
digraph h) 9379
digraph i) 9380
digraph j) 9381
digraph k) 9382
digraph l) 9383
digraph m) 9384
digraph n) 9385
digraph o) 9386
digraph p) 9387
digraph q) 9388
digraph r) 9389
digraph s) 9390
digraph t) 9391
" no u because RFC 1345 has u) being ŭ, and )u is ⎞ from above
digraph v) 9393
digraph w) 9394
digraph x) 9395
digraph y) 9396
digraph z) 9397

