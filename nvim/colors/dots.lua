vim.o.background = "dark"
vim.cmd.highlight("clear")
vim.g.colors_name = "dots"

local function highlight(...)
	vim.api.nvim_set_hl(0, ...)
end

---------
-- Colors
---------

local colors = require("cfg.colors")
local gutter_fg = colors.dark_cyan
local gutter_bg = colors.black

--------------------------------
-- Syntax Groups (:h group-name)
--------------------------------

highlight("Comment", { fg = colors.dark_white, italic = true })

highlight("Constant", { fg = colors.dark_blue })
highlight("String", { fg = colors.green })
highlight("Character", { fg = colors.dark_green })
highlight("Number", { fg = colors.yellow })
highlight("Boolean", { fg = colors.dark_yellow, italic = true })
highlight("Float", { fg = colors.yellow })

highlight("Identifier", {})
highlight("Function", { fg = colors.dark_green })

highlight("Statement", { fg = colors.magenta })
highlight("Conditional", { fg = colors.magenta })
highlight("Repeat", { fg = colors.magenta })
highlight("Label", { fg = colors.magenta })
highlight("Operator", { fg = colors.blue })
highlight("Keyword", { fg = colors.dark_red })
highlight("Exception", { fg = colors.dark_red })

highlight("PreProc", { fg = colors.yellow })
highlight("Include", { fg = colors.magenta })
highlight("Define", { fg = colors.magenta })
highlight("Macro", { fg = colors.magenta })
highlight("PreCondit", { fg = colors.yellow })

highlight("Type", { fg = colors.yellow })
highlight("StorageClass", { fg = colors.yellow })
highlight("Structure", { fg = colors.yellow })
highlight("Typedef", { fg = colors.yellow })

highlight("Special", { fg = colors.yellow })
highlight("SpecialChar", { link = "Special" })
highlight("Tag", { fg = colors.magenta })
highlight("Delimiter", { fg = colors.blue })
highlight("SpecialComment", {})
highlight("Debug", {})

highlight("Underlined", {})

highlight("Ignore", {})

highlight("Error", { sp = colors.red, undercurl = true })

highlight("Todo", { fg = colors.red })

-----------------------------------------
-- Highlight Groups (:h highlight-groups)
-----------------------------------------

highlight("ColorColumn", { bg = colors.highlight_purple })
highlight("Conceal", {})
highlight("Cursor", { fg = colors.black, bg = colors.blue })
highlight("CursorIM", {})
highlight("CursorColumn", { bg = colors.highlight_green })
highlight("CursorLine", { bg = colors.highlight_purple, sp = colors.yellow })
highlight("Directory", { fg = colors.blue })
highlight("DiffAdd", { bg = colors.highlight_green })
highlight("DiffChange", { bg = colors.highlight_blue })
highlight("DiffDelete", { fg = colors.bright_black })
highlight("DiffText", { bg = colors.highlight_light_blue })
highlight("ErrorMsg", { fg = colors.red })
highlight("WinSeparator", { fg = colors.dark_cyan, bg = colors.dark_cyan })
highlight("VertSplit", { link = "WinSeparator" })
highlight("Folded", { fg = gutter_fg, bg = gutter_bg })
highlight("FoldColumn", { fg = colors.bright_black })
highlight("SignColumn", { bg = gutter_bg })
highlight("IncSearch", { fg = colors.yellow, bg = colors.dark_cyan })
highlight("LineNr", { fg = gutter_fg, bg = gutter_bg })
highlight("CursorLineNr", { fg = colors.yellow, bg = gutter_bg })
highlight("MatchParen", { fg = colors.yellow, bg = colors.dark_cyan })
highlight("ModeMsg", {})
highlight("MoreMsg", {})
highlight("NonText", { fg = colors.bright_black })
highlight("Normal", { fg = colors.white })
highlight("NormalFloat", { fg = colors.white })
highlight("Pmenu", { fg = colors.white, bg = colors.highlight_green })
highlight("PmenuSel", { fg = colors.yellow, bg = colors.dark_cyan })
highlight("PmenuSbar", { bg = colors.bright_black })
highlight("PmenuThumb", { bg = colors.dark_cyan })
highlight("Question", { fg = colors.magenta })
highlight("Search", { bg = colors.dark_cyan })
highlight("SpecialKey", { fg = colors.dark_magenta })
highlight("SpellBad", { sp = colors.red, undercurl = true })
highlight("SpellCap", { sp = colors.yellow, undercurl = true })
highlight("SpellLocal", { sp = colors.yellow, undercurl = true })
highlight("SpellRare", { sp = colors.yellow, undercurl = true })
highlight("StatusLine", { fg = colors.cyan, bg = colors.dark_cyan })
highlight("StatusLineNC", { fg = colors.dark_white, bg = colors.highlight_green })
highlight("TabLine", { fg = colors.black, bg = colors.dark_cyan })
highlight("TabLineFill", { fg = colors.white, bg = colors.bright_black })
highlight("TabLineSel", { fg = colors.black, bg = colors.cyan })
highlight("Title", { fg = colors.dark_green, bold = true })
highlight("Visual", { bg = colors.highlight_green })
highlight("VisualNOS", { link = "Visual" })
highlight("WarningMsg", { fg = colors.yellow })
highlight("WildMenu", { fg = colors.yellow, bg = colors.dark_cyan })

