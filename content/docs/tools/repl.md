+++
title = "REPL"
weight = 1
+++

Start the REPL by running `bilk` with no arguments:

```sh
bilk
```

## Features

- **Syntax highlighting** with two built-in themes (dark and light)
- **Rainbow parentheses** — depth-based color cycling for matching parens
- **Paredit** — structural editing that keeps parentheses balanced
- **Multi-line input** — automatic detection of incomplete expressions
- **Tab completion** — completes Scheme identifiers and REPL commands
- **Interactive tab completion menu** — visual popup for ambiguous completions; Tab/Shift-Tab to cycle, Enter to accept, Escape to cancel
- **Context-sensitive completion** — completes identifiers, file paths inside strings, library names in `import` forms, and arguments for `,load`, `,theme`, and `,reload`
- **Session checkpoints** — save and restore REPL state with `,checkpoint` and `,revert`
- **Datum comment highlighting** — `#;` styles the entire commented expression
- **Auto-indentation** — smart indentation for `def*`, `let*`, `lambda*`, `cond`, `begin`, `when`, `unless`, and more
- **History** — persistent across sessions, saved to `~/.bilk_history`
- **Emacs keybindings** — Ctrl-A/E, Ctrl-B/F, Ctrl-K, Ctrl-U, Alt-Left/Right
- **Library watching** — in package projects, rebuilds stale libraries in the background

## REPL commands

Commands are prefixed with a comma:

| Command | Description |
|---------|-------------|
| `,help` / `,h` | Show available commands |
| `,quit` / `,q` | Exit the REPL |
| `,load <file>` | Load and evaluate a Scheme file |
| `,env` | List all bound names in the global environment |
| `,libs` | List loaded/registered libraries |
| `,available` | List all discoverable libraries on disk |
| `,exports <lib>` | Show exports of a library, e.g. `,exports (scheme base)` |
| `,deps <lib>` | Show dependency tree, e.g. `,deps (srfi 1)` |
| `,reload <lib>` | Reload a library from source |
| `,build` | Trigger library rebuild |
| `,theme <name>` | Switch theme: `dark`, `light`, `none`, or a file path |
| `,paredit` | Toggle structural editing mode |
| `,clear` | Clear terminal and scrollback |
| `,checkpoint [name]` | Save REPL session state to FASL |
| `,revert [name]` | Restore a saved checkpoint |
| `,checkpoints` | List all available checkpoints |
| `,save-session <file>` | Save all checkpoints to a binary file |
| `,load-session <file>` | Load checkpoints from a binary file |

## Paredit mode

Paredit keeps parentheses balanced automatically. When enabled:

- Typing `(` inserts `()` and places the cursor inside
- Typing `)` moves past the closing paren instead of inserting
- Backspace will not delete an unmatched paren
- `"` handles string delimiters in balanced pairs

Structural operations:

| Operation | Description |
|-----------|-------------|
| Slurp forward | Absorb the next s-expression into the current list |
| Slurp backward | Absorb the previous s-expression |
| Barf forward | Eject the last s-expression from the current list |
| Barf backward | Eject the first s-expression |
| Wrap | Wrap the next s-expression in parentheses |
| Splice | Remove the enclosing parentheses |
| Raise | Replace the enclosing list with the current s-expression |

S-expression navigation:

| Key | Action |
|-----|--------|
| Ctrl-Alt-F | Move forward by s-expression |
| Ctrl-Alt-B | Move backward by s-expression |
| Ctrl-Alt-U | Move up out of the current list |
| Ctrl-Alt-N | Move forward out of the enclosing list |
| Ctrl-Alt-D | Descend into the next list |
| Ctrl-Alt-P | Move backward into the enclosing list |

Indentation:

- **Tab** indents the current line (when not completing an identifier)
- **Shift-Tab** re-indents all lines
- **Enter** auto-indents the new line and lines below it

Toggle paredit on or off with `,paredit`.

## Themes

Switch between built-in themes or load a custom theme file:

```
,theme dark
,theme light
,theme none
,theme /path/to/my-theme.scm
```

You can also set the default theme with the `BILK_THEME` environment variable.

Settings (theme, paredit mode) persist across sessions in `~/.bilk/config`.

## Keyboard shortcuts

| Key | Action |
|-----|--------|
| Ctrl-A | Move to start of line |
| Ctrl-E | Move to end of line |
| Ctrl-B / Ctrl-F | Move backward/forward one character |
| Alt-Left / Alt-Right | Move backward/forward one word |
| Ctrl-K | Kill from cursor to end of line |
| Ctrl-U | Kill from cursor to start of line |
| Ctrl-W | Kill previous word |
| Up / Down | Navigate history |
| Tab | Complete identifier or command; indent current line (paredit) |
| Shift-Tab | Re-indent all lines (paredit) |
| Ctrl-Alt-F / Ctrl-Alt-B | Move forward/backward by s-expression (paredit) |
| Ctrl-D | Exit (on empty line) |
