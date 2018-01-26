"*********************************************************************
"#########################  VIMRC FOR C++ ############################
"*********************************************************************


" "**************vim-plug package manager (faster than vundle)
call plug#begin('~/.vim/plugged')

" rtags for vim
Plug 'lyuts/vim-rtags'

" ale linter
Plug 'w0rp/ale'

" fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" google autoformatting + dependencies
" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plug 'google/vim-glaive'

" YouCompleteMe autocompletion
" Plug 'Valloric/YouCompleteMe'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
Plug 'tweekmonster/deoplete-clang2'

" " clang-based c/c++ syntax highlighter
" Plug 'arakashic/chromatica.nvim'

" " another c/c++ syntax highlighter
Plug 'octol/vim-cpp-enhanced-highlight'

" " switch between header file and cpp file
Plug 'vim-scripts/a.vim'

" CRITICAL

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

" " lightline
Plug 'itchyny/lightline.vim'

" " trailing whitespace
Plug 'ntpeters/vim-better-whitespace'

" "***COLORSCHEMES***
" " NOTE: some colorschemes don't support 24-bit truecolor that well
" " colorscheme repo from vim.org
" Plug 'mswift42/vim-themes'
" Plug 'rafi/awesome-vim-colorschemes'
" Plug 'rakr/vim-one'
" Plug 'lifepillar/vim-solarized8'
" Plug 'rakr/vim-two-firewatch'
" Plug 'mhartington/oceanic-next'
" Plug 'morhetz/gruvbox'
" Plug 'freeo/vim-kalisi'
""" Plug 'liuchengxu/space-vim-dark'
""" Plug 'colepeters/spacemacs-theme.vim'
" Plug 'crusoexia/vim-monokai'
" Plug 'tyrannicaltoucan/vim-deep-space'
" Plug 'trevordmiller/nova-vim'
" Plug 'arcticicestudio/nord-vim'
" Plug 'sonph/onehalf', {'rtp': 'vim/'}
" Plug 'cocopon/iceberg.vim'
" Plug 'jacoborus/tender.vim'
" Plug 'danilo-augusto/vim-afterglow'
" Plug 'dracula/vim'
" Plug 't1mxg0d/vim-lucario'
Plug 'junegunn/seoul256.vim'
Plug 'KeitaNakamura/neodark.vim'
Plug 'NLKNguyen/papercolor-theme'


call plug#end()

call glaive#Install()
Glaive codefmt plugin[mappings]
Glaive codefmt google_java_executable="java -jar /path/to/google-java-format-VERSION-all-deps.jar"

" ********* Settings ********
"
filetype plugin indent on

syntax on


" set new leader key
let mapleader=","
" let mapleader = "\<Space>"

" when vim sees these filetypes, the comment strings will be //
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
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

" c++ indentation rules
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


"********* Plugin Settings *********

" google autoformat + dependencies
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
augroup END

set completeopt-=preview

" " chromatic.nvim syntax highlighter settings
" let g:chromatica#responsive_mode = 1
" " " let g:chromatica#libclang_path = '/usr/lib/llvm-3.8/lib/libclang.so'
" let g:chromatica#libclang_path = '/usr/lib/libclang.so.4.0'
" let g:chromatica#enable_at_startup=1
" let g:chromatica#highlight_feature_level=0

" ALE linter settings
let g:airline#extensions#ale#enabled = 1
" --- ale linting on save vs asynchronously in background
" let g:ale_lint_on_text_changed = 'never'
" --- ale linting on opening a file
" let g:ale_lint_on_enter = 0

" vim-cpp-enhanced-highlight settings
let c_no_curly_error = 1
let g:cpp_class_scope_highlight = 1

"******** Colorschemes + Status Line ********

set noshowmode " don't let vim itself show modes (let lightline do it)

" lightline.vim
let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" vim-slash
noremap <plug>(slash-after) zz

" vim truecolor or 256
"revert back to 256 colors
"set t_Co=256

if (has("termguicolors"))
	set termguicolors
endif

" vertical column showing 80 char limit
" highlight ColorColumn ctermbg=darkgray

" vim background
" set background=dark
set background=light

" dark colorscheme
" let g:seoul256_background = 235
" colorscheme seoul256
" let g:neodark#background = '#202020'
" let g:neodark#terminal_transparent = 1
" colorscheme neodark

" light colorscheme
colorscheme PaperColor

"italic text
"let g:two_firewatch_italics=1
" let g:oceanic_next_terminal_italic=1
" let g:deepspace_italics = 1
let g:nord_italic_comments = 1

"bold text
let g:oceanic_next_terminal_bold=1

" for having .vimrc file within the current project folder
"set secure




