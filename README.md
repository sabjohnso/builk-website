# Bilk Scheme Website

Source for the [Bilk Scheme](https://sabjohnso.github.io/bilk-website/)
website. Built with [Hugo](https://gohugo.io/) and the
[Hextra](https://github.com/imfing/hextra) theme.

## Prerequisites

The only dependency is [Nix](https://nixos.org/) with flakes enabled. The Nix
flake provides Hugo (extended) and Go at pinned versions.

### Install Nix

```sh
sh <(curl -L https://nixos.org/nix/install) --daemon
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
```

## Getting started

```sh
git clone https://github.com/sabjohnso/bilk-website.git
cd bilk-website
nix develop
hugo server -D
```

Open <http://localhost:1313/bilk-website/> to see the site locally.

### Using direnv (optional)

If you have [direnv](https://direnv.net/) installed, the dev shell activates
automatically:

```sh
direnv allow   # run once after cloning
```

## Project layout

```
content/                Markdown content pages
  _index.md             Homepage
  about.md              About page
  contributing.md       Contributing guide
  releases.md           Releases page
  docs/                 Documentation section
    getting-started/    Installation and first steps
    guide/              Language guide (11 chapters)
    tools/              Tool guide (REPL, LSP, DAP, profiler, packages, build)
    srfi/               SRFI reference table
layouts/                Template overrides
  _partials/custom/     Custom Hextra partials (footer, head)
static/                 Static assets (favicons)
hugo.toml               Site configuration
flake.nix               Nix flake (dev shell)
.github/workflows/      CI/CD (GitHub Actions → GitHub Pages)
PLAN.org                Implementation plan
```

## Common tasks

### Run the dev server

```sh
hugo server -D
```

The `-D` flag includes draft pages. The server live-reloads on file changes.

### Build the site

```sh
hugo
```

Output goes to `public/`. This directory is gitignored.

### Build with minification (production)

```sh
hugo --minify
```

### Add a new content page

```sh
hugo new content/docs/guide/new-topic.md
```

Then edit the generated file. Use TOML front matter (`+++`).

### Run Hugo without entering the dev shell

```sh
nix develop --command hugo server -D
```

## Content conventions

- **Front matter**: Use TOML (`+++`), not YAML (`---`).
- **Scheme code blocks**: Use `scheme` as the language identifier.
- **Accuracy**: All technical claims must be verifiable against the
  [bilk source](https://github.com/sabjohnso/bilk). When in doubt, read the
  code.
- **Shortcodes**: Use Hextra shortcodes (`tabs`, `cards`, `feature-grid`, etc.)
  for structured content. See the
  [Hextra docs](https://imfing.github.io/hextra/docs/guide/shortcodes/) for
  available shortcodes.

## Deployment

Pushing to `main` triggers a GitHub Actions workflow that builds the site and
deploys it to GitHub Pages. The workflow is defined in
`.github/workflows/deploy.yml`.

## License

MIT
