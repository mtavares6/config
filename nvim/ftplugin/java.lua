local home = os.getenv 'HOME'
local workspace_path = home .. '/.local/share/nvim/jdtls-workspace/'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = workspace_path .. project_name

-- Needed for debugging
local bundles = {
  vim.fn.glob(home .. '/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar'),
}
-- Needed for running/debugging unit tests
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. '/.local/share/nvim/mason/share/java-test/*.jar', 1), '\n'))

local status, jdtls = pcall(require, 'jdtls')
if not status then
  return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities

local mason_share_path = vim.fn.stdpath 'data' .. '/mason/share'

-- Java Debug Adapter path
local java_debug_path = vim.fn.glob(mason_share_path .. '/java-debug-adapter/com.microsoft.java.debug.plugin.jar', true)
if java_debug_path ~= '' then
  table.insert(bundles, java_debug_path)
end

local java_test_path = vim.fn.glob(mason_share_path .. '/java-test/com.microsoft.java.test.plugin.jar', true)
if java_test_path ~= '' then
  table.insert(bundles, java_test_path)
end

-- Start jdtls with proper initialization
require('jdtls').start_or_attach {
  cmd = {
    '/Users/MiguelTavares/Library/Java/JavaVirtualMachines/openjdk-21.0.1/Contents/Home/bin/java', -- Ensure Java is in PATH or use full path
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1G',
    '-Xmx2G',
    '--add-modules=ALL-SYSTEM',
    '--add-opens=java.base/java.util=ALL-UNNAMED',
    '--add-opens=java.base/java.lang=ALL-UNNAMED',
    '--add-opens=java.base/java.lang.reflect=ALL-UNNAMED',
    -- '-javaagent:'
    --   .. home
    --   .. '/.local/share/nvim/mason/packages/jdtls/lombok.jar', -- Uncomment if needed
    '-jar',
    vim.env.HOME .. '/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar',
    '-configuration',
    home .. '/.local/share/nvim/mason/packages/jdtls/config_mac_arm',
    '-data',
    workspace_dir, -- Removed trailing space
  },

  settings = {
    java = {
      runtimes = {
        {
          name = '11.0.25-amzn',
          path = '/Users/MiguelTavares/.sdkman/candidates/java/11.0.25-amzn',
        },
        {
          name = 'JavaSE-17',
          path = '/opt/homebrew/Cellar/openjdk@17',
        },
      },
      signatureHelp = { enabled = true },
      extendedClientCapabilities = extendedClientCapabilities,
      maven = {
        downloadSources = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,

        parameterNames = {
          enabled = 'all', -- literals, all, none
        },
      },
      format = {
        enabled = false,
      },
    },
  },

  init_options = {
    bundles = bundles, -- Load Java Debug and Test extensions
  },
  on_attach = function(client, bufnr)
    -- Ensure that jdtls is attached to the current buffer
    if client.name == 'jdtls' then
      print 'jdtls is attached'

      -- Configure DAP if jdtls client is attached
      require('jdtls').setup_dap {
        hotcodereplace = 'auto',
        config_overrides = {}, -- Required field
      }
      require('jdtls.dap').setup_dap_main_class_configs()
    end
  end,
}

-- For debugging, print active clients
-- vim.cmd [[
--   autocmd BufRead *.java lua require('jdtls').get_active_clients()
-- ]]
