source /etc/vimrc

" vimpager options
let vimpager_use_gvim = 1
"let vimpager_passthrough = 0
"let vimpager_disable_x11 = 1
"let vimpager_scrolloff = 5
"let vimpager_disable_ansiesc = 1

" tmux will send xterm-style keys when its xterm-keys option is on
if &term =~ '^screen'
    execute 'set <xUp>=\e[1;*A'
    execute 'set <xDown>=\e[1;*B'
    execute 'set <xRight>=\e[1;*C'
    execute 'set <xLeft>=\e[1;*D'
endif

