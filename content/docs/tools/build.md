+++
title = "Build System"
weight = 6
+++

Bilk Scheme includes a build system that compiles libraries, manages dependencies,
and watches for changes.

## Commands

```sh
bilk build              # build all project libraries
bilk build --clean      # remove all .fasl cache files
bilk build --dry-run    # show what would be built
bilk build --verbose    # verbose output
bilk build --watch      # rebuild on source changes (Ctrl-C to stop)
bilk build --graph      # emit Graphviz DOT dependency graph
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
bilk build --watch
```

Monitors source directories for changes and automatically rebuilds stale
libraries. When used alongside the REPL, rebuilt libraries are reloaded
automatically.

## Dependency graph

Visualize library dependencies as a Graphviz DOT graph:

```sh
bilk build --graph | dot -Tsvg -o deps.svg
```

## Ahead-of-time compilation

For standalone programs (not libraries), use `bilk compile`:

```sh
bilk compile program.scm -o program.fasl    # bytecode
bilk compile program.scm --exe -o program   # native executable
```

See [Getting Started — Compiling programs]({{< relref "/docs/getting-started#compiling-programs" >}})
for details.

## Testing

Bilk Scheme also includes a test runner:

```sh
bilk test              # discover and run all tests
bilk test --verbose    # print file names during execution
bilk test test/foo.scm # run a specific test file
```

The test runner auto-discovers files matching `test-*.scm` or `*-test.scm` in
the `test/` directory, builds project libraries first, then runs each test as
an isolated subprocess.
