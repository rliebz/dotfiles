" Vim Color File
" Name:       dots.vim
" Version:    1.0
" Maintainer: https://github.com/rliebz
" License:    The MIT License (MIT)
" Based On:   https://github.com/joshdick/onedark.vim/

" +----------------+
" | Initialization |
" +----------------+

set background=dark

highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name='dots'

" Set to "256" for 256-color terminals, or
" set to "16" to use your terminal emulator's native colors
if !exists('g:dots_termcolors')
  let g:dots_termcolors = 256
endif

" Not all terminals support italics properly. If yours does, opt-in.
if !exists('g:dots_terminal_italics')
  let g:dots_terminal_italics = 0
endif

" This function was borrowed from FlatColor: https://github.com/MaxSt/FlatColor/
" It was based on one found in hemisu: https://github.com/noahfrederick/vim-hemisu/
function! s:h(group, style)
  if g:dots_terminal_italics ==# 0 && has_key(a:style, 'cterm') && a:style['cterm'] ==# 'italic'
    unlet a:style.cterm
  endif
  if g:dots_termcolors == 16
    let l:ctermfg = (has_key(a:style, 'fg') ? a:style.fg.cterm16 : 'NONE')
    let l:ctermbg = (has_key(a:style, 'bg') ? a:style.bg.cterm16 : 'NONE')
  else
    let l:ctermfg = (has_key(a:style, 'fg') ? a:style.fg.cterm : 'NONE')
    let l:ctermbg = (has_key(a:style, 'bg') ? a:style.bg.cterm : 'NONE')
  end
  execute 'highlight' a:group
    \ 'guifg='   (has_key(a:style, 'fg')    ? a:style.fg.gui   : 'NONE')
    \ 'guibg='   (has_key(a:style, 'bg')    ? a:style.bg.gui   : 'NONE')
    \ 'guisp='   (has_key(a:style, 'sp')    ? a:style.sp.gui   : 'NONE')
    \ 'gui='     (has_key(a:style, 'gui')   ? a:style.gui      : 'NONE')
    \ 'ctermfg=' . l:ctermfg
    \ 'ctermbg=' . l:ctermbg
    \ 'cterm='   (has_key(a:style, 'cterm') ? a:style.cterm    : 'NONE')
endfunction

" +-----------------+
" | Color Variables |
" +-----------------+

let s:red           = { 'gui': '#C00C03', 'cterm': '1', 'cterm16': '1' }
let s:dark_red      = { 'gui': '#7D0701', 'cterm': '9', 'cterm16': '9' }

let s:green         = { 'gui': '#63A60A', 'cterm': '2', 'cterm16': '2' }
let s:dark_green    = { 'gui': '#355A05', 'cterm': '10', 'cterm16': '10' }

let s:yellow        = { 'gui': '#DEA000', 'cterm': '3', 'cterm16': '3' }
let s:dark_yellow   = { 'gui': '#A07300', 'cterm': '11', 'cterm16': '11' }

let s:blue          = { 'gui': '#A663FF', 'cterm': '4', 'cterm16': '4' }
let s:dark_blue     = { 'gui': '#4B2C73', 'cterm': '12', 'cterm16': '12' }

let s:magenta       = { 'gui': '#DD187A', 'cterm': '5', 'cterm16': '5' }
let s:dark_magenta  = { 'gui': '#760D41', 'cterm': '13', 'cterm16': '13' }

let s:cyan          = { 'gui': '#00ADD6', 'cterm': '6', 'cterm16': '6' }
let s:dark_cyan     = { 'gui': '#00566A', 'cterm': '14', 'cterm16': '14' }

let s:white         = { 'gui': '#B1CDD0', 'cterm': '7', 'cterm16': '7' }
let s:dark_white    = { 'gui': '#515D5F', 'cterm': '15', 'cterm16': '15' }

let s:black         = { 'gui': '#001014', 'cterm': '0', 'cterm16': '0' }
let s:bright_black  = { 'gui': '#002B36', 'cterm': '8', 'cterm16': '8' }

" Comments
let s:comment_grey      = s:dark_white

" Whitespace characters
let s:special_grey      = s:bright_black

" Gutter on left of screen and vertical dividers
let s:gutter_fg         = s:dark_cyan
let s:gutter_bg         = s:bright_black
let s:vertsplit         = s:dark_cyan

" Visual highlighting
let s:visual_bg         = s:dark_green
let s:search_bg         = s:dark_cyan
let s:search_fg         = s:yellow

" +---------------------------------------------------------+
" | Syntax Groups (descriptions and ordering from `:h w18`) |
" +---------------------------------------------------------+

call s:h('Comment',     { 'fg': s:comment_grey, 'gui': 'italic', 'cterm': 'italic' }) " any comment

