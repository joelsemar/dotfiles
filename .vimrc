" Filename:      vimrc
" Description:   Vim configuration file
set directory=~/.vim/tmp
set guioptions-=T

set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/

call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'jnurmine/Zenburn'
Bundle 'flazz/vim-colorschemes'
Bundle 'maksimr/vim-jsbeautify'
Bundle 'einars/js-beautify'
:set cursorline
:hi CursorLine   cterm=NONE ctermbg=lightgray ctermfg=white guibg=darkred guifg=white

" Misc --------------------------------------------------------------------
"

filetype plugin indent on

set cpoptions+=>  " Items in register separated by newline
set history=1000  " Size of command/search history
set hidden        " Allow changing buffers without saving

set spell         " Enables spell check




" Files, Backup -----------------------------------------------------------

set viminfo='1000,<1000,s100,h
"           |     |     |    |
"           |     |     |    +-- Don't restore hlsearch on startup
"           |     |     +------- Exclude registers greater than N Kb
"           |     +------------- Keep N lines for each register
"           +------------------- Keep marks for N files

" Get rid of filename.txt~
set nobackup
" Where to store swap files
set directory=~/.vim_backup



" Text-Formatting, Identing, Tabbing --------------------------------------

set autoindent     " Use indent from previous line
set smarttab       " Smart handling of the tab key
set expandtab      " Use spaces for tabs
set shiftround     " Round indent to multiple of shiftwidth
set shiftwidth=2   " Number of spaces for each indent
set softtabstop=2 " Number of spaces for tab key
set number         " Line numbers on
set textwidth=120   " Column width
set nowrap         " Do not wrap lines

set formatoptions-=t  " Don't auto-wrap text
set formatoptions+=corqn
"                  |||||
"                  ||||+-- Recognize numbered lists
"                  |||+--- Allow formatting of comments with 'gq'
"                  ||+---- Insert comment leader after <Enter>
"                  |+----- Insert comment leader after o/O
"                  +------ Auto-wrap comments

set backspace=indent,eol,start  " Allow backspacing over these

set foldmethod=marker

" Non-text and special key characters
let &sbr = nr2char(8618).' '  " Show ↪ at the beginning of wrapped lines
"set list

" Date formatting
let timestamp_format = '%a %Y-%m-%d %H:%M:%S (%z)'



" Searching, Substituting -------------------------------------------------

set incsearch    " Show search matches as you type
set ignorecase   " Ignore case when searching
set smartcase    " Override 'ignorecase' when needed
set hlsearch     " Highlight search results
set showmatch    " Show matching bracket
set paste
set matchtime=2  " (for only .2 seconds)




" Menus, Completion -------------------------------------------------------

set infercase  " Try to adjust insert completions for case
set completeopt=longest,menu,menuone
"               |       |    |
"               |       |    +-- Show popup even with one match
"               |       +------- Use popup menu with completions
"               +--------------- Insert longest completion match

set wildmenu  " Enable wildmenu for completion
set wildmode=longest:full,list:full
"            |            |
"            |            +-- List matches, complete first match
"            +--------------- Complete longest prefix, use wildmenu



" Windows, Tabs -----------------------------------------------------------

set mouse=a           " Enable the mouse for all modes
set mousehide         " Hide mouse while typing
set mousemodel=popup  " Use popup menu for right mouse button

set splitright  " When splitting vertically, split to the right
set splitbelow  " When splitting horizontally, split below

set tabpagemax=128  " Maximum number of tabs open



" Display, Messages, Terminal ---------------------------------------------

set numberwidth=1     " Make line number column as narrow as possible
set lazyredraw        " Don't redraw while executing macros
set ttyfast           " Indicates a fast terminal connection
set noerrorbells      " Error bells are annoying
set title             " Set descriptive window/terminal title
set report=0          " Always report the number of lines changed
set display=lastline  " Show as much of the last line as possible

set printoptions=paper:letter

set shortmess=aTItoO
"             ||||||
"             |||||+- Message for reading file overwrites previous
"             ||||+-- Don't prompt to overwrite file
"             |||+--- Truncate file at start if too long
"             ||+---- Disable intro message
"             |+----- Truncate messages in the middle if too long
"             +------ Shortcut for various status line options



" Statusline, Messages ----------------------------------------------------

set showcmd       " Display the command in the last line
set showmode      " Display the current mode in the last line
set ruler         " Display info on current position
set laststatus=2  " Always show status line

set statusline=%!GetStatusLine()  " Set statusline from a function



" Functions ---------------------------------------------------------------

" Places the cursor at the last position for a file
function! JumpToLastPosition()
    if line("'\"") > 0 && line("'\"") <= line("$")
        normal! g`"
    endif
endfunction

" Returns the indent level of the current line
function! GetIndent()
    return indent('.')/&sw
endfunction

" Returns the string used for the status line
function! GetStatusLine()
    let line = ''
    let line .= '%5*[%n]%* '       " Buffer number
    let line .= '%<%4*%f%*'        " Filename
    let line .= '%7*%4m%*'         " Modified flag
    let line .= '%3*%5r%*'         " Readonly flag
    let line .= '%3*%10w%* '       " Preview flag
    let line .= '%9*[%{&ff}]%* '   " File format
    let line .= "%9*[%{(&fenc!=''?&fenc:&enc)}]%* " " File encoding
    let line .= '%6*%y%* '         " File type
    let line .= '%='               " Left/right separator
    let line .= '%1*[%o] '         " Byte number
    let line .= '+%{GetIndent()} ' " Indent level
    let line .= '%l,%c%V/%L%* '    " Position line,column/total
    let line .= '%3*%P%*'          " Percentage through file
    return line
endfunction



" Plugin Settings ---------------------------------------------------------

" NERD Tree
let NERDSpaceDelims = 1
let NERDShutUp = 1
let NERDTreeIgnore = ['\.pyc$']
" Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

" SuperTab
let g:SuperTabDefaultCompletionType = "<C-X><C-O>" " Pressing tab calls ctrl+X ctrl+O instead of default (ctrl+N ?)



" Autocommands ------------------------------------------------------------

augroup misc
    autocmd!
    autocmd BufReadPost * call JumpToLastPosition()
    autocmd FileChangedShell * call WarningMsg("File changed outside of vim")
augroup end

" Use Arduino syntax file for any files ending in .pde
au BufNewFile,BufRead *.pde setf arduino

" autocmd VimEnter * exe 'NERDTree' | wincmd l "Start NERDTree on load




" Highlighting, Colors ----------------------------------------------------

syntax on  " Enable syntax highlighting

"colorscheme codeschool
"colorscheme twilight
colorscheme zenburn






"NerdTree help--------------------------------------------------------------
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>
map  <C-n> :tabnew<CR>
autocmd VimEnter * NERDTree
autocmd BufEnter * NERDTreeMirror
"
autocmd VimEnter * wincmd w
":hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:nnoremap <Leader>c :set cursorline!<CR>

:noremap <S-Tab> <C-w><C-w>
:vnoremap <C-S-c> "+y
set list
set listchars=tab:▸\ ,eol:¬,trail:.,extends:›,precedes:‹
au BufWritePre * :%s/\s\+$//e
