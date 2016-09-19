" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" properly set to work with the Vim-related packages.
" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim74/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

runtime! archlinux.vim
"runtime! vimrc_example.vim

" Or better yet, read /usr/share/vim/vim74/vimrc_example.vim or the vim manual
" and configure vim to your own liking!
" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim74/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" vimpager options
let vimpager_use_gvim = 1
"let vimpager_passthrough = 0
"let vimpager_disable_x11 = 1
"let vimpager_scrolloff = 5
"let vimpager_disable_ansiesc = 1
" [1;5Q [12^

" tmux will send xterm-style keys when its xterm-keys option is on
"if &term =~ '^screen'
"    execute 'set <xUp>=\e[1;*A'
"    execute 'set <xDown>=\e[1;*B'
"    execute 'set <xRight>=\e[1;*C'
"    execute 'set <xLeft>=\e[1;*D'
"endif


" mark-colors mark-highlight-color
let g:mwDefaultHighlightingPalette = 'maximum'
"let g:mwDefaultHighlightingPalette = 'extended'
let g:mwAutoLoadMarks = 1
"let g:mwDefaultHighlightingNum = 9
let g:mwIgnoreCase = 0
highlight link SearchSpecialSearchType MoreMsg
"There are no default mappings for toggling all marks and for the |:MarkClear|
"command, but you can define some yourself: >
    nmap <Leader>M <Plug>MarkToggle
    "nmap <Leader>n <Plug>MarkAllClear
"As the latter is irreverible, there's also an alternative with an additional
"confirmation: >
    nmap <Leader>n <Plug>MarkConfirmAllClear
"To remove the default overriding of * and #, use: >
    nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
    nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev
"If you don't want the * and # mappings remember the last search type and
"instead always search for the next occurrence of the current mark, with a
"fallback to Vim's original * command, use: >
    nmap * <Plug>MarkSearchOrCurNext
    nmap # <Plug>MarkSearchOrCurPrev
"The search mappings (*, #, etc.) interpret [count] as the number of
"occurrences to jump over. If you don't want to use the separate
"|mark-keypad-searching| mappings, and rather want [count] select the highlight
"group to target (and you can live with jumps restricted to the very next
"match), (re-)define to these mapping targets: >
    "nmap * <Plug>MarkSearchGroupNext
    "nmap # <Plug>MarkSearchGroupPrev
"You can remap the direct group searches (by default via the keypad 1-9 keys): >
    nmap <Leader>1  <Plug>MarkSearchGroup1Next
    nmap <Leader>!  <Plug>MarkSearchGroup1Prev
    nmap <Leader>2  <Plug>MarkSearchGroup2Next
    nmap <Leader>3  <Plug>MarkSearchGroup2Next
    nmap <Leader>4  <Plug>MarkSearchGroup2Next
    nmap <Leader>5  <Plug>MarkSearchGroup2Next
    nmap <Leader>6  <Plug>MarkSearchGroup2Next
    nmap <Leader>7  <Plug>MarkSearchGroup2Next
    nmap <Leader>8  <Plug>MarkSearchGroup2Next
    nmap <Leader>9  <Plug>MarkSearchGroup2Next
"*g:mwDirectGroupJumpMappingNum*
"If you need more / less groups, this can be configured via: >
    let g:mwDirectGroupJumpMappingNum = 50
" *mark-whitespace-indifferent*
"Some people like to create a mark based on the visual selection, like
"|v_<Leader>m|, but have whitespace in the selection match any whitespace when
"/gsearching (searching for 'hello world' will also find 'hello<Tab>world' as
"/gwell as 'hello' at the end of a line, with 'world' at the start of the next
"line). The Vim Tips Wiki describes such a setup for the built-in search at
"    http://vim.wikia.com/wiki/Search_for_visually_selected_text
"You can achieve the same with the Mark plugin through the <Plug>MarkIWhiteSet
"mapping target: Using this, you can assign a new visual mode mapping <Leader>* >
    xmap <Leader>* <Plug>MarkIWhiteSet
