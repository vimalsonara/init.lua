return {
  {
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = true, -- Change this to true for error notifications
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 2000,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { { "prettierd", "prettier" } },
        javascriptreact = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
        html = { { "prettierd", "prettier" } },
        css = { { "prettierd", "prettier" } },
        json = { { "prettierd", "prettier" } },
        markdown = { { "prettierd", "prettier" } },
        yaml = { { "prettierd", "prettier" } },
        mdx = { { "prettierd", "prettier" } },
      },
    },
    config = function(_, opts)
      local conform = require("conform")

      conform.setup(opts)

      -- Add logging
      -- conform.formatters.prettier = {
      --   prepend_args = function()
      --     print("Prettier formatter called")
      --     return {}
      --   end
      -- }

      -- Log when format_on_save is triggered
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          print("Format on save triggered for buffer: " .. vim.fn.bufname())
        end,
      })
    end,
  },
}
