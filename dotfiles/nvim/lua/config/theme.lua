local M = {}

local flavours = { "latte", "frappe", "macchiato", "mocha" }
local current = "mocha"

function M.apply(flavour)
  current = flavour
  vim.g.catppuccin_flavour = flavour
  vim.cmd.colorscheme("catppuccin")
  vim.notify("Catppuccin " .. flavour, vim.log.levels.INFO, { title = "Theme" })
end

function M.cycle()
  local index = 1

  for i, flavour in ipairs(flavours) do
    if flavour == current then
      index = i
      break
    end
  end

  local next_index = (index % #flavours) + 1
  M.apply(flavours[next_index])
end

function M.setup()
  require("catppuccin").setup({
    flavour = current,
    background = {
      light = "latte",
      dark = "mocha",
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
      telescope = true,
      treesitter = true,
    },
  })

  M.apply(current)
end

return M
