"===============================================================================
" File: vimrc
" Author: Eli Gundry <eligundry@gmail.com>
" Description: A collection of all my Vim settings
"===============================================================================

"===============================================================================
" => Legacy Settings
"===============================================================================

" ...or more accurately, I don't give a shit about Vi. This is Vim!
set nocompatible

"===============================================================================
" => Script Loading
"===============================================================================

runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

"===============================================================================
" => Global Settings
"===============================================================================

if has("autocmd")
	filetype on
	filetype plugin on
	filetype indent on
endif

" I needs my syntax highlighting
if has("syntax")
	syntax enable
endif

" I don't use sessions currently, but I shall set this anyways.
if has("mksession")
	set sessionoptions=blank,buffers,curdir,folds,help,options,resize,slash,winpos,winsize
endif

"===============================================================================
" => File Handling
"===============================================================================

" Buffer is unloaded when abandoned
set hidden

" Reload if modified, write on certain commands
set autoread
set autowrite

" Set default line endings as Unix
set fileformats=unix,dos,mac

" I love UTF-8
if has("multi_byte")
	scriptencoding utf-8
	let &termencoding = &encoding
	setglobal encoding=utf-8
	setglobal fileencoding=utf-8
	setglobal nobomb
endif

" Disable encryption
if has("cryptv")
	set key=
endif

"===============================================================================
" => Terminal Settings
"===============================================================================

" Must use this conditional or else GVim won't open
if !has("gui")
	set shell=$SHELL
	set term=$TERM
	set ttyfast " I usually work locally, so my connection is fast
	set lazyredraw " Makes macros work smoother by not redrawing screen
endif

"===============================================================================
" => Word Wrap
"===============================================================================

set nowrap " I like scrolling off the screen
set textwidth=80 " Standard width for terminals
set formatoptions=oqn1 " Check out 'fo-table' to see what this does.

"===============================================================================
" => Tabs
"===============================================================================

set tabstop=4 " I like my tabs to seem like four spaces
set shiftwidth=4 " I'd also like to shift lines the same amount of spaces
set softtabstop=4 " If using expandtab for some reason, use four spaces
set autoindent " Copy indenting from original block of text when yanked/pulled
set noexpandtab " Tabs are '\t', not four spaces
set smarttab " Make expandtab more tolerable
set shiftround " Round indents to multiples of shiftwidth

" Does a certain amount of guessing with indentation
if has("smartindent")
	set smartindent
endif

"===============================================================================
" => Editing
"===============================================================================

" Stay in the same column when jumping around
set nostartofline

" Backspace all the things!
set backspace=2

" I don't want other people's files messing up my settings
set nomodeline
set modelines=0

" Don't use more than one space after punctuation
set nojoinspaces

if has("folding")
	set foldenable " I hate folds...
	set foldmethod=manual " ...but if there are folds, let me control them
endif

" I don't need Vim telling me where I can't go!
if has("virtualedit")
	set virtualedit=all
endif

" Change current directory to whatever file I'm editing
if exists("+autochdir")
	set autochdir
endif

"===============================================================================
" => History
"===============================================================================

set history=700

" I hate backups. There's no point anymore!
set nobackup
set nowritebackup
set backupdir=~/.vim/backup

" I'm done using swaps. They are annoying.
set noswapfile
set directory=~/.vim/swap

" Persistent undo is pretty awesome. It basically builds all sorts
" of version control straight into your editor. It commits when ever
" you leave insert/replace/change/etc. to normal. Gundo allows you to
" see all of your edits in diff style so you can revert back to certain
" parts in time.
if has("persistent_undo")
	set undofile
	set undolevels=3000
	set undodir=~/.vim/undo
else
	" If persistent undo isn't available, let's enable backups.
	set backup
	set writebackup
	set swapfile
endif

"===============================================================================
" => Spelling
"===============================================================================

if has("spell")
	setlocal spell
	setlocal spelllang=en_us
endif

"===============================================================================
" => Search
"===============================================================================

" Fancy (quick) search highlighting
if has("extra_search")
	set hlsearch
	set incsearch
endif

set ignorecase infercase " When I search, I don't need to capitalize...
set smartcase " ...but when I do, it'll pair down the search.
set shellslash " When in Windows, you can use / instead of \
set magic " Do You Believe In (Perl) Magic?
set gdefault " Use global by default when replacing

"===============================================================================
" => Wildmenu
"===============================================================================

if has("wildmenu")
	set wildmenu " Really helpful tab command completion
	set wildmode=longest,full
	set wildignorecase
endif

