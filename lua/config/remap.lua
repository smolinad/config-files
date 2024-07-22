vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>x', vim.cmd.Ex)

-- Selected and move
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

--Folder
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

--Escape
vim.keymap.set('i', 'C-z>', '<Esc>')

--Parenthesis
vim.keymap.set('i', '(', '()<Left>')
vim.keymap.set('i', '{', '{}<Left>')
vim.keymap.set('i', '[', '[]<Left>')
vim.keymap.set('i', '"', '""<Left>')
vim.keymap.set('i', "'", "''<Left>")
