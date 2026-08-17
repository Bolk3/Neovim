local	telescope_builtin = require("telescope.builtin")
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.keymap.set('t', '<esc>' ,"<C-\\><C-n>", {desc = 'Exit terminal mode in terminal'})

vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {desc = 'Telescope find file'})
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {desc = 'Telescope live grep'})
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {desc = 'Telescope buffers'})
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {desc = 'Telescope help tags'})
vim.keymap.set('n', '<leader>ft', "<Cmd>Themery<CR>", {desc = 'Change theme'})

map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)

map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)

map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)

map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)

map('n', '<C-p>',   '<Cmd>BufferPick<CR>', opts)
map('n', '<C-s-p>', '<Cmd>BufferPickDelete<CR>', opts)

map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
