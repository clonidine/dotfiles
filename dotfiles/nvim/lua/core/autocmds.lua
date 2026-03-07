vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("dotfiles-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("dotfiles-commit-settings", { clear = true }),
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.colorcolumn = "51,73"
    vim.opt_local.textwidth = 72
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("dotfiles-rust-format", { clear = true }),
  pattern = "*.rs",
  callback = function(args)
    local clients = vim.lsp.get_clients({ bufnr = args.buf, name = "rust-analyzer" })
    if #clients == 0 then
      return
    end

    vim.lsp.buf.format({
      bufnr = args.buf,
      async = false,
      timeout_ms = 3000,
    })
  end,
})
