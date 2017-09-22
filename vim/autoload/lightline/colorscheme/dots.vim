" =============================================================================
" Filename: autoload/lightline/colorscheme/dots.vim
" Author: Robert Liebowitz
" License: MIT License
" =============================================================================
let s:red = [ '#800000', 1 ]
let s:dark_red = [ '#ff0000', 9 ]

let s:green = [ '#008000', 2 ]
let s:dark_green = [ '#00ff00', 10 ]

let s:yellow = [ '#808000', 3 ]
let s:dark_yellow = [ '#ffff00', 11  ]

let s:blue = [ '#000080', 4 ]
let s:dark_blue = [ '#0000ff', 12 ]

let s:magenta = [ '#800080', 5 ]
let s:dark_magenta = [ '#ff00ff', 13 ]

let s:cyan = [ '#008080', 6 ]
let s:dark_cyan = [ '#00ffff', 14 ]

let s:white = [ '#c0c0c0', 7 ]
let s:dark_white = [ '#ffffff', 15 ]

let s:bright_black = [ '#808080', 8 ]
let s:black = [ '#000000', 0 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left = [ [ s:black, s:blue ], [ s:black, s:cyan ] ]
let s:p.insert.left = [ [ s:black, s:yellow ], [ s:black, s:cyan ] ]
let s:p.replace.left = [ [ s:black, s:magenta ], [ s:black, s:cyan ] ]
let s:p.visual.left = [ [ s:black, s:green ], [ s:black, s:cyan ] ]

let s:p.normal.right = [ [ s:black, s:white ], [ s:black, s:cyan ] ]
let s:p.normal.middle = [ [ s:black, s:dark_cyan ] ]
let s:p.inactive.right = [ [ s:black, s:bright_black ], [ s:black, s:bright_black ] ]
let s:p.inactive.left =  [ [ s:black, s:bright_black ], [ s:black, s:bright_black ] ]
let s:p.inactive.middle = [ [ s:black, s:bright_black ] ]
let s:p.tabline.left = [ [ s:white, s:dark_green ] ]
let s:p.tabline.tabsel = [ [ s:white, s:black ] ]
let s:p.tabline.middle = [ [ s:dark_green, s:white ] ]
let s:p.tabline.right = copy(s:p.normal.right)
let s:p.normal.error = [ [ s:white, s:red ] ]
let s:p.normal.warning = [ [ s:black, s:yellow ] ]

let g:lightline#colorscheme#dots#palette = lightline#colorscheme#flatten(s:p)
