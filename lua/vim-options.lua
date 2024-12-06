vim.g.mapleader = " "
vim.cmd("set number relativenumber")

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.incsearch = true

vim.opt.scrolloff = 12

vim.opt.colorcolumn = "80"

vim.api.nvim_set_option("clipboard", "unnamedplus")

vim.cmd([[
	augroup YankHighlight
		autocmd!
		autocmd TextYankPost * silent! lua vim.highlight.on_yank()
	augroup end
]])
