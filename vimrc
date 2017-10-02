" ~~~~~~~~~~~~~~
" ~~ BEHAVIOR ~~
" ~~~~~~~~~~~~~~

set number
set numberwidth=3
" line numbers are absolute by default, unless you’re moving around in normal
" mode
" http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/
if exists('+relativenumber')
    set relativenumber
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
endif

" enable use of the mouse for all modes
set mouse=a

" each item allows a way to backspace over something:
"     indent  allow backspacing over autoindent
"     eol     allow backspacing over line breaks (join lines)
"     start   allow backspacing over the start of insert; CTRL-W and CTRL-U
"             stop once at the start of insert.
set backspace=indent,eol,start

set history=1000
set scrolloff=4
set sidescrolloff=10

" reload files changed outside vim
set autoread


set encoding=utf-8

" display tabs and trailing blanks
set list listchars=tab:»\ ,trail:¶,extends:>,precedes:<
"set list listchars=tab:»\ ,trail:·
"set list listchars=tab:>\ ,trail:$

set tabstop=4
set shiftwidth=4
set softtabstop=0
set smartindent
set smarttab  " experimental
set shiftround
set expandtab
set autoindent

set formatoptions+=n      " support for numbered/bullet lists
set formatoptions+=l      " only break lines that were not longer than 'tw'

" remove ALL autocommands for the current group.
autocmd!

filetype plugin indent on
autocmd BufRead,BufNewFile .bash_login set filetype=sh
syntax clear
syntax on

" automatically reload vimrc when it's saved
autocmd BufWritePost .vimrc,vimrc sleep 250m | source $MYVIMRC

if has('syntax') && version >= 700
    set spelllang=en,hu
endif

let g:tex_flavor='latex'

let g:gitgutter_eager = 1
let g:gitgutter_realtime = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_diff_args = '-w'

let g:html_number_lines = 1
let g:html_line_ids = 1
let g:html_prevent_copy = "fn"
let g:html_use_css = 1

autocmd FileType latex,tex,md,markdown setlocal spell
autocmd FileType latex,tex,md,markdown setlocal formatoptions=tcroqb1an
autocmd FileType latex,tex,md,markdown setlocal textwidth=72

autocmd FileType gitcommit setlocal textwidth=72 spell

autocmd FileType sh setlocal formatoptions-=t  " do not hard break long lines

" show partial commands in the last line of the screen
set showcmd

set showmode
" statusline overrides ruler
"set ruler

" remove splash screen
set shortmess+=I

" instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" when there is a previous search pattern, highlight all its matches.
set hlsearch

" while typing a search command, show where the pattern, as it was typed
" so far, matches.
set incsearch
" use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" this makes Vim break text to avoid lines getting longer than 80 characters.
" (not just visually, inserts <EOL>)
set textwidth=80

" vertical ruler
if exists('+colorcolumn')
    set colorcolumn=+1  " after textwidth
    "set colorcolumn=81
endif

" visually wrap long lines
set wrap
if has('linebreak')
    " Vim will wrap long lines at a character in 'breakat' rather than at the
    " last character (only affects how the text is displayed)
    set linebreak

    if exists('+breakindent')
        " every wrapped line will continue visually indented
        set breakindent
        set breakindentopt=min:25
    end

    " string to put at the start of lines that have been wrapped
    "set showbreak=~~~\ 
    set showbreak=↪\ 
end

if exists('+virtualedit')
    " virtual editing means that the cursor can be positioned where there is no
    " actual character.  This can be halfway into a tab or beyond the line end.
    "   block   Allow virtual editing in Visual block mode.
    "   insert  Allow virtual editing in Insert mode.
    "   all     Allow virtual editing in all modes.
    "   onemore Allow the cursor to move just past the end of the line
    set virtualedit=all
    "set virtualedit=block,onemore
endif

" set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" do not unload abandoned buffers
set hidden

" Behavior when switching buffers (:sbuffer, :cc)
"     useopen   Jump to the first open window that contains the specified
"               buffer
"     usetab    Same for tabs
"     split     If included, split the current window before loading a buffer
"               for a quickfix command that display errors.
"               Otherwise: do not split, use current window.
set switchbuf=useopen,usetab,split

" put swap files in a central directory instead of the current dir
set directory=~/.vim/swap//,.

set undofile undodir=~/.vim/undodir//,.

if has('title') && &t_ts != ''
    set title

    "auto BufEnter * let &titlestring = hostname() . "/" . expand("%:p")
    set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
