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
"inoremap <script><expr> <C-l> SuggestOneWord()
"inoremap <script><expr> <C-k> SuggestOneCharacter()
