" neovim init file
"
" Author: Michal Fojtik <mi@mifo.sk>
" Date: Sep-12-2016
"
" some basic settings first:
let mapleader = ","
set clipboard=unnamedplus
set shortmess=atIsAo
set ignorecase
set visualbell
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif
set completeopt=menu,noinsert,noselect

" allow neovim to change cursor shape
"let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" formatting options and tabs/spaces
set formatoptions=tcqronj
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set textwidth=90

" FIXME: disable mouse for editing modes because it causes troubles for clipboard
set mouse=n
set title
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set scrolloff=5
set scrolljump=8
set nocursorline

let loaded_matchparen=1
let html_no_rendering=1
set noshowmatch
set nocursorcolumn
set nocursorline

" basic indentation
au Filetype ruby,python,bash,go set cindent

" manage external plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'tpope/vim-fugitive'
Plug 'jlanzarotta/bufexplorer'
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'dgryski/vim-godef'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/molokai'
Plug 'itchyny/lightline.vim'
Plug 'mattn/webapi-vim'
Plug 'mileszs/ack.vim'
Plug 'airblade/vim-gitgutter'
Plug 'arakashic/chromatica.nvim'
call plug#end()

let g:chromatica#libclang_path='/usr/local/opt/llvm/lib'
let g:chromatica#enable_at_startup=1

" colors
" allow neovim to use the original terminal colors
set termguicolors
set nolazyredraw
"set t_Co=256
colorscheme molokai
"let g:rehash256 = 0
let g:molokai_original = 0

" tagbar
nmap <F8> :TagbarToggle<CR>

" gitgutter
let g:gitgutter_map_keys = 0
nmap <Leader>ad <Plug>GitGutterStageHunk
nmap <Leader>aD <Plug>GitGutterUndoHunk

" vim-go settings
let g:go_fmt_command = "goimports"
let g:go_bin_path = $HOME."/go/bin"
let g:go_gotags_bin = $HOME."/go/bin/gotags"
let g:go_highlight_space_tab_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 0

" syntastic settings
let g:syntastic_go_checkers = ['govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" deoplete settings
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = $HOME.'/go/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#json_directory = $HOME.'/.config/nvim/cache'

" gist settings
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" ctrlp
let g:ctrlp_by_filename = 1

" custom key bindings
map <leader>d :NERDTreeToggle<CR>
map <leader>s :BufExplorer<CR>

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>i <Plug>(go-info)

" do not try to colorize huge json files
au FileType json let g:vim_json_syntax_conceal = 0
" let vim-go deal with tabs
au FileType go set listchars-=tab:>. nolist

" statusline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'syntastic', 'readonly', 'absolutepath', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"RO":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

" enable syntastic in status line
augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp,*.go call s:syntastic()
augroup END

function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction
