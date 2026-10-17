return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	{ 
		 "tpope/vim-sleuth" 
	},
	{ 
		"sainnhe/gruvbox-material"
	},
	{ 
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		build = ":TSUpdate"
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	{
		"nvim-tree/nvim-web-devicons",
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		config = function()
			require("config.lualine")
		end,
	},
	{
		"tpope/vim-surround",
	},
	{
		"windwp/nvim-autopairs",
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"rcarriga/nvim-notify"
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local startify = require("alpha.themes.startify")
			startify.file_icons.provider = "devicons"
			require("alpha").setup(startify.config)
		end,
	},
	{
		"dense-analysis/ale",
		config = function()
			local g = vim.g
			g.ale_ruby_rubocop_auto_correct_all = 1
			g.ale_linters = {
				ruby = { "rubocop", "ruby" },
				lua = { "lua_language_server" }
			}
		end
	},
	{
		"lervag/vimtex",
		lazy = false,
		tag = "v2.17",
		init = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_compiler_method = "latexmk"
			vim.g.vimtex_quickfix_mode = 0
			--vim.g.maplocalleader = ","
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "prettierd", "prettier" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},
 }
