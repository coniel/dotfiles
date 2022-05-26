require('neogen').setup({
  enabled = true,
  snippet_engine = 'luasnip',
  languages = {
    typescript = {
      template = {
        annotation_convention = 'tsdoc'
      }
    }
  }
})
