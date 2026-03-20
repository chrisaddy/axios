# Axios MVP Design Doc

## Purpose of the MVP

The Axios MVP is a polished vertical slice that proves three things:
1. Constantinople is a compelling game setting.
2. The exploration-dialogue-quest loop is genuinely enjoyable.
3. Orthodox formation can emerge naturally through play rather than exposition.

Target playtime:
- 20 to 40 minutes for a first playthrough

Primary player fantasy:
- You are a catechumen attached to a Christian community in 4th-century Constantinople.
- You move through a living district, meet clergy and laypeople, help solve local problems, and begin to understand the life of the Church through service, discernment, and participation.

## MVP boundaries

The MVP is not:
- an open world
- a combat-driven RPG
- a full historical sim
- a giant branching narrative
- a complete catechetical curriculum

The MVP is:
- one district
- one church-centered community
- a small cast of memorable NPCs
- three interconnected main quests
- a handful of side interactions
- one culminating feast or vigil event
- one clear loop of instruction, action, consequence, and reflection

## High-level player loop

1. Receive instruction from a mentor or community figure.
2. Explore the district and speak with inhabitants.
3. Gather information through observation, dialogue, and small acts of service.
4. Resolve a local problem through discernment and choice.
5. Return to the church community for reflection and progression.
6. See how your actions shape the final communal event.

## MVP district

Working district concept:
The Portico Quarter

This is a compact district near a church complex, a market street, residential lanes, and a harbor-facing edge. It should feel plausible as a mixed social space where clergy, laborers, merchants, widows, and catechumens all cross paths.

### District goals
The district must communicate:
- sacred life at the center of a neighborhood
- social difference without enormous scale
- everyday commerce and hardship
- enough visual and narrative density to imply a much larger city beyond the slice

### District sub-areas

1. Church Courtyard
   - central hub
   - quest handoff and return space
   - atmosphere of dusk prayer, teaching, and local gathering

2. Narthex / Church Threshold
   - not a full liturgical simulation in MVP
   - enough access to establish reverence and interior sacred light
   - used for reflection beats and final event staging

3. Market Street
   - bustling daytime quest zone
   - merchants, deliveries, public rumor, social friction

4. Residential Lane
   - narrower, quieter, more intimate
   - homes, courtyards, domestic interactions, side conversations

5. Widow's House / Charitable House
   - emotionally important interior location
   - tied to mercy, scarcity, and trust

6. Harbor Edge or Loading Court
   - connection to trade, labor, and the wider city
   - useful for delivery, investigation, and atmosphere

7. Small Side Passage / Shortcut
   - unlocked or discovered through exploration
   - gives the district a sense of learnable spatial intimacy

## Core cast

The MVP should have around 8-10 named NPCs and additional ambient NPCs.

### 1. Father Theophilos
Role:
- priest or catechist mentor

Function:
- gives instruction
- interprets player actions afterward
- frames the catechumen journey without over-explaining everything

Tone:
- warm, serious, perceptive
- neither sentimental nor severe

### 2. Deaconess Olympias-inspired figure: Anna
Role:
- charitable worker and organizer attached to the church

Function:
- introduces mercy-centered tasks
- connects the church to households in need
- practical, efficient, spiritually grounded

Tone:
- composed, intelligent, quietly formidable

### 3. Markos
Role:
- merchant dealing in oil, cloth, or staples

Function:
- morally ambiguous quest figure
- not a cartoon villain; under pressure, rationalizing compromises

Tone:
- personable, defensive, worldly

### 4. Helena
Role:
- widow in need, or caretaker within a struggling household

Function:
- emotional anchor for mercy questline
- reveals the cost of neglect and the dignity of the poor

Tone:
- restrained, dignified, perceptive

### 5. Stephanos
Role:
- another catechumen, slightly ahead or behind the player

Function:
- peer contrast
- can be eager, anxious, proud, or sincere depending on writing direction
- helps externalize the catechumen experience

Tone:
- earnest, flawed, relatable

### 6. Diodoros
Role:
- porter, dock worker, or delivery hand

Function:
- links market and harbor spaces
- useful witness in investigation quests
- represents laboring life in the district

Tone:
- blunt, practical, observant

### 7. Kyria Irene
Role:
- older neighborhood woman / informal keeper of local memory

Function:
- side quest giver
- source of rumor, correction, and social texture
- can either clarify or complicate what the player thinks is true

Tone:
- sharp, affectionate, impossible to fool entirely

### 8. Leontios
Role:
- local educated man, clerk, or rhetorically confident troublemaker

Function:
- tied to the rumor/discernment quest
- not necessarily a formal heretic, but someone who spreads confusion, pride, or half-understood claims

Tone:
- articulate, vain, plausible

### 9. Minor clergy / chanter / acolyte
Role:
- support church scenes and final vigil atmosphere

