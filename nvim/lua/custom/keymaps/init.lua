-- Neogit
local neogit = require 'neogit'

vim.keymap.set('n', '<leader>go', neogit.open, { silent = true, noremap = true })

vim.keymap.set('n', '<leader>gc', ':Neogit commit<CR>', { silent = true, noremap = true })

vim.keymap.set('n', '<leader>gp', ':Neogit pull<CR>', { silent = true, noremap = true })

vim.keymap.set('n', '<leader>gP', ':Neogit push<CR>', { silent = true, noremap = true })

vim.keymap.set('n', '<leader>gb', ':Telescope git_branches<CR>', { silent = true, noremap = true })

vim.keymap.set('n', '<leader>gB', ':G blame<CR>', { silent = true, noremap = true })

-- Java
vim.keymap.set('n', '<leader>co', "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = 'Organize Imports' })
vim.keymap.set('n', '<leader>crv', "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = 'Extract Variable' })
vim.keymap.set('v', '<leader>crv', "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", { desc = 'Extract Variable' })
vim.keymap.set('n', '<leader>crc', "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = 'Extract Constant' })
vim.keymap.set('v', '<leader>crc', "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", { desc = 'Extract Constant' })
vim.keymap.set('v', '<leader>crm', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { desc = 'Extract Method' })

-- Debugging
vim.keymap.set('n', '<leader>bb', "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
vim.keymap.set('n', '<leader>bc', "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
vim.keymap.set('n', '<leader>bl', "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
vim.keymap.set('n', '<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>")
vim.keymap.set('n', '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>')
vim.keymap.set('n', '<leader>dc', "<cmd>lua require'dap'.continue()<cr>")
vim.keymap.set('n', '<leader>dj', "<cmd>lua require'dap'.step_over()<cr>")
vim.keymap.set('n', '<leader>dk', "<cmd>lua require'dap'.step_into()<cr>")
vim.keymap.set('n', '<leader>do', "<cmd>lua require'dap'.step_out()<cr>")
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
