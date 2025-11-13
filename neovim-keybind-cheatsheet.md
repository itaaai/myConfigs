# Neovim Keybind Cheatsheet

## Legend
- `<leader>` = Space key (default leader)
- `<C-x>` = Ctrl + x
- `<A-x>` = Alt + x
- `<S-x>` = Shift + x

## Your Custom Keybinds

### File Explorer & Navigation
| Keybind | Action | Description |
|---------|---------|-------------|
| `<leader>ex` | `:Ex` | Open file explorer (netrw) |

### Window & Split Management
| Keybind | Action | Description |
|---------|---------|-------------|
| `<leader>-` | `:split` | Horizontal split |
| `<leader>\|` | `:vsplit` | Vertical split |
| `<leader>q` | `<C-w>c` | Close current window |
| `<A-Left>` | `:vertical resize -2` | Decrease window width |
| `<A-Right>` | `:vertical resize +2` | Increase window width |
| `<A-Up>` | `:resize -2` | Decrease window height |
| `<A-Down>` | `:resize +2` | Increase window height |

### Tab Management
| Keybind | Action | Description |
|---------|---------|-------------|
| `<leader>t` | `:tabnew` | New tab |
| `<leader>T` | `:tabclose` | Close tab |
| `<A-S-h>` | `:tabprevious` | Previous tab |
| `<A-S-l>` | `:tabnext` | Next tab |

### Telescope (Fuzzy Finder)
| Keybind | Action | Description |
|---------|---------|-------------|
| `<leader>ff` | `find_files` | Find files in project |
| `<leader>fo` | `oldfiles` | Recently opened files |
| `<leader>fb` | `buffers` | Open buffers |
| `<leader>fq` | `quickfix` | Quickfix list |
| `<leader>fh` | `help_tags` | Help tags |
| `<leader>fg` | `grep_string` | Search text (input prompt) |
| `<leader>fc` | Custom grep | Find current filename |
| `<leader>fs` | `grep_string` | Find current string under cursor |
| `<leader>fi` | `find_files` | Find files in Neovim config |
| `<leader>fj` | `jumplist` | Show jump list |
| `<leader>fl` | Harpoon telescope | Open harpoon list with telescope |

#### Telescope Mappings (Inside Telescope)
| Keybind | Action | Mode |
|---------|---------|------|
| `<C-k>` | Previous result | Insert |
| `<C-j>` | Next result | Insert |
| `<C-q>` | Send to quickfix | Insert |
| `<C-t>` | Open in new tab | Insert/Normal |
| `d` | Delete buffer | Normal |

### Harpoon (File Bookmarks)
| Keybind | Action | Description |
|---------|---------|-------------|
| `<leader>a` | Add file | Add current file to harpoon |
| `<C-e>` | Toggle menu | Show/hide harpoon quick menu |
| `<C-p>` | Previous file | Navigate to previous harpoon file |
| `<C-n>` | Next file | Navigate to next harpoon file |

### TMUX Navigation
| Keybind | Action | Description |
|---------|---------|-------------|
| `<C-h>` | Navigate left | Move to left pane (tmux/vim) |
| `<C-j>` | Navigate down | Move to down pane (tmux/vim) |
| `<C-k>` | Navigate up | Move to up pane (tmux/vim) |
| `<C-l>` | Navigate right | Move to right pane (tmux/vim) |
| `<C-\>` | Navigate previous | Navigate to previous pane |

### LSP (Language Server Protocol)
| Keybind | Action | Description |
|---------|---------|-------------|
| `gd` | Go to definition | Jump to definition |
| `gr` | References | Show all references |
| `gD` | Go to declaration | Jump to declaration |
| `gi` | Go to implementation | Jump to implementation |
| `gt` | Type definition | Show type definition |
| `K` | Hover | Show documentation |
| `<leader>rn` | Rename | Rename symbol |
| `<leader>ca` | Code action | Show code actions |
| `<leader>ds` | Document symbols | Show document symbols |
| `<leader>ws` | Workspace symbols | Show workspace symbols |
| `<leader>f` | Format | Format file/range |

### Completion (nvim-cmp)
| Keybind | Action | Mode |
|---------|---------|------|
| `<C-Space>` | Trigger completion | Insert |
| `<CR>` | Accept completion | Insert |
| `<Tab>` | Next item / Expand snippet | Insert |
| `<S-Tab>` | Previous item / Jump back | Insert |

### TreeSitter Text Objects
| Keybind | Action | Description |
|---------|---------|-------------|
| `af` | Around function | Select around function |
| `if` | Inside function | Select inside function |

## Default Vim/Neovim Keybinds (Most Common)

### Basic Movement
| Keybind | Action |
|---------|---------|
| `h` | Move left |
| `j` | Move down |
| `k` | Move up |
| `l` | Move right |
| `w` | Next word |
| `b` | Previous word |
| `e` | End of word |
| `0` | Beginning of line |
| `^` | First non-blank character |
| `$` | End of line |
| `gg` | Go to first line |
| `G` | Go to last line |
| `{number}G` | Go to line number |
| `%` | Jump to matching bracket |

### Editing
| Keybind | Action |
|---------|---------|
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `I` | Insert at beginning of line |
| `A` | Insert at end of line |
| `o` | New line below |
| `O` | New line above |
| `x` | Delete character |
| `dd` | Delete line |
| `yy` | Copy line |
| `p` | Paste after cursor |
| `P` | Paste before cursor |
| `u` | Undo |
| `<C-r>` | Redo |
| `.` | Repeat last command |

### Visual Mode
| Keybind | Action |
|---------|---------|
| `v` | Visual mode |
| `V` | Visual line mode |
| `<C-v>` | Visual block mode |

### Search & Replace
| Keybind | Action |
|---------|---------|
| `/` | Search forward |
| `?` | Search backward |
| `n` | Next search result |
| `N` | Previous search result |
| `*` | Search word under cursor forward |
| `#` | Search word under cursor backward |
| `:%s/old/new/g` | Replace all occurrences |

### Window Management (Default)
| Keybind | Action |
|---------|---------|
| `<C-w>s` | Split horizontally |
| `<C-w>v` | Split vertically |
| `<C-w>h` | Move to left window |
| `<C-w>j` | Move to down window |
| `<C-w>k` | Move to up window |
| `<C-w>l` | Move to right window |
| `<C-w>q` | Close window |
| `<C-w>=` | Equal window sizes |

### File Operations
| Keybind | Action |
|---------|---------|
| `:w` | Save file |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:q!` | Quit without saving |

### Registers & Marks
| Keybind | Action |
|---------|---------|
| `"{register}` | Use specific register |
| `ma` | Set mark 'a' |
| `'a` | Jump to mark 'a' |
| `''` | Jump to previous position |

### Jump List
| Keybind | Action |
|---------|---------|
| `<C-o>` | Jump back |
| `<C-i>` | Jump forward |
| `:ju` | Show jump list |

### Macros
| Keybind | Action |
|---------|---------|
| `q{register}` | Start recording macro |
| `q` | Stop recording |
| `@{register}` | Execute macro |
| `@@` | Repeat last macro |

## Quick Tips
- Use `:help {command}` to get help on any command
- Use `:map` to see all current mappings
- Use `:verbose map {key}` to see where a mapping was defined
- Press `<Esc>` to return to normal mode from any mode