endif


" ~~~~~~~~~~~~~~
" ~~ PATHOGEN ~~
" ~~~~~~~~~~~~~~

runtime bundle/vim-pathogen/autoload/pathogen.vim

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = ['vim-latex-suite']

silent call system('which git &> /dev/null')
if v:shell_error != 0
    call add(g:pathogen_disabled, 'vim-gitgutter')
endif

let g:airline_powerline_fonts = 1
set timeoutlen=10

execute pathogen#infect()

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ~~~~~~~~~~~~~
" ~~ THEMING ~~
" ~~~~~~~~~~~~~

" gorgeous 24-bit colors
if has('termguicolors')
    set termguicolors

    " for tmux
    " linuxquestions.org/questions/slackware-14/tip-24-bit-true-color-terminal-tmux-vim-4175582631/
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes work properly
    " when Vim is used inside tmux and GNU screen. From:
    " https://superuser.com/a/588243
    set t_ut=
endif


" reset all highlighting to the defaults
highlight clear

set background=dark

let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_improved_warnings=1
let g:gruvbox_improved_strings=0


"colorscheme nova
"colorscheme solarized8_dark
colorscheme wwdc16
"colorscheme spring-night

highlight IncSearch term=inverse,undercurl cterm=bold ctermfg=16 ctermbg=130
        \ guibg=#af5f00
highlight Search    term=inverse,bold cterm=bold ctermfg=16 ctermbg=134
        \ guibg=#af31b6

" status-line colors
highlight User1 term=inverse,bold ctermfg=15 ctermbg=240
        \ gui=bold guibg=#333333            " buffer number
highlight User2 term=inverse,bold cterm=bold ctermfg=16 ctermbg=160
        \ gui=bold guibg=#ee1111            " modified, read-only and root flags
highlight User3 term=inverse,bold ctermfg=15 ctermbg=238
        \ guibg=#555555                     " character under cursor

highlight SpecialKey guifg=#D57AF4
	" original: #455A64

" change diff highlighting
highlight DiffAdd    cterm=none ctermfg=10 ctermbg=17
highlight DiffDelete cterm=none ctermfg=10 ctermbg=17
highlight DiffChange cterm=none ctermfg=10 ctermbg=17
highlight DiffText   cterm=none ctermfg=10 ctermbg=88

"highlight ColorColumn term=reverse cterm=bold ctermbg=1 ctermfg=7

highlight clear MatchParen
highlight MatchParen term=reverse cterm=reverse,underline
"underline

" change line number column style
"highlight LineNr term=bold ctermfg=254 ctermbg=236
"    \ guifg=#000000 guibg=#a4a4a4
" cterm=none
"highlight LineNr term=underline ctermfg=10 ctermbg=0
"    \ guifg=#586e75 guibg=#000000

highlight CursorLineNr term=reverse cterm=NONE gui=NONE guibg=#052731
"guibg=#073642

"highlight! link SignColumn LineNr

"highlight Error ctermbg=160 ctermfg=15
highlight Error ctermbg=Red ctermfg=White
" White

highlight clear SpellBad
highlight SpellBad cterm=underline gui=underline,bold

if v:version > 700
    "set cursorline
    highlight clear CursorLine
    highlight CursorLine cterm=underline
    " ctermbg=0
endif

" ~~~~~~~~~~~~~~~~~
" ~~ STATUS LINE ~~
" ~~~~~~~~~~~~~~~~~

if (!exists('g:loaded_airline') || !g:loaded_airline)
    " always display the status line, even if only one window is displayed
    set laststatus=2
    " set special statusline, format:
    set statusline=%1*%n)%*                     " buffer number
    set statusline+=%<%F                        " filename
    set statusline+=%2*%m                       " modified flag (red)
    set statusline+=%#LineNr#[%Y%H%W]%k%a       " file type + flags
    set statusline+=[%{&fenc!=''?&fenc:&enc},   " encoding
    set statusline+=%{&ff}]                     " file format
    set statusline+=%2*%{&paste=='0'?'':'[paste]'}%*
                                                " paste mode on?
    set statusline+=%2*%r%*                     " read-only flag (red)
    set statusline+=%2*%{$USER=='root'?'[root]':''}%*
                                                " run as root?
    set statusline+=%=                          " separator between left & right
    "set statusline+=[Ch=%-3b\ 0x%04B]           " character under cursor
    set statusline+=%3*[C=%3b]%*                " character under cursor
    set statusline+=%8(%l/%L%),\                " line number
    set statusline+=%-6(%c%V%)                  " column number(s)
    set statusline+=%1*%3P%*                    " percentage
