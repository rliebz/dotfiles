vim.g.go_code_completion_enabled = 0
vim.g.go_doc_keywordprg_enabled = 0
vim.g.go_def_mapping_enabled = 0
vim.g.go_fmt_autosave = 0
vim.g.go_fmt_fail_silently = 1
vim.g.go_imports_autosave = 0
vim.g.go_mod_fmt_autosave = 1
vim.g.go_gopls_enabled = 0
vim.g.go_echo_command_info = 0
vim.g.go_jump_to_error = 0

function configure_vim_go()
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>cu', ':GoCoverage<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>cd', ':GoCoverageClear<CR>', { noremap = true })
end

vim.cmd([[
  augroup vim_go
    autocmd!
    autocmd FileType go lua configure_vim_go()
  augroup END
]])
