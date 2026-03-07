local map = vim.keymap.set

map("n", "<leader>w", "<cmd>write<cr>", { desc = "Write buffer" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })

map("n", "<leader>tt", "<cmd>ThemeCycle<cr>", { desc = "Cycle Catppuccin theme" })
map("n", "<leader>tl", "<cmd>ThemeLatte<cr>", { desc = "Theme Latte" })
map("n", "<leader>tf", "<cmd>ThemeFrappe<cr>", { desc = "Theme Frappe" })
map("n", "<leader>tm", "<cmd>ThemeMacchiato<cr>", { desc = "Theme Macchiato" })
map("n", "<leader>to", "<cmd>ThemeMocha<cr>", { desc = "Theme Mocha" })

map("n", "<leader>rr", "<cmd>CargoRun<cr>", { desc = "Cargo run" })
map("n", "<leader>rt", "<cmd>CargoTest<cr>", { desc = "Cargo test" })
map("n", "<leader>rc", "<cmd>CargoCheck<cr>", { desc = "Cargo check" })
map("n", "<leader>rl", "<cmd>CargoClippy<cr>", { desc = "Cargo clippy" })

map("n", "<leader>ai", "<cmd>Codex<cr>", { desc = "Open Codex in project root" })
map("n", "<leader>ac", "<cmd>CodexHere<cr>", { desc = "Open Codex in file directory" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }

    map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
    map("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Implementation" }))
    map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))
    map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
    map("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
    map("n", "<leader>ld", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))
    map("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
    map("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
    map("n", "<leader>lf", function()
      vim.lsp.buf.format({ async = false })
    end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
  end,
})
