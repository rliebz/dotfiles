" =============================================================================
" Filename: autoload/lightline/colorscheme/dots.vim
" Author: Robert Liebowitz
" License: MIT License
" =============================================================================
let s:black = [ '#000000', 0 ]
let s:bright_black = [ '#00212a', 8 ]

let s:red = [ '#f72c09', 1 ]
let s:dark_red = [ '#cd6200', 9 ]

let s:green = [ '#92e009', 2 ]
let s:dark_green = [ '#355a05', 10 ]

let s:yellow = [ '#ffb702', 3 ]
let s:dark_yellow = [ '#b08500', 11  ]

let s:blue = [ '#8a60ff', 4 ]
let s:dark_blue = [ '#231944', 12 ]

let s:magenta = [ '#ff57fe', 5 ]
let s:dark_magenta = [ '#892f89', 13 ]

let s:cyan = [ '#00bee2', 6 ]
let s:dark_cyan = [ '#007992', 14 ]

let s:white = [ '#dbf8ff', 7 ]
let s:dark_white = [ '#91a6ab', 15 ]

let s:p = {
      \ 'normal': {},
      \ 'inactive': {},
      \ 'insert': {},
      \ 'replace': {},
      \ 'visual': {},
      \ 'tabline': {},
      \ }

let s:p.normal.left = [ [ s:black, s:blue ], [ s:black, s:cyan ] ]
let s:p.insert.left = [ [ s:black, s:yellow ], [ s:black, s:cyan ] ]
let s:p.replace.left = [ [ s:black, s:magenta ], [ s:black, s:cyan ] ]
let s:p.visual.left = [ [ s:black, s:green ], [ s:black, s:cyan ] ]
let s:p.normal.right = [ [ s:black, s:white ], [ s:black, s:cyan ] ]
let s:p.normal.middle = [ [ s:black, s:dark_cyan ] ]

let s:p.inactive.right = [ [ s:dark_cyan, s:bright_black ], [ s:dark_cyan, s:bright_black ] ]
let s:p.inactive.left =  [ [ s:dark_cyan, s:bright_black ], [ s:dark_cyan, s:bright_black ] ]
let s:p.inactive.middle = [ [ s:dark_cyan, s:bright_black ] ]

let s:p.tabline.left = [ [ s:black, s:dark_cyan ] ]
let s:p.tabline.tabsel = [ [ s:black, s:cyan ] ]
let s:p.tabline.middle = [ [ s:black, s:bright_black ] ]
let s:p.tabline.right = [ [ s:black, s:dark_cyan ] ]

let s:p.normal.error = [ [ s:white, s:red ] ]
let s:p.normal.warning = [ [ s:black, s:yellow ] ]

let g:lightline#colorscheme#dots#palette = lightline#colorscheme#flatten(s:p)
