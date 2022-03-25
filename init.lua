vim.opt.expandtab = true
vim.opt.cursorline = false
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.signcolumn = 'yes'
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak = "∵∴∵"
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.shadafile = "/home/brendan/.config/nvim/viminfo"
vim.opt.shada = "<800,'100,/50,:100,h"
vim.opt.nu = true -- line numbers
vim.opt.rnu = true -- relative numbering
vim.opt.clipboard = 'unnamed' -- clipboard stuff
vim.opt.clipboard:append('unnamedplus')
vim.g.mapleader = " "
vim.g.completeopt = "menuone,noselect,noinsert,popup"


require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'sainnhe/sonokai'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use 'junegunn/fzf.vim'
  use 'stsewd/fzf-checkout.vim'

  use 'justinmk/vim-dirvish'
  use 'roginfarrer/vim-dirvish-dovish'

  use 'machakann/vim-highlightedyank'

  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'rhysd/git-messenger.vim'
  use 'airblade/vim-gitgutter'

  use 'williamboman/nvim-lsp-installer'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp_extensions.nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'quangnguyen30192/cmp-nvim-ultisnips'
  use  'SirVer/ultisnips'

  use 'nvim-treesitter/nvim-treesitter'

  use 'haya14busa/is.vim'

  use 'justinmk/vim-sneak'
  use 'michaeljsmith/vim-indent-object'
  use 'tpope/vim-commentary'
  use {'andymass/vim-matchup', event = 'VimEnter'}
  use 'AndrewRadev/splitjoin.vim'
  use 'tpope/vim-surround'

  use 'dyng/ctrlsf.vim'
  use 'mg979/vim-visual-multi'
  use 'tpope/vim-rsi'

  use 'tpope/vim-repeat'
  use 'tpope/vim-unimpaired'
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

local configs = require'nvim-treesitter.configs'
configs.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  }
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'sonokai',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
vim.g.UltiSnipsEditSplit="vertical"
vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
vim.g.UltiSnipsRemoveSelectModeMappings = 0
vim.g.UltiSnipsJumpForwardTrigger = '<c-f>'
vim.g.UltiSnipsJumpBackwardTrigger = '<c-b>'
vim.g.sonokai_enable_italic = 1
vim.g.sonokai_transparent_background = 1
vim.g.sonokai_disable_italic_comment = 1
vim.g.surround_no_mappings = 1
vim.g.highlightedyank_highlight_duration = 400
vim.g.background = 'dark'
vim.cmd [[
  let g:UltiSnipsSnippetDirectories=[$HOME."/.config/nvim/UltiSnips"]
]]

local map = vim.keymap.set
local nore = {noremap = true}
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
map("n", "<c-w><c-f>", "<CMD>vs <cfile><CR>", {})
map("i", "<c-w><c-q>", "<ESC>ZQ", {})
map("i", "<c-w><c-w>", "<ESC>ZZ", {})

map("i", "<c-x><c-k>", "<c-x><c-k>", nore)

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

-- map("c", "<c-j>", "<c-n>")
-- map("c", "<c-k>", "<c-p>")
map("c", "<c-l>", "<down>")
map("c", "<c-h>", "<up>")

map('n', '<leader>gg', '<CMD>Git<CR>', nore)
map('n', '<leader>gl', '<CMD>Git log<CR>', nore)
map('n', '<leader>gb', '<CMD>Git blame<CR>', nore)
map('n', '<leader>gd', '<CMD>Gdiffsplit<CR>', nore)
map('n', '<leader>gD', '<CMD>Gdiffsplit!<CR>', nore)
map('n', '<leader>gP', '<CMD>Git push<CR>', nore)
map('n', '<leader>gul', '<CMD>diffget //3<CR>', nore)
map('n', '<leader>guy', '<CMD>diffget //2<CR>', nore)
map('n', '<leader>gs', '<Plug>(GitGutterStageHunk)', nore)
map('n', '<leader>gS', '<Plug>(GitGutterUndoHunk)', nore)
map('n', '<leader>gr', '<CMD>GBrowse<CR>', nore)
map('v', '<leader>gr',  ':GBrowse<CR>', nore)
map('v', '<leader>gR',  ':GBrowse!<CR>', nore)
map('n', 'gf', '<CMD>edit <cfile><CR>', nore)
map('n', 'gp', '`[v`]', nore)

