-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- vim.g.netrw_liststyle = 3

-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true

if vim.g.neovide then
    vim.o.guifont = "Iosevka NF"
    vim.g.neovide_background_color = "#1e1e2e"
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_refresh_rate_idle = 60
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_confirm_quit = false
    vim.g.neovide_floating_opacity = 1.0
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_cursor_animate_command_line = false
end

-- Swap and undo
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.o.undofile = true

vim.opt.list = true
vim.opt.listchars = {
    tab = "».",
    extends = "›",
    precedes = "‹",
    nbsp = "·",
    trail = "·",
}

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldenable = true

-- Split
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.api.nvim_set_keymap(
    "n",
    "<Leader>mp",
    ":MarkdownPreview<CR>",
    { silent = true }
)

-- Let you move visual blocks with J and K
vim.keymap.set(
    "v",
    "J",
    ":m '>+1<cr>gv=gv",
    { desc = "Move selected lines up" }
) -- up
vim.keymap.set(
    "v",
    "K",
    ":m '<-2<cr>gv=gv",
    { desc = "move selected lines down" }
) -- down

-- Easier reach to beginning and end of lines
vim.keymap.set(
    "n",
    "H",
    "^",
    { desc = "Move to beginning of text on current line" }
)
vim.keymap.set("n", "L", "g_", { desc = "Move to end of text on current line" })
vim.keymap.set(
    "v",
    "L",
    "g_",
    { desc = "Move to end of text on current line - Visual mode" }
)

-- remap escape to a closer key
vim.keymap.set(
    "i",
    "jj",
    "<Esc>",
    { desc = "Remap escape to 'j' key twice for ergonomics - Insert mod" }
)

-- Cursor in middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste over without losing what's in your clipboard
vim.keymap.set("x", "<leader>P", '"_dP')

-- Yank into system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Paste from system clipboard
vim.keymap.set("n", "<leader>p", '"+p"')
vim.keymap.set("v", "<leader>p", '"+p"')

-- Captial Q is the worst place in the universe
vim.keymap.set("n", "Q", "<nop>")

-- q: is too close to :q for my tastes, and I never use it.
vim.keymap.set("n", "q:", "<nop>")

-- Control-S save
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group =
    vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

-- When closing the last window, load alpha back up
vim.api.nvim_create_user_command("Q", function()
    local multiple_windows, _ =
        pcall(vim.api.nvim_win_close, vim.fn.win_getid(), false)

    if multiple_windows then
        vim.cmd.bd()
    elseif vim.o.ft == "alpha" then
        vim.cmd.quitall()
    else
        vim.cmd.bd()
        vim.cmd.Alpha()
    end
end, {})
