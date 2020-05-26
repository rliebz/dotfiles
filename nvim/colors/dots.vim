set background=dark
highlight clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name='dots'

function! s:h(group, style)
  if get(g:, 'dots_terminal_italics', 1) ==# 0 && get(a:style, 'cterm') ==# 'italic'
    unlet a:style.cterm
  endif
  execute 'highlight' a:group
    \ 'guifg='   (has_key(a:style, 'fg')    ? a:style.fg.gui   : 'NONE')
    \ 'guibg='   (has_key(a:style, 'bg')    ? a:style.bg.gui   : 'NONE')
    \ 'guisp='   (has_key(a:style, 'sp')    ? a:style.sp.gui   : 'NONE')
    \ 'gui='     (has_key(a:style, 'gui')   ? a:style.gui      : 'NONE')
    \ 'ctermfg=' (has_key(a:style, 'fg')    ? a:style.fg.cterm : 'NONE')
    \ 'ctermbg=' (has_key(a:style, 'bg')    ? a:style.bg.cterm : 'NONE')
    \ 'cterm='   (has_key(a:style, 'cterm') ? a:style.cterm    : 'NONE')
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Color Variables
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:black         = { 'gui': '#000000', 'cterm': '0' }
let s:bright_black  = { 'gui': '#00313a', 'cterm': '8' }

let s:red           = { 'gui': '#f72c09', 'cterm': '1' }
let s:dark_red      = { 'gui': '#cd6200', 'cterm': '9' }

let s:green         = { 'gui': '#92e009', 'cterm': '2' }
let s:dark_green    = { 'gui': '#355a05', 'cterm': '10' }

let s:yellow        = { 'gui': '#ffb702', 'cterm': '3' }
let s:dark_yellow   = { 'gui': '#b08500', 'cterm': '11' }

let s:blue          = { 'gui': '#8a60ff', 'cterm': '4' }
let s:dark_blue     = { 'gui': '#231944', 'cterm': '12' }

let s:magenta       = { 'gui': '#ff57fe', 'cterm': '5' }
let s:dark_magenta  = { 'gui': '#892f89', 'cterm': '13' }

let s:cyan          = { 'gui': '#00bee2', 'cterm': '6' }
let s:dark_cyan     = { 'gui': '#007992', 'cterm': '14' }

let s:white         = { 'gui': '#dbf8ff', 'cterm': '7' }
let s:dark_white    = { 'gui': '#91a6ab', 'cterm': '15' }

" Related colors
let s:special_grey  = s:bright_black
let s:gutter_fg     = s:dark_cyan
let s:gutter_bg     = s:bright_black
let s:visual_bg     = s:dark_green


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntax Groups (:h group-name)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call s:h('Comment',     { 'fg': s:dark_white, 'gui': 'italic', 'cterm': 'italic' })

call s:h('Constant',    { 'fg': s:cyan })
call s:h('String',      { 'fg': s:green })
call s:h('Character',   { 'fg': s:dark_magenta })
call s:h('Number',      { 'fg': s:yellow })
call s:h('Boolean',     { 'fg': s:cyan, 'gui': 'italic', 'cterm': 'italic' })
call s:h('Float',       { 'fg': s:yellow })

call s:h('Identifier',  { 'fg': s:cyan })
call s:h('Function',    { 'fg': s:blue })

call s:h('Statement',   { 'fg': s:magenta })
call s:h('Conditional', { 'fg': s:magenta })
call s:h('Repeat',      { 'fg': s:magenta })
call s:h('Label',       { 'fg': s:magenta })
call s:h('Operator',    { 'fg': s:blue })
call s:h('Keyword',     { 'fg': s:dark_red })
call s:h('Exception',   { 'fg': s:dark_red })

call s:h('PreProc',     { 'fg': s:yellow })
call s:h('Include',     { 'fg': s:magenta })
call s:h('Define',      { 'fg': s:magenta })
call s:h('Macro',       { 'fg': s:magenta })
call s:h('PreCondit',   { 'fg': s:yellow })

call s:h('Type',        { 'fg': s:yellow })
call s:h('StorageClass',{ 'fg': s:yellow })
call s:h('Structure',   { 'fg': s:yellow })
call s:h('Typedef',     { 'fg': s:yellow })

call s:h('Special',     { 'fg': s:yellow })
call s:h('SpecialChar', {})
call s:h('Tag',         {})
call s:h('Delimiter',   {})
call s:h('SpecialComment', {})
call s:h('Debug',       {})

call s:h('Underlined',  {})

call s:h('Ignore',      {})

call s:h('Error',       { 'sp': s:red, 'gui': 'undercurl', 'cterm': 'undercurl' })

