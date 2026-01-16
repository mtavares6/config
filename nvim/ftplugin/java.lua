local home = os.getenv 'HOME'
local workspace_path = home .. '/.local/share/nvim/jdtls-workspace/'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = workspace_path .. project_name

-- Bundle configuration for debugging and testing
local bundles = {
  vim.fn.glob(home .. '/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar'),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. '/.local/share/nvim/mason/share/java-test/*.jar', 1), '\n'))

-- Load jdtls with error handling
local status, jdtls = pcall(require, 'jdtls')
if not status then
  return
end

-- Load project-specific configuration
local project_config = {}
local root_markers = { '.git', 'pom.xml', 'build.gradle', 'settings.gradle' } -- Added settings.gradle
local root_dir = require('jdtls.setup').find_root(root_markers)

if root_dir then
  local project_config_path = root_dir .. '/.jdtls.lua'
  if vim.fn.filereadable(project_config_path) == 1 then
    local ok, config = pcall(dofile, project_config_path)
    if ok then
      project_config = config
    else
      vim.notify('Error loading .jdtls.lua: ' .. config, vim.log.levels.ERROR)
    end
  end
end

-- Start jdtls with proper initialization
require('jdtls').start_or_attach {
  cmd = {
    '/Users/MiguelTavares/Library/Java/JavaVirtualMachines/openjdk-21.0.1/Contents/Home/bin/java', -- Use system Java (must be JDK 17+)
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
    '-jar',
    home .. '/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar',
    '-configuration',
    home .. '/.local/share/nvim/mason/packages/jdtls/config_mac_arm',
    '-data',
    workspace_dir,
  },

  settings = {
    java = vim.tbl_deep_extend('force', {
      configuration = {
        updateBuildConfiguration = 'automatic',
        runtimes = {
          {
            name = '21.0.6-amzn',
            path = '/Users/MiguelTavares/.sdkman/candidates/21.0.6-amzn',
          },
          {
            name = '11.0.25-amzn',
            path = '/Users/MiguelTavares/.sdkman/candidates/java/11.0.25-amzn',
          },
          {
            name = 'JavaSE-17',
            path = '/opt/homebrew/Cellar/openjdk@17',
          },
        },
      },
      signatureHelp = { enabled = true },
      maven = { downloadSources = true },
      referencesCodeLens = { enabled = true },
      references = {
        includeDecompiledSources = true,
        parameterNames = { enabled = 'all' },
      },
      format = {
        enabled = true,
        settings = {
          url = vim.fn.expand '~/.config/nvim/ftplugin/carrot-style.xml',
          profile = 'carrot',
        },
      },
    }, project_config.java or {}),
  },

  init_options = { bundles = bundles },

  on_attach = function(client, bufnr)
    if client.name == 'jdtls' then
      -- Set project-specific runtime if configured
      if project_config.java and project_config.java.configuration and project_config.java.configuration.runtimes then
        for _, runtime in ipairs(project_config.java.configuration.runtimes) do
          if runtime.default then
            pcall(require('jdtls').set_runtime, runtime.name)
            break
          end
        end
      end

      -- Configure DAP
      require('jdtls').setup_dap { hotcodereplace = 'auto' }
      require('jdtls.dap').setup_dap_main_class_configs()
    end
  end,
}

-- Add command to set runtime manually
vim.api.nvim_buf_create_user_command(0, 'JdtSetRuntime', function(opts)
  require('jdtls').set_runtime(opts.args)
end, { nargs = 1, complete = require('jdtls')._complete_set_runtime })
