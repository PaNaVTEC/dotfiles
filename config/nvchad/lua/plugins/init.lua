return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  { "j-hui/fidget.nvim", opts = { } },
	{ "tpope/vim-surround" },
  {
    "scalameta/nvim-metals",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "scala", "sbt", "java" },
    opts = function()
      local config = require("metals").bare_config()
      local lspconfig = require "nvchad.configs.lspconfig"
      config.settings = {
        superMethodLensesEnabled = true,
        showImplicitArguments = true,
        showInferredType = true,
        showImplicitConversionsAndClasses = true,
        excludedPackages = {},
        defaultBspToBuildTool = true
      }
      config.init_options.statusBarProvider = "on"
      config.on_attach = lspconfig.on_attach
      config.on_init = lspconfig.on_init
      config.capabilities = lspconfig.caps
      return config
    end,
    config = function(self, config)
      local group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(config)
        end,
        group = group,
      })
    end,
  },
}
