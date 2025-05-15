vim.keymap.set('n', '<C-j>', '10j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '10k', { noremap = true, silent = true })

-- Neogit
local neogit = require 'neogit'

--vim.api.nvim_set_keymap('i', '{', '{}<Left><CR><CR><Up><Tab>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>go', neogit.open, { silent = true, noremap = true })

vim.keymap.set('n', '<leader>gc', ':Neogit commit<CR>', { silent = true, noremap = true })

vim.keymap.set('n', '<leader>gP', ':Neogit push<CR>', { silent = true, noremap = true })

vim.keymap.set('n', '<leader>gb', ':Telescope git_branches<CR>', { silent = true, noremap = true })

vim.keymap.set('n', '<leader>gp', ':Neogit pull<CR>', { silent = true, noremap = true })

-- TS
vim.keymap.set('n', '<leader>io', function()
  vim.lsp.buf.execute_command {
    command = '_typescript.organizeImports',
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
end, { desc = 'Organize Imports (TS)' })

vim.keymap.set('n', '<leader>ia', function()
  vim.lsp.buf.code_action {
    context = { only = { 'source.addMissingImports.ts' } },
    apply = true,
  }
end, { desc = 'Import Missing Imports (TS)' })

-- Java
vim.keymap.set('n', '<leader>co', "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = 'Organize Imports' })
vim.keymap.set('n', '<leader>crv', "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = 'Extract Variable' })
vim.keymap.set('v', '<leader>crv', "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", { desc = 'Extract Variable' })
vim.keymap.set('n', '<leader>crc', "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = 'Extract Constant' })
vim.keymap.set('v', '<leader>crc', "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", { desc = 'Extract Constant' })
vim.keymap.set('v', '<leader>crm', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { desc = 'Extract Method' })
-- Filetype-specific keymaps (these can be done in the ftplugin directory instead if you prefer)
vim.keymap.set('n', '<leader>jo', function()
  if vim.bo.filetype == 'java' then
    require('jdtls').organize_imports()
  end
end)

vim.keymap.set('n', '<leader>ju', function()
  if vim.bo.filetype == 'java' then
    require('jdtls').update_projects_config()
  end
end)

vim.keymap.set('n', '<leader>jc', function()
  if vim.bo.filetype == 'java' then
    require('jdtls').test_class()
  end
end)

vim.keymap.set('n', '<leader>jm', function()
  if vim.bo.filetype == 'java' then
    require('jdtls').test_nearest_method()
  end
end)
-- Debugging
vim.keymap.set('n', '<leader>du', function()
  require('dapui').toggle()
end)
vim.keymap.set('n', '<leader>bb', "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
vim.keymap.set('n', '<leader>bc', "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
vim.keymap.set('n', '<leader>bl', "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
vim.keymap.set('n', '<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>")
vim.keymap.set('n', '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>')
vim.keymap.set('n', '<leader>dc', "<cmd>lua require'dap'.continue()<cr>")
vim.keymap.set('n', '<leader>dj', "<cmd>lua require'dap'.step_over()<cr>")
vim.keymap.set('n', '<leader>dk', "<cmd>lua require'dap'.step_into()<cr>")
vim.keymap.set('n', '<leader>do', "<cmd>lua require'dap'.step_out()<cr>")
vim.keymap.set('n', '<space>?', function()
  require('dapui').eval(nil, { enter = true })
end)

vim.keymap.set('n', '<leader>dd', function()
  require('dap').disconnect()
  require('dapui').close()
end)
vim.keymap.set('n', '<leader>dt', function()
  require('dap').terminate()
  require('dapui').close()
end)
vim.keymap.set('n', '<leader>dr', "<cmd>lua require'dap'.repl.toggle()<cr>")
vim.keymap.set('n', '<leader>dl', "<cmd>lua require'dap'.run_last()<cr>")
vim.keymap.set('n', '<leader>di', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set('n', '<leader>d?', function()
  local widgets = require 'dap.ui.widgets'
  widgets.centered_float(widgets.scopes)
end)
vim.keymap.set('n', '<leader>df', '<cmd>Telescope dap frames<cr>')
vim.keymap.set('n', '<leader>dh', '<cmd>Telescope dap commands<cr>')
vim.keymap.set('n', '<leader>de', function()
  require('telescope.builtin').diagnostics { default_text = ':E:' }
end)

-- Harpoon
local harpoon = require 'harpoon'

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set('n', '<leader>a', function()
  harpoon:list():add()
end)

vim.keymap.set('n', '<leader>hc', function()
  harpoon:list():clear()
end, { desc = 'Clear all Harpoon marks' })
vim.keymap.set('n', '<leader>h', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set('n', '<C-y>', function()
  harpoon:list():select(1)
end)

vim.keymap.set('n', '<C-u>', function()
  harpoon:list():select(2)
end)
vim.keymap.set('n', '<C-i>', function()
  harpoon:list():select(3)
end)
vim.keymap.set('n', '<C-o>', function()
  harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set('n', '<C-p>', function()
  harpoon:list():prev()
end)
vim.keymap.set('n', '<C-n>', function()
  harpoon:list():next()
end)

-- Telescope
vim.keymap.set('n', '<leader>ff', function()
  require('telescope.builtin').find_files {
    hidden = true,
    no_ignore = true,
    follow = true,
  }
end, { desc = '[F]ind [F]iles (include .ignore)' })
