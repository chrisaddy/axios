# Axios Vision

Working title: Axios

## Core concept

Axios is a historical spiritual adventure set in 4th-century Constantinople during the age of Saint John Chrysostom. The player is a catechumen preparing for baptism, exploring the city, serving its people, learning the life of the Church, and facing moral and spiritual trials through quests shaped by history, community, and faith.

## Why this project exists

Most religious games teach by telling. Axios should teach by letting the player live inside a sacred world: to explore, to serve, to discern, and to be formed. It should not feel like a sermon with movement controls, nor like a generic adventure game with Orthodox paint. The goal is a real game first, with theology encountered through action, ritual, relationships, and consequence.

## Design pillars

1. Lived theology
   - The player learns through action, relationships, liturgy, service, and moral struggle.
   - Doctrine should emerge through play rather than exposition dumps or quizzes.

2. Historical immersion
   - Constantinople should feel specific, inhabited, and real.
   - The game should reflect the texture of late antique urban life: churches, markets, harbors, wealth, poverty, politics, feast days, and social tensions.

3. Meaningful exploration
   - The city is not just backdrop.
   - Discovery should reveal narrative, spiritual insight, practical opportunities, and new routes through the world.

4. Human-scale drama
   - The focus is on souls, households, neighborhoods, and communities before empire-level spectacle.
   - Stakes should feel personal, moral, and communal.

5. Beauty without sentimentality
   - The atmosphere should be reverent and luminous, but honest about injustice, temptation, grief, and conflict.

## Gameplay goals

Primary loop:
1. Receive guidance from a mentor, saintly figure, or local community member.
2. Explore a district of Constantinople.
3. Gather understanding through observation, conversation, and participation.
4. Resolve the situation through service, discernment, and choice.
5. Receive consequences in trust, access, and understanding.
6. Advance catechumen formation and unlock the next layer of the city.

Secondary formation loop:
- Hear teaching.
- Face a lived test.
- Make a choice.
- Experience consequences.
- Return for reflection and deeper instruction.

## Core systems

- Exploration across richly detailed districts of Constantinople.
- Branching dialogue and relationship-driven quest resolution.
- A catechumen formation progression model centered on virtues like mercy, truth, humility, courage, and faithfulness.
- Knowledge unlocks tied to scripture, symbols, liturgy, local customs, and doctrine.
- Light inventory built around meaningful objects rather than loot accumulation.
- Time and liturgical rhythm, initially in a simple form such as ordinary day vs feast day.

## Content principles

- Saints should be encountered with reverence and dramatic specificity.
- Quests should teach one spiritual truth, one historical truth, and one emotional truth.
- The game should avoid preachiness, grind, and generic fantasy conventions.
- Combat, if present at all, should be limited and carefully justified.

## MVP / vertical slice

The first playable slice should be a 20-40 minute experience set in one district of Constantinople.

It should include:
- one church complex
- one market street
- one residential alley or courtyard
- one harbor edge or forum edge
- one charitable house or widow's dwelling
- 3 main quests
- 3-5 side quests
- one culminating liturgical or feast event
- 15-25 NPCs
- a simple quest log, dialogue system, inventory, trust/formation tracking, and time-of-day progression

The MVP should prove three things:
1. the setting is compelling
2. the gameplay loop is fun
3. Orthodox formation can emerge naturally through play

## Early quest shape

Possible vertical-slice main quests:
- First Instruction: introductory errands, relationships, and player orientation
- The Widow's Oil: a mercy and honesty quest tied to poverty and commerce
- A False Rumor: a discernment quest about gossip, truth, and right teaching
- Feast Vigil: the culminating communal event whose tone and turnout reflect player choices

## Technology direction

Current preferred direction:
- Language: Zig
- Graphics/windowing: raylib (via Zig's C interop)
- Distribution: Steam (primary), itch.io (secondary)

## Product positioning

Short pitch:
Axios is a narrative historical adventure set in 4th-century Constantinople. You play a catechumen preparing for baptism in the age of Saint John Chrysostom, exploring the city, helping its people, learning the life of the Church, and facing moral and spiritual trials through quests shaped by history, community, and faith.

Even shorter pitch:
Become a catechumen in 4th-century Constantinople. Explore the Queen of Cities, serve its people, encounter saints, and prepare for baptism in a historical adventure shaped by Holy Orthodoxy.
