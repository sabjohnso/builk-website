# Wile Website

Static website for the **wile** programming language — an R7RS Scheme compiler
written in OCaml. Built with [Hugo](https://gohugo.io/).

The wile compiler source lives at `../wile`. We do not modify that code from
this repo, but we reference it for accurate documentation of features,
architecture, and usage.

## Development Environment

This project uses a **Nix flake** to provide Hugo (extended) and Go.

```sh
nix develop             # enter the dev shell (or use direnv)
hugo server -D          # local dev server with drafts
hugo                    # build to public/
```

If you have [direnv](https://direnv.net/) installed, `cd` into the project
and run `direnv allow` once — the shell will activate automatically.

## Project Layout

```
archetypes/             Default front matter templates for `hugo new`
assets/                 CSS, JS, images processed by Hugo Pipes
content/                Markdown content pages (the site's prose)
data/                   Structured data files (TOML/YAML/JSON)
i18n/                   Internationalization strings
layouts/                Go HTML templates (overrides theme templates)
static/                 Files served verbatim (favicon, fonts, etc.)
hugo.toml               Site configuration
flake.nix               Nix flake (dev shell with Hugo + Go)
.envrc                  direnv integration (activates flake)
```

## Wile at a Glance

When writing content about wile, refer to `../wile/README.md` and
`../wile/CLAUDE.md` for authoritative details. Key facts:

- **R7RS compliant** — all 16 `(scheme ...)` standard libraries
- **Compiles to bytecode** — no interpreter; every `eval` compiles first
- **Pipeline**: Reader → Expander → Compiler → VM (12 instructions)
- **Full numeric tower**: fixnum, bignum, rational, flonum, complex
- **Hygienic macros**: `syntax-rules`, `define-syntax`, `let-syntax`,
  `letrec-syntax`, `define-record-type`, `guard`, quasiquote
- **31+ bundled SRFIs** (1, 13, 14, 69, 115, 151, …)
- **Interactive REPL** with syntax highlighting, paredit, rainbow parens,
  tab completion, and history
- **Ahead-of-time compilation** to FASL bytecode or standalone executables
- **Embedding APIs** for both OCaml and C
- **Developer tools**: LSP server, DAP debugger, runtime profiler
- **Package manager** with semver resolution and virtual environments
- **License**: MIT

## Conventions

- **Content accuracy**: All technical claims must be verifiable against the
  wile source at `../wile`. When in doubt, read the code.
- **Hugo idioms**: Follow standard Hugo directory conventions. Use
  page bundles for content that has associated assets. Use shortcodes for
  reusable content patterns.
- **Scheme code examples**: Use fenced code blocks with `scheme` as the
  language identifier. Ensure all examples are valid R7RS that wile can
  actually run.
- **Front matter**: Use TOML (`+++`) for consistency across content files.
- **Minimal custom templates**: Prefer configuring the theme over writing
  custom layouts. Only add custom templates when the theme genuinely cannot
  accommodate the need.
- **Assets pipeline**: Place CSS/JS in `assets/` (processed by Hugo Pipes)
  rather than `static/` when they need minification or fingerprinting.
- **No generated files in git**: `public/` and `resources/` should be
  gitignored. Only source files belong in the repo.