endif



" ~~~~~~~~~~~~~~~
" ~~ FUNCTIONS ~~
" ~~~~~~~~~~~~~~~

" remove trailing spaces
function! TrimWS()
  %s/\s*$//
  ''
:endfunction

" display the 256 available xterm background and foreground colors
function! ColorDemo()
    let num = 255
    while num >= 0
        exec 'hi col_bg1_'.num.' ctermbg='.num.' ctermfg=white'
        exec 'hi col_bg2_'.num.' ctermbg='.num.' ctermfg=black'
        exec 'hi col_fg1_'.num.' ctermbg=black ctermfg='.num
        exec 'hi col_fg2_'.num.' ctermbg=white ctermfg='.num
        exec 'syn match col_bg1_'.num.' "ctermbg1='.num.':" containedIn=ALL'
        exec 'syn match col_bg2_'.num.' "ctermbg2='.num.':" containedIn=ALL'
        exec 'syn match col_fg1_'.num.' "ctermfg1='.num.':" containedIn=ALL'
        exec 'syn match col_fg2_'.num.' "ctermfg2='.num.':" containedIn=ALL'
        call append(0, 'ctermbg1='.num.': ctermbg2='.num.': ctermfg1='.num.': ctermfg2='.num.':')
        let num = num - 1
    endwhile
:endfunction

command! TrimWS call TrimWS()
command! ColorDemo new +call\ ColorDemo()
command! Rc source $MYVIMRC

" :w!! command saves current file with sudo, useful when changes were made in
" read-only mode
" http://www.jovicailic.org/2015/05/saving-read-only-files-in-vim-sudo-trick/
cmap w!! w !sudo tee % >/dev/null

if $USER !=# 'root' && exists('+secure')
    " enable .vimrc in current directory
    set exrc
    " limit commands for security
    set secure
endif

" if Vim is used as the pager, this is needed for the case when you start Vim
" normally and want to use Vim's Man function
" http://vim.wikia.com/wiki/Using_vim_as_a_man-page_viewer_under_Unix
let $PAGER=''

" modeline: comments at the end of a file can contain option settings
" e.g: vim: tw=72 et
set modeline
set modelines=5

" completion mode: display list and complete to longest common string, then to
" first full match
set wildmenu
set wildmode=list:longest,list:full

set helpheight=15

" a status line will be used to separate windows.  The 'laststatus' option
" tells when the last window also has a status line:
"   'laststatus' = 0   never a status line
"   'laststatus' = 1   status line if there is more than one window
"   'laststatus' = 2   always a status line
set laststatus=2

" threshold for reporting number of lines changed (for commands like
" substitution), 0 means always report
set report=0

" when on, splitting a window will put the new window below the current one.
set splitbelow
" when on, splitting a window will put the new window right of the current one.
set splitright

" stop certain movements from always going to the first character of a line.
set nostartofline

" when diffing, fill deleted lines & ignore white space differences
set diffopt=filler,iwhite

" different colorscheme for diff'ing
"if &diff
"    colorscheme ron
"endif

" ~~~~~~~~~~~~~~
" ~~ MAPPINGS ~~
" ~~~~~~~~~~~~~~

" remove arrow key mappings
"inoremap  <Up>     <NOP>
"inoremap  <Down>   <NOP>
"inoremap  <Left>   <NOP>
"inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" move between displayed lines, important when lines are visually wrapped
noremap j gj
noremap k gk
"noremap h gh
"noremap l gl

" make mappings
" map <F5> :make<CR><CR>:cwindow 8<CR>

" save, run `make`, open quickfix window and jump to first error
map <F5> :w<CR>:make<CR><CR>:cwindow 5<CR>:cc<CR>
map! <F5> <ESC>:w<CR>:make<CR><CR>:cwindow 5<CR>:cc<CR>
" jump to next/previous error
map <F6> :cn<CR>
map <F7> :cp<CR>

" toggle options
noremap <F2> :set paste! paste?<CR>
set pastetoggle=<F2> " for insert mode

noremap <F3> :set spell! spell?<CR>
noremap! <F3> <C-O>:set spell! spell?<CR>
" stop highlighting search matches
noremap <F4> :nohlsearch<CR>