-------------------------------------------
-- LSP Highlight Groups  (:h lsp-highlight)
-------------------------------------------

highlight("LspCodeLens", { fg = colors.dark_cyan, italic = true })
highlight("LspSignatureActiveParameter", { bg = colors.highlight_purple, bold = true })

-- LSP Semantic Tokens
highlight("@lsp.type.property", { link = "@property" })
highlight("@lsp.type.comment", {}) -- this clobbers TODO, etc.
highlight("@lsp.typemod.function.defaultLibrary", { link = "@function.builtin" })

---------------------------------
-- Language-Specific Highlighting
---------------------------------

highlight("healthSuccess", { fg = colors.green })
highlight("healthWarning", { fg = colors.yellow })
highlight("healthError", { fg = colors.red })

highlight("jsonKeyword", { link = "Identifier" })
highlight("jsonCommentError", { fg = colors.dark_white, sp = colors.yellow, undercurl = true })

highlight("pythonDecorator", { fg = colors.yellow, bold = true })
highlight("pythonDottedName", { fg = colors.yellow })
highlight("pythonRawString", { fg = colors.yellow })
highlight("pythonBuiltinFunc", { fg = colors.blue })

highlight("rubyBlockParameterList", { fg = colors.dark_red })
highlight("rubyInterpolation", { fg = colors.green })
highlight("rubyInterpolationDelimiter", { fg = colors.dark_red })

highlight("markdownBlockQuote", { fg = colors.dark_magenta })
highlight("markdownCode", { fg = colors.green })
highlight("markdownCodeDelimiter", { fg = colors.green })
highlight("markdownId", { fg = colors.magenta })
highlight("markdownIdDeclaration", { fg = colors.magenta })
highlight("markdownHeadingDelimiter", { fg = colors.dark_yellow })
highlight("markdownLinkText", { link = "@markup.link.url" })

-- Fix issue with LSP hover windows
highlight("mkdLineBreak", { link = "NONE" })

highlight("yamlBlockCollectionItemStart", { link = "@punctuation" })
highlight("yamlBlockMappingKey", { link = "@variable.member" })
highlight("yamlBool", { link = "@boolean" })
highlight("yamlFlowIndicator", { link = "@punctuation" })
highlight("yamlKeyValueDelimiter", { link = "@punctuation" })

--------------------------
-- Custom Highlight Groups
--------------------------

-- For drawing borders around floating windows
highlight("FloatBorder", { fg = colors.dark_cyan })

----------------------
-- Plugin Highlighting
----------------------

-- ALE
highlight("ALEErrorSign", { link = "DiagnosticSignError" })
highlight("ALEWarningSign", { link = "DiagnosticSignWarn" })
highlight("ALEInfoSign", { link = "DiagnosticSignInfo" })

-- Clover
highlight("CloverCovered", { fg = colors.green })
highlight("CloverUncovered", { fg = colors.red })
highlight("CloverIgnored", { fg = colors.dark_white })

