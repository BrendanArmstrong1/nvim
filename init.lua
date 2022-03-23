vim.opt.expandtab = true
vim.opt.cursorline = false
vim.opt.laststatus = 3
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.nu = true
vim.opt.rnu = true
vim.g.mapleader = " "

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'sainnhe/sonokai'

  use 'justinmk/vim-dirvish'
  use 'roginfarrer/vim-dirvish-dovish'
  use 'kristijanhusak/vim-dirvish-git'
  use 'stsewd/fzf-checkout.vim'
  use 'machakann/vim-highlightedyank'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'rhysd/git-messenger.vim'
  use 'airblade/vim-gitgutter'
  use 'junegunn/gv.vim'
  use 'haya14busa/vim-asterisk'
  use 'haya14busa/is.vim'
  use 'justinmk/vim-sneak'
  use 'dyng/ctrlsf.vim'
  use 'mg979/vim-visual-multi'
  use 'tpope/vim-endwise'
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-rsi'


  use 'sheerun/vim-polyglot'
  use 'tpope/vim-repeat'
  use 'michaeljsmith/vim-indent-object'
  use 'tpope/vim-commentary'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-scriptease'
  use 'AndrewRadev/splitjoin.vim'
  use 'tpope/vim-surround'
  use {'andymass/vim-matchup', event = 'VimEnter'}
  use {
    'vimwiki/vimwiki',
    config = function()
      vim.g.vimwiki_list = {
        {
          path = '~/.config/nvim/wiki/',
          syntax = 'markdown',
          ext = '.md',
        }
      }
      vim.g.vimwiki_ext2syntax = {
        ['.md'] = 'markdown',
        ['.markdown'] = 'markdown',
        ['.mdown'] = 'markdown',
      }
    end
  }

  
end)

vim.g.sonokai_enable_italic = 1
vim.g.sonokai_transparent_background = 1
vim.g.sonokai_disable_italic_comment = 1
vim.g.surround_no_mappings = 1
vim.g.highlightedyank_highlight_duration = 400
vim.cmd [[
  syntax enable
  colorscheme sonokai
]]


local map = vim.keymap.set
map("n", "<C-z>", "<NOP>", {})
map("i", "<C-z>", "<NOP>", {})
map("n", "<space>", "<NOP>", {})
map("n", "<c-z><c-s>", "<CMD>w!<CR>", {})
map("i", "<c-z><c-s>", "<CMD>w!<CR>", {})

map("n", "<c-l>", "<c-w>l", {})
map("n", "<c-h>", "<c-w>h", {})
map("n", "<c-j>", "<c-w>j", {})
map("n", "<c-k>", "<c-w>k", {})
map("n", "<c-w>h", "<c-w>H", {})
map("n", "<c-w>l", "<c-w>L", {})
map("n", "<c-w>j", "<c-w>J", {})
map("n", "<c-w>k", "<c-w>K", {})

map("n", "<c-w><c-q>", "ZQ", {})
map("n", "<c-w><c-w>", "ZZ", {})
map("n", "<c-w><c-w>", "<CMD>vs <cfile><CR>", {})
map("i", "<c-w><c-q>", "<ESC>ZQ", {})
map("i", "<c-w><c-w>", "<ESC>ZZ", {})

map("x", "<", "<gv", {})
map("x", ">", ">gv", {})

map("t", "<c-z>", "<c-\\><c-n>", {})
map("n", "<c-w><c-t>", "<CMD>vs term://zsh<CR>", {})


map("n", "[&", "<Plug>(GitGutterPrevHunk)", {silent= true})
map("n", "]&", "<Plug>(GitGutterNextHunk)", {silent= true})
map("n", "[`", "<CMD>cprevious<CR>", { silent= true })
map("n", "]`", "<CMD>cnext<CR>", {silent= true})
map("n", "[\\", "<CMD>bprevious<CR>", {silent= true})
map("n", "]\\", "<CMD>bnext<CR>", {silent= true})
map("n", "[_", "<CMD>previous<CR>", {silent= true})
map("n", "]_", "<CMD>next<CR>", {silent= true})

map("x", "z", "<Plug>VSurround")
map("n", "yzz", "<Plug>Yssurround")
map("n", "yz",  "<Plug>Ysurround")
map("n", "dz",  "<Plug>Dsurround")
map("n", "cz",  "<Plug>Csurround")


--map("n", "<C-e>", repeat("<C-e>", 5), {noremap = true, expr = true})
--map("n", "<C-y>", repeat("<C-y>", 5), {noremap = true, expr = true})

