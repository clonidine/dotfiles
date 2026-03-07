local M = {}

function M.setup()
  require("lualine").setup({
    options = {
      theme = "catppuccin",
      globalstatus = true,
      component_separators = "|",
      section_separators = "",
    },
  })
end

return M