call s:h('Constant',    { 'fg': s:cyan }) " any constant
call s:h('String',      { 'fg': s:green }) " a string constant: 'this is a string'
call s:h('Character',   { 'fg': s:dark_magenta }) " a character constant: 'c', '\n'
call s:h('Number',      { 'fg': s:yellow }) " a number constant: 234, 0xff
call s:h('Boolean',     { 'fg': s:cyan, 'gui': 'italic', 'cterm': 'italic' }) " a boolean constant: TRUE, false
call s:h('Float',       { 'fg': s:yellow }) " a floating point constant: 2.3e10

call s:h('Identifier',  { 'fg': s:cyan }) " any variable name
call s:h('Function',    { 'fg': s:blue }) " function name (also: methods for classes)

call s:h('Statement',   { 'fg': s:magenta }) " any statement
call s:h('Conditional', { 'fg': s:magenta }) " if, then, else, endif, switch, etc.
call s:h('Repeat',      { 'fg': s:magenta }) " for, do, while, etc.
call s:h('Label',       { 'fg': s:magenta }) " case, default, etc.
call s:h('Operator',    { 'fg': s:blue }) " 'sizeof', '+', '*', etc.
call s:h('Keyword',     { 'fg': s:red }) " any other keyword
call s:h('Exception',   { 'fg': s:red }) " try, catch, throw

call s:h('PreProc',     { 'fg': s:yellow }) " generic Preprocessor
call s:h('Include',     { 'fg': s:magenta }) " preprocessor #include
call s:h('Define',      { 'fg': s:magenta }) " preprocessor #define
call s:h('Macro',       { 'fg': s:magenta }) " same as Define
call s:h('PreCondit',   { 'fg': s:yellow }) " preprocessor #if, #else, #endif, etc.

call s:h('Type',        { 'fg': s:yellow }) " int, long, char, etc.
call s:h('StorageClass',{ 'fg': s:yellow }) " static, register, volatile, etc.
call s:h('Structure',   { 'fg': s:yellow }) " struct, union, enum, etc.
call s:h('Typedef',     { 'fg': s:yellow }) " A typedef

call s:h('Special',     { 'fg': s:yellow }) " any special symbol
call s:h('SpecialChar', {}) " special character in a constant
call s:h('Tag',         {}) " you can use CTRL-] on this
call s:h('Delimiter',   {}) " character that needs attention
call s:h('SpecialComment', {}) " special things inside a comment
call s:h('Debug',       {}) " debugging statements

call s:h('Underlined',  {}) " text that stands out, HTML links

call s:h('Ignore',      {}) " left blank, hidden

call s:h('Error',       { 'bg': s:dark_red }) " any erroneous construct

call s:h('Todo',        { 'fg': s:magenta }) " anything that needs extra attention; mostly the keywords TODO FIXME and XXX

" +----------------------------------------------------------------------+
" | Highlighting Groups (descriptions and ordering from `:h hitest.vim`) |
" +----------------------------------------------------------------------+

