local M = {}

local function project_root(markers)
  local path = vim.api.nvim_buf_get_name(0)
  local root = vim.fs.root(path ~= "" and path or vim.loop.cwd(), markers)
  return root or vim.loop.cwd()
end

local function run_in_terminal(command, opts)
  opts = opts or {}

  if opts.layout == "tab" then
    vim.cmd("tabnew")
  else
    vim.cmd("botright " .. (opts.height or 14) .. "new")
  end

  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false

  local job_id = vim.fn.termopen(command, {
    cwd = opts.cwd or vim.loop.cwd(),
  })

  if job_id <= 0 then
    vim.notify("Failed to start terminal command: " .. command, vim.log.levels.ERROR)
    return
  end

  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.signcolumn = "no"
  vim.cmd("startinsert")
end

local function require_codex()
  if vim.fn.executable("codex") == 1 then
    return true
  end

  vim.notify("`codex` is not available in PATH.", vim.log.levels.WARN)
  return false
end

function M.setup()
  vim.api.nvim_create_user_command("ThemeCycle", function()
    require("config.theme").cycle()
  end, {})

  vim.api.nvim_create_user_command("ThemeLatte", function()
    require("config.theme").apply("latte")
  end, {})

  vim.api.nvim_create_user_command("ThemeFrappe", function()
    require("config.theme").apply("frappe")
  end, {})

  vim.api.nvim_create_user_command("ThemeMacchiato", function()
    require("config.theme").apply("macchiato")
  end, {})

  vim.api.nvim_create_user_command("ThemeMocha", function()
    require("config.theme").apply("mocha")
  end, {})

  vim.api.nvim_create_user_command("CargoRun", function()
    run_in_terminal("cargo run", {
      cwd = project_root({ "Cargo.toml", ".git" }),
      height = 14,
    })
  end, {})

  vim.api.nvim_create_user_command("CargoTest", function()
    run_in_terminal("cargo test", {
      cwd = project_root({ "Cargo.toml", ".git" }),
      height = 14,
    })
  end, {})

  vim.api.nvim_create_user_command("CargoCheck", function()
    run_in_terminal("cargo check", {
      cwd = project_root({ "Cargo.toml", ".git" }),
      height = 14,
    })
  end, {})

  vim.api.nvim_create_user_command("CargoClippy", function()
    run_in_terminal("cargo clippy --all-targets --all-features", {
      cwd = project_root({ "Cargo.toml", ".git" }),
      height = 14,
    })
  end, {})

  vim.api.nvim_create_user_command("Codex", function()
    if not require_codex() then
      return
    end

    run_in_terminal("codex", {
      cwd = project_root({ ".git" }),
      layout = "tab",
    })
  end, {})

  vim.api.nvim_create_user_command("CodexHere", function()
    if not require_codex() then
      return
    end

    run_in_terminal("codex", {
      cwd = vim.fn.expand("%:p:h"),
      layout = "tab",
    })
  end, {})
end

M.setup()

return M