-- cmp
highlight("CmpItemMenu", { link = "Comment" })
highlight("CmpItemKindText", { link = "String" })
highlight("CmpItemKindMethod", { link = "Function" })
highlight("CmpItemKindFunction", { link = "Function" })
highlight("CmpItemKindConstructor", { link = "Function" })
highlight("CmpItemKindField", { link = "@variable.member" })
highlight("CmpItemKindVariable", { link = "CmpItemKindDefault" })
highlight("CmpItemKindClass", { link = "CmpItemKindDefault" })
highlight("CmpItemKindInterface", { link = "CmpItemKindDefault" })
highlight("CmpItemKindModule", { link = "@module" })
highlight("CmpItemKindProperty", { link = "@property" })
highlight("CmpItemKindUnit", { link = "CmpItemKindDefault" })
highlight("CmpItemKindValue", { link = "CmpItemKindDefault" })
highlight("CmpItemKindEnum", { link = "CmpItemKindDefault" })
highlight("CmpItemKindKeyword", { link = "Keyword" })
highlight("CmpItemKindSnippet", { link = "CmpItemKindDefault" })
highlight("CmpItemKindColor", { link = "CmpItemKindDefault" })
highlight("CmpItemKindFile", { link = "CmpItemKindDefault" })
highlight("CmpItemKindReference", { link = "CmpItemKindDefault" })
highlight("CmpItemKindFolder", { link = "Directory" })
highlight("CmpItemKindEnumMember", { link = "CmpItemKindDefault" })
highlight("CmpItemKindConstant", { link = "Constant" })
highlight("CmpItemKindStruct", { link = "CmpItemKindDefault" })
highlight("CmpItemKindEvent", { link = "CmpItemKindDefault" })
highlight("CmpItemKindOperator", { link = "Operator" })
highlight("CmpItemKindTypeParameter", { link = "CmpItemKindDefault" })

-- Compe
highlight("CompeDocumentation", { link = "Pmenu" })

-- csv.vim
highlight("CSVColumnHeaderEven", { fg = colors.magenta })
highlight("CSVColumnHeaderOdd", { fg = colors.dark_magenta })
highlight("CSVColumnEven", { fg = colors.dark_white })
highlight("CSVColumnOdd", { fg = colors.white })
highlight("CSVDelimiter", { link = "Delimiter" })

-- GitSigns
highlight("GitSignsAdd", { fg = colors.green, bg = gutter_bg })
highlight("GitSignsDelete", { fg = colors.red, bg = gutter_bg })
highlight("GitSignsChange", { fg = colors.yellow, bg = gutter_bg })
highlight("GitSignsAddPreview", { fg = colors.green })
highlight("GitSignsDeletePreview", { fg = colors.red })
highlight("GitSignsAddInline", { bg = colors.background_green })
highlight("GitSignsDeleteInline", { bg = colors.background_red })
highlight("GitSignsChangeInline", { bg = colors.background_yellow })

-- Signify
highlight("SignifyAdd", { fg = colors.green, bg = gutter_bg })
highlight("SignifyDelete", { fg = colors.red, bg = gutter_bg })
highlight("SignifyChange", { fg = colors.yellow, bg = gutter_bg })

-- GitGutter
highlight("GitGutterAdd", { fg = colors.green, bg = gutter_bg })
highlight("GitGutterDelete", { fg = colors.red, bg = gutter_bg })
highlight("GitGutterChange", { fg = colors.yellow, bg = gutter_bg })
highlight("GitGutterChangeDelete", { fg = colors.red, bg = gutter_bg })

-- Floaterm
highlight("Floaterm", { bg = colors.black })
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

highlight("DiagnosticError", { fg = colors.red })
highlight("DiagnosticWarn", { fg = colors.yellow })
highlight("DiagnosticInfo", { fg = colors.blue })
highlight("DiagnosticHint", { fg = colors.dark_white })

highlight("DiagnosticUnderlineError", { sp = colors.red, undercurl = true })
highlight("DiagnosticUnderlineWarn", { sp = colors.yellow, undercurl = true })
highlight("DiagnosticUnderlineInfo", { sp = colors.blue, undercurl = true })
highlight("DiagnosticUnderlineHint", { sp = colors.dark_white, undercurl = true })

-- Fugitive
highlight("diffAdded", { fg = colors.green })
highlight("diffRemoved", { fg = colors.red })
highlight("diffChanged", { fg = colors.yellow })
highlight("diffFile", { fg = colors.blue })
highlight("diffIndexLine", { link = "diffFile" })
highlight("diffLine", { fg = colors.cyan })

-- Lspconfig
highlight("LspInfoBorder", { link = "FloatBorder" })

-- NeoTree
highlight("NeoTreeGitAdded", { fg = colors.green })
highlight("NeoTreeGitConflict", { fg = colors.dark_yellow })
highlight("NeoTreeGitDeleted", { fg = colors.red })
highlight("NeoTreeGitModified", { fg = colors.yellow })
highlight("NeoTreeGitUntracked", { fg = colors.dark_white })

-- Noice
highlight("LspSignatureActiveParameter", { bg = colors.highlight_purple, bold = true })

-- Notify
highlight("NotifyBackground", { bg = colors.black })

-- Null LS
highlight("NullLSInfoBorder", { link = "FloatBorder" })

