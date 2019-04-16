" ~~~~~~~~~~~~~~
" ~~ BEHAVIOR ~~
" ~~~~~~~~~~~~~~

set encoding=utf-8
scriptencoding utf-8

" {{ ASD
set number
set numberwidth=3
" }}

" remove ALL autocommands for the current group.
autocmd!

if has('gui_running')
    set langmenu=none
    if has('win32')
        language en
    else
        language en_US.UTF-8
    endif
endif

" reset all highlighting to the defaults
"highlight clear

" default config for windows
if has('win32') && filereadable($VIM . '/_vimrc')
    source $VIM/_vimrc
endif
if has('+shellslash')
    set shellslash
endif


" line numbers are absolute by default, unless you’re moving around in normal
" mode
" http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/
if exists('+relativenumber')
    set relativenumber
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :let &relativenumber=&number
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

" reload files changed outside Vim (only when there are no local changes)
set autoread



" display tabs and trailing blanks
set list listchars=tab:».,trail:¶,extends:>,precedes:<
let g:LcsTab='tab:».,trail:¶,extends:>,precedes:<'
let g:LcsNoTab='tab:  ,trail:¶,extends:>,precedes:<'
"set list listchars=tab:»\ ,trail:·
"set list listchars=tab:>\ ,trail:$

set tabstop=4
set shiftwidth=4
set softtabstop=0
"set smartindent
set smarttab
set shiftround
set expandtab
set autoindent

set formatoptions+=n      " support for numbered/bullet lists
set formatoptions+=l      " only break lines that were not longer than 'tw'

filetype plugin indent on
autocmd BufRead,BufNewFile .bash_login set filetype=sh
syntax clear
syntax on

" automatically reload vimrc when it's saved
autocmd BufWritePost .vimrc,vimrc sleep 150m | source $MYVIMRC

if has('syntax') && v:version >= 700
    set spelllang=en,hu
endif

let g:tex_flavor='latex'

let g:gitgutter_override_sign_column_highlight = 1
"let g:gitgutter_diff_args = '-w'
"let g:gitgutter_highlight_lines = 0

let g:html_number_lines = 1
let g:html_line_ids = 1
let g:html_prevent_copy = 'fn'
let g:html_use_css = 1

autocmd FileType latex,tex,md,markdown setlocal spell
"autocmd FileType latex,tex,md,markdown setlocal formatoptions=tcroqb1anj
autocmd FileType latex,tex,md,markdown setlocal formatoptions=rojtcq
autocmd FileType latex,tex,md,markdown setlocal textwidth=72
autocmd FileType yaml setlocal sw=2 ts=2

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
    "let &showbreak = "~~~ "
    let &showbreak = '↪ '
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

" put backup, swap and undo files in a central directory instead of the current
" dir
if has('win32') || has ('win64')
    let $VIMHOME = $HOME . '/vimfiles'
else
    let $VIMHOME = $HOME . '/.vim'
endif

let &directory=$VIMHOME . '/swap//, ., ~//, ~/tmp'
let &backupdir=$VIMHOME . '/swap/, ., ~/tmp, ~/'

" remove backup after the file was successful written
set nobackup writebackup

set swapfile updatecount=40 updatetime=1500

if has('persistent_undo')
    set undofile
    let &undodir=$VIMHOME . '/undodir//,.'
endif
set undolevels=1200  " default is 1000

if !has('gui_running') && exists('$TMUX') && empty(&t_ts)
    " enable displaying title in TMUX
    let &t_ts = "\e]2;"
    let &t_fs = "\007"
endif

