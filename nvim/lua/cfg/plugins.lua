local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) == 1 then
	vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
end

vim.cmd.packadd("packer.nvim")

local packer = require("packer")

packer.init({
	disable_commands = true,
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
	autoremove = true,
})

packer.reset()

local use = packer.use

-- Manage packer with packer
use({ "wbthomason/packer.nvim", opt = true })

-- General Purpose Plugins
use("AndrewRadev/splitjoin.vim")
use("b4winckler/vim-angry")
use({
	"bkad/CamelCaseMotion",
	config = function()
		vim.g.camelcasemotion_key = "<leader>"
	end,
})
use({
	"itchyny/lightline.vim",
	config = function()
		vim.g.lightline = {
			colorscheme = "dots",
			active = {
				left = {
					{ "mode", "paste" },
					{ "readonly", "relativepath", "modified" },
				},
			},
		}
	end,
})
use({
	"vim-test/vim-test",
	config = function()
		vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>")
		vim.keymap.set("n", "<leader>tf", ":TestFile<CR>")
		vim.keymap.set("n", "<leader>ts", ":TestSuite<CR>")
		vim.keymap.set("n", "<leader>tl", ":TestLast<CR>")

		vim.g["test#go#gotest#options"] = {
			all = "-count 1",
			nearest = "-tags integration,e2e",
			file = "-tags integration",
			suite = "-tags integration",
		}
	end,
})
use({
	"junegunn/vim-easy-align",
	config = function()
		vim.keymap.set({ "n", "x" }, "ga", "<Plug>(EasyAlign)")
	end,
})
use({
	"justinmk/vim-dirvish",
	config = function()
		vim.keymap.set("n", "<leader>e", ":Dirvish %:h<CR>", { silent = true })

		local ignored = {
			[[\.DS_Store]],
			[[\.git/]],
			[[\.gitmodules/]],
			[[\.pytest_cache/]],
			[[\.vscode/]],
			[[__pycache__/]],
			[[\.bak]],
			[[\.log]],
			[[\.pid]],
			[[\.pyc]],
		}

		local cmds = {
			"sort",
			"sort ;.*/;",
			string.format("silent keeppattern g;%s;d", table.concat(ignored, [[\|]])),
		}

		vim.g.dirvish_mode = ":" .. table.concat(cmds, "|")

		function dirvish_rename()
			local path = vim.fn.getline(".")

			local target = vim.fn.input("Rename: ", path)
			vim.cmd.mode()

			vim.fn.system({ "mv", path, target })
			vim.cmd.Dirvish("%")
		end

		function dirvish_delete()
			local confirm = vim.fn.input("Confirm deletion [y/n]: ")
			vim.cmd.mode()

			if confirm ~= "y" then
				print("Canceled")
				return
			end

			local path = vim.fn.getline(".")

			local rm = "rm"
			if vim.fn.executable("trash") == 1 then
				rm = "trash"
			elseif string.sub(path, -1) == "/" then
				rm = "rmdir"
			end

			vim.fn.system({ rm, path })
			vim.cmd.Dirvish("%")
		end

		function dirvish_mkdir()
			local dirname = vim.fn.input("Directory name: ")
			vim.cmd.mode()

			vim.fn.system({ "mkdir", vim.fn.expand("%") .. dirname })
			vim.cmd.Dirvish("%")
		end

		function dirvish_mkfile()
			local filename = vim.fn.input("File name: ")

			if filename == "" then
				print("Canceled")
				return
			end

			vim.cmd.edit(vim.fn.expand("%") .. filename)
		end

		local augroup_dirvish_settings = vim.api.nvim_create_augroup("dirvish_settings", {})
		vim.api.nvim_create_autocmd("Filetype", {
			pattern = "dirvish",
			group = augroup_dirvish_settings,
			callback = function()
				vim.opt_local.number = false

				-- Set a noop keymap so we can delete idempotently
				vim.keymap.set("", "<C-p>", function() end, { buffer = true })
				vim.keymap.del("", "<C-p>", { buffer = true })

				vim.keymap.set("n", "R", dirvish_rename, { buffer = true, silent = true })
				vim.keymap.set("n", "D", dirvish_delete, { buffer = true, silent = true })
				vim.keymap.set("n", "d", dirvish_mkdir, { buffer = true, nowait = true, silent = true })
				vim.keymap.set("n", "%", dirvish_mkfile, { buffer = true, silent = true })
				vim.keymap.set("n", "<C-l>", ":Dirvish %<CR>", { buffer = true, silent = true })
			end,
		})
	end,
})
use({
	"lewis6991/gitsigns.nvim",
	requires = { "nvim-lua/plenary.nvim" },
	config = function()
		require("gitsigns").setup({
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				-- Actions
				map({ "n", "v" }, "<leader>hs", gs.stage_hunk)
				map({ "n", "v" }, "<leader>hr", gs.reset_hunk)
				map("n", "<leader>hS", gs.stage_buffer)
				map("n", "<leader>hu", gs.undo_stage_hunk)
				map("n", "<leader>hR", gs.reset_buffer)
				map("n", "<leader>hp", gs.preview_hunk)
				map("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end)
				map("n", "<leader>hd", gs.diffthis)
				map("n", "<leader>hD", function()
					gs.diffthis("~")
				end)

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		})
	end,
})
use({
	"numToStr/FTerm.nvim",
	config = function()
		local fterm = require("FTerm")
		fterm.setup({
			border = "rounded",
			dimensions = {
				height = 0.9,
				width = 0.9,
			},
		})

		vim.keymap.set({ "n", "t" }, "<C-t>", fterm.toggle, { silent = true })
	end,
})
use({
	"ntpeters/vim-better-whitespace",
	config = function()
		vim.g.better_whitespace_enabled = 0
		vim.g.strip_whitespace_on_save = 1
	end,
})
use({
	"rliebz/vim-clover",
	config = function()
		vim.keymap.set("n", "<leader>cu", ":CloverUp<CR>")
		vim.keymap.set("n", "<leader>cd", ":CloverDown<CR>")
	end,
})
use("romainl/vim-cool")
use("tpope/vim-abolish")
use("tpope/vim-commentary")
use({
	"tpope/vim-fugitive",
	requires = { "tpope/vim-rhubarb", "shumphrey/fugitive-gitlab.vim" },
})
use("tpope/vim-repeat")
use("tpope/vim-sleuth")
use("tpope/vim-surround")
use({
	"tyru/open-browser.vim",
	config = function()
		vim.g.netrw_nogx = true
		vim.keymap.set({ "n", "v" }, "gx", "<Plug>(openbrowser-smart-search)", {})
	end,
})
use("wellle/targets.vim")

use({
	"nvim-treesitter/nvim-treesitter",
	requires = { "nvim-treesitter/playground" },
	run = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = "all",
			ignore_install = { "phpdoc" },
			highlight = {
				enable = true,
				disable = {
					"sql",
					"yaml",
				},
			},
		})

		vim.keymap.set("n", "<leader>hi", vim.cmd.TSHighlightCapturesUnderCursor, {})
	end,
})

