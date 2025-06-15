return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      -- Add LSP dependency
      'neovim/nvim-lspconfig',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        mapping = cmp.mapping.preset.insert {
          --['<C-n>'] = cmp.mapping.select_next_item(),
          --['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'orgmode'},
          {
            name = 'lazydev',
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
      -- Setup LSP after cmp is configured
      local lspconfig = require('lspconfig')
      -- Python LSP
      lspconfig.pyright.setup{}
      -- LaTeX LSP
      lspconfig.texlab.setup{}
      -- Lua LSP
      lspconfig.lua_ls.setup{
        settings = {
          Lua = {
            diagnostics = {
              globals = {'vim'},
            },
          },
        },
      }
      -- C/C++ LSP
      lspconfig.clangd.setup{}
      -- Keybindings for LSP functionality
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {desc = 'Hover Documentation'})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {desc = 'Go to Definition'})
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, {desc = 'Go to References'})
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {desc = 'Code Action'})
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {desc = 'Rename Symbol'})
    end,
}
