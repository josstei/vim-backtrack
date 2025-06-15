# vim-backtrack

**vim-backtrack** helps you quickly jump back to your recent files in Vim or Neovim. With a single command, you’ll see your 10 most recently opened files—just press a number to open one instantly. No fuss, no extra setup.

---

## Features

- Instantly access your 10 most recent files with `:Backtrack`
- Clean, numbered list—press 1–9 or 0 to pick a file
- Choose how the list appears: in a split, a vertical split, or right in your current window
- Designed to be fast, simple, and out of your way

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

You’ll get a list of up to 10 recent files. Each is labeled `[1]` to `[0]` (0 is the 10th).  
Press the matching number (in normal mode) and you’re back in your file.

---

## Customization

Want the list to pop up in a split or vertical split?  
Set the `g:backtrack_split` variable in your config:

| Value               | What it does                     |
|---------------------|----------------------------------|
| `''` (default)      | Uses your current window         |
| `split`             | Opens in a horizontal split      |
| `vsplit`            | Opens in a vertical split        |
| `botright split`    | Bottom horizontal split          |
| `botright vsplit`   | Bottom right vertical split      |
| `topleft split`     | Top horizontal split             |
| `topleft vsplit`    | Top left vertical split          |
| `aboveleft split`   | Above current window split       |
| `aboveleft vsplit`  | Above left vertical split        |
| `belowright split`  | Below current window split       |
| `belowright vsplit` | Below right vertical split       |

**Example:**  
To always use a vertical split:

```vim
let g:backtrack_split = 'vsplit'
```

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
Press `3` to open the file labeled `[3]`—done!

---

## Contributing

Contributions are welcome!  
Feel free to open [issues](https://github.com/josstei/vim-backtrack/issues) or [pull requests](https://github.com/josstei/vim-backtrack/pulls) for improvements or bug fixes.

---

## License

[MIT License](LICENSE)
