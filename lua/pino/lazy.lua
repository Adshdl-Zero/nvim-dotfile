-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{
			"nvim-telescope/telescope.nvim",
			tag = "v0.2.0",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				local telescope = require("telescope")
				local builtin = require("telescope.builtin")
				telescope.setup({})
				vim.keymap.set("n", "<leader>pf", function()
					builtin.find_files()
				end)
				vim.keymap.set("n", "<leader>ps", function()
					builtin.grep_string({ search = vim.fn.input("Grep > ") })
				end)
				vim.keymap.set("n", "<C-p>", function()
					builtin.git_files()
				end)
			end,
		},
		{
			"rose-pine/neovim",
			name = "rose-pine",
			config = function()
				local function ColorMyPencils(color)
					color = color or "rose-pine"
					vim.cmd.colorscheme(color)

					vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
					vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
				end
				ColorMyPencils()
			end,
		},
		{
			"ThePrimeagen/harpoon",
			branch = "harpoon2",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				local harpoon = require("harpoon")
				harpoon:setup()
				vim.keymap.set("n", "<leader>a", function()
					harpoon:list():add()
				end)
				vim.keymap.set("n", "<C-e>", function()
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end)

				vim.keymap.set("n", "<C-1>", function()
					harpoon:list():select(1)
				end)
				vim.keymap.set("n", "<C-2>", function()
					harpoon:list():select(2)
				end)
				vim.keymap.set("n", "<C-3>", function()
					harpoon:list():select(3)
				end)
				vim.keymap.set("n", "<C-4>", function()
					harpoon:list():select(4)
				end)
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			branch = "master",
			build = ":TSUpdate",
			config = function()
				require("nvim-treesitter.configs").setup({
					ensure_installed = {
						"javascript",
						"cpp",
						"python",
						"java",
						"c",
						"lua",
						"vim",
						"vimdoc",
						"query",
						"markdown",
						"markdown_inline",
					},

					sync_install = false,

					auto_install = true,

					highlight = {
						enable = true,
						additional_vim_regex_highlighting = false,
					},
				})
			end,
		},
		{
			"mbbill/undotree",
			config = function()
				vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
			end,
		},
		{
			"tpope/vim-fugitive",
			config = function()
				vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
			end,
		},
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
		},
		{
			"numToStr/Comment.nvim",
			opts = {},
		},
		{
			"neovim/nvim-lspconfig",
			event = { "BufReadPre", "BufNewFile" },
			dependencies = {
				{ "mason-org/mason.nvim", opts = {} },
				{ "mason-org/mason-lspconfig.nvim", opts = {} },
				{
					"hrsh7th/cmp-nvim-lsp",
					lazy = false,
				},
			},

			config = function()
				local lspconfig = require("lspconfig")
				local capabilities = require("cmp_nvim_lsp").default_capabilities()
				lspconfig.pyright.setup({
					capabilities = capabilities,
				})

				lspconfig.clangd.setup({
					capabilities = capabilities,
				})

				lspconfig.lua_ls.setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				})
			end,
		},
		{
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lua",
				"saadparwaiz1/cmp_luasnip",
				{
					"L3MON4D3/LuaSnip",
					dependencies = {
						"rafamadriz/friendly-snippets",
					},
				},
			},

			opts = function()
				local cmp = require("cmp")
				local luasnip = require("luasnip")

				require("luasnip.loaders.from_vscode").lazy_load()

				return {
					snippet = {
						expand = function(args)
							luasnip.lsp_expand(args.body)
						end,
					},
					mapping = cmp.mapping.preset.insert({
						["<C-Space>"] = cmp.mapping.complete(),
						["<CR>"] = cmp.mapping.confirm({ select = true }),
						["<Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_next_item()
							elseif luasnip.expand_or_jumpable() then
								luasnip.expand_or_jump()
							else
								fallback()
							end
						end, { "i", "s" }),

						["<S-Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_prev_item()
							elseif luasnip.jumpable(-1) then
								luasnip.jump(-1)
							else
								fallback()
							end
						end, { "i", "s" }),
					}),

					sources = {
						{ name = "nvim_lsp" },
						{ name = "luasnip" },
						{ name = "buffer" },
						{ name = "path" },
					},
				}
			end,
		},
		{
			"stevearc/conform.nvim",
			event = { "BufWritePre" },
			cmd = { "ConformInfo" },

			opts = {
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					markdown = { "prettier" },
					c = { "clang_format" },
					cpp = { "clang_format" },
				},

				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			},
		},
		{
			"nvim-tree/nvim-tree.lua",
			lazy = false,
			dependencies = {
				"nvim-tree/nvim-web-devicons",
			},
			keys = {
				{ "<leader>e", "<cmd>NvimTreeToggle<CR>" },
				{ "<leader>f", "<cmd>NvimTreeFindFile<CR>" },
			},

			opts = {
				disable_netrw = true,
				hijack_netrw = true,

				view = {
					width = 30,
					side = "left",
				},

				renderer = {
					icons = {
						show = {
							git = true,
							folder = true,
							file = true,
							folder_arrow = true,
						},
					},
				},

				git = {
					enable = true,
				},

				actions = {
					open_file = {
						quit_on_open = false,
					},
				},
			},
		},
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			opts = {},
		},
	},

	-- install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
