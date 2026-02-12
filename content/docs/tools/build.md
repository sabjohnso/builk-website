+++
title = "Build System"
weight = 6
+++

Wile includes a build system that compiles libraries, manages dependencies,
and watches for changes.

## Commands

```sh
wile build              # build all project libraries
wile build --clean      # remove all .fasl cache files
wile build --dry-run    # show what would be built
wile build --verbose    # verbose output
wile build --watch      # rebuild on source changes (Ctrl-C to stop)
wile build --graph      # emit Graphviz DOT dependency graph
```

## How it works

The build system:

1. Auto-discovers all `.sld` library files in the project
2. Resolves inter-library dependencies
3. Detects staleness (missing `.fasl`, source newer than cache, dependency changed)
4. Compiles stale libraries to `.fasl` bytecode
5. Caches the results for fast subsequent loads

## FASL caching

Compiled libraries are cached as `.fasl` files alongside their `.sld` sources.
Cache invalidation is mtime-based: if the source or any dependency is newer
than the `.fasl`, the library is recompiled.

## Watch mode

```sh
wile build --watch
```

Monitors source directories for changes and automatically rebuilds stale
libraries. When used alongside the REPL, rebuilt libraries are reloaded
automatically.

## Dependency graph

Visualize library dependencies as a Graphviz DOT graph:

```sh
wile build --graph | dot -Tsvg -o deps.svg
```

## Ahead-of-time compilation

For standalone programs (not libraries), use `wile compile`:

```sh
wile compile program.scm -o program.fasl    # bytecode
wile compile program.scm --exe -o program   # native executable
```

See [Getting Started — Compiling programs]({{< relref "/docs/getting-started#compiling-programs" >}})
for details.

## Testing

Wile also includes a test runner:

```sh
wile test              # discover and run all tests
wile test --verbose    # print file names during execution
wile test test/foo.scm # run a specific test file
```

The test runner auto-discovers files matching `test-*.scm` or `*-test.scm` in
the `test/` directory, builds project libraries first, then runs each test as
an isolated subprocess.
