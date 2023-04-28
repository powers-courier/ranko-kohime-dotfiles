" ========================= Setup Plug plugin manager =========================
call plug#begin('~/.config/nvim/plugged')

    " Monokai Pro Color Scheme (NeoVim)
Plug 'loctvl842/monokai-pro.nvim'

    " Noodle Timer (Gonna find a better solution for this)
"Plug 'yukiomoto/noodle.vim'

    " Airline Status Bar & Themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

    " Animated Indentations
Plug 'huy-hng/anyline.nvim'
    " ...and it's dependency, nvim-treesitter
Plug 'nvim-treesitter/nvim-treesitter'

    " Git Wrapper
Plug 'tpope/vim-fugitive'

    " Dev Icons
Plug 'ryanoasis/vim-devicons'

    " Markdown
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
        " Shortcut keys for vim-markdown:
            " zr: reduces fold level throughout the buffer
            " zR: opens all folds
            " zm: increases fold level throughout the buffer
            " zM: folds everything all the way
            " za: open a fold your cursor is on
            " zA: open a fold your cursor is on recursively
            " zc: close a fold your cursor is on
            " zC: close a fold your cursor is on recursively

    " Python
      " Code formatting
Plug 'psf/black'

    " Teach yourself the right way
      " Disable arrow keys when overused
Plug 'takac/vim-hardtime'

    " Code snippet suggestions
"Plug 'sirver/ultisnips'
"Plug 'phenomenes/ansible-snippets'

    " Pairing for Quotations, brackets, etc...
Plug 'tmsvg/pear-tree'

    " Requires Node.js, 
Plug 'github/copilot.vim'

    " Emacs Org Mode for Neovim
Plug 'jceb/vim-orgmode'
    " ...and it's dependency, vim-speeddating
Plug 'tpope/vim-speeddating'


" All of your Plugins must be added before the following line
call plug#end()


" ============================== Plugin settings ==============================
  " Airline
    " Smarter tab line
    " Automatically displays all buffers when there's only one tab open.
let g:airline#extensions#tabline#enabled = 1
    " Status bar on top
let g:airline_statusline_ontop = 1
    " Use Devicons
let g:airline_powerline_fonts = 1
    " Set Airline theme
let g:airline_theme='google_dark'

    " Enable Hardtime by default
let g:hardtime_default_on = 0

    " Enable smart pairing with pear-tree
    " Smart pairs are disabled by default:
let g:pear_tree_smart_openers = 0
let g:pear_tree_smart_closers = 0
let g:pear_tree_smart_backspace = 0


" ============================== General Config ===============================
    " Change color scheme
set background=dark
colorscheme vim-monokai-tasty

    " Let's fix gvim for good
if has("gui_running")
    :gui
    set guifont=Source\ Code\ Pro\ Regular\ 12
endif


    " File-type highlighting and configuration.
    " Run :filetype (without args) to see what you may have
    " to turn on yourself, or just set them all to be sure.
filetype plugin indent on
    " Enable syntax highlighting
syntax on

    "Toggle whether the pasting includes or excludes indents
set pastetoggle=<F2>

    " Disable showmode, as it is superfluous with vim-airline installed
set noshowmode

    " Needed for vim-devicons
set encoding=UTF-8

    " TABS TABS TABS
set expandtab     " Replace tabs with spaces
set softtabstop=2 " Tabs output to spaces
set shiftwidth=2  " Affects indenting
set autoindent    " Automatically indent newlines 
"set smartindent   " Do that ^^ smartly
set smarttab      " Because Dumb tabs would be... Dumb!

    " Shows line numbers on the left, relative to cursor position.
set number relativenumber
    " But don't show the bottom *ruler*
    " (Because it's NOT A REAL FUCKING RULER BRAD!)
set noruler

    " Highlight the cursor, so we know where it bloody is.
set cursorline
set cursorcolumn
    " Also highlight columns 80 and 120, for size visibility
set colorcolumn=80,120
highlight ColorColumn ctermbg=red guibg=red

    " Allow backspace in insert mode