"or override the default |v_<Leader>m| mapping, in case you always want this
"behavior: >
    vmap <Plug>IgnoreMarkSet <Plug>MarkSet
    xmap <Leader>m <Plug>MarkIWhiteSet

" Custom mappings
" Quickly select the text that was just pasted. This allows you to, e.g.,
" indent it after pasting.
noremap gV `[v`]
" Stay in visu" al mode when indenting. You will never have to run gv after
" performing an indentation.
vnoremap < <gv
vnoremap > >gv
" Make Y yank everything from the cursor to the end of the line. This makes Y
" act more like C or D because by default, Y yanks the current line (i.e. the
" same as yy).
noremap Y y$
" Make Ctrl-e jump to the end of the current line in the insert mode. This is
" handy when you are in the middle of a line and would like to go to its end
" without switching to the normal mode.
inoremap <C-e> <C-o>$
" Allows you to easily replace the current word and all its occurrences.
nnoremap <Leader>rc :%s/\<<C-r><C-w>\>/
vnoremap <Leader>rc y:%s/<C-r>"/
" Allows you to easily change the current word and all occurrences to something
" else. The difference between this and the previous mapping is that the mapping
" below pre-fills the current word for you to change.
nnoremap <Leader>cc :%s/\<<C-r><C-w>\>/<C-r><C-w>
vnoremap <Leader>cc y:%s/<C-r>"/<C-r>"
" Replace tabs with four spaces. Make sure that there is a tab character between
" the first pair of slashes when you copy this mapping into your .vimrc!
nnoremap <Leader>rts :%s/ /    /g<CR>
" Remove ANSI color escape codes for the edited file. This is handy when
" piping colored text into Vim.
nnoremap <Leader>rac :%s/<C-v><Esc>\[\(\d\{1,2}\(;\d\{1,2}\)\{0,2\}\)\?[m\|K]//g<CR>
" onoremap af :<C-u>normal! ggVG<CR>
nnoremap <silent> <expr> j (v:count ? 'j' : 'gj')
nnoremap <silent> <expr> k (v:count ? 'k' : 'gk')
nnoremap <Leader>ew :tabe <C-r>=expand("%:p:h")."/"<CR>
nnoremap <Leader>[ :q<CR>
nnoremap <Leader>] :w<CR>
nnoremap <Leader>; :q!<CR>
nnoremap <Leader>' :w!<CR>
nnoremap <Leader>" mzI# <Esc>`z
" nnoremap <Leader>" mzI" <Esc>`z
nnoremap <Leader>- <Esc>:set nu!<CR>
nnoremap <Leader>= <Esc>:set rnu!<CR>
"nnoremap <Leader>, :s/.*[0-9]*[\.\]] \([A-Z].*\) \[.*\]$/\1/
nnoremap <Leader>, :s/ .*:[0-9][0-9]//
nnoremap <Leader>. :s/[0-9]*\. //
"nnoremap <Leader>. V"+y<Esc>:call system("xclip -i -selection clipboard", getreg("\""))
"\<CR>:call system("xclip -i", getreg("\""))<CR>
map [1;5Q <C-F2>
map [1;5R <C-F3>
map [1;5S <C-F4>
map [15;5~ <C-F5>
map [17;5~ <C-F6>
map [18;5~ <C-F7>
map [19;5~ <C-F8>
map [20;5~ <C-F9>
map <Esc><F2> <M-F2>
map <Esc><F3> <M-F3>
map <Esc><F4> <M-F4>
map <Esc><F5> <M-F5>
map <Esc><F6> <M-F6>
map <Esc><F7> <M-F7>
map <Esc><F8> <M-F8>
map <Esc><F9> <M-F9>
nnoremap <F2> ^
nnoremap <C-F2> 0dw
nnoremap <M-F2> <Esc>:set scrollbind<CR>
nnoremap <F3> $
nnoremap <C-F3> gi
nnoremap <M-F3> <Esc>:set noscb<CR>
nnoremap <F4> <C-u>
nnoremap <C-F4> <Esc>:tabn<CR>
nnoremap <F5> <C-d>
nnoremap <C-F5> <Esc>:tabp<CR>
" Clipboard mappings
vmap <F6> "+y<Esc>:call system("xclip -i -selection clipboard", getreg("\""))
\<CR>:call system("xclip -i", getreg("\""))<CR>
vmap <C-F6> <F6>v`>
vmap <M-F6> :<Esc>`>a<CR><Esc>mx`<i<CR><Esc>my'xk$v'y!xclip -selection c<CR>u
"vmap <M-F6> <F6>v`>"+x
"nmap <F7> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>"+p
nmap <F7> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>"+p
nmap <C-F7> :set paste<CR>i<CR><CR><Esc>k:.!xclip -o<CR>JxkJx:set nopaste<CR>
"nmap <C-F7> mz:call setreg("\"",system("xclip -o -selection clipboard"))<CR>"+gP
nmap <M-F7> mz:-1r !xclip -o -sel clip<CR>`z
vmap <M-c> "*y
vmap <M-x> "*x
nmap <M-v> "*p
" Function maps
"nmap <F8> <Esc>:help
nmap <F8> <Esc>:verbose map
"map <C-F8> <Esc>:verbose set all
let g:tverbose = 0
function! ToggleVerbose()
    if g:tverbose
        set verbose=0
	let g:tverbose = 0
    else
        set verbose=9
	let g:tverbose = 1
    endif
endfunction
nnoremap <C-F8> :call ToggleVerbose()<CR>
let g:thex = 0
function! ToggleHex()
    if g:thex == 0
	set display=uhex,lastline
	let g:thex = 1
    elseif g:thex == 1
	set display=
	let g:thex = 2
   else
	set display=lastline
	let g:thex = 0
    endif
endfunction
nnoremap <M-F8> :call ToggleHex()<CR>
"let g:tmouse = 0
let g:tfold = 0
"function! ToggleMouse()
function! ToggleFold()
    "if g:tmouse
    if g:tfold
        "set mouse=a
        "let g:tmouse = 0
	0,$foldc!
	let g:tfold = 0
    else
        "set mouse=r
        "let g:tmouse = 1
	0,$foldo!
	let g:tfold = 1
    endif
endfunction
nnoremap <F9> :call ToggleFold()<CR>
"nnoremap <F9> :call ToggleMouse()<CR>
let g:txxd = 0
function! ToggleXXD()
    if g:txxd
	edit!
	let g:txxd  = 0
    else
	%!xxd
	let g:txxd = 1
    endif
endfunction
nnoremap <C-F9> :call ToggleXXD()<CR>
"nnoremap <F10> <Esc>:%!xxd<CR>
let g:tindent = 0
function! ToggleIndent()
    if g:tindent == 0
	set shiftwidth=1
	let g:tindent = 1
    elseif g:tindent == 1
	set shiftwidth=8
	let g:tindent = 2
   else
	set shiftwidth=4
	let g:tindent = 0
    endif
endfunction
nnoremap <M-F9> :call ToggleIndent()<CR>
"nnoremap <C-F9> <C-O>:call ToggleIndent()<CR>
"inoremap <F9> :call ToggleMouse()<CR>

if has('gui_running')
  set nopaste
  set guioptions=aAeigmrLT
"  set clipboard=unnamedplus,autoselectplus
  set clipboard=unnamedplus
  let g:solarized_termcolors=16	"default value is 16
  let g:solarized_degrade=0		"default value is 0
  let g:solarized_termtrans=0		"default value is 0
  let g:solarized_contrast="low"	"default value is normal
  let g:solarized_visibility="normal"	"default value is normal
  set lines=60 columns=108 linespace=0
  set guifont=Source\ Code\ Pro\ Light\ 16
"  set guifont=Terminus\ (TTF)\ Medium\ 16
"  set guifont=Terminess\ Powerline\ 16
else
  set paste
  set guioptions=aAeaigmrLT
"  set clipboard+=unnamedplus
  set clipboard=unnamedplus,autoselectplus
  let g:solarized_termcolors=256	"default value is 16
  let g:solarized_degrade=0		"default value is 0
  let g:solarized_termtrans=1		"default value is 0
  let g:solarized_contrast="high"	"default value is normal
  let g:solarized_visibility="normal"	"default value is normal
  let g:mwDefaultHighlightingPalette = 'maximum'
endif
let g:solarized_diffmode="high"	"default value is normal
let g:solarized_hitrail=1	"default value is 0
" colorscheme solarized
colorscheme gruvbox
syntax on
syntax enable
filetype on
filetype plugin on
set omnifunc=syntaxcomplete#Complete
set nocp
set background=dark
set mouse=a
set shiftwidth=4
set verbose=0
set display=lastline
set showcmd
set timeout timeoutlen=2500 ttimeoutlen=100
set pastetoggle=<F10>
set number
set incsearch
set smartcase
"set relativenumber
"formal: au BufNewFile,BufRead * setf {filetype}
au BufNewFile,BufRead *.jq setf javascript
au BufNewFile,BufRead *tmux.conf setf tmux
au BufNewFile,BufRead *nanorc setf nanorc
au BufNewFile,BufRead *vimpagerrc setf vim
au BufNewFile,BufRead *.\(service\|socket\|target\|timer\)* setf sysctl
au BufNewFile,BufRead *\(nftables.conf\|.nft\)* set filetype=nftables
au BufNewFile,BufRead *conf setf config
" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo=!,\'100,\"100,:100,%,n~/.viminfo
"set viminfo='100,n~/.vim/files/info/viminfo
"set viminfo+=
"set viminfo='10,\"100,:20,%,n/store/.viminfo
"call plug#begin('~/.vim/plugged')
" Make sure you use single quotes
" Plug 'junegunn/seoul256.vim'
" Plug 'junegunn/vim-easy-align'
" Group dependencies, vim-snippets depends on ultisnips
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Using git URL
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'
"Plug 'mhinz/vim-startify'
"call plug#end()
"
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
if has("folding")
  function! UnfoldCur()
    if !&foldenable
      return
    endif
    let cl = line(".")
    if cl <= 1
      return
    endif
    let cf  = foldlevel(cl)
    let uf  = foldlevel(cl - 1)
    let min = (cf > uf ? uf : cf)
    if min
      execute "normal!" min . "zo"
      return 1
    endif
  endfunction
endif
augroup resCur
  autocmd!
  if has("folding")
    au VimEnter * if ResCur() | call UnfoldCur() | endif
    au BufWinEnter * if ResCur() | call UnfoldCur() | endif
  else
"  au VimEnter * silent loadview
  au VimEnter * loadview
"  au BufWinEnter * silent loadview
  au BufWinEnter * loadview
  au BufWinEnter * call ResCur()
"  au BufReadPost * call setpos(".", getpos("'\""))
  au BufWinLeave * mkview
  endif
augroup END
"augroup resCur
"  au!
"  au VimEnter * silent loadview
"  au BufWinEnter * silent loadview
"  au BufWinEnter * call ResCur()
"  au BufReadPost * call setpos(".", getpos("'\""))
"  au BufWinLeave * mkview
"augroup END
" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endiF
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END
"augroup myvimrc
"    au!
"    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so /etc/vimrc | if has('gui_running') | so /etc/gvimrc | endif
"augroup END

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesActivate
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"Commands:
":RainbowParenthesesToggle       " Toggle it on/off
":RainbowParenthesesLoadRound    " (), the default when toggling
":RainbowParenthesesLoadSquare   " []
":RainbowParenthesesLoadBraces   " {}
":RainbowParenthesesLoadChevrons " <>

let g:startify_custom_header =
    \ map(split(system('fortune | cowsay'), '\n'), '"   ". v:val')

autocmd User Startified setlocal cursorline

let g:startify_enable_special         = 1
let g:startify_files_number           = 8
let g:startify_relative_path          = 1
let g:startify_change_to_dir          = 1
let g:startify_update_oldfiles        = 1
let g:startify_session_autoload       = 1
let g:startify_session_persistence    = 1
let g:startify_session_delete_buffers = 1

let g:startify_list_order = [
  \ ['   LRU:'],
  \ 'files',
  \ ['   LRU within this dir:'],
  \ 'dir',
  \ ['   Sessions:'],
  \ 'sessions',
  \ ['   Bookmarks:'],
  \ 'bookmarks',
  \ ]

let g:startify_skiplist = [
	    \ 'COMMIT_EDITMSG',
	    \ 'bundle/.*/doc',
	    \ '/data/repo/neovim/runtime/doc',
	    \ '/Users/mhi/local/vim/share/vim/vim74/doc',
	    \ ]

let g:startify_bookmarks = [
	    \ { 'c': '~/.vim/vimrc' },
	    \ '~/golfing',
	    \ ]

let g:startify_custom_footer =
      \ ['', "   Vim is charityware. Please read ':help uganda'.", '']

hi StartifyBracket ctermfg=240
hi StartifyFile    ctermfg=147
hi StartifyFooter  ctermfg=240
hi StartifyHeader  ctermfg=114
hi StartifyNumber  ctermfg=215
hi StartifyPath    ctermfg=245
hi StartifySlash   ctermfg=240
hi StartifySpecial ctermfg=240

function! Hashbang(portable, permission)
let shells = {
        \    'awk': "awk",
        \     'sh': "bash",
        \     'hs': "runhaskell",
        \     'jl': "julia",
        \    'lua': "lua",
        \    'mak': "make",
        \     'js': "node",
        \      'm': "octave",
        \     'pl': "perl",
        \    'php': "php",
        \     'py': "python",
        \      'r': "Rscript",
        \     'rb': "ruby",
        \  'scala': "scala",
        \    'tcl': "tclsh",
        \    ' tk': "wish"
        \    }

let extension = expand("%:e")

if has_key(shells,extension)
	let fileshell = shells[extension]

	if a:portable
		let line =  "#! /usr/bin/env " . fileshell
	else
		let line = "#! " . system("which " . fileshell)
	endif

	0put = line

	if a:permission
		:autocmd BufWritePost * :autocmd VimLeave * :!chmod u+x %
	endif

endif

endfunction

:autocmd BufNewFile *.* :call Hashbang(1,1)

" archived mappings
"function! ToggleHex()
"    if g:thex
"	set display=uhex,lastline
"	let g:thex = 1
"    else
"	set display=
"	let g:thex = 0
"    endif
"endfunction
"function! ToggleIndent()
"    if g:tindent
"	set shiftwidth=1
"	let g:tindent = 0
"    else
"        set shiftwidth=8
"	let g:tindent = 1
"    endif
"endfunction
"let g:thex = 0
"function! ToggleHex()
"    if g:thex
"	set display=uhex
"	let g:thex = 0
"    else
"	set display=lastline
"	let g:thex = 1
"    endif
"function! ToggleHex()
"    if g:thex == 0
"	set display=uhex
"	let g:thex = 1
"    elseif g:thex == 1
"	set display=lastline
"	let g:thex = 2
"   else
"	set display=
"	let g:thex = 0
"    endif
"endfunction
"nmap <C-F7> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>P`]
"vmap <M-x> :! xclip -i -sel clip<CR>p`[
""nmap <M-F7> mz:-1r !xclip -o -sel clip<CR>`z
"nmap <C-F7> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
"imap <F7> :call setreg("\"",system("xclip -o -selection clipboard"))<CR><C-O>p
"imap <C-F7> <C-O>mz:-1r !xclip -o -sel clip<CR>
"imap <C-F7> <C-O>mz:-1r !xclip -o -sel clip<CR><C-O>:`z
"vmap <F6> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
"vmap <C-F6> "+x
"vmap <M-F6> "+y
"vmap <C-S-c> :! xclip -i -sel clip<CR>p`[
"vmap <M-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
"nmap <C-S-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p`[
"nmap <M-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p`]
"nmap <F7> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p`[
"nmap <C-F7> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p`]
"vmap <M-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
"vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
"vmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
"vmap <F6> :!xclip -f -sel clip<CR>
"vmap <F6> :!xclip -i -sel clip<CR>
"nmap <F6> :w !xsel -ib<CR>
"nmap <F7> :!xclip -o -sel clip<CR>
"nmap <F7> :r !xclip -o<CR>
":if did_filetype()
":  finish
":endif
":if getline(1) =~ '^#!.*[/\\]sh\>'
":  setf xyz
":endif



