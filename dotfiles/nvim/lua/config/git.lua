local M = {}

function M.setup()
  require("gitsigns").setup({
    current_line_blame = false,
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "^" },
      changedelete = { text = "~" },
    },
  })
end

return M
