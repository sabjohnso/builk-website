+++
title = "Releases"
toc = false
+++

Wile is under active development. No versioned releases have been published yet.

## Building from source

To use wile today, build from the `main` branch:

```sh
git clone https://github.com/wile-scheme/wile.git
cd wile
opam switch create . ocaml-variants.5.3.0+BER
eval $(opam env)
opam install . --deps-only --with-test -y
dune build
dune install
```

See [Getting Started]({{< relref "/docs/getting-started" >}}) for detailed
instructions.

## Following development

- **Source**: [github.com/wile-scheme/wile](https://github.com/wile-scheme/wile)
- **Discussions**: [github.com/wile-scheme/wile/discussions](https://github.com/wile-scheme/wile/discussions)

This page will be updated when versioned releases are available.
