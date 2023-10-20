local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then
  return
end

saga.setup({
  server_filetype_map = {
    typescript = 'typescript'
  }
})