-- SQL
highlight("sqlKeyword", { link = "Keyword" })
highlight("sqlParen", { link = "Delimiter" })
highlight("sqlParenFunc", { link = "Delimiter" })
highlight("sqlUnknownFunc", { link = "Function" })

-- Telescope
highlight("TelescopeBorder", { link = "FloatBorder" })

-- Treesitter
highlight("@attribute", { fg = colors.blue, italic = true })
highlight("@comment.note", { fg = colors.cyan })
highlight("@comment.todo", { link = "Todo" })
highlight("@constant.builtin", { fg = colors.dark_blue, italic = true })
highlight("@keyword.import", { link = "Keyword" })
highlight("@markup.emphasis", { italic = true })
highlight("@markup.heading", { link = "Title" })
highlight("@markup.link", { fg = colors.yellow })
highlight("@markup.link.url", { link = "@string.special.url" })
highlight("@markup.raw.delimiter", { link = "Delimiter" })
highlight("@markup.raw.markdown_inline", { fg = colors.green })
highlight("@markup.strong", { bold = true })
highlight("@module", { fg = colors.dark_magenta })
highlight("@property", { link = "@variable.member" })
highlight("@string.escape", { link = "Special" })
highlight("@string.special.path", { fg = colors.white, underline = true })
highlight("@string.special.url", { fg = colors.cyan, sp = colors.dark_cyan, underline = true })
highlight("@tag.attribute", { link = "@variable.member" })
highlight("@tag.delimiter", { link = "Delimiter" })
highlight("@variable", { fg = colors.white })
highlight("@variable.builtin", { fg = colors.dark_blue, italic = true })
highlight("@variable.member", { fg = colors.cyan })

highlight("@constant.fish", { link = "@variable.fish" })
highlight("@variable.fish", { fg = colors.cyan })

-- vim-go
highlight("goCoverageCovered", { link = "CloverCovered" })
highlight("goCoverageUncover", { link = "CloverUncovered" })
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

-- lightline
local color_to_number = {
	[colors.black] = 0,
	[colors.bright_black] = 8,
	[colors.red] = 1,
	[colors.dark_red] = 9,
	[colors.green] = 2,
	[colors.dark_green] = 10,
	[colors.yellow] = 3,
	[colors.dark_yellow] = 11,
	[colors.blue] = 4,
	[colors.dark_blue] = 12,
	[colors.magenta] = 5,
	[colors.dark_magenta] = 13,
	[colors.cyan] = 6,
	[colors.dark_cyan] = 14,
	[colors.white] = 7,
	[colors.dark_white] = 15,
}

local fill = function(cfg)
	for _, mode in pairs(cfg) do
		for _, position in pairs(mode) do
			for i, c in ipairs(position) do
				position[i] = { c.fg, c.bg, color_to_number[c.fg], color_to_number[c.bg] }
			end
		end
	end

	return cfg
end

vim.g["lightline#colorscheme#dots#palette"] = fill({
	normal = {
		left = {
			{ fg = colors.black, bg = colors.blue },
			{ fg = colors.black, bg = colors.cyan },
		},
		middle = {
			{ fg = colors.black, bg = colors.dark_cyan },
		},
		right = {
			{ fg = colors.black, bg = colors.white },
			{ fg = colors.black, bg = colors.cyan },
		},
		error = {
			{ fg = colors.white, bg = colors.red },
		},
		warning = {
			{ fg = colors.black, bg = colors.yellow },
		},
	},
	inactive = {
		left = {
			{ fg = colors.dark_cyan, bg = colors.bright_black },
			{ fg = colors.dark_cyan, bg = colors.bright_black },
		},
		middle = {
			{ fg = colors.dark_cyan, bg = colors.bright_black },
		},
		right = {
			{ fg = colors.dark_cyan, bg = colors.bright_black },
			{ fg = colors.dark_cyan, bg = colors.bright_black },
		},
	},
	insert = {
		left = {
			{ fg = colors.black, bg = colors.yellow },
			{ fg = colors.black, bg = colors.cyan },
		},
	},
	replace = {
		left = {
			{ fg = colors.black, bg = colors.magenta },
			{ fg = colors.black, bg = colors.cyan },
		},
	},
	visual = {
		left = {
			{ fg = colors.black, bg = colors.green },
			{ fg = colors.black, bg = colors.cyan },
		},
	},
	tabline = {
		left = {
			{ fg = colors.black, bg = colors.dark_cyan },
		},
		middle = {
			{ fg = colors.black, bg = colors.bright_black },
		},
		right = {
			{ fg = colors.black, bg = colors.dark_cyan },
		},
		tabsel = {
			{ fg = colors.black, bg = colors.cyan },
		},
	},
})
