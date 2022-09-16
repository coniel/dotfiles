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
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts("toggle sidebar"))

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
keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts("find files"))
keymap("n", "<leader>g", "<cmd>lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", base_opts)
keymap("n", "<leader>F", "<cmd>Telescope live_grep<cr>", opts("search files"))

wk.register({
  t = {
    name = "terminal",
    t = { "<cmd>FloatermToggle<cr>", "toggle" },
    g = { "<cmd>FloatermNew lazygit<cr>", "git" },
    d = { "<cmd>FloatermNew lazydocker<cr>", "docker" }
  },
}, { prefix = "<leader>" })
