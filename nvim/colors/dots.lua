vim.opt.background = "dark"
vim.cmd([[
highlight clear
if exists('syntax_on')
	syntax reset
endif
]])
vim.g.colors_name = "dots"

local function highlight(...)
	vim.api.nvim_set_hl(0, ...)
end

---------
-- Colors
---------
local colors = require("cfg.colors")

local black = colors.black
local bright_black = colors.bright_black
local red = colors.red
local dark_red = colors.dark_red
local green = colors.green
local dark_green = colors.dark_green
local yellow = colors.yellow
local dark_yellow = colors.dark_yellow
local blue = colors.blue
local dark_blue = colors.dark_blue
local magenta = colors.magenta
local dark_magenta = colors.dark_magenta
local cyan = colors.cyan
local dark_cyan = colors.dark_cyan
local white = colors.white
local dark_white = colors.dark_white

local gutter_fg = colors.dark_cyan
local gutter_bg = colors.black

--------------------------------
-- Syntax Groups (:h group-name)
--------------------------------

highlight("Comment", { fg = dark_white, italic = true })

highlight("Constant", { fg = cyan })
highlight("String", { fg = green })
highlight("Character", { fg = dark_green })
highlight("Number", { fg = yellow })
highlight("Boolean", { fg = dark_magenta, italic = true })
highlight("Float", { fg = yellow })

highlight("Identifier", { fg = cyan })
highlight("Function", { fg = dark_green })

highlight("Statement", { fg = magenta })
highlight("Conditional", { fg = magenta })
highlight("Repeat", { fg = magenta })
highlight("Label", { fg = magenta })
highlight("Operator", { fg = blue })
highlight("Keyword", { fg = dark_red })
highlight("Exception", { fg = dark_red })

highlight("PreProc", { fg = yellow })
highlight("Include", { fg = magenta })
highlight("Define", { fg = magenta })
highlight("Macro", { fg = magenta })
highlight("PreCondit", { fg = yellow })

highlight("Type", { fg = yellow })
highlight("StorageClass", { fg = yellow })
highlight("Structure", { fg = yellow })
highlight("Typedef", { fg = yellow })

highlight("Special", { fg = yellow })
highlight("SpecialChar", {})
highlight("Tag", {})
highlight("Delimiter", { fg = blue })
highlight("SpecialComment", {})
highlight("Debug", {})

highlight("Underlined", {})

highlight("Ignore", {})

highlight("Error", { sp = red, undercurl = true })

highlight("Todo", { fg = magenta })

-----------------------------------------
-- Highlight Groups (:h highlight-groups)
-----------------------------------------

highlight("ColorColumn", { bg = dark_blue })
highlight("Conceal", {})
highlight("Cursor", { fg = black, bg = blue })
highlight("CursorIM", {})
highlight("CursorColumn", { bg = bright_black })
highlight("CursorLine", { bg = dark_blue })
highlight("Directory", { fg = blue })
highlight("DiffAdd", { fg = green })
highlight("DiffChange", { fg = dark_yellow })
highlight("DiffDelete", { fg = red })
highlight("DiffText", { fg = blue })
highlight("ErrorMsg", { fg = red })
highlight("VertSplit", { fg = dark_cyan, bg = dark_cyan })
highlight("Folded", { fg = gutter_fg, bg = gutter_bg })
highlight("FoldColumn", {})
highlight("SignColumn", { bg = gutter_bg })
highlight("IncSearch", { fg = yellow, bg = dark_cyan })
highlight("LineNr", { fg = gutter_fg, bg = gutter_bg })
highlight("CursorLineNr", { fg = yellow, bg = gutter_bg })
highlight("MatchParen", { fg = yellow, bg = dark_cyan })
highlight("ModeMsg", {})
highlight("MoreMsg", {})
highlight("NonText", { fg = bright_black })
highlight("Normal", { fg = white })
highlight("NormalFloat", { fg = white })
highlight("Pmenu", { fg = white, bg = bright_black })
highlight("PmenuSel", { fg = yellow, bg = dark_cyan })
highlight("PmenuSbar", { bg = dark_cyan })
highlight("PmenuThumb", { bg = white })
highlight("Question", { fg = magenta })
highlight("Search", { bg = dark_cyan })
highlight("SpecialKey", { fg = dark_magenta })
highlight("SpellBad", { sp = red, undercurl = true })
highlight("SpellCap", { sp = yellow, undercurl = true })
highlight("SpellLocal", { sp = yellow, undercurl = true })
highlight("SpellRare", { sp = yellow, undercurl = true })
highlight("StatusLine", { fg = cyan, bg = dark_cyan })
highlight("StatusLineNC", { fg = dark_white, bg = bright_black })
highlight("TabLine", { fg = black, bg = dark_cyan })
highlight("TabLineFill", { fg = white, bg = bright_black })
highlight("TabLineSel", { fg = black, bg = cyan })
highlight("Title", { fg = dark_green, bold = true })
highlight("Visual", { bg = bright_black })
highlight("VisualNOS", { link = "VisualNOS" })
highlight("WarningMsg", { fg = yellow })
highlight("WildMenu", { fg = yellow, bg = dark_cyan })

