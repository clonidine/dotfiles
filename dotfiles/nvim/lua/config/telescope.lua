local M = {}

function M.setup()
  require("telescope").setup({
    defaults = {
      layout_strategy = "horizontal",
      layout_config = {
        prompt_position = "top",
      },
      sorting_strategy = "ascending",
      mappings = {
        i = {
          ["<Esc>"] = require("telescope.actions").close,
        },
      },
    },
  })
end

return M
