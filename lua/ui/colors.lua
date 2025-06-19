vim.cmd([[
  " === LINHAS ===
  highlight LineNr guifg=#565f89
  highlight CursorLineNr guifg=#AF89EB gui=bold
  highlight CursorLine cterm=NONE ctermbg=236 guibg=#2a2e3680

  " === TEXTO ===
  highlight Comment guifg=#565f89 gui=italic
  highligh Search guibg=#e0af68 guifg=#1a1b26
  highlight MatchParen guibg=#3b4261 guifg=#bb9afi7

  " === GITSIGNS ===
  highlight GitSignsAdd    guifg=#9ece6a
  highlight GitSignsChange guifg=#e0af68
  highlight GitSignsDelete guifg=#f7768e

  " === INDENTAÇÃO ===
  highlight IndentBlanklineChar guifg=#3b4261 gui=nocombine
  highlight IndentBlanklineContextChar guifg=#9ece6a gui=nocombine
]])