vim.cmd([[
set termguicolors
highlight MyWhiteTrails ctermbg=red guibg=red
augroup standard_group
    autocmd!

    autocmd InsertEnter * match MyWhiteTrails /\s\+\%#\@<!$/
    autocmd InsertLeave * match MyWhiteTrails /\s\+$/
    autocmd ColorScheme *  highlight SpellBad
        \ cterm=Underline ctermfg=red ctermbg=NONE
    autocmd ColorScheme *  highlight SpellCap
        \ cterm=Underline,italic ctermfg=Blue ctermbg=NONE
    autocmd ColorScheme *  highlight SpellLocal
        \ cterm=Underline ctermfg=Yellow ctermbg=NONE
    autocmd ColorScheme *  highlight SpellRare
        \ cterm=Underline ctermfg=Magenta ctermbg=NONE
    autocmd ColorScheme * highlight Normal guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight LineNr guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight SignColumn guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight EndOfBuffer guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight Todo guibg=NONE guifg=#33cc33
    autocmd ColorScheme * highlight Terminal guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight Comment guifg=#5C6370 ctermfg=59

    "Inc-Search stuff
    autocmd ColorScheme * highlight Search guibg=#3d3d5c guifg=#c2c2d6

    " Sneak Highlighting
    autocmd ColorSchEme * highlight Sneak guibg=#800033 guifg=#ff80b3
    autocmd ColorScheme * highlight SneakScope guibg=#3d3d5c guifg=#c2c2d6
    autocmd ColorScheme * highlight SneakLabel guibg=#800033 guifg=#ff80b3
    autocmd ColorScheme * highlight SneakLabelMask guibg=#800033 guifg=#ff80b3

    "Ensure files open the way that i want
    autocmd BufRead,BufNewFile *.tex set filetype=tex
    autocmd BufRead,BufNewFile *.json setfiletype json
    autocmd BufRead,BufNewFile *.json.* setfiletype json
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    autocmd BufNewFile,BufReadPost *.dockerfile set filetype=Dockerfile
    autocmd BufNewFile,BufReadPost *.jenkinsfile set filetype=groovy

    " Open Ggrep results in a quickfix window (Suggested by tpope)
    autocmd QuickFixCmdPost *grep* cwindow

    "https://github.com/junegunn/fzf.vim/issues/503
    autocmd TermOpen * setlocal nonumber norelativenumber

    " Resize splits in all tabs upon window resize
    " https://vi.stackexchange.com/a/206
    autocmd VimResized * tabdo wincmd =

    " Reload file on focus/enter. This seems to break in Windows.
    " https://stackoverflow.com/a/20418591
    if !has("win32")
        autocmd FocusGained,BufEnter * :silent! !
    endif
augroup END
]])

-- Dirvish
vim.cmd([[
let g:dirvish_relative_paths = 0
let g:dirvish_mode = ':sort ,^.*[\/],'
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

let g:dirvish_git_indicators = {
 \ 'Modified'  : '📝',
 \ 'Staged'    : '✚',
 \ 'Untracked' : '🧲',
 \ 'Renamed'   : '👅',
 \ 'Unmerged'  : '═',
 \ 'Ignored'   : '❌',
 \ 'Unknown'   : '?'
 \ }

augroup dirvish_config
  autocmd!

    " Map `gh` to hide dot-prefixed files.  Press `R` to "toggle" (reload).
    autocmd FileType dirvish nnoremap <silent><buffer> gh :silent keeppatterns g@\v/\.[^\/]+/?$@d _<cr>:setl cole=3<cr>

    autocmd FileType dirvish nnoremap <silent><buffer> t ddO<Esc>:let @"=substitute(@", '\n', '', 'g')<CR>
          \ :r ! find "<C-R>"" -maxdepth 1 -print0 \| xargs -0 ls -Fd<CR>
          \ :silent! keeppatterns %s/\/\//\//g<CR>
          \ :silent! keeppatterns %s/[^a-zA-Z0-9\/]$//g<CR>
          \ :silent! keeppatterns g/^$/d<CR>
          \ :noh<CR>

    autocmd FileType dirvish nmap <silent><buffer> <C-n> <Plug>(dirvish_git_next_file)
    autocmd FileType dirvish nmap <silent><buffer> <C-p> <Plug>(dirvish_git_prev_file)

augroup END
]])

