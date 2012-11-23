"===============================================================================
" File: gvimrc
" Author: Eli Gundry <eligundry@gmail.com>
" Description: My Vim settings for GVim
"===============================================================================

"===============================================================================
" => GUI
"===============================================================================

set visualbell t_vb= " No Errorbells!
set guioptions=c " Use console dialogs instead of popups
set linespace=1 " One pixel of linespace
set antialias " Antialias the font

"===============================================================================
" => Fonts
"===============================================================================

if has("gui_win32")
	set guifont=Consolas:h11
elseif has("gui_gtk2")
	set guifont=Ubuntu\ Mono\ 12
elseif has("gui_mac")
	set guifont=Monaco 10
endif

"===============================================================================
" => Solarized
"===============================================================================

"===============================================================================
" => Mouse
"===============================================================================

set mouse=a " Mouse is enabled in all modes
set nomousefocus " Prevents mouse hovering to change windows/buffers
set mousemodel=popup_setpos " Left clicking with the mouse shows context menu
set mousehide " Hide the mouse when typing

"===============================================================================
" => Cursor
"===============================================================================

" This is the perfect blink sequence for me
set guicursor=n-v-c:block-Cursor-blinkon0
set guicursor+=ve:ver35-Cursor
set guicursor+=o:hor50-Cursor
set guicursor+=i-ci:ver25-Cursor
set guicursor+=r-cr:hor20-Cursor
set guicursor+=sm:block-Cursor-blinkwait300-blinkoff150-blinkon300

"===============================================================================
" => Plugins
"===============================================================================

" @name: Solarized
" @author: Ethan Schoonover
" @url: https://github.com/altercation/vim-colors-solarized
colorscheme solarized
set background=dark

" @name: headlights
" @author: Mohammed Badran
" @url: https://github.com/mbadran/headlights
let g:headlights_show_abbreviations = 1
let g:headlights_show_commands = 1
let g:headlights_show_functions = 1
let g:headlights_show_mappings = 1
let g:headlights_spillover_menus = 1
let g:headlights_use_plugin_menu = 0
