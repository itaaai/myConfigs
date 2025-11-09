function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end


nmap("<leader>ex", "<Cmd>Ex<CR>")

nmap("<leader>-", "<Cmd>split<CR>")
nmap("<leader>|", "<Cmd>vsplit<CR>")
nmap("<leader>q", "<C-w>c")

nmap("<leader>t", ":tabnew<CR>");
nmap("<leader>T", ":tabclose<CR>");
nmap("<A-S-h>", ":tabprevious<CR>");
nmap("<A-S-l>", ":tabnext<CR>");

-- Split resizing with Alt + arrow keys (allows continuous pressing)
nmap("<A-Left>", ":vertical resize -2<CR>");
nmap("<A-Right>", ":vertical resize +2<CR>");
nmap("<A-Up>", ":resize -2<CR>");
nmap("<A-Down>", ":resize +2<CR>");