Function:
- ambient sacred life
- practical instructions and ceremonial atmosphere

### 10. Ambient district NPCs
Examples:
- fish seller
- child messenger
- cloth buyer
- elderly man seated in shade
- laborer carrying amphorae
- woman at basin

These create density and can deliver one-line world texture.

## Player identity and progression

The player character is a catechumen, new enough to need instruction, but trusted enough to be sent on useful errands and acts of service.

The player has no combat kit in the MVP.

Primary progression dimensions for MVP:
- Mercy
- Truth
- Humility
- Courage
- Faithfulness

These should be light-touch, not heavy RPG stats.

### How progression works in MVP
- Dialogue choices, quest resolutions, and optional acts influence these five dimensions.
- Values unlock alternate lines, mentor responses, and slight quest variations.
- The final vigil scene reflects some of the player's formed tendencies.

For MVP, these can remain mostly hidden or softly surfaced through journal language rather than explicit numeric bars.

## Core systems in MVP

### 1. Exploration system
Requirements:
- player movement
- readable interaction prompts
- scene transitions between district sub-areas
- a sense of spatial cohesion and small discoverable shortcuts

Success criteria:
- the district becomes familiar by the end of the slice
- the player remembers places in relation to people and tasks

### 2. Dialogue system
Requirements:
- branching dialogue choices
- quest gating through conversation
- support for tone differences and simple consequence tracking
- portraits for key NPCs if possible

Success criteria:
- conversations feel authored and meaningful rather than purely transactional

### 3. Quest system
Requirements:
- quest acceptance
- state tracking
- objective updates
- simple branching resolutions
- final-state consequences reflected in later scenes

Success criteria:
- the three main quests clearly chain into one another
- player choices alter lines, access, or final tone

### 4. Journal / codex system
Requirements:
- quest log
- notable people and places list
- unlocked terms or concepts discovered in context

Examples of unlocked entries:
- catechumen
- vigil
- almsgiving
- narthex

Success criteria:
- supports learning through context without turning into a glossary dump

### 5. Time-of-day progression
Requirements:
- at minimum: day to dusk to evening progression
- certain NPCs move or become available at different times
- final vigil occurs at a clear culminating time

Success criteria:
- time progression gives emotional shape to the slice

### 6. Formation tracking
Requirements:
- lightweight internal flags or scores tied to virtues
- mentor reflections and ending beats react to them

Success criteria:
- player feels morally and spiritually observed, not just mechanically scored

## Main questline

The three main quests should feel like one unfolding experience, not isolated errands.

### Main Quest 1: First Instruction

Purpose:
- teach movement, dialogue, hub structure, and basic social context
- establish the player as a catechumen in a church-centered neighborhood

Setup:
Father Theophilos or Anna gives the player a first set of small tasks before the evening gathering.

Objectives may include:
- deliver a message to Anna in the courtyard or market
- bring a small item such as lamp oil, bread, or cloth to a household
- speak to Stephanos or another catechumen near the church
- return with a report

What the quest teaches:
- where the church is in relation to daily life
- how the district is laid out
- that Christian life in the city is social and practical, not abstract

Choice opportunities:
- how respectfully or impatiently the player speaks
- whether the player notices and helps with a tiny optional act on the way
- whether the player asks questions from curiosity or pride

Outcome:
- the player earns a first measure of trust
- the next quest emerges organically through mention of an unmet need

### Main Quest 2: The Widow's Oil

Purpose:
- prove the game can deliver moral and social depth through a local issue
- center mercy, truth, and practical justice

Setup:
Anna tells the player that Helena, a widow tied to the church community, has not received oil that had been promised or expected.

The apparent problem:
- a missing delivery

The real problem:
- supply pressure, corner-cutting, excuses, competing loyalties, and the quiet invisibility of the poor

Quest flow:
1. Visit Helena and understand the need directly.
2. Investigate by speaking with Markos, Diodoros, and perhaps another witness.
3. Learn that the issue is not simple theft, but compromised priorities and rationalization.
4. Decide how to resolve it.

Possible player resolutions:
- confront Markos directly and demand honesty
- appeal to his conscience through Anna or the church's trust
- cover the gap personally through collected aid from several people
- choose a partial fix that solves the immediate problem but leaves the deeper issue unaddressed

Formation implications:
- Mercy: helping Helena materially and attentively
- Truth: naming dishonesty clearly
- Humility: listening before accusing
- Courage: confronting a socially stronger figure
- Faithfulness: understanding care for the vulnerable as part of Christian life

Outcome possibilities:
- Helena receives oil and expresses gratitude, caution, or both
- Markos becomes defensive, repentant, evasive, or pragmatically cooperative
- Anna and Theophilos later interpret what the player did, not just whether the practical problem was solved

### Main Quest 3: A False Rumor

