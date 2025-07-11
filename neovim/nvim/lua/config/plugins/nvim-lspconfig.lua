return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',            -- For automatic LSP installation
    'williamboman/mason-lspconfig.nvim',  -- For mason-lspconfig integration
    'hrsh7th/cmp-nvim-lsp',              -- For autocompletion integration
  },
  config = function()
    require('mason').setup({
        ensure_installed = {
            'clangd',
            'clang-format',
            'codelldb',
        },
    })

    require('mason-lspconfig').setup({
      automatic_installation = true,
    })

    local function map(buf, keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = buf, desc = 'LSP: ' .. desc })
    end

    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
            vim.lsp.buf.format({
                async = false,
                bufnr = args.buf
            })
        end
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local buf = event.buf
        map(buf, 'gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        map(buf, 'gr', vim.lsp.buf.references, '[G]oto [R]eferences')
        map(buf, 'gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        map(buf, 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map(buf, '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map(buf, '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities()

    local lspconfig = require('lspconfig')

    lspconfig.clangd.setup({
      capabilities = capabilities,
      cmd = {"clangd", "--offset-encoding=utf-16",}
    })

    lspconfig.pylsp.setup({
      capabilities = capabilities,
      settings = {
        pylsp = {
          plugins = {
            pyflakes = { enabled = true },
            pylint = { enabled = true },
            autopep8 = { enabled = true },
          },
        },
      },
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          diagnostics = { globals = { 'vim' } },
          workspace = { library = vim.api.nvim_get_runtime_file("", true) },
          telemetry = { enable = false },
        },
      },
    })
  end,
}

