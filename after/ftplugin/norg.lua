vim.opt.textwidth = 80


vim.keymap.set({"o", "x"}, "ih", "<Plug>(neorg.text-objects.textobject.heading.inner)", { buffer = true })
vim.keymap.set({"o", "x"}, "ah", "<Plug>(neorg.text-objects.textobject.heading.outer)", { buffer = true })