if has('title') && has('statusline') && &t_ts != ''
    set title
    set titlestring=%t%(\ %{&ro?'=':''}%M%)      " filename, readonly, modified
    set titlestring+=\ (%{expand(\"%:p:~:h\")})  " path
    if exists('$SSH_CONNECTION') && !exists('$TMUX')
        set titlestring+=@%{hostname()}          " hostname if inside SSH,
                                                 " but not in TMUX
    endif
    set titlestring+=%(\ %a%) " path, hostname, argument list status (X of Y)
    set titlestring+=%< " truncate at the end
endif

if has('gui_running')
    if has('win32')
        set guifont=Hack:h10:cEASTEUROPE
        set visualbell
    elseif has('unix')
        set guifont=Hack\ 10
    endif
endif

let mapleader = ','
let g:mkdx#map_prefix = '<leader>'
let g:mkdx#settings = {
            \ 'highlight': { 'enable': 1 },
            \ 'toc': { 'text': 'Table of Contents' }
            \ }

"g:mkdx#settings.toc.text

" is it a slow system?
if has('unix') && system('uname -m') !~? 'x86*'
    set lazyredraw
endif


" ~~~~~~~~~~~~~~
" ~~ PATHOGEN ~~
" ~~~~~~~~~~~~~~

runtime bundle/vim-pathogen/autoload/pathogen.vim

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = ['vim-latex-suite', 'vim-airline']

if hostname() == 'ural2'
    let g:pathogen_disabled = [ 'gruvbox', 'sslsecure.vim', 'vim-airline', 'vim-color-spring-night', 'vim-easy-align', 'vim-fugitive', 'vim-gitgutter', 'vim-latex-suite', 'vimtex', 'vim-wwdc16-theme']

    " 'mkdx', 'nova.vim', 'vim-searchindex', 'vim-solarized8'
endif

if 1
    if has('win32')
        call add(g:pathogen_disabled, 'vim-gitgutter')
        call add(g:pathogen_disabled, 'vim-fugitive')
    else
        silent call system('which git &> /dev/null')
        if v:shell_error != 0
            call add(g:pathogen_disabled, 'vim-gitgutter')
            call add(g:pathogen_disabled, 'vim-fugitive')
        endif
    endif

    "let g:airline_powerline_fonts = 1
    "set timeoutlen=10

    execute pathogen#infect()
endif

set timeout timeoutlen=1500 ttimeoutlen=100

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

let g:color_cursor = 0
if g:color_cursor
    "&term =~ "xterm"
    let &t_SI = "\<Esc>]12;purple\x7"
    let &t_SR = "\<Esc>]12;red\x7"
    let &t_EI = "\<Esc>]12;blue\x7"
endif

" set cursor based on mode: bar in insert mode, block otherwise
if exists('$TMUX')
    "let &t_SI = "\ePtmux;\e\e[5 q\e\\"
    "let &t_EI = "\ePtmux;\e\e[1 q\e\\"
    let &t_SI = &t_SI . "\<ESC>Ptmux;\e\e[5 q\e\\"
    let &t_EI = &t_EI . "\<ESC>Ptmux;\e\e[1 q\e\\"
    set ttimeoutlen=20
elseif &term =~ 'xterm'
    let &t_SI = &t_SI . "\e[5 q"
    let &t_EI = &t_EI . "\e[1 q"
endif

" make striketrough work in TMUX
if exists('$TMUX') && exists('&t_Te')
    " in .tmux.conf:
    " set -as terminal-overrides ',xterm-256color:Tc:smxx=\E[9m'
    let &t_Te = "\e[29m"
    let &t_Ts = "\e[9m"
endif


set background=dark

if 1
    let g:gruvbox_italic=1
    let g:gruvbox_contrast_dark='hard'
    let g:gruvbox_improved_warnings=1
    let g:gruvbox_improved_strings=0
endif


"colorscheme nova
"colorscheme spring-night
if hostname() == 'ural2'
    colorscheme solarized8_dark
else
    colorscheme wwdc16
endif

highlight IncSearch term=inverse,undercurl cterm=bold,undercurl ctermfg=16 ctermbg=130
        \ gui=undercurl guibg=#af5f50 guifg=#000000
highlight Search    term=inverse,bold cterm=bold ctermfg=16 ctermbg=134
        \ guibg=#af0000
        "\ guibg=#af31b6

highlight Search guibg=Turquoise4 guifg=#ffffff


" status-line colors
highlight StatusLineNC gui=inverse guibg=#000000
"highlight StatusLineNC term=inverse cterm=inverse gui=bold guibg=#00ff00
highlight User1 term=inverse,bold ctermfg=15 ctermbg=240
        \ gui=bold guibg=#333333            " buffer number
highlight User2 term=inverse,bold cterm=bold ctermfg=16 ctermbg=160
        \ gui=bold guibg=#ee1111            " modified, read-only and root flags
highlight User3 term=inverse,bold ctermfg=15 ctermbg=238
        \ guibg=#555555                     " character under cursor

highlight SpecialKey cterm=bold gui=bold guifg=#D57AF4
    " original: #455A64
" use it for line overflow marks and 'showbreak' too:
set highlight+=@:SpecialKey

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

if has('statusline') && (!exists('g:loaded_airline') || !g:loaded_airline)
    " always display the status line, even if only one window is displayed
    set laststatus=2
    " set special statusline, format:
    set statusline=%1*%n)%*                     " buffer number
    set statusline+=%<%F                        " filename
    set statusline+=%2*%m                       " modified flag (red)
    set statusline+=%#LineNr#[%Y%H%W]%k%a       " file type + flags
    function! GetStatusLineEnc()
        let l:enc = &fenc!='' ? &fenc : &enc
        if l:enc == 'utf-8'
            let l:enc = ''
        endif

        let l:ff = &ff != 'unix' ? &ff : ''

        if l:enc == '' && l:ff == ''
            return ''
        elseif l:enc != '' && l:ff != ''
            return '[' . l:enc . ',' . l:ff . ']'
        else
            return '[' . l:enc . l:ff . ']'
        endif
    endfunction
    "set statusline+=[%{substitute(&fenc!=''?&fenc:&enc,'^utf-8$','','')}
    set statusline+=%{GetStatusLineEnc()}       " encoding, fifeformat (EoL)
    set statusline+=%2*%{&paste?'[paste]':''}%*
                                                " paste mode on?
    set statusline+=%2*%r%*                     " read-only flag (red)
    set statusline+=%2*%{$USER=='root'?'[root]':''}%*
                                                " run as root?
    set statusline+=%=                          " separator between left & right
    "set statusline+=[Ch=%-3b\ 0x%04B]           " character under cursor
    set statusline+=%3*C=%3b%*\                 " character under cursor
    set statusline+=%8(%l/%L%),\                " line number
    set statusline+=%-6(%c%V%)                  " column number(s)
    set statusline+=%1*%3P%*                    " percentage
endif



" ~~~~~~~~~~~~~~~
" ~~ FUNCTIONS ~~
" ~~~~~~~~~~~~~~~

" remove trailing spaces
function! TrimWS()
    mark '
    " e flag: do not show error when there is nothing to replace
    %substitute/\s\s*$//e
    normal g`'
endfunction

" display the 256 available xterm background and foreground colors
function! ColorDemo()
    let num = 255
    while num >= 0
        let nums = printf('%03d', num)
        exec 'hi col_bg1_' . nums . ' ctermbg=' . nums . ' ctermfg=white'
        exec 'hi col_bg2_' . nums . ' ctermbg=' . nums . ' ctermfg=black'
        exec 'hi col_fg1_' . nums . ' ctermbg=black ctermfg=' . nums
        exec 'hi col_fg2_' . nums . ' ctermbg=white ctermfg=' . nums
        exec 'syn match col_bg1_' . nums . ' "ctermbg1=' . nums .
                    \ ':" containedIn=ALL'
        exec 'syn match col_bg2_' . nums . ' "ctermbg2=' . nums .
                    \ ':" containedIn=ALL'
        exec 'syn match col_fg1_' . nums . ' "ctermfg1=' . nums .
                    \ ':" containedIn=ALL'
        exec 'syn match col_fg2_' . nums . ' "ctermfg2=' . nums .
                    \ ':" containedIn=ALL'

        call append(0, 'ctermbg1=' . nums . ': ctermbg2=' . nums .
                    \ ': ctermfg1=' . nums . ': ctermfg2=' . nums . ':')
        let num = num - 1
    endwhile
endfunction

function! TryDiffFile()
    let path = expand('%')
    if (stridx(path, 'a/') == 0 && !isdirectory('a')) || (stridx(path, 'b/') == 0 && !isdirectory('b'))
        let newpath = path[2:]
        if filereadable(newpath)
            bdelete!
            exec 'edit ' . newpath
            filetype detect
        endif
    endif
endfunction

autocmd BufNewFile a/*,b/* call TryDiffFile()


command! TrimWS call TrimWS()
command! ColorDemo new +call\ ColorDemo()\ |\ set\ bt=nofile
command! Rc source $MYVIMRC
command! ERc edit $MYVIMRC

command! ShowTab let &listchars=g:LcsTab
command! HideTab let &listchars=g:LcsNoTab
"	test

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command! DiffOrig diffoff | let _ft=&ft | vert new | set bt=nofile |
    \ let &ft=_ft | r # | 0d_ | diffthis | wincmd p | diffthis

" user command (named R) to allow easy capture of output in a scratch buffer
" http://vim.wikia.com/wiki/Append_output_of_an_external_command
command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>

" :w!! command saves current file with sudo, useful when changes were made in
" read-only mode
" http://www.jovicailic.org/2015/05/saving-read-only-files-in-vim-sudo-trick/
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

if $USER !=# 'root' && exists('+secure')
    " enable .vimrc in current directory
    set exrc
    " limit commands for security
    set secure
endif

" the default encryption (zip) is weak
set cryptmethod=blowfish2

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

" threshold for reporting number of lines changed (for commands like
" substitution), 0 means always report
set report=0

" when on, splitting a window will put the new window below and right to the
" current one.
set splitbelow splitright

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
noremap <silent> j gj
noremap <silent> k gk
noremap <silent> gj j
noremap <silent> gk k
inoremap <buffer> <silent> <Up>   <C-o>gk
inoremap <buffer> <silent> <Down> <C-o>gj
"noremap h gh
"noremap l gl

" insert newline above or below (like o and O, but stays in normal mode)
" http://vim.wikia.com/wiki/Insert_newline_without_entering_insert_mode
nnoremap <SPACE> msO<Esc>`s
" don't map it for QuickFix and command line (q:) windows
"nnoremap <CR>    mso<Esc>`s
autocmd BufRead,BufNew * if &bt == '' | nnoremap <buffer> <CR> mso<Esc>`sh | endif

" make mappings
" noremap <F5> :make<CR><CR>:cwindow 8<CR>

" save, run `make`, open quickfix window and jump to first error
noremap <F5> :w<CR>:make<CR><CR>:cwindow 5<CR>:cc<CR>
noremap! <F5> <ESC>:w<CR>:make<CR><CR>:cwindow 5<CR>:cc<CR>
" jump to next/previous error
noremap <F6> :cn<CR>
noremap <F7> :cp<CR>

" toggle options
noremap <F2> :set paste! paste?<CR>
set pastetoggle=<F2> " for insert mode

noremap <silent> <F3> :set spell! spell?<CR>
inoremap <silent> <F3> <C-O>:set spell! spell?<CR>
" stop highlighting search matches
noremap <silent> <F4> :nohlsearch<CR>
inoremap <silent> <F4> <C-O>:nohlsearch<CR>

" http://vim.wikia.com/wiki/Search_for_visually_selected_text
"vnoremap // y/\V<C-R>"<CR>
"vnoremap <expr> // 'y/\V'.escape(@*,'\/').'<CR>'
vnoremap <script> // "ty<SID>//
nnoremap <expr> <SID>// '/\V'.escape(@t,'\/').'<CR>'


" needed because sourcing vimrc again makes the sign column glitchy
if exists('gitgutter_enabled') && g:gitgutter_enabled == 1
    call gitgutter#highlight#define_sign_column_highlight()
    call gitgutter#highlight#define_highlights()
endif

" vim: foldmethod=marker foldmarker={{,}}
