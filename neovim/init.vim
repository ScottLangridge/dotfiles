"""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Bindnigs - Global
"""""""""""""""""""""""""""""""""""""""""""""""""
imap jj <Esc>

nnoremap <C-_> gcc
vnoremap <C-_> gc

nnoremap <C-N> :Files<CR>
nnoremap <C-P> :NERDTree<CR>
nnoremap <C-p> :NERDTreeFind<CR>

nnoremap <C-F> :Ag<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Setting - Global
"""""""""""""""""""""""""""""""""""""""""""""""""
" Don't exit visual mode when changing tab depth
vnoremap < <gv
vnoremap > >gv

" Split behaviour
set splitright
set splitbelow
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Gets rid of annoying bell spam
set visualbell
set noerrorbells

" Line numbers
set nu

" Keep cursor centered
set scrolloff=5

" Don't save swap files
set noswapfile

" Open folders with Ranger
let g:NERDTreeHijackNetrw = 0
let g:ranger_replace_netrw = 1

"""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin List
"""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.local/share/nvim/site/plugged')

" Themes
Plug 'doums/darcula'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'gosukiwi/vim-atom-dark'
Plug 'arcticicestudio/nord-vim'
Plug 'cocopon/iceberg.vim'
Plug 'joshdick/onedark.vim'

Plug 'fnune/base16-vim'
Plug 'Shatur/neovim-ayu'

" Pretty Stuff 
Plug 'vim-airline/vim-airline'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'

" Quality of Life
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'justinmk/vim-sneak'
Plug 'terryma/vim-expand-region'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-autoformat/vim-autoformat'
Plug 'rbgrouleff/bclose.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'dbeniamine/cheat.sh-vim'

" Autocomplete/LSP Tools
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'davidhalter/jedi-vim'

" Other Tools
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'

" NERDTree
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

" Disabled
" Plug 'airblade/vim-gitgutter'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""
" Colour Settings
"""""""""""""""""""""""""""""""""""""""""""""""""
syntax on

" Theme
colorscheme atom-dark-256
set termguicolors

"""""""""""""""""""""""""""""""""""""""""""""""""
" Visual Settings
"""""""""""""""""""""""""""""""""""""""""""""""""
"Limelight
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

"Airline
let g:airline_powerline_fonts=1

"FZF
let g:fzf_preview_window = 'right:50%'

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"""""""""""""""""""""""""""""""""""""""""""""""""
" Autocomplete
"""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt=menu,menuone,noselect
lua <<EOF
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },

    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert({
      ['<Tab>'] = cmp.mapping.confirm({ select = true }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      -- { name = 'cmdline' } -- Disabled because it's very slow
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  require'lspconfig'.jedi_language_server.setup{}
  require('lspconfig')['solargraph'].setup {
    capabilities = capabilities
  }
EOF