use({
	"nvim-telescope/telescope.nvim",
	requires = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
	},
	config = function()
		local telescope = require("telescope")

		local function rg(args)
			local command = {
				"rg",
				"--hidden",
				"-g",
				"!.git/*",
				"-g",
				"!*.min.js",
				"-g",
				"!*.js.map",
			}
			for _, arg in ipairs(args) do
				table.insert(command, arg)
			end
			return command
		end

		local actions = require("telescope.actions")
		telescope.setup({
			defaults = {
				hidden = true,
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					prompt_position = "top",
				},
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
				vimgrep_arguments = rg({
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				}),
			},
			pickers = {
				find_files = {
					hidden = true,
					find_command = rg({
						"--files",
					}),
				},
			},
		})
		telescope.load_extension("fzf")
		telescope.load_extension("live_grep_args")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<C-p>", builtin.find_files, {})
		vim.keymap.set("n", "<C-f>", builtin.live_grep, {})
	end,
})

-- Language Server Protocol
use({
	"jose-elias-alvarez/null-ls.nvim",
	requires = { "nvim-lua/plenary.nvim" },
	config = function()
		local null_ls = require("null-ls")
		local helpers = require("null-ls.helpers")
		local lsp = require("cfg.lsp")

		local ibm_openapi_validator = {
			name = "openapi-validator",
			method = null_ls.methods.DIAGNOSTICS,
			filetypes = {
				"openapi",
				"yaml.openapi", -- hack because null-ls doesn't support multi ft
			},
			generator = helpers.generator_factory({
				command = "lint-openapi",
				args = { "--json", "$FILENAME" },
				format = "json_raw",
				check_exit_code = function(code, stderr)
					return code <= 1
				end,
				on_output = function(params)
					local diagnostics = {}

					if params.err then
						-- If we have an output, it's more informative than a JSON parse error.
						-- If not, show what we have.
						table.insert(diagnostics, { message = params.output or params.err })
					end

					if type(params.output) == "table" then
						local severities = {
							{
								source = params.output.errors,
								level = helpers.diagnostics.severities["error"],
							},
							{
								source = params.output.warnings,
								level = helpers.diagnostics.severities["warning"],
							},
							{
								source = params.output.infos,
								level = helpers.diagnostics.severities["information"],
							},
							{
								source = params.output.hints,
								level = helpers.diagnostics.severities["hint"],
							},
						}

						for _, severity in ipairs(severities) do
							if type(severity.source) == "table" then
								for _, e in ipairs(severity.source) do
									table.insert(diagnostics, {
										source = "openapi-validator",
										row = e.line,
										message = e.message,
										code = e.rule,
										severity = severity.level,
									})
								end
							end
						end
					end

					return diagnostics
				end,
			}),
		}
		null_ls.register({ ibm_openapi_validator })

		null_ls.setup({
			on_attach = function(client, bufnr)
				lsp.bind_keys()
				lsp.format_on_save(client, bufnr)
			end,
			sources = {
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.fish_indent,
				null_ls.builtins.formatting.prettier.with({
					condition = function(utils)
						return utils.root_has_file({
							".prettierrc",
							".prettierrc.json",
							".prettierrc.yml",
							".prettierrc.yaml",
							".prettierrc.json5",
							".prettierrc.js",
							".prettierrc.cjs",
							".prettierrc.config.js",
							".prettierrc.config.cjs",
							".prettierrc.toml",
							"node_modules/prettier",
						})
					end,
				}),
				null_ls.builtins.formatting.rustfmt,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.diagnostics.eslint,
				null_ls.builtins.diagnostics.flake8,
				null_ls.builtins.diagnostics.golangci_lint.with({
					-- Drop --fast, we're fast enough and want all diagnostics
					args = {
						"run",
						"--fix=false",
						"--out-format=json",
						"$DIRNAME",
						"--path-prefix",
						"$ROOT",
					},
				}),
				null_ls.builtins.diagnostics.hadolint,
				null_ls.builtins.diagnostics.shellcheck,
				null_ls.builtins.diagnostics.vint,
			},
		})
	end,
})
use({
	"williamboman/mason.nvim",
	config = function()
		require("mason").setup({
			ui = { border = "rounded" },
		})
	end,
})
use({
	"jayp0521/mason-null-ls.nvim",
	after = {
		"mason.nvim",
		"null-ls.nvim",
	},
	config = function()
		require("mason-null-ls").setup({ automatic_installation = true })
	end,
})
use({
	"neovim/nvim-lspconfig",
	after = {
		"mason.nvim",
	},
	requires = {
		"williamboman/mason-lspconfig.nvim",
		"b0o/schemastore.nvim",
		{
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/vim-vsnip",
			},
		},
	},
	config = function()
		require("mason-lspconfig").setup({ automatic_installation = true })

		local lspconfig = require("lspconfig")
		local lsp = require("cfg.lsp")

		require("lspconfig.ui.windows").default_options.border = "rounded"

		lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
			on_attach = function(client, bufnr)
				lsp.bind_keys()
				lsp.format_on_save(client, bufnr)
				lsp.organize_imports_on_save(client, bufnr)
			end,
		})

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "single",
		})

		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = "single",
		})

		local gomodcache = nil
		local gomodcache_loaded = false
		local gopls_root_dir = nil

		local server_configs = {
			bashls = {},
			cssls = {},
			gopls = {
				root_dir = function(fname)
					local fullpath = vim.fn.expand(fname, ":p")

					if gopls_root_dir ~= nil then
						if not gomodcache_loaded then
							gomodcache_loaded = true

							local path = vim.fn.trim(vim.fn.system("go env GOMODCACHE"))
							if vim.v.shell_error == 0 then
								gomodcache = path
							end
						end

						if gomodcache ~= nil and string.find(fullpath, gomodcache) then
							return gopls_root_dir
						end
					end

					gopls_root_dir = lspconfig.util.root_pattern("go.mod", ".git")(fname)

					return gopls_root_dir
				end,
				settings = {
					gopls = {
						linksInHover = false,
						buildFlags = {
							-- Enable common build flags used for test files
							"-tags=e2e,integration,integrity",
						},
						gofumpt = true,
					},
				},
			},
			intelephense = {},
			jsonls = {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
					},
				},
			},
			omnisharp = {},
			pylsp = {},
			rust_analyzer = {},
			solargraph = {},
			sumneko_lua = {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
							disable = { "lowercase-global" },
						},
						workspace = {
							checkThirdParty = false,
							library = vim.api.nvim_get_runtime_file("", true),
							preloadFileSize = 1000,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			},
			tsserver = {
				-- Skip formatting in favor of prettier
				on_attach = function(client, bufnr)
					lsp.bind_keys()
					-- TODO: This seems like it doesn't work
					lsp.organize_imports_on_save(client, bufnr)
				end,
			},
		}

		local lsp_server_names = {}
		for server_name in pairs(server_configs) do
			table.insert(lsp_server_names, server_name)
		end

		local cmp = require("cmp")
		cmp.setup({
			preselect = cmp.PreselectMode.None,

			snippet = {
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body)
				end,
			},

			mapping = {
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
				["<Tab>"] = cmp.mapping.select_next_item(),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm(),
			},

			sources = {
				{ name = "nvim_lsp" },
			},

			window = {
				completion = cmp.config.window.bordered({ winhighlight = "" }),
				documentation = cmp.config.window.bordered({ winhighlight = "" }),
			},
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
			capabilities = capabilities,
		})

		for server, config in pairs(server_configs) do
			lspconfig[server].setup(config)
		end
	end,
})

-- Language-specific plugins
use("shmup/vim-sql-syntax")
use({
	"chrisbra/csv.vim",
	config = function()
		vim.g.csv_no_conceal = 1
	end,
})

return packer
