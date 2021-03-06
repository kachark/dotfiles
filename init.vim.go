"*********************************************************************
"#########################  VIMRC FOR GO ############################
"*********************************************************************

"## support for Alacritty true color ##
"execute "set t_8f=\e[38;2;%lu;%lu;%lum"
"execute "set t_8f=\e[48;2;%lu;%lu;%lum"
" set t_ut=


" "**************vim-plug package manager (faster than vundle)
call plug#begin('~/.vim/plugged')

" vim-go
Plug 'fatih/vim-go'

" go debugger
Plug 'sebdah/vim-delve'

" ale linter
Plug 'w0rp/ale'

" fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" *** fuzzy finder that works with vim-go
Plug 'ctrlpvim/ctrlp.vim'

" deoplete async completion framework
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
" go autocompletion dependant on gocode
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }

" vim indent display
Plug 'Yggdroot/indentLine'

" " vim-sneak movement
Plug 'justinmk/vim-sneak'

" " easy commenting
Plug 'tpope/vim-commentary'

" " surround support in vim
Plug 'tpope/vim-surround'

" " remembers the previous state of vim
Plug 'tpope/vim-obsession'

" " improvements to backslash-search
Plug 'junegunn/vim-slash'

" " git integration
Plug 'tpope/vim-fugitive'

" " git gutter
Plug 'airblade/vim-gitgutter'

" " airline status bar
Plug 'vim-airline/vim-airline'

" " airline status bar themes
Plug 'vim-airline/vim-airline-themes'

" " trailing whitespace
Plug 'ntpeters/vim-better-whitespace'


" "***COLORSCHEMES***
" " NOTE: some colorschemes don't support 24-bit truecolor that well
" " colorscheme repo from vim.org
Plug 'mswift42/vim-themes'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'rakr/vim-one'
Plug 'lifepillar/vim-solarized8'
Plug 'rakr/vim-two-firewatch'
Plug 'mhartington/oceanic-next'
Plug 'morhetz/gruvbox'
Plug 'freeo/vim-kalisi'
" Plug 'liuchengxu/space-vim-dark'
" Plug 'colepeters/spacemacs-theme.vim'
Plug 'crusoexia/vim-monokai'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'trevordmiller/nova-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'cocopon/iceberg.vim'
Plug 'jacoborus/tender.vim'
Plug 'danilo-augusto/vim-afterglow'
Plug 'dracula/vim'
Plug 't1mxg0d/vim-lucario'
Plug 'junegunn/seoul256.vim'
Plug 'KeitaNakamura/neodark.vim'


call plug#end()

" ********* Settings ********
"
filetype plugin indent on

syntax on


" set new leader key
let mapleader=","
" let mapleader = "\<Space>"

" when vim sees these filetypes, the comment strings will be //
autocmd FileType c,cpp,cs,java,go setlocal commentstring=//\ %s
" disable auto commenting when going to a new line from a line with comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


" massively simplified take on https://github.com/chreekat/vim-paren-crosshairs
func! s:matchparen_cursorcolumn_setup()
  augroup matchparen_cursorcolumn
    autocmd!
    autocmd CursorMoved * if get(w:, "paren_hl_on", 0) | set cursorcolumn | else | set nocursorcolumn | endif
    autocmd InsertEnter * set nocursorcolumn
  augroup END
endf
if !&cursorcolumn
  augroup matchparen_cursorcolumn_setup
    autocmd!
    " - Add the event _only_ if matchparen is enabled.
    " - Event must be added _after_ matchparen loaded (so we can react to w:paren_hl_on).
    autocmd CursorMoved * if exists("#matchparen#CursorMoved") | call <sid>matchparen_cursorcolumn_setup() | endif
          \ | autocmd! matchparen_cursorcolumn_setup
  augroup END
endif

" cursor in middle of screen when searching
set scrolloff=5

set cursorline

" line numbers
set nu
set relativenumber
set showcmd
set showmatch
set showmode
set ruler
set formatoptions+=t
set textwidth=79
set modeline
" set esckeys
set linespace=0
set nojoinspaces
" clipboard to copy/paste
set clipboard=unnamed

" how to split vim
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" indentation rules
filetype indent on
set tabstop=2
set softtabstop=4
set shiftwidth=2
set expandtab
set colorcolumn=80

" c++ filetype detection
augroup project
	autocmd!
	autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
augroup END

"******** Key Remaps *********

" fzf remaps
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit', }
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" --- search terminal, files, or buffers
nnoremap <Leader>f :FZF<CR>
nnoremap <Leader>p :Files<CR>
nnoremap <Leader>b :Buffers<CR>
" --- line completion using fzf
imap <c-x><c-l> <plug>(fzf-complete-line)

" ctrl-p


"********* Plugin Settings *********

" google autoformat + dependencies
" augroup autoformat_settings
"   autocmd FileType bzl AutoFormatBuffer buildifier
"   autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
"   autocmd FileType dart AutoFormatBuffer dartfmt
"   autocmd FileType go AutoFormatBuffer gofmt
"   autocmd FileType gn AutoFormatBuffer gn
"   autocmd FileType html,css,json AutoFormatBuffer js-beautify
"   autocmd FileType java AutoFormatBuffer google-java-format
"   autocmd FileType python AutoFormatBuffer yapf
"   " Alternative: autocmd FileType python AutoFormatBuffer autopep8
" augroup END

set completeopt-=preview

" ALE linter settings
let g:airline#extensions#ale#enabled = 1
" --- ale linting on save vs asynchronously in background
" let g:ale_lint_on_text_changed = 'never'
" --- ale linting on opening a file
" let g:ale_lint_on_enter = 0
" Error and warning signs.
let g:ale_sign_error = '???'
let g:ale_sign_warning = '???'
" linter settings
let g:ale_linter = {
      \'go': ['golint'],
      \}

" VIM GO
" vim-go highlighting
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
" *** highlight same words
let g:go_auto_sameids = 1
" auto import dependencies
let g:go_fmt_command = "goimports"
" show type info in status line
let g:go_auto_type_info = 1
" hotkey for :GoDeclsDir - Requires ctrlp-vim
au FileType go nmap <leader>gt :GoDeclsDir<cr>

" go autocompletion
" neocomplete like
" set completeopt+=noinsert
" deoplete.nvim recommend
set completeopt+=noselect
" Path to python interpreter for neovim
let g:python3_host_prog  = '/usr/local/bin/python3'
" Skip the check of neovim module
let g:python3_host_skip_check = 1
" deoplete-go settings
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#json_directory = '/path/to/data_dir'

" vim-delve
let g:delve_backend = "native"


" VIM AIRLINE AND COLORSCHEMS
" vim-airline
" --- airline settings
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#tabline#right_sep = ' '
" let g:airline#extensions#tabline#right_alt_sep = '|'
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = '|'
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = '|'

" " --- airline fonts/symbols
let g:airline_powerline_fonts = 1
" --- airline themes
let g:airline_theme='neodark'

"italic text
let g:nord_italic_comments = 1

"bold text
let g:oceanic_next_terminal_bold=1

" vim-slash
noremap <plug>(slash-after) zz


"revert back to 256 colors
"set t_Co=256

if (has("termguicolors"))
	set termguicolors
endif

" vertical column showing 80 char limit
highlight ColorColumn ctermbg=darkgray
set background=dark
"set background=light


" let g:seoul256_background = 235
" colorscheme seoul256
let g:neodark#background = '#202020'
" let g:neodark#terminal_transparent = 1
colorscheme neodark
" colorscheme warm-night
" colorscheme flatcolor
" colorscheme apprentice
" colorscheme focuspoint
" colorscheme hybrid_reverse
" colorscheme molokayo
" colorscheme angr
" colorscheme abstract
" colorscheme space-vim-dark
" colorscheme reykjavik
" colorscheme lucario
" colorscheme dracula
" colorscheme afterglow
" colorscheme deep-space
" colorscheme tender
" colorscheme onehalfdark
" colorscheme nova
" colorscheme nord
" colorscheme kalisi
"colorscheme gruvbox
" colorscheme solarized8_dark_flat
" colorscheme solarized8_dark_high
" colorscheme OceanicNext
" colorscheme two-firewatch
" colorscheme one
" colorscheme molokai


" for having .vimrc file within the current project folder
"set secure




