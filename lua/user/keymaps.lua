local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  return
end

local base_opts = { noremap = true, silent = true }

local function opts(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", base_opts)
keymap("", "s", "<Nop>", base_opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<leader>h", "<C-w>h", base_opts)
keymap("n", "<leader>j", "<C-w>j", base_opts)
keymap("n", "<leader>k", "<C-w>k", base_opts)
keymap("n", "<leader>l", "<C-w>l", base_opts)

-- Pane spliting
keymap("n", "ss", ":vsplit<CR>", base_opts)
keymap("n", "sh", ":split<CR>", base_opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", base_opts)
keymap("n", "<C-Down>", ":resize +2<CR>", base_opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", base_opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", base_opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", base_opts)
keymap("n", "<S-j>", ":bprevious<CR>", base_opts)
keymap("n", "<leader>w", ":Bdelete<CR>", base_opts)

-- Save
keymap("n", "<leader>s", ":w<CR>", base_opts)

-- Format
keymap("n", "<leader>a", ":Format<cr>", base_opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", base_opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", base_opts)

-- Nvimtree
keymap("n", "<leader>q", ":NvimTreeToggle<cr>", opts("toggle sidebar"))

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", base_opts)
keymap("v", ">", ">gv", base_opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", base_opts)
keymap("v", "<A-k>", ":m .-2<CR>==", base_opts)
keymap("v", "p", '"_dP', base_opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", base_opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", base_opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", base_opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", base_opts)

-- Telescope
keymap("n", "<leader>f",
  "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
  opts("find files"))
keymap("n", "<leader>g",
  "<cmd>lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
  base_opts)
keymap("n", "<leader>F", "<cmd>Telescope live_grep<cr>", opts("search files"))

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts("find definition"))

-- Code action
keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts("code action"))

-- Rename
keymap("n", "gr", "<cmd>Lspsaga rename<CR>", opts("rename"))

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts("peek definition"))

-- Show line diagnostics
keymap("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts("line diagnostics"))

-- Show cursor diagnostic
keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts("cursor diagnostics"))

-- Diagnsotic jump can use `<c-o>` to jump back
keymap("n", "gp", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts("previous diagnostic"))
keymap("n", "gn", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts("next diagnostic"))

-- Only jump to error
keymap("n", "gP", "<cmd>lua require 'lspsaga.diagnostic'.goto_prev({ severity = vim.diagnostic.severity.ERROR })<cr>", opts("previous error"))
keymap("n", "gN", "<cmd>lua require 'lspsaga.diagnostic'.goto_prev({ severity = vim.diagnostic.severity.ERROR })<cr>", opts("next error"))

-- Outline
keymap("n","<leader>o", "<cmd>LSoutlineToggle<CR>",opts(""))

-- Hover Doc
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts(""))

-- Harpoon
keymap("n", "<leader>a", "<cmd>lua require 'harpoon.mark'.add_file()<cr>", opts("mark file"))
keymap("n", "<leader>e", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", opts("view marks"))
keymap("n", "<leader>h", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", opts("open file 1"))
keymap("n", "<leader>j", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", opts("open file 2"))
keymap("n", "<leader>k", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", opts("open file 3"))
keymap("n", "<leader>l", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", opts("open file 4"))

wk.register({
  t = {
    name = "terminal",
    t = { "<cmd>FloatermToggle<cr>", "toggle" },
    g = { "<cmd>FloatermNew --height=0.9 --width=0.9 --title=- lazygit<cr>", "git" },
    s = { "<cmd>FloatermNew --height=0.8 --width=0.8 --title=- btop<cr>", "stats" },
    d = { "<cmd>FloatermNew --height=0.9 --width=0.9 --title=- lazydocker<cr>", "docker" }
  },
}, { prefix = "<leader>" })
