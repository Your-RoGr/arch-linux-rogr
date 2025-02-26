
set mouse=a " Включить поддержку мыши
set encoding=utf-8 " Установить кодировку в UTF-8
set number " Включить нумерацию строк
set cursorline " Подсвечивать строку с курсором
set noswapfile " Отключить создание swap-файлов
set scrolloff=7 " Установить отступ для прокрутки (7 строк)
set clipboard+=unnamedplus " Копировать в системный буфер

" Настройки для табуляции
set smartindent " Включить умный отступ
set tabstop=4 " Установить ширину табуляции в 4 пробела
set softtabstop=4 " Установить мягкий размер табуляции в 4 пробела
set shiftwidth=4 " Установить отступ на 4 пробела при автоотступах
set expandtab " Использовать пробелы вместо табуляций
set autoindent " Включить автоотступ
set fileformat=unix " Установить формат файлов как Unix (LF)
filetype indent on " Включить загрузку файлов с настройками отступов для типа файла

" Открытие горизонтального сплита ниже и справа
set splitbelow " Разделение окна будет открываться снизу
set splitright " Разделение окна будет открываться справа

set colorcolumn=88 " Установить вертикальную линию на 88-ом столбце

set relativenumber " Относительная нуммерация строк

inoremap jk <esc> " Преобразовать комбинацию клавиш 'jk' в 'esc' в режиме вставки

call plug#begin('~/.vim/plugged') " Инициализация плагинов в каталоге ~/.vim/plugged

Plug 'neovim/nvim-lspconfig' " Плагин для настройки LSP в Neovim
Plug 'hrsh7th/nvim-cmp' " Плагин для автодополнения
Plug 'hrsh7th/cmp-nvim-lsp' " Плагин для автодополнения с LSP
Plug 'saadparwaiz1/cmp_luasnip' " Плагин для использования snippets в автодополнении
Plug 'L3MON4D3/LuaSnip' " Плагин для LuaSnip (сниппеты)

" Плагины для go
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua'

" Темы оформления
Plug 'morhetz/gruvbox' " Цветовая схема Gruvbox
Plug 'joshdick/onedark.vim' " Цветовая схема onedark
Plug 'mhartington/oceanic-next' " Цветовая схема OceanicNext
Plug 'ayu-theme/ayu-vim' " Цветовая схема Ayu
Plug 'daltonmenezes/aura-theme', { 'rtp': 'packages/neovim' } " aura-theme
Plug 'rebelot/kanagawa.nvim' " Цветовая схема kanagawa
Plug 'folke/tokyonight.nvim' " Цветовая схема tokyonight

Plug 'Pocco81/auto-save.nvim' " Плагин для авто-сохранения
Plug 'justinmk/vim-sneak' " Плагин для улучшенного поиска

" JS/JSX/TS
Plug 'pangloss/vim-javascript' " Плагин для JavaScript
Plug 'leafgarland/typescript-vim' " Плагин для TypeScript
Plug 'peitalin/vim-jsx-typescript' " Плагин для JSX и TypeScript
Plug 'maxmellon/vim-jsx-pretty' " Плагин для красивого отображения JSX

" Плагин для работы с форматированием и линтерами
Plug 'jose-elias-alvarez/null-ls.nvim'

" Утилиты для работы с LSP для TypeScript 
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils' 

" Утилиты для Lua
Plug 'nvim-lua/plenary.nvim' 

" Плагин для автоматического форматирования с Prettier
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'solid-js', 'typescriptreact', 
  \'javascriptreact', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 
  \'vue', 'svelte', 'yaml', 'html'] }

Plug 'bmatcuk/stylelint-lsp' " Плагин для поддержки Stylelint (css)

" Плагин для поиска с Telescope
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }

" Плагин для фаст поиска с fzf
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Удобное плавающее окно терминала
Plug 'voldikss/vim-floaterm'

Plug 'ray-x/lsp_signature.nvim' " Плагин для отображения подсказок с LSP

Plug 'lspcontainers/lspcontainers.nvim' " Плагин для контейнеров LSP

Plug 'nvim-tree/nvim-web-devicons'

Plug 'lewis6991/gitsigns.nvim'

Plug 'NeogitOrg/neogit'
Plug 'sindrets/diffview.nvim'

Plug 'romgrk/barbar.nvim'

call plug#end() " Завершить подключение плагинов

" Привязка Leader-ключа к пробелу
let mapleader = ","

" Настройки проводника Netrw
let g:netrw_banner = 0 " Скрыть баннер над файлами
let g:netrw_liststyle = 3 " Использовать дерево вместо обычного вида
let g:netrw_browse_split = 3 " Разделять окно по вертикали при нажатии Enter на файл

" Автоматическое форматирование файлов с помощью Prettier после сохранения
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

" Отключить окно быстрого исправления для Prettier
let g:prettier#quickfix_enabled = 0

" Включить vim-sneak
let g:sneak#label = 1

" Выбор цветовой схемы
colorscheme kanagawa-wave

if (has('termguicolors')) " Если поддерживаются 24-битные цвета
  set termguicolors " Включить поддержку 24-битных цветов
endif

" Отключить подсветку поиска
nnoremap ,<space> :nohlsearch<CR>

lua require('config')
lua require('config-go')
lua require('gitsigns').setup()
lua require('neogit').setup()

" Удаление буфера при сохранении раскладки окна (не закрывать окно)
" Версия от 2008-11-18 с http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
  finish
endif

let loaded_bclose = 1

if !exists('bclose_multiple')
  let bclose_multiple = 1