map({"n", "v"}, "<C-e>", "repeat('<C-e>', 5)", {noremap = true, expr = true})
map({"n", "v"}, "<C-y>", "repeat('<C-y>', 5)", {noremap = true, expr = true})

local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 'c'}),
      ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 'c'}),
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-y>'] = cmp.mapping(cmp.mapping.confirm({ select = true }), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' }, -- For ultisnips users.
    }, {
      { name = 'buffer' },
    }),
  experimental = {
    native_menu = false,
    ghost_text = true,
  }
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gl', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>F', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'clangd', 'vimls'}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

vim.cmd([[autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }
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
syntax enable
colorscheme sonokai
set laststatus=3
]])

-- CTRLSF
vim.cmd([[
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-s>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-s>'           " replace visual C-n
let g:VM_show_warnings = 0

" Prifix r
let g:ctrlsf_backend = 'rg'
let g:ctrlsf_extra_backend_args = {
    \ 'rg': '--no-ignore --glob "!.git"'
    \ }
let g:ctrlsf_position = 'left_local'
xmap <leader>r <Plug>CtrlSFVwordExec
nmap <leader>rr <Plug>CtrlSFPrompt
" search for word under cursor with 'c'
nmap <leader>rc <Plug>CtrlSFCwordExec
nmap <leader>rC <Plug>CtrlSFCwordPath
" add word boundaries to search with 'b'
nmap <leader>rb <Plug>CtrlSFCCwordExec
nmap <leader>rB <Plug>CtrlSFCCwordPath
" search for last search '/' term
nmap <leader>r/ <Plug>CtrlSFPwordExec
nmap <leader>r? <Plug>CtrlSFPwordPath
" update, toggle open, clear hl
nmap <leader>ru <CMD>CtrlSFUpdate<CR>
nmap <leader>ro <CMD>CtrlSFToggle<CR>
nmap <leader>rh <CMD>CtrlSFClearHL<CR>
let g:ctrlsf_mapping = { "vsplit": "<C-v>", }
let g:ctrlsf_auto_focus = { "at" : "start", }
  ]])
-- Git Messenger
vim.cmd([[
function! s:setup_git_messenger_popup() abort
    " Your favorite configuration here

    " For example, set go back/forward history to <C-o>/<C-i>
    nmap <buffer><C-o> o
    nmap <buffer><C-i> O
endfunction
autocmd FileType gitmessengerpopup call <SID>setup_git_messenger_popup()
]])

-- AutoPairs function
vim.cmd([[
function! s:tabout(dir) abort
    let l:pair = '"[{(<>)}]' . "'"
    let l:pos = col('.')-1
    if a:dir
        let l:lfor = getline('.')[l:pos:]
        for i in l:lfor
            let l:pos += 1
            if stridx(l:pair, i) != -1
                call cursor(0, l:pos+1)
                return ""
            endif
        endfor
    else
        let l:lbac = getline('.')[:l:pos]
        while l:pos > 0
            let l:pos -= 1
            if stridx(l:pair, l:lbac[l:pos]) != -1
                call cursor(0, l:pos+1)
                return ""
            endif
        endwhile
    endif
    return ""
endfunction

imap <silent> <C-l> <c-r>=<SID>tabout(1)<CR>
imap <silent> <C-h> <C-r>=<SID>tabout(0)<CR>
  ]])

-- Dirvish
vim.cmd([[
let g:dirvish_relative_paths = 1
let g:dirvish_mode = ':sort ,^.*[\/],'
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

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

augroup END
]])