Purpose:
- introduce discernment and the danger of confused speech
- show that truth in the city is social, theological, and personal

Setup:
A rumor begins circulating in the district. It may involve:
- a distorted claim about Christian teaching
- slander involving a local cleric or charitable distribution
- a half-understood theological boast repeated by Leontios

Recommended MVP version:
The rumor is partly theological and partly social, so the player must evaluate both doctrine and motive.

Quest flow:
1. Hear conflicting versions of the rumor.
2. Speak with Kyria Irene, Stephanos, Leontios, and one clergy-connected figure.
3. Notice how pride, insecurity, grievance, and careless speech distort truth.
4. Decide how to respond.

Possible player approaches:
- public correction
- private confrontation
- reporting to mentor without directly intervening
- trying to reconcile parties and stop escalation

What the quest teaches:
- discernment is more than being factually right
- truth spoken wrongly can still wound
- right teaching belongs to life in community, not private cleverness alone

Outcome possibilities:
- tension is calmed quietly
- the rumor is publicly exposed but leaves resentment
- the player acts too harshly or too timidly and receives correction
- trust is strengthened with some characters and weakened with others

## Culminating event: The Vigil

Purpose:
- provide payoff through community, atmosphere, and reflection rather than spectacle
- gather the emotional and thematic threads of the slice

Setup:
As evening deepens, the district prepares for a vigil or feast-adjacent church gathering.

What changes based on player actions:
- which NPCs appear in the courtyard or threshold
- whether Helena attends or sends word
- how Markos behaves toward the player and community
- whether Stephanos is encouraged, ashamed, inspired, or confused
- what Father Theophilos says about the player's progress
- whether the atmosphere feels reconciled, fragile, or quietly hopeful

What the scene contains:
- lamps lit in the courtyard and church threshold
- gathered townspeople and clergy
- short reflective dialogue
- perhaps a brief non-interactive or lightly interactive sacred moment
- journal update indicating the player has taken a first real step in catechumen life

Victory condition for the MVP:
The player should leave wanting to return to the city, see more districts, and continue the path toward baptism.

## Side content

The MVP can include 3-5 side interactions. These should be compact but meaningful.

Possible side moments:
- help a child deliver bread or recover a dropped item
- ask an older woman about a district landmark and unlock a codex note
- choose whether to give time to someone speaking at length when in a hurry
- find a shortcut through a service alley or courtyard
- notice a symbol in the church area and ask about it later

Rules for side content:
- short
- thematically aligned
- no filler collecting
- ideally each reveals either place, doctrine, or character

## Journal and codex structure

The MVP journal should contain three tabs or sections:

1. Tasks
   - active quest
   - completed quest summaries

2. People and Places
   - unlocked names with one or two sentence descriptions

3. Notes
   - terms or concepts learned in context

Important rule:
Terms should unlock because the player encountered them naturally, not because the game wants to teach a lesson in the abstract.

## Scene-by-scene MVP flow

### Scene 1: Arrival in the Courtyard
- player gains control
- meets mentor figure
- receives first instruction
- introduced to movement and first interaction

### Scene 2: First Errands Through Market and Lane
- learns district layout
- meets first layer of NPCs
- completes basic tasks
- optional side interactions available

### Scene 3: Discovery of the Widow's Need
- shift from simple errand to meaningful service
- visits Helena
- emotional grounding of the slice deepens

### Scene 4: Investigation Across Market and Harbor Edge
- gather accounts
- talk to Markos, Diodoros, and others
- choose how to resolve the issue

### Scene 5: Rumor Emerges
- district social tension rises
- player tracks conflicting accounts
- must act with discernment

### Scene 6: Return and Reflection
- mentor interprets what has happened
- time advances toward evening
- final event is prepared

### Scene 7: Vigil / Feast Gathering
- community payoff
- visible consequences of choices
- thematic closure with openness toward future chapters

## MVP success checklist

The MVP succeeds if playtesters say things like:
- I want to keep exploring this city.
- The world felt different from other games.
- I learned things naturally without feeling lectured.
- The characters felt human.
- My choices felt morally meaningful even without combat.
- The church scenes felt beautiful and grounded.

The MVP fails if playtesters say things like:
- it felt like errands without drama
- it felt preachy
- the city felt empty
- I couldn't tell what made the setting special
- there was no real consequence to choices
- it felt like an educational app instead of a game

## Production priorities

If scope gets tight, preserve these in order:
1. church courtyard hub atmosphere
2. strong writing for the main cast
3. widow's oil quest quality
4. final vigil payoff
5. market readability and density
6. codex/journal polish
7. side content quantity

## Recommended next documents

After this MVP doc, create:
- docs/quest-outline.md
- docs/npc-bible.md
- docs/world-lore-boundaries.md
- docs/technical-architecture.md
- docs/website-plan.md