set backspace=indent,eol,start
    " Test Backspace (?)
"set backspace=^?

    " Store lots of :cmdline history
set history=1000

    " Show incomplete cmds down the bottom
set showcmd

    " Reload files changed outside vim
set autoread

    " Disable that stupid fucking Visual mouse mode
set mouse-=a

    " Since we have airline-vim, we don't need the built-in
set statusline=0

    " Move viewport with cursor plus offset
set scrolloff=3

    " Make a backup before writing file
set backup

    " Enable spellchecking
set spell
set spelllang=en

    " Split behavior
set splitbelow
set splitright

    " Highlight search terms...
set hlsearch
    " ...dynamically as they are typed.
set incsearch
    " Ignore case during /-style searches, plus VVV
set ignorecase
" Case-sensitive searches only if capital letter in search text
set smartcase

    " Don't ask to save when switching buffers
set hidden

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.png,.jpg

" ================================ Keymappings ================================
    " Disable Ex mode keys.
    " https://vi.stackexchange.com/questions/457/does-ex-mode-have-any-practical-use
map q: <Nop>
nnoremap Q <nop>
    " See usage of Q below in Buffer handling

    " You can be more specific about when you want mappings to apply by using
    " nmap, vmap, and imap. These tell Vim to only use the mapping in normal,
    " visual, or insert mode respectively.

" Use the <Spacebar> as leader
nnoremap <SPACE> <Nop>
vnoremap <SPACE> <Nop>
let mapleader = " "

    " Delete a line
nnoremap \ dd

    " *Normal* keybindings for Cut/Copy/Paste on desktop
vnoremap <leader>x "+d
vnoremap <leader>c "+y
    " Visual for Cut/Copy, Insert/Normal for pasting
inoremap <leader>v <esc>"+pa
nnoremap <leader>v <C-v>
    " And saving, while we're at it
nnoremap <C-s> :w<cr>
nnoremap <leader>s :w<cr>
    " Why not open a file too?
nnoremap <leader>e :e<space>

    " Upper CASE WORD
inoremap <C-u> <ESC>vBUea
nnoremap <C-u> <ESC>vBUe

    " Quote word
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

    " Quote selected
vnoremap <leader>" <esc>`<i"<esc>`>la"<esc>
vnoremap <leader>' <esc>`<i'<esc>`>la'<esc>

" Buffer handling
    " Close current buffer
nnoremap <leader>w :bd<cr>
    " Next and Previous buffers on Up and Down respectively
nnoremap <C-i> :bn<cr>
nnoremap <C-u> :bp<cr>
nnoremap <leader>b :buffers<cr>:buffer<space>

" Map jk as <esc> in Insert mode
inoremap jk <esc>

" Fancy auto-indent and close bracket creation
  " Disabled due to pear-tree plugin
"inoremap {<cr> {<cr><cr>}<esc>kI<tab>
"inoremap [<cr> [<cr>]<c-o>0<tab>
"inoremap (<cr> (<cr>)<c-o>0<tab>

" Navigate splits using Ctrl+h/j/k/l
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" =============================== Abbreviations ===============================
iabbrev ssig --<cr>Ranko Kohime<cr>ranko.kohime@runbox.com

" ===============  Github Copilot (https://copilot.github.com/) ===============

" From https://github.com/community/community/discussions/12426#discussioncomment-3102062
" Functions to accept partial suggestions, and keymaps to use them

function! SuggestOneCharacter()
    let suggestion = copilot#Accept("")
    let bar = copilot#TextQueuedForInsertion()
    return bar[0]
endfunction

function! SuggestOneWord()
    let suggestion = copilot#Accept("")
    let bar = copilot#TextQueuedForInsertion()
    return split(bar, '[ .]\zs')[0]
endfunction

" Will enable later, haven't decided on keymaps yet
inoremap <script><expr> <C-l> SuggestOneWord()
"inoremap <script><expr> <C-k> SuggestOneCharacter()