" I have these wildignores commented out because they prevent NERDTree from
" showing these files and will break Fugitive. Uncomment these if you want to
" make Vim's autocomplete more relevant.
if has("wildignore")
	" set wildignore+=.git,.svn,.hg " Version control files
	" set wildignore+=*.jpg,*.jpeg,*.png,*.psd,*.ai,*.bmp,*.gif " Images
	" set wildignore+=*.o,*.obj,*.bak,*.exe " Compiled files
endif

"===============================================================================
" => Printing
"===============================================================================

if has("printer")
	set printoptions=header:0,number:y,duplex:long
endif

"===============================================================================
" => GUI
"===============================================================================

if has("cmdline_info")
	set ruler
	set showcmd
	set cmdheight=2
	set laststatus=2
	set noshowmode " Powerline shows mode now
endif

" Remove cursorline and colorcolumn when buffer loses focus
" Put it back in when it gains focus
if has("syntax")
	set cursorline colorcolumn=+1
	autocmd WinLeave * set nocursorline colorcolumn=""
	autocmd WinEnter,BufEnter,BufNewFile * set cursorline colorcolumn=+1
endif

if has("title")
	set title
	set titlelen=70
	set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
endif

" 256 color support in terminal
set t_Co=256

set background=dark " I like a dark background
set scrolloff=5 " When vertically scrolling, pad cursor 5 lines
set sidescrolloff=5 " When scrolling horizontally, pad cursor 5 lines

" List characters
set nolist
set listchars=tab:▸∙,eol:␤,trail:∘,extends:⤦,nbsp:ᢸ

" Timeout settings
set timeout
set nottimeout
set timeoutlen=3000

" Split Handling
if has("windows") && has("vertsplit")
	set splitbelow splitright
endif

" NO FREAKING BELLS
set noerrorbells
set novisualbell
set t_vb=

" Line Numbers
set number
set norelativenumber

" I like my number line to be super fat
if has("linebreak")
	set numberwidth=4
endif

"===============================================================================
" => Keyboard Shortcuts
"===============================================================================

" Use commas as leaders
let mapleader = ','
let maplocalleader = ','
let g:mapleader = ','

" Window Navigation
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

" Window Rotation
nnoremap <A-r> :wincmd r<CR>

" Window Resizing
nnoremap <silent> <Up> :resize +1<CR>
nnoremap <silent> <Down> :resize -1<CR>
nnoremap <silent> <Left> :vertical resize -1<CR>
nnoremap <silent> <Right> :vertical resize +1<CR>
nnoremap <A-e> :wincmd =<CR>

" Disable arrow keys in insert mode
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>

" Alternate increment mappings for screen
nnoremap + <C-a>
nnoremap - <C-x>

" Easier line jumping
noremap H ^
noremap L $

" Toggle search highlighting
nnoremap <Leader><Leader> :nohlsearch<CR>

" Toggle relative line numbering
nnoremap <Leader>rn :call ToggleRelativeNumber()<CR>

" Toggle list chars
nnoremap <Leader>ll :set list!<CR>

" Map <Esc> to my right hand
inoremap <silent> jj <Esc>
inoremap <silent> JJ <Esc>

" Paste toggle for the win
nnoremap <Leader>pt :set paste!<CR>:set paste?<CR>

" Yank should work just like every other Vim verb
noremap Y y$

" Undo/redo now make sense
nnoremap U :redo<CR>

" Vimrc quick edit
nnoremap <Leader>tv :tabnew $MYVIMRC<CR>
nnoremap <Leader>ev :edit $MYVIMRC<CR>
nnoremap <Leader>pv :split $MYVIMRC<CR>
nnoremap <Leader>vv :vsplit $MYVIMRC<CR>
nnoremap <Leader>rv :source $MYVIMRC<CR>

" Buffer Navigation
nnoremap <Leader>bb :buffers<CR>
nnoremap <Leader>bd :bdelete<CR>
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bp :bprevious<CR>

" Command mode settings
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Jump between bracket pairs easily
" Not using remap so I can use matchit
nmap <Tab> %
vmap <Tab> %

" Keep searches in the middle of the screen
noremap n nzzzv
noremap N Nzzzv
noremap * *zz
noremap # #zz
noremap g* g*zz
noremap g# g#zz

" Select all text in current buffer
noremap <Leader>a ggVG

" Faster command mode access
noremap <Space> :
noremap ; :!

" Saving & Quiting Shortcuts
nnoremap <Leader>s :write<CR>
nnoremap <Leader>wq :wq!<CR>
nnoremap <Leader>wa :wall<CR>
nnoremap <Leader>qa :qall<CR>
nnoremap <Leader>tt :tabnew<CR>
nnoremap <Leader>tc :tabclose<CR>
nnoremap <Leader>to :tabonly<CR>

