local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("user.lsp.lsp-installer")
require("user.lsp.handlers").setup()
require "lsp_signature".setup({
  hint_enable = false
})
require("user.lsp.null-ls")
require("user.lsp.trouble")
