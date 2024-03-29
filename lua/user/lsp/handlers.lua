local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- TODO: backfill this to template
M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]] ,
      false
    )
  end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  --[[ vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts) ]]
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  --[[ vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts) ]]
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  --[[ vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts) ]]
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format{ async = true }' ]]
end

M.on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end

  if client.name == "tsserver" or client.name == "volar" or client.name == "volar_html" then
    client.server_capabilities.documentFormattingProvider = false
  end
  --[[ print(client.name) ]]
  --[[ if client.name == "eslint" then ]]
  --[[   client.server_capabilities.documentFormattingProvider = false ]]
  --[[ end ]]
  --[[ if client.name == "tsserver" then ]]
  --[[   client.server_capabilities.documentFormattingProvider = false ]]
  --[[ end ]]
  --[[]]
  --[[ if client.name == "volar" then ]]
  --[[   client.server_capabilities.documentFormattingProvider = false ]]
  --[[ end ]]
  --[[]]
  --[[ if client.name == "sumneko_lua" then ]]
  --[[   client.server_capabilities.documentFormattingProvider = false ]]
  --[[ end ]]
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

--[[ local capabilities = vim.lsp.protocol.make_client_capabilities() ]]
--[[]]
--[[ local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp") ]]
--[[ if not status_ok then ]]
--[[   return ]]
--[[ end ]]
--[[]]
--[[ M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities) ]]

return M
