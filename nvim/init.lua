--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- See `:help vim.o`
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.foldmethod = 'indent'

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Quick shortcuts to leave insert mode
vim.keymap.set('i', 'jh', '<Esc>:w<CR>', { desc = 'Escape and save' })
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Escape' })

vim.keymap.set('n', 'nvt', ':NvimTreeOpen<CR>', { desc = 'Open nvim-tree' })
local toggle_listchar = 0
function ToggleListChar()
  if toggle_listchar == 1 then
    vim.o.list = true
    vim.opt.listchars = { tab = '→ ', trail = '•', nbsp = '␣' }
    toggle_listchar = 0
  else
    vim.o.list = true
    vim.opt.listchars = { tab = '→ ', space = '·', nbsp = '␣', trail = '•', eol = '¶', precedes = '«', extends = '»' }
    toggle_listchar = 1
  end
end
vim.keymap.set('n', '<C-Space>', ToggleListChar, { desc = 'Make special spaces visible' })
vim.keymap.set('n', 'dsds', ':execute ":%s/\\s\\+$//g"<CR>')

vim.keymap.set('n', '<leader>tv', function()
  local current_config = vim.diagnostic.config()
  local is_enabled = false
  if current_config and (type(current_config.virtual_lines) == 'table' or current_config.virtual_lines) then
    is_enabled = true
  end
  vim.diagnostic.config { virtual_lines = not is_enabled }
end, { desc = 'Toggle Diagnostic Virtual Text' })

-- DAP
vim.fn.sign_define('DapBreakpoint', { text = '📌', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '🐝', texthl = 'DapStopped', linehl = '', numhl = '' })
vim.keymap.set('n', '<F5>', ':DapContinue<CR>', { desc = 'DAP Continue / Start' })
vim.keymap.set('n', '<F9>', ':DapToggleBreakpoint<CR>', { desc = 'DAP Step Over' })
vim.keymap.set('n', '<F10>', ':DapStepOver<CR>', { desc = 'DAP Step Into' })
vim.keymap.set('n', '<F12>', ':DapStepInto<CR>', { desc = 'DAP Step Into' })
vim.keymap.set('n', '<F13>', ':DapStepOut<CR>', { desc = 'DAP Step Into' })

vim.keymap.set('n', '<leader>cp', function()
  local path = vim.fn.expand '%'
  vim.fn.setreg('+', path)
  print('Copied relative path: ' .. path)
end, { desc = 'Copy relative file path' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

--  To check the current status of your plugins, run
--    :Lazy
require('lazy').setup 'plugins'

-- ################################################################################
require('image').setup {
  backend = 'kitty', -- or "ueberzug" or "sixel"
  processor = 'magick_cli', -- or "magick_rock"
  integrations = {
    markdown = {
      enabled = true,
      clear_in_insert_mode = false,
      download_remote_images = true,
      only_render_image_at_cursor = false,
      only_render_image_at_cursor_mode = 'popup', -- or "inline"
      floating_windows = false, -- if true, images will be rendered in floating markdown windows
      filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
    },
    asciidoc = {
      enabled = true,
      clear_in_insert_mode = false,
      download_remote_images = true,
      only_render_image_at_cursor = false,
      only_render_image_at_cursor_mode = 'popup',
      floating_windows = false,
      filetypes = { 'asciidoc', 'adoc' },
    },
    neorg = {
      enabled = true,
      filetypes = { 'norg' },
    },
    rst = {
      enabled = true,
    },
    typst = {
      enabled = true,
      filetypes = { 'typst' },
    },
    html = {
      enabled = false,
    },
    css = {
      enabled = false,
    },
  },
  scale_factor = 1.0,
  editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
  tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
  hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif' }, -- render image files as images when opened
  max_width = 200, -- tweak to preference
  max_height = 200, -- ^
  max_height_window_percentage = math.huge, -- this is necessary for a good experience
  max_width_window_percentage = math.huge,
  window_overlap_clear_enabled = false,
  window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs' },
}

-- JUPYTER MESS
-- I find auto open annoying, keep in mind setting this option will require setting
-- a keybind for `:noautocmd MoltenEnterOutput` to open the output again
vim.g.molten_auto_open_output = false

-- this guide will be using image.nvim
-- Don't forget to setup and install the plugin if you want to view image outputs
vim.g.molten_image_provider = 'image.nvim'

-- optional, I like wrapping. works for virt text and the output window
vim.g.molten_wrap_output = false

-- Output as virtual text. Allows outputs to always be shown, works with images, but can
-- be buggy with longer images
vim.g.molten_virt_text_output = true
vim.g.molten_virt_text_max_lines = 500
vim.g.molten_output_show_exec_time = true
vim.g.molten_output_virt_lines = true

-- this will make it so the output shows up below the \`\`\` cell delimiter
vim.g.molten_virt_lines_off_by_1 = true

vim.keymap.set('n', '<localleader>e', ':MoltenEvaluateOperator<CR>', { desc = 'evaluate operator', silent = true })
vim.keymap.set('n', '<localleader>os', ':noautocmd MoltenEnterOutput<CR>', { desc = 'open output window', silent = true })
vim.keymap.set('n', '<localleader>rr', ':MoltenReevaluateCell<CR>', { desc = 're-eval cell', silent = true })
vim.keymap.set('v', '<localleader>r', ':<C-u>MoltenEvaluateVisual<CR>gv', { desc = 'execute visual selection', silent = true })
vim.keymap.set('n', '<localleader>oh', ':MoltenHideOutput<CR>', { desc = 'close output window', silent = true })
vim.keymap.set('n', '<localleader>md', ':MoltenDelete<CR>', { desc = 'delete Molten cell', silent = true })

vim.keymap.set('n', '<leader>mi', ':MoltenInit<CR>:QuartoActivate<CR>', { desc = 'Initialize Molten kernel', silent = true })
-- Runs the Markdown code block under the cursor
vim.keymap.set('n', '<leader>rc', require('quarto.runner').run_cell, { desc = 'run cell', silent = true })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
