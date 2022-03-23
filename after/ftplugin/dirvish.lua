vim.g.dirvish_dovish_map_keys = 0

local map = vim.keymap.set
map('n', 'o', '<Plug>(dovish_create_file)', {silent = true, buffer = 0})
map('n', 'O', '<Plug>(dovish_create_directory)', {silent = true, buffer = 0})
map('n', 'dk', '<Plug>(dovish_delete)', {silent = true, buffer = 0})
map('n', 'r', '<Plug>(dovish_rename)', {silent = true, buffer = 0})
map('n', 'y', '<Plug>(dovish_yank)', {silent = true, buffer = 0})
map('n', 'y', '<Plug>(dovish_yank)', {silent = true, buffer = 0})
map('n', 'p', '<Plug>(dovish_copy)', {silent = true, buffer = 0})
map('n', 'P', '<Plug>(dovish_move)', {silent = true, buffer = 0})
