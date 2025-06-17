![Stable](https://img.shields.io/badge/status-stable-brightgreen) ![License](https://img.shields.io/badge/license-MIT-blue)
# vim-backtrack

**vim-backtrack** helps you quickly jump back to your recent files in Vim or Neovim. With a single command, you’ll see your most recently opened files (up to 50—user configurable). Just press a number to open one instantly. No fuss, no extra setup.

---

## Features

- Instantly access your most recent files with `:Backtrack` (default 10, configurable up to 50).
- Clean, numbered list - just press the number next to the file to navigate
- Choose how the list appears: in a split, a vertical split, or right in your current window (user configurable).
- Alternate split behavior for specific filetypes (user configurable).
- Only shows files that still exist on disk.
- Designed to be fast, simple, and out of your way.

---

## Installation

### Vim

Add this to your favorite plugin manager:

```vim
Plug 'josstei/vim-backtrack'
```

### Neovim

For `init.vim` or `init.lua` (vim-plug example):

```vim
Plug 'josstei/vim-backtrack'
```

Or with [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'josstei/vim-backtrack'
}
```

Or clone it directly:

```sh
git clone https://github.com/josstei/vim-backtrack ~/.vim/pack/plugins/start/vim-backtrack
```

---

## Usage

Just run:

```vim
:Backtrack
```
Or add it as a key map

```vim
" Normal mode: show recent files on <leader> b keypress
nnoremap <leader>b :Backtrack<CR>
```

You’ll get a list of recent files (up to your configured maximum). Each is labeled `[01]`, `[02]`, etc.  
Press the matching number (in normal mode) and you’re back in your file.

---

## Customization

### Control How Many Files Are Shown

Set the maximum number of files (up to 50, default 10):

```vim
let g:backtrack_max_count = 25
```

### Control Where the List Appears

Set the split command for the file list buffer:

| Value                | What it does                     |
|----------------------|----------------------------------|
| `''`                 | Uses your current window         |
| `split` (default)    | Opens in a horizontal split      |
| `vsplit`             | Opens in a vertical split        |
| `botright split`     | Bottom horizontal split          |
| `botright vsplit`    | Bottom right vertical split      |
| `topleft split`      | Top horizontal split             |
| `topleft vsplit`     | Top left vertical split          |
| `aboveleft split`    | Above current window split       |
| `aboveleft vsplit`   | Above left vertical split        |
| `belowright split`   | Below current window split       |
| `belowright vsplit`  | Below right vertical split       |

Example:
```vim
let g:backtrack_split = 'vsplit'
```

### Alternate Split for Certain Filetypes

To use a different split for certain filetypes:

```vim
let g:backtrack_alternate_split_types = ['markdown', 'help']
let g:backtrack_alternate_split = 'belowright split'
```

When Backtrack is opened from a buffer with one of those filetypes, the alternate split will be used.

---

## How It Works

- Grabs your recent files from Vim’s own file history
- Only shows files that still exist on disk
- Cleans up after itself—no clutter left behind
- Local number mappings make file selection quick and efficient

---

## Example Workflow

```vim
:Backtrack
```
Press `3` to open the file labeled `[03]`—done!

---

## Contributing

Contributions are welcome!  
Feel free to open [issues](https://github.com/josstei/vim-backtrack/issues) or [pull requests](https://github.com/josstei/vim-backtrack/pulls) for improvements or bug fixes.

---

## License

[MIT License](LICENSE)
