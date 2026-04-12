-- Personal keymaps and options ported from legacy init.vim
-- These supplement the kickstart.nvim defaults

-- [[ Options ]]

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.swapfile = false

-- [[ Keymaps ]]

-- Q replays macro q (instead of Ex mode)
vim.keymap.set('n', 'Q', '@q')

-- Split creation
vim.keymap.set('n', '<Leader>d', ':<C-u>vsplit<CR><C-w>w', { desc = 'Vertical split', silent = true })
vim.keymap.set('n', '<Leader>D', ':<C-u>split<CR><C-w>w', { desc = 'Horizontal split', silent = true })

-- Buffer navigation
vim.keymap.set('n', '<S-Tab>', ':bn<CR>', { desc = 'Next buffer', silent = true })
vim.keymap.set('n', '<leader>c', ':bp <BAR> bd #<CR>', { desc = 'Close buffer', silent = true })

-- Maintain visual mode after shifting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Move visual block up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move block down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move block up' })

-- Strong moves: L -> end of line, H -> start of line
vim.keymap.set('n', 'L', '$')
vim.keymap.set('n', 'H', '0')

-- Move by display lines (for wrapped lines)
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Center screen on search navigation
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
