+++
title = "Package Manager"
weight = 5
+++

Bilk Scheme includes a local package manager for installing and managing Scheme
libraries.

## Commands

| Command | Description |
|---------|-------------|
| `bilk pkg init [NAME]` | Initialize a new project with `package.scm` (default name: current directory) |
| `bilk pkg install [PATH]` | Install a package from a directory (default: `.`) |
| `bilk pkg list` | List all installed packages and versions |
| `bilk pkg info <name> [version]` | Show package details |
| `bilk pkg remove <name> <version>` | Remove a specific package version |
| `bilk pkg lock` | Resolve dependencies and write a lockfile |
| `bilk pkg why <name>` | Explain why a package is in the dependency tree |
| `bilk pkg fetch <name> [version]` | Download a package from a repository |
| `bilk pkg search <query>` | Search repositories for packages |

### Repository management

Repositories are remote sources of packages. Manage them with `bilk pkg repo`:

| Command | Description |
|---------|-------------|
| `bilk pkg repo add <name> <url>` | Add a package repository |
| `bilk pkg repo list` | List configured repositories |
| `bilk pkg repo remove <name>` | Remove a repository |
| `bilk pkg repo update <name>` | Update a repository's package index |

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
bilk pkg install
```

Or from another location:

```sh
bilk pkg install /path/to/package
```

Packages are installed to `~/.bilk/packages/<name>/<version>/`.

## Dependency resolution

When a package declares dependencies, Bilk Scheme resolves them using semantic
versioning. The resolver picks the latest installed version that satisfies each
constraint and detects circular dependencies.

## Virtual environments

Virtual environments isolate project-specific libraries:

```sh
bilk venv myenv
```

This creates a directory with a `lib/` folder for local libraries and a
`bilk-venv.cfg` marker file.

Activate a virtual environment by setting:

```sh
export BILK_VENV=./myenv
```

When activated, the `lib/` directory is prepended to the library search path,
so libraries installed there take precedence over system-wide packages.

## Environment variables

| Variable | Description |
|----------|-------------|
| `BILK_HOME` | Override for Bilk Scheme home directory (default: `~/.bilk/`) |
| `BILK_PATH` | Additional library search directories (colon-separated) |
| `BILK_VENV` | Path to active virtual environment |
