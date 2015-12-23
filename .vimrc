" Colors
    syntax enable
    "set background=dark
    "colorscheme material-theme
    colorscheme molokai
    "colorscheme molokai_new
    "colorscheme blackdust

" Basic config
    filetype plugin indent on " Load filetype-specific indent files
    set tabstop=4  " Number of visual spaces per tab
    set softtabstop=4 " Number of spaces in tab
    set shiftwidth=4
    set expandtab " tabs are spaces
    
    set number " Show line numbers
    set showcmd " Show command in bottom bar
    set cursorline " Highlight current line

    set wildmenu " Visual autocomplete 
    set wildignore=*.o,*~,*.pyc

    set lazyredraw " Only redraw when needed
    set showmatch " Highlight matching ( and { 

    set ignorecase " No case Search
    set smartcase " Smart Search
    set incsearch " Search as typing in text
    set hlsearch " Highlight

    " No annoying things
    set noerrorbells
    set novisualbell
    set t_vb=
    set tm=500
    map q: :q

    " Move by visual line
    nnoremap j gj
    nnoremap k gk

    " Center me!
    nnoremap <space> zz

    " Quit on jk
    imap jk <Esc>

" Tabs and vsp and splits
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l
    set splitbelow
    set splitright
    set title
    set scrolloff=3

" Leader Shortcuts
    let mapleader=","  " , instead of  \

    " Make for files
    nmap <silent> <leader>mp2 <Esc>:w<CR>:!clear;python2 %<CR>
    nmap <silent> <leader>mp3 <Esc>:w<CR>:!clear;python3 %<CR>
    nmap <silent> <leader>mc <Esc>:w<CR>:!clear;gcc % && ./a.out<CR>
    nmap <silent> <leader>mm <Esc>:w<CR>:!make && ./a.out<CR>
    nmap <silent> <leader>mo <Esc>:w<CR>:!octave --no-gui %<CR>

	" Save session
	nmap <leader>s <Esc>:mksession!<CR>:wqa<CR>
	nmap <leader>w <Esc>:w<CR>
	nmap <leader>q <Esc>:q<CR>

    " Resize nicely
    nmap <leader>= <C-w>=
    nmap <leader>> <C-w>>
    nmap <leader>< <C-w><

    " Clear search highlight
    nmap <silent> <leader><space> <Esc>:nohlsearch<CR>

    " Copy and Paste from + register
    nmap <silent> <leader>p <Esc>:set paste<CR>"+p<CR>:set nopaste<CR>
    nmap <silent> <leader>P <Esc>:set paste<CR>"+P<CR>:set nopaste<CR>
    vmap <silent> <leader>p <Esc>:set paste<CR>"+p<CR>:set nopaste<CR>
    vmap <silent> <leader>P <Esc>:set paste<CR>"+P<CR>:set nopaste<CR>
    vmap <leader>y "+y<CR>

    " Toggle numbering
    nnoremap <leader>n <Esc>:call ToggleNumber()<CR>

    " Force redraw
    nnoremap <silent> <leader><space><space> <Esc>:redraw!<CR>

    " Hex editor
    nnoremap <leader>h <Esc>Hexmode<CR>

" Folds
    set foldenable
    set foldlevelstart=10
    set foldnestmax=10
    set foldmethod=indent
    nnoremap <leader>f za

" Plugins
    runtime bundle/vim-surround/plugin/surround.vim

" Functions
    " Switch between number and relative number
    function! ToggleNumber()
        if(&relativenumber == 1)
            set norelativenumber
            set number
        else
            set relativenumber
        endif
    endfunc


    " Set up command to toggle Hex
    command -bar Hexmode call ToggleHex()

    " helper function to toggle hex mode
    function ToggleHex()
        " hex mode should be considered a read-only operation
        " save values for modified and read-only for restoration later,
        " and clear the read-only flag for now
        let l:modified=&mod
        let l:oldreadonly=&readonly
        let &readonly=0
        let l:oldmodifiable=&modifiable
        let &modifiable=1
        if !exists("b:editHex") || !b:editHex
            " save old options
            let b:oldft=&ft
            let b:oldbin=&bin
            " set new options
            setlocal binary " make sure it overrides any textwidth, etc.
            silent :e " this will reload the file without trickeries 
            "(DOS line endings will be shown entirely )
            let &ft="xxd"
            " set status
            let b:editHex=1
            " switch to hex editor
            %!xxd
        else
            " restore old options
            let &ft=b:oldft
            if !b:oldbin
                setlocal nobinary
            endif
            " set status
            let b:editHex=0
            " return to normal editing
            %!xxd -r
        endif
        " restore values for modified and read only state
        let &mod=l:modified
        let &readonly=l:oldreadonly
        let &modifiable=l:oldmodifiable
    endfunction

    " autocmds to automatically enter hex mode and handle file writes properly
    if has("autocmd")
      " vim -b : edit binary using xxd-format!
      augroup Binary
        au!

        " set binary option for all binary files before reading them
        au BufReadPre *.bin,*.hex setlocal binary

        " if on a fresh read the buffer variable is already set, it's wrong
        au BufReadPost *
              \ if exists('b:editHex') && b:editHex |
              \   let b:editHex = 0 |
              \ endif

        " convert to hex on startup for binary files automatically
        au BufReadPost *
              \ if &binary | Hexmode | endif

        " When the text is freed, the next time the buffer is made active it will
        " re-read the text and thus not match the correct mode, we will need to
        " convert it again if the buffer is again loaded.
        au BufUnload *
              \ if getbufvar(expand("<afile>"), 'editHex') == 1 |
              \   call setbufvar(expand("<afile>"), 'editHex', 0) |
              \ endif

        " before writing a file when editing in hex mode, convert back to non-hex
        au BufWritePre *
              \ if exists("b:editHex") && b:editHex && &binary |
              \  let oldro=&ro | let &ro=0 |
              \  let oldma=&ma | let &ma=1 |
              \  silent exe "%!xxd -r" |
              \  let &ma=oldma | let &ro=oldro |
              \  unlet oldma | unlet oldro |
              \ endif

        " after writing a binary file, if we're in hex mode, restore hex mode
        au BufWritePost *
              \ if exists("b:editHex") && b:editHex && &binary |
              \  let oldro=&ro | let &ro=0 |
              \  let oldma=&ma | let &ma=1 |
              \  silent exe "%!xxd" |
              \  exe "set nomod" |
              \  let &ma=oldma | let &ro=oldro |
              \  unlet oldma | unlet oldro |
              \ endif
      augroup END
    endif


" Fix for tmux
set term=screen-256color
