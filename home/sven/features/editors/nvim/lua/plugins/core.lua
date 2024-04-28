local dracula = require("dracula")
dracula.setup({
    overrides = {
      MiniIndentscopeSymbol  = { fg = "#444444" },
    },
})

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    }
  }
}