call s:h('Todo',        { 'fg': s:magenta })


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Highlight Groups (:h highlight-groups)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call s:h('ColorColumn', { 'bg': s:dark_blue })
call s:h('Conceal',     {})
call s:h('Cursor',      { 'fg': s:black, 'bg': s:blue })
call s:h('CursorIM',    {})
call s:h('CursorColumn', { 'bg': s:bright_black })
call s:h('CursorLine',  { 'bg': s:dark_blue })
call s:h('Directory',   {})
call s:h('DiffAdd',     { 'fg': s:green })
call s:h('DiffChange',  { 'fg': s:dark_yellow })
call s:h('DiffDelete',  { 'fg': s:red })
call s:h('DiffText',    { 'fg': s:blue })
call s:h('ErrorMsg',    { 'fg': s:red })
call s:h('VertSplit',   { 'fg': s:dark_cyan, 'bg': s:dark_cyan })
call s:h('Folded',      { 'fg': s:gutter_fg, 'bg': s:gutter_bg })
call s:h('FoldColumn',  {})
call s:h('SignColumn',  { 'bg': s:gutter_bg })
call s:h('IncSearch',   { 'fg': s:yellow, 'bg': s:dark_cyan })
call s:h('LineNr',      { 'fg': s:gutter_fg, 'bg': s:gutter_bg })
call s:h('CursorLineNr', { 'fg': s:yellow, 'bg': s:gutter_bg })
call s:h('MatchParen',  { 'fg': s:yellow, 'bg': s:dark_cyan })
call s:h('ModeMsg',     {})
call s:h('MoreMsg',     {})
call s:h('NonText',     { 'fg': s:special_grey })
call s:h('Normal',      { 'fg': s:white })
call s:h('Pmenu',       { 'fg': s:white, 'bg': s:bright_black })
call s:h('PmenuSel',    { 'fg': s:yellow, 'bg': s:dark_cyan })
call s:h('PmenuSbar',   { 'bg': s:dark_cyan })
call s:h('PmenuThumb',  { 'bg': s:white })
call s:h('Question',    { 'fg': s:magenta })
call s:h('Search',      { 'bg': s:dark_cyan })
call s:h('SpecialKey',  { 'fg': s:special_grey })
call s:h('SpellBad',    { 'sp': s:red, 'gui': 'undercurl', 'cterm': 'undercurl' })
call s:h('SpellCap',    { 'sp': s:yellow, 'gui': 'undercurl', 'cterm': 'undercurl' })
call s:h('SpellLocal',  { 'sp': s:yellow, 'gui': 'undercurl', 'cterm': 'undercurl' })
call s:h('SpellRare',   { 'sp': s:yellow, 'gui': 'undercurl', 'cterm': 'undercurl' })
call s:h('StatusLine',  { 'fg': s:cyan, 'bg': s:dark_cyan })
call s:h('StatusLineNC', { 'fg': s:dark_white, 'bg': s:bright_black })
call s:h('TabLine',     { 'fg': s:black, 'bg': s:dark_cyan })
call s:h('TabLineFill', { 'fg': s:white, 'bg': s:bright_black })
call s:h('TabLineSel',  { 'fg': s:black, 'bg': s:cyan })
call s:h('Title',       { 'fg': s:dark_red, 'gui': 'bold', 'cterm': 'bold' })
call s:h('Visual',      { 'bg': s:visual_bg })
call s:h('VisualNOS',   { 'bg': s:visual_bg })
call s:h('WarningMsg',  { 'fg': s:yellow })
call s:h('WildMenu',    { 'fg': s:yellow, 'bg': s:dark_cyan })


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Language-Specific Highlighting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

hi link jsonKeyword Identifier
call s:h('jsonCommentError',        {
      \ 'fg': s:dark_white, 'sp': s:yellow, 'gui': 'undercurl', 'cterm': 'undercurl'
      \ })

call s:h('pythonDecorator',         { 'fg': s:yellow, 'gui': 'bold', 'cterm': 'bold' })
call s:h('pythonDottedName',        { 'fg': s:yellow })
call s:h('pythonRawString',         { 'fg': s:yellow })
call s:h('pythonBuiltinFunc',       { 'fg': s:blue })

call s:h('rubyBlockParameterList',     { 'fg': s:dark_red })
call s:h('rubyInterpolation',          { 'fg': s:green })
call s:h('rubyInterpolationDelimiter', { 'fg': s:dark_red })


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Custom Highlight Groups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" For drawing borders around floating windows
call s:h('FloatBorder', {'fg': s:dark_cyan})


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Highlighting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ALE
call s:h('ALEErrorSign',   {'fg': s:red, 'bg': s:gutter_bg })
call s:h('ALEWarningSign', {'fg': s:yellow, 'bg': s:gutter_bg })
call s:h('ALEInfoSign',    {'fg': s:blue, 'bg': s:gutter_bg })

" Signify
hi link SignifySignAdd              LineNr
hi link SignifySignDelete           LineNr
hi link SignifySignChange           LineNr

" GitGutter
call s:h('GitGutterAdd',            { 'fg': s:green, 'bg': s:gutter_bg })
call s:h('GitGutterDelete',         { 'fg': s:red, 'bg': s:gutter_bg })
call s:h('GitGutterChange',         { 'fg': s:yellow, 'bg': s:gutter_bg })
call s:h('GitGutterChangeDelete',   { 'fg': s:red, 'bg': s:gutter_bg })

" Floaterm
call s:h('Floaterm',       { 'bg': s:black })
call s:h('FloatermBorder', { 'fg': s:dark_cyan })

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

" vim-go
call s:h('goCoverageCovered', { 'fg': s:green })
call s:h('goCoverageUncover', { 'fg': s:red })
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 0
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_declarations = 0
let g:go_highlight_variable_assignments = 0
