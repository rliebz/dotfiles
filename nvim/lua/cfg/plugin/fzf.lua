vim.g.fzf_layout = {
	window = {
		width = 0.9,
		height = 0.6,
		highlight = "FloatBorder",
	},
}

vim.g.rg_ignore_opts = '--hidden -g "!.git/*" -g "!*.min.js" -g "!*.js.map"'
if vim.api.nvim_eval('executable("rg")') then
	vim.env.FZF_DEFAULT_COMMAND = "rg --files --follow " .. vim.g.rg_ignore_opts
end

vim.cmd([[
function! RipgrepFzf(args)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case ' . g:rg_ignore_opts . ' %s %s || true'
  let initial_command = printf(command_fmt, a:args, '""')
  let reload_command = printf(command_fmt, a:args, '{q}')
  let spec = {'options': [ '--reverse', '--phony', '--bind', 'change:reload:'.reload_command ]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec))
endfunction
command! -nargs=* RG call RipgrepFzf(<q-args>)
nnoremap <C-P> :FZF --reverse<CR>
nnoremap <C-F> :RG<CR>
]])
