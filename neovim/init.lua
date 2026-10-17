local opt = vim.opt

opt.number = true
opt.relativenumber = false
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.autoindent = true
opt.smartindent = true
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.hidden = true
opt.mouse = "a"
opt.cursorline = true
opt.termguicolors = true
opt.scrolloff = 8
opt.updatetime = 300
opt.ignorecase = true
opt.smartcase = true
opt.swapfile = false
opt.clipboard = "unnamedplus"
opt.colorcolumn = "120"
opt.signcolumn = "yes:1"
opt.showcmd = true

-- Filetype-specific keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "tex" },
  callback = function()
    local opts = { noremap = true, buffer = true, expr = false }
    -- Add closing $-symbol for LaTeX
    vim.keymap.set("i", "$", "$$<Left>", opts)
    -- Add closing |-symbol for LaTeX
    vim.keymap.set("i", "|", "||<Left>", opts)
    -- Add closing backtics for markdown
    if vim.bo.filetype == "markdown" then
      vim.keymap.set("i", "```", "```<CR><CR>```<Up><Up><Right><Right><Right>", opts)
    end
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
      ["'"] = "'",
      ['"'] = '"',
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
      ["'"] = "'",
      ['"'] = '"',
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
vim.keymap.set("i", "'", "''<Left>", { noremap = true })
vim.keymap.set("i", '"', '""<Left>', { noremap = true })

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<F2>", ":w<CR>")
vim.keymap.set("i", "<F2>", "<Esc>:w<CR>i<Right>")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    lazyrepo, lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error("Failed to clone lazy.nvim:\n" .. out)
  end
end

vim.opt.rtp:prepend(lazypath)

-- Load plugins from lua/plugins/
require("lazy").setup("plugins")

-- Set theme
vim.g.gruvbox_material_enable_italic = true
vim.o.background = "dark"
vim.keymap.set("n", "<leader>tb", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, { desc = "Toggle background" })
vim.cmd.colorscheme('gruvbox-material')

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

vim.lsp.config("pyright", {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
      },
    },
  },
})
vim.lsp.enable("pyright")

vim.lsp.config("texlab", {
  settings = {
    texlab = {
      build = { onSave = false },
      chktex = { onEdit = true },
    },
  },
})
vim.lsp.enable("texlab")
require("conform").setup({
  formatters_by_ft = { tex = { "latexindent" } },
})

vim.keymap.set("i", "<CR>", function()
  local line = vim.api.nvim_get_current_line()
  local env = line:match("^%s*\\begin{([^}]+)}%s*$")
  if env then
    return "<CR>\\end{" .. env .. "}<Esc>O"
  end
  return "<CR>"
end, { buffer = true, expr = true })
