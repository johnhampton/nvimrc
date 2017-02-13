if &compatible
  set nocompatible
endif

let g:Fsep='/'
let g:onyxvim_plugin_bundle_dir='~/.cache/vimfiles'
let g:onyxvim_dein_install_dir=join([
      \ g:onyxvim_plugin_bundle_dir,
      \ 'repos',
      \ 'github.com',
      \ 'Shougo',
      \ 'dein.vim'],
      \ g:Fsep)

if filereadable(expand(join([g:onyxvim_dein_install_dir,
      \ 'README.md'],
      \ g:Fsep)))
  let g:onyxvim_dein_installed = 1
else
  if executable('git')
    exec '!git clone https://github.com/Shougo/dein.vim '
          \. g:onyxvim_dein_install_dir
    let g:onyxvim_dein_installed = 1
  else
    echohl WarningMsg
    echom "You need to install git!"
    echohl None
  endif
endif

exec 'set runtimepath+=' . g:onyxvim_dein_install_dir

if dein#load_state(g:onyxvim_plugin_bundle_dir)
  call dein#begin(g:onyxvim_plugin_bundle_dir)

  call dein#add(g:onyxvim_dein_install_dir)
  call dein#add('morhetz/gruvbox')
  call dein#add('pangloss/vim-javascript', { 'on_ft': ['javascript']})
  call dein#add('mxw/vim-jsx', { 'on_ft': ['javascript'] })
  call dein#add('maksimr/vim-jsbeautify', { 'on_ft': ['javascript']})
  call dein#add('leafgarland/typescript-vim', { 'on_ft': ['typescript']})
  call dein#add('kchmck/vim-coffee-script', { 'on_ft': ['coffee']})
  call dein#add('mmalecki/vim-node.js', { 'on_ft': ['javascript']})
  call dein#add('elzr/vim-json', { 'on_ft': ['javascript', 'json']})
  call dein#add('othree/javascript-libraries-syntax.vim', { 'on_ft': ['javascript', 'coffee', 'ls', 'typescript']})
  call dein#add('Valloric/MatchTagAlways', { 'on_ft': ['html, jsx, xml'] })

  call dein#add('christoomey/vim-tmux-navigator', { 'if': '!empty($TMUX)' })
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-surround', { 'depends': 'vim-repeat' })

  call dein#add('hashivim/vim-terraform', { 'on_ft': 'tf' })

  " call dein#add('Shougo/neopairs.vim')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('edkolev/tmuxline.vim', { 'if': '!empty($TMUX)' })
  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')

  " Unite/Denite
  call dein#add('nixprime/cpsm', { 'build': 'PY3=ON ./install.sh' })
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/vimfiler.vim', { 'on_map': {'n': '<Plug>'}, 'depends': 'unite.vim' })
  call dein#add('neomake/neomake')
  call dein#add('benjie/neomake-local-eslint.vim', { 'depends': 'neomake' })

  call dein#add('Shougo/deoplete.nvim')
  call dein#add('SirVer/ultisnips')
  call dein#add('ervandew/supertab')

  call dein#add('honza/vim-snippets')
  call dein#add('ternjs/tern_for_vim', { 'build': 'npm install', 'on_ft': ['javascript'] })
  call dein#add('carlitux/deoplete-ternjs', { 'on_ft': ['javascript'] })
  call dein#add('othree/jspc.vim', { 'on_ft': ['javascript'] })

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  augroup OnyxVimCheckInstall
    au!
    au VimEnter * call dein#install()
  augroup END
endif

filetype plugin indent on
syntax enable
let mapleader="\<Space>"

colorscheme gruvbox
set background=dark
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set expandtab
set shiftwidth=2
set softtabstop=2

autocmd BufEnter,WinEnter,InsertLeave * set cursorline
autocmd BufLeave,WinLeave,InsertEnter * set nocursorline

set relativenumber
set number          " Display line numbers

let g:airline_powerline_fonts = 1
let g:AutoPairsFlyMode = 1
let g:mta_filetypes = {
      \ 'javascript.jsx': 1,
      \ 'html' : 1,
      \ 'xhtml' : 1,
      \ 'xml' : 1,
      \ 'jinja' : 1,
      \ }
let g:vimfiler_as_default_explorer = 1
set noshowmode " No need to show the mode as airline gives us one

let g:deoplete#enable_at_startup = 1

let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_json_enabled_makers = ['jsonlint']
"let g:neomake_verbose = 0
autocmd! BufWritePost * Neomake
autocmd! VimLeave * let g:neomake_verbose = 0
"autocmd! BufWritePost * let g:neomake_verbose = 1
"
" mapping
nmap <silent> <F3> :VimFilerExplore<CR>
nnoremap <silent> <F8> :Neomake<cr>

let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]

let g:deoplete#file#enable_buffer_path=1

call denite#custom#var('file_rec', 'command',
      \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#source(
      \ 'file_rec', 'matchers', ['matcher_cpsm'])
call denite#custom#source(
      \ 'file_rec', 'sorters', ['sorter_sublime'])
nnoremap <leader>t :<C-u>Denite file_rec<cr>
nnoremap <leader>e :<C-u>Denite buffer<cr>
nnoremap <leader>g :<C-u>Denite grep<cr>
