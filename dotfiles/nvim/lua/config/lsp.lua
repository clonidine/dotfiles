local M = {}

function M.setup()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  vim.diagnostic.config({
    severity_sort = true,
    underline = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 2,
      source = "if_many",
      prefix = "*",
    },
    float = {
      border = "rounded",
      source = "if_many",
    },
  })

  local function on_attach(client, bufnr)
    if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end

  vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  })
  vim.lsp.enable("lua_ls")

  vim.lsp.config("nil_ls", {
    capabilities = capabilities,
    on_attach = on_attach,
  })
  vim.lsp.enable("nil_ls")

  vim.g.rustaceanvim = {
    server = {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
          },
          check = {
            command = "clippy",
          },
          completion = {
            callable = {
              snippets = "fill_arguments",
            },
          },
          diagnostics = {
            enable = true,
          },
          inlayHints = {
            bindingModeHints = {
              enable = true,
            },
            closureReturnTypeHints = {
              enable = "always",
            },
            lifetimeElisionHints = {
              enable = "skip_trivial",
              useParameterNames = true,
            },
            parameterHints = {
              enable = true,
            },
            typeHints = {
              enable = true,
            },
          },
          procMacro = {
            enable = true,
          },
        },
      },
    },
  }
end

return M
