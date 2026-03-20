# Axios

Historical spiritual adventure game set in 4th-century Constantinople, written in Zig.

## Build

All builds, tests, and deployments go through devenv.

```
devenv tasks run axios:build      # Build
devenv tasks run axios:test       # Run tests
devenv tasks run axios:run        # Build and run
devenv tasks run axios:release    # Optimized release build
devenv tasks run axios:clean      # Remove build artifacts
```

## Tech stack

- Zig 0.16.0-dev (managed via zigup, NOT nixpkgs)
- raylib (C library, linked via Zig build system)
- Steamworks SDK (optional, `-Dsteam=true`)
- devenv for all tooling

## Project structure

```
src/
  main.zig          - Entry point, raylib window, input reading
  game_state.zig    - Pure game state machine (no raylib)
  player.zig        - Pure player logic (no raylib)
  save.zig          - Save/load to disk (binary format)
  render.zig        - All raylib rendering
  raylib.zig        - Shared @cImport for raylib
  steam.zig         - Steamworks wrapper (compile-time optional)
  tests.zig         - Test entry point for pure logic modules
```

## Architecture

Game logic is separated from rendering. `player.zig`, `game_state.zig`, and `save.zig` have zero raylib dependency and are fully unit-testable. `render.zig` and `main.zig` are the only files that touch raylib.

## Workflow

Commit and push after all changes to keep git in a constantly-updated state.