---------------------------------
-- Language-Specific Highlighting
---------------------------------

highlight("jsonKeyword", { link = "Identifier" })
highlight("jsonCommentError", { fg = dark_white, sp = yellow, undercurl = true })

highlight("pythonDecorator", { fg = yellow, bold = true })
highlight("pythonDottedName", { fg = yellow })
highlight("pythonRawString", { fg = yellow })
highlight("pythonBuiltinFunc", { fg = blue })

highlight("rubyBlockParameterList", { fg = dark_red })
highlight("rubyInterpolation", { fg = green })
highlight("rubyInterpolationDelimiter", { fg = dark_red })

highlight("markdownBlockQuote", { fg = dark_magenta })
highlight("markdownCode", { fg = green })
highlight("markdownCodeDelimiter", { fg = green })
highlight("markdownId", { fg = magenta })
highlight("markdownIdDeclaration", { fg = magenta })
highlight("markdownHeadingDelimiter", { fg = dark_yellow })
highlight("markdownLinkText", { fg = cyan, sp = dark_cyan, underline = true })

-- Fix issue with LSP hover windows
highlight("mkdLineBreak", { link = "NONE" })

--------------------------
-- Custom Highlight Groups
--------------------------

-- For drawing borders around floating windows
highlight("FloatBorder", { fg = dark_cyan })

----------------------
-- Plugin Highlighting
----------------------

-- ALE
highlight("ALEErrorSign", { fg = red, bg = gutter_bg })
highlight("ALEWarningSign", { fg = yellow, bg = gutter_bg })
highlight("ALEInfoSign", { fg = blue, bg = gutter_bg })

-- Clover
highlight("CloverCovered", { fg = green })
highlight("CloverUncovered", { fg = red })
highlight("CloverIgnored", { fg = dark_white })

-- Compe
highlight("CompeDocumentation", { link = "Pmenu" })

-- GitSigns
highlight("GitSignsAdd", { fg = green, bg = gutter_bg })
highlight("GitSignsDelete", { fg = red, bg = gutter_bg })
highlight("GitSignsChange", { fg = yellow, bg = gutter_bg })
highlight("diffAdded", { fg = green })
highlight("diffRemoved", { fg = red })
highlight("diffChanged", { fg = yellow })

-- Signify
highlight("SignifyAdd", { fg = green, bg = gutter_bg })
highlight("SignifyDelete", { fg = red, bg = gutter_bg })
highlight("SignifyChange", { fg = yellow, bg = gutter_bg })

-- GitGutter
highlight("GitGutterAdd", { fg = green, bg = gutter_bg })
highlight("GitGutterDelete", { fg = red, bg = gutter_bg })
highlight("GitGutterChange", { fg = yellow, bg = gutter_bg })
highlight("GitGutterChangeDelete", { fg = red, bg = gutter_bg })

-- Floaterm
highlight("Floaterm", { bg = black })
highlight("FloatermBorder", { link = "FloatBorder" })

-- FZF
vim.g.fzf_colors = {
	fg = { "fg", "Normal" },
	bg = { "bg", "Normal" },
	hl = { "fg", "Constant" },
	["fg+"] = { "fg", "Normal" },
	["bg+"] = { "bg", "ColorColumn" },
	["hl+"] = { "fg", "Constant" },
	info = { "bg", "Search" },
	border = { "fg", "VertSplit" },
	prompt = { "fg", "Label" },
	pointer = { "fg", "Number" },
	marker = { "fg", "Number" },
	spinner = { "fg", "Label" },
	header = { "fg", "Comment" },
}

-- Diagnostics
vim.fn.sign_define("DiagnosticSignError", { text = "●", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "●", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "●", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "●", texthl = "DiagnosticSignHint" })

highlight("DiagnosticError", { fg = red })
highlight("DiagnosticWarn", { fg = yellow })
highlight("DiagnosticInfo", { fg = blue })
highlight("DiagnosticHint", { fg = dark_white })

highlight("DiagnosticUnderlineError", { sp = red, undercurl = true })
highlight("DiagnosticUnderlineWarn", { sp = yellow, undercurl = true })
highlight("DiagnosticUnderlineInfo", { sp = blue, undercurl = true })
highlight("DiagnosticUnderlineHint", { sp = dark_white, undercurl = true })

-- Telescope
highlight("TelescopeBorder", { link = "FloatBorder" })

-- Treesitter
highlight("TSTextReference", { fg = yellow })
highlight("TSURI", { fg = cyan, sp = dark_cyan, underline = true })
highlight("TSConstant", { link = "TSVariable" })
highlight("TSConstBuiltin", { link = "Boolean" })
highlight("TSStringEscape", { link = "Special" })
highlight("TSInclude", { link = "Keyword" })

-- vim-go
highlight("goCoverageCovered", { fg = green })
highlight("goCoverageUncover", { fg = red })
vim.g.go_highlight_operators = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_parameters = 0
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_build_constraints = 1
vim.g.go_highlight_generate_tags = 1
vim.g.go_highlight_variable_declarations = 0
vim.g.go_highlight_variable_assignments = 0
