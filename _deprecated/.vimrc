" Basic defaults
set nocompatible
let mapleader = ","
" Fix loading of neovim runtime while using vimr
set runtimepath+=/usr/local/share/vim/vim74

set swapfile
set undofile         " persist undo tree
set history=100      " lines of command line history
"set viminfo=
set undodir=~/.vim/tmp/undo//,/tmp//    " undo files
set directory=~/.vim/tmp/swap//,/tmp//  " swap files
set clipboard+=unnamed
set formatoptions=tcqron
set suffixesadd=.rb,.go
set includeexpr+=substitute(v:fname,'s$','','g')
set shortmess=atIsAo
set grepprg=ack
set grepformat=%f:%l:%m
set ic
set expandtab
set smarttab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set hls showmatch
set textwidth=90
set visualbell
set wildmenu
set wildmode=full
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif
set complete=.,w,b,u,t,k
set laststatus=2
"set encoding=utf-8
set t_Co=256
set backspace=indent,eol,start
set nolazyredraw
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set nocursorcolumn
set re=1
set completeopt=longest,menuone ",noinsert,noselect
set nolazyredraw

" prevent folding where folding sux
let g:vim_markdown_folding_disabled=1 " Markdown
let javaScript_fold=1 " JavaScript
let go_syntax_folding=1 " Go
let ruby_fold=1 " Ruby
let sh_fold_enabled=1 " sh
let vimsyn_folding='af' " Vim script
let xml_syntax_folding=1 " XML

" turn on syntax highlighting and filetype plugin indentation
syntax on
filetype plugin indent on

" use C-style indentation for my langs
au Filetype ruby,python,bash,go set cindent autoindent 

" json files are JSON, not javascript
au BufNewFile,BufRead *.json set filetype=json

" trust vim-go plugin when dealing with extra spaces
au FileType go set listchars-=tab:>. nolist

" the :Lcd for fast-cd to dirs that are symlinks
fun! ChangeDirFollow(dir)
  exe 'cd ' resolve(expand(a:dir))
endfunction
command! -nargs=+ -complete=dir Lcd call ChangeDirFollow('<args>')

" neovim offers :terminal feature but I like the terminal to appear on bottom of
" the screen so use :VTerm for that
command! VTerm belowright split | te

" initialize vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Install all plugins: vim +PluginInstall +qall
Plugin 'gmarik/Vundle.vim'
Plugin 'mileszs/ack.vim'
Plugin 'fatih/vim-go'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
"Plugin 'airblade/vim-gitgutter'
Plugin 'elzr/vim-json'
Plugin 'jlanzarotta/bufexplorer'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'Shougo/neocomplete.vim'
"Plugin 'roxma/SimpleAutoComplPop'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
" only works with neo-vim
Bundle "Shougo/deoplete.nvim"
Bundle 'zchee/deoplete-go', {'build': {'unix': 'make'}}
"Plugin 'baskerville/vim-sxhkdrc'
Plugin 'dgryski/vim-godef'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ekalinin/Dockerfile.vim'
"Plugin 'majutsushi/tagbar'
Plugin 'fatih/molokai'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'int3/vim-extradite'
Plugin 'itchyny/lightline.vim'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'

"Bundle "L9"
"Bundle "FuzzyFinder"

let g:fuf_modesDisable = []
nnoremap <silent> <leader>f :FufFileWithCurrentBufferDir<CR>
call vundle#end()
filetype plugin indent on
" end of vundle initialization

" Some GUI vs. non-GUI settings
if has("gui") || exists("neovim_dot_app")
  set guioptions=aevAi
  set guioptions-=Ll
  " font is set in app
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12
  "set antialias!
  map  <silent>  <S-Insert>  "+p
  imap <silent>  <S-Insert>  <Esc>"+pa
  set nomousehide
  set mousemodel=popup
  set novisualbell
  set guiheadroom=0
endif
colorscheme molokai

function! SL(function)
  if exists('*'.a:function)
    return call(a:function,[])
  else
    return ''
  endif
endfunction
set statusline=[%n]\ %<%.99f\ %h%w%m%r%{SL('CapsLockStatusline')}%y%{SL('fugitive#statusline')}%#ErrorMsg#%{SL('SyntasticStatuslineFlag')}%*%=%-14.(%l,%c%V%)\ %P

" Configure plugins
let g:vim_json_syntax_conceal = 0

let g:syntastic_ruby_exec='/usr/bin/ruby'
let g:syntastic_haml_exec='/usr/bin/haml'
let g:syntastic_json_checkers=['jsonlint']
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'

let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
let g:NERDShutUp = 1
let g:NERDTreeHijackNetrw = 0
let g:bufExplorerShowRelativePath = 1
let NERDTreeIgnore = ['\.pyc$']

let g:go_fmt_command = "goimports"
let g:go_bin_path = "/Users/mfojtik/go/bin"
let g:go_snippet_engine = "neosnippet"
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1

let g:syntastic_go_checkers = ['govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = '/Users/mfojtik/go/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#json_directory = '/Users/mfojtik/.cache/code'

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2

let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

let g:ctrlp_by_filename = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.config/nvim/ctrlp'


map <leader>d :NERDTreeToggle<CR>
map <leader>s :BufExplorer<CR>

au FileType go nmap <Leader>l <Plug>(go-info)
au FileType json let g:vim_json_syntax_conceal = 0

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'syntastic', 'readonly', 'relativepath', 'modified' ] ]
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

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp,*.go call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