-- Thesaurus
vim.cmd([[
func! Thesaur(findstart, base)
  if a:findstart
	return searchpos('\<', 'bnW', line('.'))[1] - 1
  endif
  let res = []
  let h = ''
  for l in systemlist('aiksaurus '.shellescape(a:base))
if l[:3] == '=== '
  let h = '('.substitute(l[4:], ' =*$', ')', '')
elseif l ==# 'Alphabetically similar known words are: '
  let h = "\U0001f52e"
elseif l[0] =~ '\a' || (h ==# "\U0001f52e" && l[0] ==# "\t")
  call extend(res, map(split(substitute(l, '^\t', '', ''), ', '), {_, val -> {'word': val, 'menu': h}}))
endif
  endfor
  return res
endfunc

if exists('+thesaurusfunc')
  set thesaurusfunc=Thesaur
endif
set thesaurus=~/.vim/thesaurus/english.txt
]])


vim.cmd([[

nmap <leader>pc  <CMD>BCommits<CR>
nmap <leader>/   <CMD>RG<CR>
nmap <leader>?   <CMD>RgWord<CR>
xmap <leader>?   <CMD>RgWordVis<CR>
nmap <leader>p/  :RG <c-r><c-w><CR>
xmap <leader>p/  "vy:<c-u>RG <c-r>v<CR>
nmap <leader>pF  <CMD>Files<CR>
nmap <leader>pf  <CMD>GFiles<CR>
nmap <leader>pg  <CMD>GFiles?<CR>
nmap <leader>pb  <CMD>GBranches<CR>
nmap <leader>pT  <CMD>GTags<CR>
nmap <leader>pl  <CMD>Lines<CR>
nmap <leader>p'  <CMD>Tags<CR>
nmap <leader>pt  <CMD>RgTODO<CR>
" Files Prefix f
nmap <leader>fL  :Locate ""<left>
nmap <leader>fb  <CMD>Buffers<CR>
nmap <leader>ff  <CMD>ProjectFiles<CR>

let $FZF_DEFAULT_COMMAND = "rg --files --no-ignore --hidden --follow --glob '!.git'"
let $FZF_DEFAULT_OPTS = "--layout=reverse --inline-info -m"
let g:todo_list_items = 'TODO\|DONE\|WAIT'

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--info=inline']}), <bang>0)

let g:rg_derive_root='true'

if has('win32') " Disable preview on Windows since it doesn't really work
  let g:fzf_preview_window = []
else
    function! RipgrepTODO(query, fullscreen)
        let command_fmt = 'rg --column --no-ignore --line-number --no-heading --color=always --smart-case --glob "!tags" --glob "!.git/*"'
        let initial_command = command_fmt . ' ' . g:todo_list_items
        let spec = {'options': ['--query', a:query]}
        call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction
    command! -nargs=* -bang RgTODO call RipgrepTODO(<q-args>, <bang>0)

    function! s:get_visual_selection()
        if mode()=="v"
            let [line_start, column_start] = getpos("v")[1:2]
            let [line_end, column_end] = getpos(".")[1:2]
        else
            let [line_start, column_start] = getpos("'<")[1:2]
            let [line_end, column_end] = getpos("'>")[1:2]
        end
        if (line2byte(line_start)+column_start) > (line2byte(line_end)+column_end)
            let [line_start, column_start, line_end, column_end] =
            \   [line_end, column_end, line_start, column_start]
        end
        let lines = getline(line_start, line_end)
        if len(lines) == 0
                return ''
        endif
        let lines[-1] = lines[-1][: column_end - 1]
        let lines[0] = lines[0][column_start - 1:]
        return join(lines, "\n")
    endfunction

    function! RipgrepWordVis(query, fullscreen)
        let command_fmt = 'rg --column --no-ignore --line-number --no-heading --color=always --smart-case --glob "!tags" --glob "!.git/*"'
        let initial_command = command_fmt . ' ' . s:get_visual_selection()
        let spec = {'options': ['--query', a:query]}
        call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction
    command! -nargs=* -bang RgWordVis call RipgrepWordVis(<q-args>, <bang>0)

    function! RipgrepWord(query, fullscreen)
        let command_fmt = 'rg --column --no-ignore --line-number --no-heading --color=always --smart-case --glob "!tags" --glob "!.git/*"'
        let initial_command = command_fmt . ' ' . expand("<cword>")
        let spec = {'options': ['--query', a:query]}
        call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction
    command! -nargs=* -bang RgWord call RipgrepWord(<q-args>, <bang>0)

    function! RipgrepFzf(query, fullscreen)
        let command_fmt = 'rg --column --no-ignore --line-number
                    \ --no-heading --color=always --smart-case --glob "!tags"
                    \ --glob "!.git/*" -- %s || true'
        let initial_command = printf(command_fmt, shellescape(a:query))
        let reload_command = printf(command_fmt, '{q}')
        let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
        call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction
    command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
endif
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d
            \ %s %C(cyan)%C(bold)%cr"'
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'
" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'enter'
command! -bang ProjectFiles call fzf#vim#files('~/S', fzf#vim#with_preview(), <bang>0)

let g:fzf_preview_window = ['right:50%', 'ctrl-/']

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_checkout_use_current_buf_cwd = v:true
let g:fzf_checkout_merge_settings= v:false
let g:fzf_checkout_git_options = '--sort=-committerdate'
let g:fzf_branch_actions = {
      \ 'diff': {
           \   'prompt': 'Diff> ',
           \   'execute': 'Git diff {branch}',
           \   'multiple': v:false,
           \   'keymap': 'ctrl-f',
           \   'required': ['branch'],
           \   'confirm': v:false,
           \ },
        \ 'checkout': {
            \   'prompt': 'Checkout> ',
            \   'execute': 'echo system("{git} -C {cwd} checkout {branch}")',
            \   'multiple': v:false,
            \   'keymap': 'enter',
            \   'required': ['branch'],
            \   'confirm': v:false,
            \ },
        \ 'track': {
        \   'prompt': 'Track> ',
        \   'execute': 'echo system("{git} -C {cwd} checkout --track {branch}")',
        \   'multiple': v:false,
        \   'keymap': 'ctrl-t',
        \   'required': ['branch'],
        \   'confirm': v:false,
        \ },
        \ 'create': {
        \   'prompt': 'Create> ',
        \   'execute': 'echo system("{git} -C {cwd} checkout -b {input}")',
        \   'multiple': v:false,
        \   'keymap': 'ctrl-b',
        \   'required': ['input'],
        \   'confirm': v:false,
        \ },
        \ 'delete': {
        \   'prompt': 'Delete> ',
        \   'execute': 'echo system("{git} -C {cwd} branch -D {branch}")',
        \   'multiple': v:true,
        \   'keymap': 'ctrl-d',
        \   'required': ['branch'],
        \   'confirm': v:true,
        \ },
        \ 'merge':{
        \   'prompt': 'Merge> ',
        \   'execute': 'echo system("{git} -C {cwd} merge {branch}")',
        \   'multiple': v:false,
        \   'keymap': 'ctrl-e',
        \   'required': ['branch'],
        \   'confirm': v:true,
        \ },
        \ 'rebase':{
        \   'prompt': 'Rebase> ',
        \   'execute': 'echo system("{git} -C {cwd} rebase {branch}")',
        \   'multiple': v:false,
        \   'keymap': 'ctrl-r',
        \   'required': ['branch'],
        \   'confirm': v:true,
        \ },
      \}

let g:fzf_tag_actions = {
      \ 'checkout': {
      \   'prompt': 'Checkout> ',
      \   'execute': 'echo system("{git} -C {cwd} checkout {tag}")',
      \   'multiple': v:false,
      \   'keymap': 'enter',
      \   'required': ['tag'],
      \   'confirm': v:false,
      \ },
      \ 'create': {
      \   'prompt': 'Create> ',
      \   'execute': 'echo system("{git} -C {cwd} tag {input}")',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-b',
      \   'required': ['input'],
      \   'confirm': v:false,
      \ },
      \ 'delete': {
      \   'prompt': 'Delete> ',
      \   'execute': 'echo system("{git} -C {cwd} branch -D {tag}")',
      \   'multiple': v:true,
      \   'keymap': 'ctrl-d',
      \   'required': ['tag'],
      \   'confirm': v:true,
      \ },
      \}
]])
