-- Set options
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.hidden = true
vim.opt.mouse = "a"
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 300
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"

-- Filetype-specific keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    local opts = { noremap = true, buffer = true, expr = false }
    -- Add closing $-symbol for LaTeX
    vim.keymap.set("i", "$", "$$<Left>", opts)
    -- Add closing backtics and place the cursor after the three initial ones where the language is defined for markdown
    vim.keymap.set("i", "```", "```<CR><CR>```<Up><Up><Right><Right><Right>", opts)
  end,
})

-- Delete both characters when the cursor is between {}
vim.keymap.set("i", "<Del>", function()
  local col = vim.fn.col(".")
  local line = vim.fn.getline(".")
  if col <= #line then
    local prev_char = line:sub(col - 1, col - 1)
    local next_char = line:sub(col, col)
    local pairs = {
      ["{"] = "}",
      ["("] = ")",
      ["["] = "]",
      ['"'] = '"',
      ["'"] = "'",
      ["`"] = "`",
    }
    if pairs[prev_char] == next_char then
      return "<Del><BS>"
    end
  end
  return "<Del>"
end, { expr = true })

vim.keymap.set("i", "<BS>", function()
  local col = vim.fn.col(".")
  local line = vim.fn.getline(".")
  if col > 1 then
    local prev_char = line:sub(col - 1, col - 1)
    local next_char = line:sub(col, col)
    local pairs = {
      ["{"] = "}",
      ["("] = ")",
      ["["] = "]",
      ['"'] = '"',
      ["'"] = "'",
      ["`"] = "`",
    }
    if pairs[prev_char] == next_char then
      return "<BS><Del>"
    end
  end
  return "<BS>"
end, { expr = true })

-- Insert mappings
vim.keymap.set("i", "{", "{}<Left>", { noremap = true })
vim.keymap.set("i", "(", "()<Left>", { noremap = true })
vim.keymap.set("i", "[", "[]<Left>", { noremap = true })
vim.keymap.set("i", '"', '""<left>', { noremap = true })
vim.keymap.set("i", "'", "''<Left>", { noremap = true })

-- Keymaps
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " " -- Set <leader> key

-- Basic keymaps
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<F2>", ":w<CR>")
vim.keymap.set("i", "<F2>", "<Esc>:w<CR>i<Right>")

-- Plugins
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")
require("lazy").setup({
  { 
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = { "nvim-lua/plenary.nvim" } 
  },
  { 
    "nvim-treesitter/nvim-treesitter",
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
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    cmd = { "MarkdownPreviewToggle", "MarkdowPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
  },  
  { 
    "sainnhe/gruvbox-material"
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
  },
  {
    "nvim-tree/nvim-web-devicons",
  },
  {
    "goolord/alpha-nvim",
    -- dependencies = { 'echasnovski/mini.icons' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local startify = require("alpha.themes.startify")
      -- available: devicons, mini, default is mini
      -- if provider not loaded and enabled is true, it will try to use another provider
      startify.file_icons.provider = "devicons"
      require("alpha").setup(
        startify.config
      )
    end,
  },
  {
    "rcarriga/nvim-notify",
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    'dense-analysis/ale',
    config = function()
        -- Configuration goes here.
        local g = vim.g

        g.ale_ruby_rubocop_auto_correct_all = 1

        g.ale_linters = {
            ruby = {'rubocop', 'ruby'},
            lua = {'lua_language_server'}
        }
    end
  },
})
-- Set theme
vim.g.gruvbox_material_enable_italic = true
vim.o.background = "dark" -- Default to dark theme
vim.keymap.set("n", "<leader>tb", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, { desc = "Toggle background" })

vim.cmd.colorscheme('gruvbox-material')

-- Markdown-preview settings
require("config.markdown")

-- Setup nvim-cmp
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- C/C++ LSP with clangd
vim.lsp.config.clangd = {
  capabilities = capabilities,
}
vim.lsp.enable("clangd")

-- Python LSP
vim.lsp.config.pyright = {
  capabilities = capabilities,
}
vim.lsp.enable("pyright")

-- Rust LSP with rust-analyzer
vim.lsp.config.rust_analyzer = {
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      checkOnSave = true,
      check = { command = "clippy" },
      inlayHints = {
        enable = true,
        locationLinks = false, -- don't make hints clickable
      },
    },
  },
  on_attach = function(client, bufnr)
    -- Enable inlay hints automatically when Rust LSP attaches
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- Optional: toggle inlay hints manually with <leader>ih
    vim.keymap.set("n", "<leader>ih", function()
      local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
      vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
    end, { desc = "Toggle Inlay Hints", buffer = bufnr })
  end,
}

-- Enable rust-analyzer
vim.lsp.enable("rust_analyzer")

