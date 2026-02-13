+++
title = "Contributing"
toc = true
+++

Contributions to Bilk Scheme are welcome. Here's how to get involved.

## Reporting bugs

Open an issue on GitHub:
[github.com/bilk-scheme/bilk/issues](https://github.com/bilk-scheme/bilk/issues)

Include:
- What you expected to happen
- What actually happened
- A minimal Scheme program that reproduces the issue
- Your platform (OS, OCaml version)

## Development setup

1. Clone the repository and create a local opam switch:

```sh
git clone https://github.com/bilk-scheme/bilk.git
cd bilk
opam switch create . ocaml-variants.5.3.0+BER
eval $(opam env)
```

2. Install dependencies:

```sh
opam install . --deps-only --with-test -y
```

3. Build and test:

```sh
dune build
dune test
```

## Development practices

Bilk Scheme follows strict test-driven development (red-green-refactor):

1. **Write a failing test** that demonstrates the bug or specifies the new behavior
2. **Write the minimum code** to make the test pass
3. **Refactor** with confidence, keeping tests green

The test suite uses **Alcotest** for example-based tests and **QCheck** for
property-based tests. Property tests are preferred for capturing invariants
(round-trips, algebraic laws, idempotence).

## Code conventions

- Every `.ml` module in `lib/` has a corresponding `.mli` interface file
- Depend on interfaces, not implementation details
- Favor small functions — each should do one thing
- Keep solutions simple and readable; three clear lines beat one opaque line
- Nontrivial optimizations require evidence (benchmarks) before acceptance

## Project structure

```
bin/main.ml         CLI entry point
lib/                Core library (37 modules)
test/               Test suite (40 files, 1600+ tests)
stdlib/srfi/        Bundled SRFI library sources
examples/           Example programs
```

Each `lib/` module has a corresponding `test/test_<module>.ml`.

## Submitting changes

1. Fork the repository on GitHub
2. Create a feature branch from `main`
3. Write tests, then implement
4. Ensure `dune test` passes
5. Open a pull request with a clear description

## Discussions

For questions, ideas, and general discussion:
[github.com/bilk-scheme/bilk/discussions](https://github.com/bilk-scheme/bilk/discussions)
