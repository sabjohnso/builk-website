+++
title = "Profiler"
weight = 4
+++

Wile includes a runtime profiler that instruments function calls and produces
reports in multiple formats.

## Running the profiler

```sh
wile profile program.scm
```

## Output formats

Specify the format with `--format`:

### Text (default)

```sh
wile profile program.scm --format text
```

Prints a flat table to stderr sorted by self-time, with columns for self%,
total time, self time, call count, procedure name, and source location.

### Flame graph

```sh
wile profile program.scm --format flamegraph > profile.svg
```

Produces a self-contained SVG with embedded JavaScript for interactive
exploration. Open it in a browser to click and zoom into hot call stacks.

### Chrome trace

```sh
wile profile program.scm --format trace > profile.json
```

Produces Chrome Trace Event JSON format. Load it in `chrome://tracing` or
[Perfetto](https://ui.perfetto.dev) for time-series analysis.

## Metrics

For each procedure, the profiler tracks:

| Metric | Description |
|--------|-------------|
| **call_count** | Number of invocations |
| **total_time** | Wall-clock seconds including time in callees |
| **self_time** | Wall-clock seconds excluding time in callees |

## Typical workflow

1. Run with `--format text` to identify the hottest procedures
2. Generate a flame graph to understand call-stack context
3. Optimize the hot path
4. Re-profile to confirm the improvement