" Sane movement
noremap <silent> j gj
noremap <silent> k gk

" Bubble lines of text with optional repeat count
nnoremap <silent> <S-j> @='ddp'<CR>
vnoremap <silent> <S-j> @='xp`[V`]'<CR>
vnoremap <silent> <S-k> @='xkP`[V`]'<CR>
nnoremap <silent> <S-k> @='ddkP'<CR>

" Shift blocks visually
vnoremap < <gv
vnoremap > >gv

" Toggle line wrapping
nnoremap <Leader>wp :set wrap!<CR>

"===============================================================================
" => Functions
"===============================================================================

" Toggle relative line numbering
function! ToggleRelativeNumber()
	if &relativenumber
		set number
	else
		set relativenumber
	endif
endfunction

" Return to current line when reopening file
augroup line_return
	autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\     execute 'normal! g`"zvzz' |
		\ endif
augroup END

" Remove trailing whitespace when saving files
autocmd BufWritePre * :%s/\s\+$//e

" Exit paste mode upon leaving insert
autocmd InsertLeave * set nopaste paste?

" Resize splits as vim is resized
autocmd! VimResized * exe "normal! \<C-w>="

"===============================================================================
" => Plugins
"===============================================================================

" @name: Solarized
" @author: Ethan Schoonover
" @url: https://github.com/altercation/vim-colors-solarized
let g:solarized_bold = 1
let g:solarized_italic = 1
let g:solarized_menu = 0
let g:solarized_termcolors = 256
let g:solarized_termtrans = 1
let g:solarized_visibility = "low"
colorscheme solarized
call togglebg#map("<Leader>bg")

" @name: Fugitive
" @author: Tim Pope
" @url: https://github.com/tpope/vim-fugitive
function! FugitiveSettings()
	nnoremap <silent> <Leader>gs :Gstatus<CR>
	nnoremap <silent> <Leader>gb :Gblame<CR>
	nnoremap <silent> <Leader>gd :Gdiff<CR>
	nnoremap <silent> <Leader>gp :Git push<CR>
	nnoremap <silent> <Leader>gl :Glog<CR>
	autocmd FileType gitcommit nnoremap <buffer> <Leader>s :wq<CR>
endfunction

autocmd VimEnter * if exists("g:loaded_fugitive") | call FugitiveSettings() | endif

" @name: Clam.vim
" @author: Steve Losh
" @url: https://github.com/sjl/clam.vim
function! ClamSettings()
	nnoremap ! :Clam<Space>
	vnoremap ! :ClamVisual<Space>
endfunction

autocmd VimEnter * if exists("loaded_clam") | call ClamSettings() | endif

" @name: vim-powerline
" @author: Kim Silkebækken
" @url: https://github.com/Lokaltog/vim-powerline
let g:Powerline_symbols = 'fancy'

" @name: NERDTree
" @author: Martin Grenfell
" @url: https://github.com/scrooloose/nerdtree
let g:NERDChristmasTree = 1
let g:NERDTreeCasadeOpenSingleChildDir = 1
let g:NERDTreeChDirMode = 1
let g:NERDTreeDirArrows = 0
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeIgnore = ['\.swp$', '\~$']
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowFiles = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowLineNumbers = 0
let g:NERDTreeWinSize = 22

function! NERDTreeSettings()
	nnoremap <silent> <Leader>nt :GundoHide<CR>:NERDTreeToggle<CR>
	autocmd FileType nerdtree set colorcolumn=""
endfunction

autocmd VimEnter * if exists(":NERDTree") | call NERDTreeSettings() | endif

" @name: vim-easytags
" @author: Peter Odding
" @url: https://github.com/xolox/vim-easytags
set tags=./.tags
let g:easytags_by_filetype = '~/.vim/tags'
let g:easytags_dynamic_files = 1
let g:easytags_file = '~/.vim/tags'
let g:easytags_suppress_ctags_warning = 1

" @name: tagbar
" @author: Jan Larres
" @url: https://github.com/majutsushi/tagbar
let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_left = 0

function! TagbarSettings()
	nnoremap <silent> <Leader>tb :TagbarToggle<CR>
endfunction

autocmd VimEnter * if exists(":TagbarToggle") | call TagbarSettings() | endif

" @name: gundo.vim
" @author: Steve Losh
" @url: https://github.com/sjl/gundo.vim
let g:gundo_help = 0
let g:gundo_preview_height = 20
let g:gundo_width = 60

function! GundoSettings()
	nnoremap <silent> <Leader>gu :NERDTreeClose<CR>:GundoToggle<CR>
	autocmd FileType gundo set colorcolumn=""
endfunction

autocmd VimEnter * if exists(":Gundo") | call GundoSettings() | endif

