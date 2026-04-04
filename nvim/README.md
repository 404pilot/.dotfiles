# Neovim quick reference

Leader key = `Space`

## Navigation

| Key | Action |
|-----|--------|
| `<leader>ff` | find files |
| `<leader>fg` | live grep |
| `<leader>fb` | buffers |
| `<leader>fr` | recent files |
| `<leader>e`  | toggle file tree |
| `<S-l> / <S-h>` | next / previous buffer |
| `<C-h/j/k/l>` | move between splits |

## Flash (fast jump)

| Key | Action |
|-----|--------|
| `s` | jump to any 2-char match on screen |
| `S` | jump to treesitter node |

## LSP

| Key | Action |
|-----|--------|
| `gd` | go to definition |
| `gr` | references |
| `K`  | hover docs |
| `<leader>rn` | rename symbol |
| `<leader>ca` | code action |
| `[d / ]d` | previous / next diagnostic |
| `<leader>d` | show diagnostic |

## Git (gitsigns)

| Key | Action |
|-----|--------|
| `]h / [h` | next / previous hunk |
| `<leader>hp` | preview hunk |
| `<leader>hs` | stage hunk |
| `<leader>hr` | reset hunk |
| `<leader>hb` | blame line |

## Completion

| Key | Action |
|-----|--------|
| `<C-Space>` | trigger completion |
| `<C-n> / <C-p>` | next / previous item |
| `<CR>` | confirm |
| `<Tab> / <S-Tab>` | cycle items or jump snippet placeholder |

## General

| Key | Action |
|-----|--------|
| `<leader>w` | save |
| `<leader>q` | quit |
| `<leader>x` | close buffer |
| `<Esc>` | clear search highlight |
| `<C-d> / <C-u>` | scroll down / up (centered) |

## Plugin manager

| Command | Action |
|---------|--------|
| `:Lazy` | open plugin manager |
| `:Mason` | open LSP server manager |
