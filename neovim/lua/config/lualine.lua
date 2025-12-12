-- ~/.config/nvim/lua/config/lualine.lua

local M = {}

-- Only run word_count in prose filetypes
local function word_count()
  local ft = vim.bo.filetype
  if not vim.tbl_contains({ "markdown", "text", "tex" }, ft) then
    return ""
  end
  local wc = vim.fn.wordcount().words or 0
  return wc .. " words"
end

-- Safe hex under cursor, handles multibyte
local function char_hex()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""
  if col < 1 or col > #line then
    return ""
  end
  local char = vim.str_byteindex(line, col)
  if not char then return "" end
  return string.format("0x%02X", string.byte(line, char, char))
end

-- LSP diagnostics component
local function lsp_diagnostics()
  local stats = vim.diagnostic.get(0)
  local count = {
    errors   = #vim.diagnostic.filter(stats, { severity = vim.diagnostic.severity.ERROR }),
    warnings = #vim.diagnostic.filter(stats, { severity = vim.diagnostic.severity.WARN }),
    hints    = #vim.diagnostic.filter(stats, { severity = vim.diagnostic.severity.HINT }),
    info     = #vim.diagnostic.filter(stats, { severity = vim.diagnostic.severity.INFO }),
  }
  local parts = {}
  if count.errors   > 0 then table.insert(parts, " " .. count.errors) end
  if count.warnings > 0 then table.insert(parts, " " .. count.warnings) end
  if count.hints    > 0 then table.insert(parts, " " .. count.hints) end
  if count.info     > 0 then table.insert(parts, " " .. count.info) end
  return table.concat(parts, " ")
end

-- A simple scrollbar
local function scrollbar()
  local curr = vim.fn.line(".")
  local total = vim.fn.line("$")
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local idx = math.ceil((curr / total) * #chars)
  return chars[idx]
end

require("lualine").setup({
  options = {
    theme            = "gruvbox-material",
    icons_enabled    = true,
    component_separators = { left = "", right = "" },
    section_separators   = { left = "", right = "" },
    globalstatus     = true,
  },
  sections = {
    lualine_a = {
      { "mode", fmt = function(m) return m:sub(1,1) end, icon = "" },
    },
    lualine_b = {
      { "branch", icon = "" },   
      {
        "diff",
        symbols = {
          added    = "",
          modified = "",
          removed  = "",
        },
        cond = function() return vim.fn.isdirectory(".git") == 1 end,
      },
    },
    lualine_c = {
      {
        "filename",
        path = 1,
        symbols = {
          modified = "●",
          readonly = "",
          unnamed  = "[No Name]",
        },
      },
      { lsp_diagnostics, color = { fg = "#fb4934" } },
    },
    lualine_x = {
      scrollbar,
      char_hex,
      word_count,
      {
        function()
          local expandtab = vim.bo.expandtab
          local shiftwidth = vim.bo.shiftwidth
          return expandtab and "Spaces: " .. shiftwidth or "Tabs: " .. shiftwidth
        end,
      },
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_c = { "filename" },
    lualine_x = { "location" },
  },
})

