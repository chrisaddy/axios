# Axios

Historical spiritual adventure set in 4th-century Constantinople. You play a catechumen navigating the Portico Quarter on the day before your baptism — running errands, meeting the faithful, and discovering that mercy, truth, and courage are tested in ordinary encounters as much as in grand ones.

Built in Zig with raylib for rendering and an optional Steamworks integration.

## Prerequisites

- [devenv](https://devenv.sh) (manages the full toolchain)
- Zig 0.16.0-dev (installed automatically via zigup through devenv)
- raylib headers and library (linked via the Zig build system)
- Steamworks SDK (optional; pass `-Dsteam=true` to enable)

## Build and run

All builds, tests, and deployments go through devenv:

```
devenv tasks run axios:build      # Build the game
devenv tasks run axios:test       # Run the test suite
devenv tasks run axios:run        # Build and run
devenv tasks run axios:release    # Optimized release build
devenv tasks run axios:clean      # Remove build artifacts
```

## Architecture

Game logic is fully separated from rendering so that the core state machine is unit-testable without a GPU or window.

```
src/
  main.zig            Entry point — window, input loop, top-level update
  game_state.zig      Pure game state machine (no raylib)
  player.zig          Movement, bounds, facing direction (no raylib)
  quest.zig           Quest stages, objectives, and the quest log
  dialogue.zig        Dialogue tree state machine and effects
  npc.zig             NPC data, placement, dialogue selection
  ambient.zig         One-line ambient characters for atmosphere
  flags.zig           Boolean progression flags (who you've spoken to, etc.)
  formation.zig       Virtue tracking — mercy, truth, humility, courage, faithfulness
  journal.zig         In-game journal: quests, people, codex
  time_of_day.zig     Quest-driven time of day (morning -> evening)
  vigil.zig           Culminating vigil scene built from player choices
  save.zig            Binary save/load using C stdio
  render.zig          All raylib drawing (the only rendering module)
  textures.zig        Texture asset loading and lookup
  raylib.zig          Shared @cImport so every module uses one raylib binding
  steam.zig           Steamworks wrapper; stubs out when compiled without Steam
  tests.zig           Test entry point for pure logic modules
  test_quest_flow.zig End-to-end quest flow tests
```

## Contributing

1. Keep game logic free of raylib imports — only `render.zig`, `textures.zig`, and `main.zig` touch raylib.
2. Run `devenv tasks run axios:test` before pushing.
3. New gameplay systems should have unit tests in the same file.

See `docs/vision.md` for the current project vision, design pillars, gameplay loop, and MVP scope.