call s:h('ColorColumn', { 'bg': s:bright_black }) " used for the columns set with 'colorcolumn'
call s:h('Conceal',     {}) " placeholder characters substituted for concealed text (see 'conceallevel')
call s:h('Cursor',      { 'fg': s:black, 'bg': s:blue }) " the character under the cursor
call s:h('CursorIM',    {}) " like Cursor, but used when in IME mode
call s:h('CursorColumn', { 'bg': s:bright_black }) " the screen column that the cursor is in when 'cursorcolumn' is set
call s:h('CursorLine',  { 'bg': s:dark_blue }) " the screen line that the cursor is in when 'cursorline' is set
call s:h('Directory',   {}) " directory names (and other special names in listings)
call s:h('DiffAdd',     { 'fg': s:green }) " diff mode: Added line
call s:h('DiffChange',  { 'fg': s:dark_yellow }) " diff mode: Changed line
call s:h('DiffDelete',  { 'fg': s:red }) " diff mode: Deleted line
call s:h('DiffText',    { 'fg': s:blue }) " diff mode: Changed text within a changed line
call s:h('ErrorMsg',    { 'fg': s:dark_red }) " error messages on the command line
call s:h('VertSplit',   { 'fg': s:vertsplit, 'bg': s:vertsplit }) " the column separating vertically split windows
call s:h('Folded',      {}) " line used for closed folds
call s:h('FoldColumn',  {}) " 'foldcolumn'
call s:h('SignColumn',  {}) " column where signs are displayed
call s:h('IncSearch',   { 'fg': s:search_fg, 'bg': s:search_bg }) " 'incsearch' highlighting; also used for the text replaced with ':s///c'
call s:h('LineNr',      { 'fg': s:gutter_fg, 'bg': s:gutter_bg }) " Line number for ':number' and ':#' commands, and when 'number' or 'relativenumber' option is set.
call s:h('CursorLineNr', { 'fg': s:yellow, 'bg': s:gutter_bg }) " Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
call s:h('MatchParen',  { 'fg': s:yellow, 'bg': s:dark_cyan }) " The character under the cursor or just before it, if it is a paired bracket, and its match.
call s:h('ModeMsg',     {}) " 'showmode' message (e.g., '-- INSERT --')
call s:h('MoreMsg',     {}) " more-prompt
call s:h('NonText',     { 'fg': s:special_grey }) " '~' and '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., '>' displayed when a double-wide character doesn't fit at the end of the line).
call s:h('Normal',      { 'fg': s:white }) " normal text
call s:h('Pmenu',       { 'fg': s:white, 'bg': s:bright_black }) " Popup menu: normal item.
call s:h('PmenuSel',    { 'fg': s:yellow, 'bg': s:dark_cyan }) " Popup menu: selected item.
call s:h('PmenuSbar',   { 'bg': s:dark_cyan }) " Popup menu: scrollbar.
call s:h('PmenuThumb',  { 'bg': s:white }) " Popup menu: Thumb of the scrollbar.
call s:h('Question',    { 'fg': s:magenta }) " hit-enter prompt and yes/no questions
call s:h('Search',      { 'bg': s:search_bg }) " Last search pattern highlighting (see 'hlsearch'). Also used for highlighting the current line in the quickfix window and similar items that need to stand out.
call s:h('SpecialKey',  { 'fg': s:special_grey }) " Meta and special keys listed with ':map', also for text used to show unprintable characters in the text, 'listchars'. Generally: text that is displayed differently from what it really is.
call s:h('SpellBad',    { 'bg': s:dark_red }) " Word that is not recognized by the spellchecker. This will be combined with the highlighting used otherwise.
call s:h('SpellCap',    { 'fg': s:yellow }) " Word that should start with a capital. This will be combined with the highlighting used otherwise.
call s:h('SpellLocal',  { 'fg': s:yellow }) " Word that is recognized by the spellchecker as one that is used in another region. This will be combined with the highlighting used otherwise.
call s:h('SpellRare',   { 'fg': s:yellow }) " Word that is recognized by the spellchecker as one that is hardly ever used. spell This will be combined with the highlighting used otherwise.
call s:h('StatusLine',  { 'fg': s:cyan, 'bg': s:dark_cyan }) " status line of current window
call s:h('StatusLineNC', { 'fg': s:comment_grey, 'bg': s:bright_black }) " status lines of not-current windows Note: if this is equal to 'StatusLine' Vim will use '^^^' in the status line of the current window.
call s:h('TabLine',     { 'fg': s:black, 'bg': s:dark_cyan }) " tab pages line, not active tab page label
call s:h('TabLineFill', { 'fg': s:white, 'bg': s:bright_black }) " tab pages line, where there are no labels
call s:h('TabLineSel',  { 'fg': s:black, 'bg': s:cyan }) " tab pages line, active tab page label
call s:h('Title',       { 'fg': s:red, 'gui': 'bold', 'cterm': 'bold' }) " titles for output from ':set all', ':autocmd' etc.
call s:h('Visual',      { 'bg': s:visual_bg }) " Visual mode selection
call s:h('VisualNOS',   { 'bg': s:visual_bg }) " Visual mode selection when vim is 'Not Owning the Selection'. Only X11 Gui's gui-x11 and xterm-clipboard supports this.
call s:h('WarningMsg',  { 'fg': s:yellow }) " warning messages
call s:h('WildMenu',    { 'fg': s:yellow, 'bg': s:dark_cyan }) " current match in 'wildmenu' completion

" +--------------------------------+
" | Language-Specific Highlighting |
" +--------------------------------+

call s:h('javaScriptBraces',        { 'fg': s:white })
call s:h('javaScriptIdentifier',    { 'fg': s:magenta })
call s:h('javaScriptNull',          { 'fg': s:yellow })
call s:h('javaScriptNumber',        { 'fg': s:yellow })

call s:h('rubyBlockParameterList',  { 'fg': s:red })
call s:h('rubyInterpolation',       { 'fg': s:green })
call s:h('rubyInterpolationDelimiter', { 'fg': s:red })

call s:h('pythonDecorator',         { 'fg': s:yellow, 'gui': 'bold', 'cterm': 'bold' })
call s:h('pythonDottedName',        { 'fg': s:yellow })
call s:h('pythonRawString',         { 'fg': s:yellow })
call s:h('pythonBuiltinFunc',       { 'fg': s:blue })


" +---------------------+
" | Plugin Highlighting |
" +---------------------+

" ALE
call s:h('ALEErrorSign',   {'fg': s:red, 'bg': s:gutter_bg })
call s:h('ALEWarningSign', {'fg': s:yellow, 'bg': s:gutter_bg })

" Signify
hi link SignifySignAdd              LineNr
hi link SignifySignDelete           LineNr
hi link SignifySignChange           LineNr

" GitGutter
call s:h('GitGutterAdd',            { 'fg': s:green, 'bg': s:gutter_bg })
call s:h('GitGutterDelete',         { 'fg': s:red, 'bg': s:gutter_bg })
call s:h('GitGutterChange',         { 'fg': s:yellow, 'bg': s:gutter_bg })
call s:h('GitGutterChangeDelete',   { 'fg': s:red, 'bg': s:gutter_bg })

" FZF
let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'],
      \ }