" @name: SudoEdit
" @author: Christian Brabandt
" @url: https://github.com/chrisbra/SudoEdit.vim
let g:sudo_no_gui = 1

" @name: rainbow_parentheses
" @author: kien
" @url: https://github.com/kien/rainbow_parentheses.vim
autocmd VimEnter * RainbowParenthesesToggle
" Enable on everything but help files
autocmd Syntax !help RainbowParenthesesLoadRound
autocmd Syntax !help RainbowParenthesesLoadSquare
autocmd Syntax !help RainbowParenthesesLoadBraces

" @name: Syntastic
" @author: Martin Grenfell
" @url: https://github.com/scrooloose/syntastic
let g:syntastic_auto_jump = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_enable_balloons = 0
let g:syntastic_enable_highlighting = 1
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_quiet_warnings = 0
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_mode_map = { 'mode': 'active',
							 \ 'active_filetypes': ['html', 'xml', 'c', 'cpp', 'php', 'css', 'javascript', 'ruby', 'eruby'],
							 \ 'passive_filetypes': [] }

" @name: delimitMate
" @author: Israel Chauca Fuentes
" @url: https://github.com/Raimondi/delimitMate
let delimitMateAutoClose = 1
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
let delimitMate_smart_quotes = 1
autocmd FileType vim,html,xml,xhtml let b:delimitMate_matchpairs = "(:),[:],{:},<:>"

" @name: Neosnippet
" @author: Shougo Matsu
" @url: https://github.com/Shougo/neosnippet
let g:neosnippet#snippets_directory = '~/.vim/bundle/snipmate-snippets/snippets'
if has('conceal')
	set conceallevel=2 concealcursor=i
endif

" @name: Neocomplcache
" @author: Shougo Matsu
" @url: https://github.com/Shougo/neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_auto_select = 0
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_include_max_processes = 50
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_max_list = 50
let g:neocomplcache_min_syntax_length = 2
let g:neocomplcache_temporary_dir = '~/.vim/neocon'

if !exists('g:neocomplcache_keyword_patterns')
	let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
	let g:neocomplcache_omni_patterns = {}
endif

function! NeocomplcacheSettings()
	imap <expr><CR> pumvisible() ? neocomplcache#smart_close_popup() . "\<CR>" : "<Plug>delimitMateCR"
	imap <expr><BS> pumvisible() ? neocomplcache#smart_close_popup() . "\<C-h>" : "<Plug>delimitMateBS"
	imap <expr><C-n> pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>\<Down>"
	imap <expr><C-p> pumvisible() ? "\<C-p>" : "\<C-p>\<C-n>"
	imap <expr><C-g> neocomplcache#undo_completion()
	imap <C-k> <Plug>(neosnippet_jump_or_expand)
	smap <C-k> <Plug>(neosnippet_jump_or_expand)
endfunction

autocmd VimEnter * if exists("g:loaded_neocomplcache") | call NeocomplcacheSettings() | endif

"===============================================================================
" => FileType Specific Settings
"===============================================================================

" Apache
autocmd BufRead,BufNewFile /etc/apache2/sites-*/* setlocal filetype=apache

" C/C++
augroup c,cpp
	au!
	autocmd FileType c,cpp let g:C_Ctrl_j = 'off'
	autocmd FileType c let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
	autocmd FileType cpp let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
augroup END

" CSS
augroup css
	au!
	" Alphabetize CSS styles
	autocmd FileType css nnoremap <Leader>cs ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
augroup END

" HTML
augroup html
	au!
	autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
augroup END

" JavaScript
augroup javascript
	au!
	autocmd FileType javascript setlocal syntax=jquery
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
augroup END

" JSON
augroup json
	au!
	autocmd BufNewFile,BufRead *.json setlocal filetype=json
augroup END

" Mindbox
autocmd BufRead,BufNewFile /var/www/mindbox/* setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2

" nginx
autocmd BufRead,BufNewFile /etc/nginx/* setlocal filetype=nginx

" PHP
augroup php
	au!
	autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
	autocmd FileType php let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
	autocmd FileType php setlocal keywordprg+="help"
augroup END

" Python
augroup python
	au!
	autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
augroup END

" Ruby
augroup ruby
	au!
	autocmd FileType ruby,eruby,haml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
	autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
	let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
	let g:ruby_path = '~/.rvm/rubies/default/bin'
augroup END

" Snippets
augroup snippets
	au!
	autocmd FileType snippets setlocal foldmethod=manual
augroup END

" SSH
autocmd BufRead *ssh/config* setlocal filetype=sshconfig

" XML
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Zsh
autocmd BufRead,BufNewFile *.zsh* setlocal filetype=zsh
