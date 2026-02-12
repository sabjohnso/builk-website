+++
title = "Package Manager"
weight = 5
+++

Wile includes a local package manager for installing and managing Scheme
libraries.

## Commands

| Command | Description |
|---------|-------------|
| `wile pkg install [PATH]` | Install a package from a directory (default: `.`) |
| `wile pkg list` | List all installed packages and versions |
| `wile pkg info <name> [version]` | Show package details |
| `wile pkg remove <name> <version>` | Remove a specific package version |

## Package descriptor

Every package has a `package.scm` file in its root directory:

```scheme
((name "my-package")
 (version "1.0.0")
 (description "A useful library")
 (license "MIT")
 (depends
   ((name "other-package")
    (version ">=0.5.0")))
 (libraries
   ((name (mylib utils))
    (path "src/utils.sld"))))
```

## Installing a package

From the package directory:

```sh
wile pkg install
```

Or from another location:

```sh
wile pkg install /path/to/package
```

Packages are installed to `~/.wile/packages/<name>/<version>/`.

## Dependency resolution

When a package declares dependencies, wile resolves them using semantic
versioning. The resolver picks the latest installed version that satisfies each
constraint and detects circular dependencies.

## Virtual environments

Virtual environments isolate project-specific libraries:

```sh
wile venv myenv
```

This creates a directory with a `lib/` folder for local libraries and a
`wile-venv.cfg` marker file.

Activate a virtual environment by setting:

```sh
export WILE_VENV=./myenv
```

When activated, the `lib/` directory is prepended to the library search path,
so libraries installed there take precedence over system-wide packages.

## Environment variables

| Variable | Description |
|----------|-------------|
| `WILE_HOME` | Override for Wile home directory (default: `~/.wile/`) |
| `WILE_PATH` | Additional library search directories (colon-separated) |
| `WILE_VENV` | Path to active virtual environment |
