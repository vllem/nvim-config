vim.cmd [[
call plug#begin('~/.vim/plugged')

Plug 'neovim/nvim-lspconfig'

Plug 'sheerun/vim-polyglot'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

Plug 'dense-analysis/ale'

Plug 'polirritmico/monokai-nightasty.nvim'

call plug#end()
]]

vim.opt.background = "dark"
vim.cmd.colorscheme("monokai-nightasty")

require'lspconfig'.pyright.setup{} -- Python
require'lspconfig'.clangd.setup{} -- C/C+
require'lspconfig'.rust_analyzer.setup{} -- Rust

local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-1),
    ['<C-f>'] = cmp.mapping.scroll_docs(1),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), 
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }),
})

require("luasnip.loaders.from_vscode").lazy_load()

vim.g.ale_fix_on_save = 1 
vim.g.ale_linters_explicit = 1
vim.g.ale_python_flake8_executable = 'flake8'
vim.g.ale_linters = {
  python = {'flake8'},  
  cpp = {'clangd'},  
  c = {'clangd'},
  rust = {'rust_analyzer'}, 
}

vim.cmd [[filetype plugin indent on]]
vim.o.syntax = 'on'
vim.wo.number = true
vim.opt.swapfile = false
vim.o.wildmode = "longest,list"
vim.opt.clipboard = "unnamedplus"