endif

" Показать сообщение об ошибке
function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
  if empty(a:buffer)
    let btarget = bufnr('%') " Если не указан буфер, используем текущий
  elseif a:buffer =~ '^\d\+$'
    let btarget = bufnr(str2nr(a:buffer)) " Если передан номер буфера, получаем его номер
  else
    let btarget = bufnr(a:buffer) " Если передано имя буфера, получаем его номер
  endif
  if btarget < 0
    call s:Warn('No matching buffer for '.a:buffer) " Если буфер не найден, выводим предупреждение
    return
  endif
  if empty(a:bang) && getbufvar(btarget, '&modified')
    call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)') " Если буфер изменён, но не сохранён, предупреждаем.
    return
  endif
  " Numbers of windows that view target buffer which we will delete.
  let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget') " Получаем все окна, где отображается целевой буфер
  if !g:bclose_multiple && len(wnums) > 1
    call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")') " Если буфер отображается в нескольких окнах, предупреждаем
    return
  endif
  let wcurrent = winnr() " Запоминаем номер текущего окна
  for w in wnums
    execute w.'wincmd w' " Переключаемся на каждое окно, где отображается этот буфер
    let prevbuf = bufnr('#') " Получаем номер предыдущего буфера
    if prevbuf > 0 && buflisted(prevbuf) && prevbuf != btarget
      buffer # " Если предыдущий буфер существует и не является целевым, переключаемся на него
    else
      bprevious " Иначе, переключаемся на предыдущий буфер
    endif
    if btarget == bufnr('%')
      " Numbers of listed buffers which are not the target to be deleted.
      let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget') " Получаем список буферов, которые не являются целевыми
      " Listed, not target, and not displayed.
      let bhidden = filter(eopy(blisted), 'bufwinnr(v:val) < 0') " Получаем скрытые буферы из списка
      " Take the first buffer, if any (could be more intelligent).
      let bjump = (bhidden + blisted + [-1])[0] " Выбираем первый подходящий буфер для переключения
      if bjump > 0
        execute 'buffer '.bjump " Если такой буфер найден, переключаемся на него
      else
        execute 'enew'.a:bang " Если подходящих буферов нет, открываем новый пустой буфер
      endif
    endif
  endfor
  execute 'bdelete'.a:bang.' '.btarget " Удаляем целевой буфер
  execute wcurrent.'wincmd w' " Возвращаемся в исходное окно
endfunction
command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose(<q-bang>, <q-args>) " Создаём команду Bclose для вызова функции
nnoremap <silent> <Leader>bd :Bclose<CR> " Привязываем команду :Bclose к сочетанию клавиш <Leader>bd

map gn :bn<cr> " Привязываем переключение на следующий буфер к клавише gn
map gp :bp<cr> " Привязываем переключение на предыдущий буфер к клавише gp
map gw :Bclose<cr> " Привязываем команду :Bclose к клавише gw

" Run Python and C files by Ctrl+h
" Для Python: при нажатии Ctrl+h сохраняем файл и запускаем его
autocmd FileType python map <buffer> <C-h> :w<CR>:exec '!python' shellescape(@%, 1)<CR>

" Для Python: при нажатии Ctrl+h в режиме вставки сохраняем и запускаем файл
autocmd FileType python imap <buffer> <C-h> <esc>:w<CR>:exec '!python' shellescape(@%, 1)<CR> 


" Для C: при нажатии Ctrl+h сохраняем файл и компилируем его с помощью gcc
autocmd FileType c map <buffer> <C-h> :w<CR>:exec '!gcc' shellescape(@%, 1) '-o out; ./out'<CR>

" Для C: при нажатии Ctrl+h в режиме вставки сохраняем и компилируем файл
autocmd FileType c imap <buffer> <C-h> <esc>:w<CR>:exec '!gcc' shellescape(@%, 1) '-o out; ./out'<CR>


" Для Go: при нажатии Ctrl+h сохраняем файл и запускаем его
autocmd FileType go map <buffer> <C-h> :w<CR>:exec '!go run' shellescape(@%, 1)<CR>

" Для Go: при нажатии Ctrl+h в режиме вставки сохраняем и запускаем файл
autocmd FileType go imap <buffer> <C-h> <esc>:w<CR>:exec '!go run' shellescape(@%, 1)<CR>


" Для Shell: при нажатии Ctrl+h сохраняем файл и выполняем его с помощью bash
autocmd FileType sh map <buffer> <C-h> :w<CR>:exec '!bash' shellescape(@%, 1)<CR>

" Для Shell: при нажатии Ctrl+h в режиме вставки сохраняем и выполняем файл
autocmd FileType sh imap <buffer> <C-h> <esc>:w<CR>:exec '!bash' shellescape(@%, 1)<CR>


" Для Python устанавливаем цветовую колонку на 88-й символ
autocmd FileType python set colorcolumn=88

tnoremap <Esc> <C-\><C-n> " В терминале переназначаем клавишу Escape для выхода из режима терминала

" Telescope bindings
" Привязываем команду поиска файлов в Telescope к клавише Alt+f
nnoremap <A-f> <cmd>Telescope find_files<cr>

" Привязываем команду поиска по тексту в Telescope к клавише Alt+g
nnoremap <A-g> <cmd>Telescope live_grep<cr>

" Go to next or prev tab by H and L accordingly
nnoremap H gT " Переключаемся на предыдущую вкладку с помощью клавиши H
nnoremap L gt " Переключаемся на следующую вкладку с помощью клавиши L
