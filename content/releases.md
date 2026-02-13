+++
title = "Releases"
toc = false
+++

Bilk Scheme is under active development. No versioned releases have been published yet.

## Building from source

To use Bilk Scheme today, build from the `main` branch:

```sh
git clone https://github.com/bilk-scheme/bilk.git
cd bilk
opam switch create . ocaml-variants.5.3.0+BER
eval $(opam env)
opam install . --deps-only --with-test -y
dune build
dune install
```

See [Getting Started]({{< relref "/docs/getting-started" >}}) for detailed
instructions.

## Following development

- **Source**: [github.com/bilk-scheme/bilk](https://github.com/bilk-scheme/bilk)
- **Discussions**: [github.com/bilk-scheme/bilk/discussions](https://github.com/bilk-scheme/bilk/discussions)

This page will be updated when versioned releases are available.
