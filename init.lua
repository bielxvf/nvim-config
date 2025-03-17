-- Bootstrap Packer if not installed
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
end

require('plugins')

------------------- nvim-tree
--- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--- optionally enable 24-bit colour
vim.opt.termguicolors = true

--- empty setup using defaults
require('nvim-tree').setup()
-----------------------------

------------------- telescope-git-branch
require('telescope').setup()
require('telescope').load_extension('git_branch')
----------------------------------------

------------------- nvim-cmp
local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Disable default `<C-y>` mapping
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm completion
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' }, -- LSP
        { name = 'luasnip' },  -- Snippets
        { name = 'buffer' },   -- Buffer
        { name = 'path' },     -- Path
    }),
})
------------------- LSP for C/C++
require('lspconfig').clangd.setup({
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    on_attach = function(client, bufnr)
        --- Keybindings and other LSP-related setup
        local opts = { noremap = true, silent = true, buffer = bufnr }

        --- Example keybindings
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts) -- Go to declaration
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts) -- Go to definition
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- Show documentation
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts) -- Go to implementation
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts) -- Signature help
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts) -- Rename symbol
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- Code actions
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts) -- Show references
    end,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').clangd.setup({
    capabilities = capabilities,
})
-------------------

------------------- Flash
require('flash')

vim.keymap.set('n', 'f', function()
  require('flash').jump()
end, { desc = 'Flash jump (f)' })

vim.keymap.set('n', 'F', function()
  require('flash').jump({ search = { mode = 'search', max_length = 0 } })
end, { desc = 'Flash jump (F)' })

vim.keymap.set('n', 't', function()
  require('flash').jump({ search = { mode = 'search', max_length = 1 } })
end, { desc = 'Flash jump (t)' })

vim.keymap.set('n', 'T', function()
  require('flash').jump({ search = { mode = 'search', max_length = 1 }, forward = false })
end, { desc = 'Flash jump (T)' })
-------------------

------------------- Surround
require('nvim-surround')
-------------------

------------------- Lualine
require('lualine').setup()
-------------------

--- Custom configuration
vim.cmd [[colorscheme gruvbox-material]]
vim.cmd [[set nu]]
vim.cmd [[set rnu]]
vim.cmd [[nnoremap <silent> <cr> :noh<cr><cr>]]
vim.cmd [[set autoindent]]
vim.cmd [[set smartindent]]
vim.cmd [[set clipboard+=unnamedplus]]
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-n>", ":NvimTreeOpen<Enter>")
vim.keymap.set("n", "G", "Gzz")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

vim.g.mapleader = " "

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

local NS = { noremap = true, silent = true }

-- Aligns to 1 character
vim.keymap.set(
    'x',
    'aa',
    function()
        require'align'.align_to_char({
            length = 1,
        })
    end,
    NS
)

-- Aligns to 2 characters with previews
vim.keymap.set(
    'x',
    'ad',
    function()
        require'align'.align_to_char({
            preview = true,
            length = 2,
        })
    end,
    NS
)

-- Aligns to a string with previews
vim.keymap.set(
    'x',
    'aw',
    function()
        require'align'.align_to_string({
            preview = true,
            regex = false,
        })
    end,
    NS
)

-- Aligns to a Vim regex with previews
vim.keymap.set(
    'x',
    'ar',
    function()
        require'align'.align_to_string({
            preview = true,
            regex = true,
        })
    end,
    NS
)

-- Example gawip to align a paragraph to a string with previews
vim.keymap.set(
    'n',
    'gaw',
    function()
        local a = require'align'
        a.operator(
            a.align_to_string,
            {
                regex = false,
                preview = true,
            }
        )
    end,
    NS
)

-- Example gaaip to align a paragraph to 1 character
vim.keymap.set(
    'n',
    'gaa',
    function()
        local a = require'align'
        a.operator(a.align_to_char)
    end,
    NS
)
