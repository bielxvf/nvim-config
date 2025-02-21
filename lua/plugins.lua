return require('packer').startup(function(use)
    -- Packer manages itself
    use 'wbthomason/packer.nvim'

    use 'NeogitOrg/neogit'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'mrloop/telescope-git-branch.nvim'
    use 'f-person/git-blame.nvim'
    use 'sainnhe/gruvbox-material'
    use 'nvim-tree/nvim-tree.lua'
    use 'folke/flash.nvim'
    use {
        'neovim/nvim-lspconfig',
        config = function()
        	require('lspconfig').clangd.setup({})
    	end
    }
    use {
        'hrsh7th/nvim-cmp',
            requires = {
                'hrsh7th/cmp-buffer', -- Buffer completions
                'hrsh7th/cmp-path',   -- Path completions
                'hrsh7th/cmp-nvim-lsp', -- LSP completions
                'hrsh7th/cmp-nvim-lua', -- Neovim Lua API completions
                'saadparwaiz1/cmp_luasnip', -- Snippet completions
                'L3MON4D3/LuaSnip', -- Snippet engine
            },
    }
    use {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require('nvim-autopairs').setup {}
        end
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
})
end)
