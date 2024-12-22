let autoload_path = '/nvim/site/autoload/plug.vim'
let plug_path = exists('$XDG_DATA_HOME') ? $XDG_DATA_HOME . autoload_path : $HOME . '/.local/share' . autoload_path
if empty(glob(plug_path))
  silent execute '!curl -fLo '.plug_path.' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let mapleader=' '

call plug#begin()
Plug 'scrooloose/nerdtree'
  let NERDTreeMinimalUI = 1
  let NERDTreeDirArrows = 1
  let g:NERDTreeDirArrowExpandable = '+'
  let g:NERDTreeDirArrowCollapsible = '-'

  nnoremap <c-n> :NERDTreeToggle<CR>

Plug 'scrooloose/nerdcommenter'
  let g:NERDCreateDefaultMappings = 0
  let g:NERDSpaceDelims = 1
  let g:NERDCompactSexyComs = 1
  let g:NERDDefaultAlign = 'left'
  let g:NERDAltDelims_java = 1
  let g:NERDCommentEmptyLines = 1
  let g:NERDTrimTrailingWhitespace = 1
  let g:NERDToggleCheckAllLines = 1
  let g:uname = substitute(system('uname -s'), '\n', '', '')
  if g:uname == 'Linux'
    nnoremap <silent> <c-_> <Plug>NERDCommenterToggle<CR>
    vnoremap <silent> <c-_> <Plug>NERDCommenterToggle<CR>gv
  else
    nnoremap <silent> <c-/> <Plug>NERDCommenterToggle<CR>
    vnoremap <silent> <c-/> <Plug>NERDCommenterToggle<CR>gv
  endif

Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " supported extensions: https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions
  let g:coc_global_extensions= ['coc-clangd', 'coc-go', 'coc-sh', 'coc-pyright', 'coc-rust-analyzer']

  autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
  inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()
  inoremap <silent><expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <leader>rn <Plug>(coc-rename)

  command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

Plug 'dense-analysis/ale'
  let g:ale_set_highlights = 1
  let g:ale_set_quickfix = 1
  let g:ale_echo_msg_error_str = 'E'
  let g:ale_echo_msg_warning_str = 'W'
  let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
  let g:ale_lint_on_enter = 1

  nmap sp <Plug>(ale_previous_wrap)
  nmap sn <Plug>(ale_next_wrap)

Plug 'easymotion/vim-easymotion'
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_smartcase = 1

  map <leader>j <Plug>(easymotion-j)
  map <leader>k <Plug>(easymotion-k)
  nmap ss <Plug>(easymotion-s2)

Plug 'junegunn/vim-easy-align'
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'shaunsingh/nord.nvim'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'thirtythreeforty/lessspace.vim'
Plug 'editorconfig/editorconfig-vim'
call plug#end()

colorscheme nord

set nu
set encoding=utf-8
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes

autocmd BufWrite,BufRead *.go,*.c,*.cpp,Makefile setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd BufWrite,BufRead *.yml,*.yaml,*.json setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

nnoremap H <C-w>h
nnoremap J <C-w>j
nnoremap K <C-w>k
nnoremap L <C-w>l

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2> /dev/null | tr -d '\n'")
endfunction
function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?' br:'.l:branchname.' ':''
endfunction
set statusline=
set statusline+=\ %{mode()}
" set statusline+=%#PmenuSel#
set statusline+=\ %{StatuslineGit()}
" set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %l/%L:%c
