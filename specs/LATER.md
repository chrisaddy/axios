# Later

Items to address after the MVP vertical slice is working.

## Dialogue / NPC system
- NPC dialogue selector: pick different dialogue based on flags/quest state
- Conditional dialogue nodes: show/hide choices based on flags
- Multiple dialogues per NPC (before/after quest events)

## Quest system
- Named quests with stage enums (not just boolean flags)
- Quest log UI
- Quest resolution branching with consequences

## Flags / progression
- Switch from fixed 32-bool array to dynamic bitset when flag count grows
- Flag enum auto-generation or data-driven flags

## Save system
- Multiple save slots
- Save metadata (timestamp, playtime, location name)

## Rendering
- Sprite/texture support for NPCs and player (replace rectangles)
- Tile-based map rendering
- Lighting / time-of-day visuals

## Audio
- Ambient district sounds
- Dialogue sound cues
- Music for title, gameplay, vigil

## Steam
- Achievements tied to quest/formation milestones
- Cloud saves
- Store page assets
