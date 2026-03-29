//! The Vigil — culminating scene of the MVP vertical slice.
//! A sequence of text beats reflecting the player's journey. No raylib dependency.

const std = @import("std");
const Flags = @import("flags.zig").Flags;
const Formation = @import("formation.zig").Formation;
const Virtue = @import("formation.zig").Virtue;

/// A single narrative moment in the vigil sequence, optionally attributed to a speaker.
pub const Beat = struct {
    speaker: []const u8,
    text: []const u8,
};

const max_beats = 16;

/// Tracks progression through the vigil's sequence of narrative beats.
pub const VigilState = struct {
    beats: [max_beats]Beat = undefined,
    beat_count: u8 = 0,
    current_beat: u8 = 0,
    active: bool = false,

    /// Returns the current beat, or null if the vigil is inactive or has ended.
    pub fn currentBeat(self: *const VigilState) ?*const Beat {
        if (!self.active or self.current_beat >= self.beat_count) return null;
        return &self.beats[self.current_beat];
    }

    /// Advances to the next beat. Returns true if the vigil has ended.
    pub fn advance(self: *VigilState) bool {
        if (self.current_beat + 1 >= self.beat_count) {
            self.active = false;
            return true; // vigil ended
        }
        self.current_beat += 1;
        return false;
    }
};

fn addBeat(state: *VigilState, speaker: []const u8, text: []const u8) void {
    if (state.beat_count < max_beats) {
        state.beats[state.beat_count] = .{ .speaker = speaker, .text = text };
        state.beat_count += 1;
    }
}

/// Constructs the vigil scene by assembling beats that reflect the player's
/// choices, quest outcomes, and dominant virtue.
pub fn buildVigil(flags: *const Flags, formation: *const Formation) VigilState {
    var state = VigilState{};
    state.active = true;

    // Opening
    addBeat(&state, "", "The evening deepens over the Portico Quarter. Lamps are lit in the church courtyard. The people gather.");

    // Helena's presence
    if (flags.has(.oil_resolved)) {
        addBeat(&state, "", "Helena arrives with her daughter, a small lamp burning in her hands. She finds a place near the entrance and kneels.");
    } else {
        addBeat(&state, "", "Helena's place in the courtyard is empty. Word came that she could not attend tonight.");
    }

    // Markos
    if (flags.has(.oil_appealed_markos)) {
        addBeat(&state, "", "Markos stands at the edge of the courtyard, uncertain but present. He catches your eye and nods, almost imperceptibly.");
    } else if (flags.has(.oil_confronted_markos)) {
        addBeat(&state, "", "Markos is not here. But a boy arrives carrying a jar of oil for the church lamps, with Markos's mark on it.");
    } else if (flags.has(.oil_covered_gap)) {
        addBeat(&state, "", "Markos stands near the back, head bowed. Something has changed in his bearing.");
    }

    // Stephanos
    if (flags.has(.spoke_to_stephanos)) {
        addBeat(&state, "Stephanos", "I am glad you are here. I was afraid I would be the only catechumen tonight.");
    }

    // Theophilos reflection based on dominant virtue
    const dominant = formation.dominant();
    if (dominant) |v| {
        switch (v) {
            .mercy => addBeat(&state, "Father Theophilos", "You have shown mercy in this quarter. The poor remember those who see them. That is the beginning of a life in Christ."),
            .truth => addBeat(&state, "Father Theophilos", "You have pursued truth, even when it was uncomfortable. A catechumen who loves truth will not be easily deceived."),
            .humility => addBeat(&state, "Father Theophilos", "You have walked humbly among these people. Humility is not weakness -- it is the strength to listen before speaking."),
            .courage => addBeat(&state, "Father Theophilos", "You have shown courage today. To speak justly to the powerful is not cruelty -- it is love in its most demanding form."),
            .faithfulness => addBeat(&state, "Father Theophilos", "You have been faithful in small things. That is how God measures readiness -- not by spectacle, but by constancy."),
        }
    } else {
        addBeat(&state, "Father Theophilos", "You have taken your first steps in this quarter. There is much still to learn, but the journey has begun.");
    }

    // Sacred moment
    addBeat(&state, "", "The chanting begins, low and steady. Candlelight fills the narthex. For a moment, the quarter is still.");
    addBeat(&state, "", "You stand among the gathered faithful — merchants and widows, porters and catechumens — and for the first time, you feel that you belong here.");

    // Closing
    addBeat(&state, "Father Theophilos", "Axios. You are worthy of the next step. Come tomorrow, and we will continue.");
    addBeat(&state, "", "The vigil ends. The lamps burn low. Constantinople sleeps, and you carry something new within you.");
    addBeat(&state, "", "End of the Vertical Slice. Thank you for playing Axios.");

    return state;
}

// --- Tests ---

const expect = std.testing.expect;

test "vigil builds with resolved oil" {
    var flags = Flags{};
    flags.grant(.oil_resolved);
    flags.grant(.oil_appealed_markos);
    flags.grant(.spoke_to_stephanos);
    var formation = Formation{};
    formation.add(.mercy, 5);

    const v = buildVigil(&flags, &formation);
    try expect(v.active);
    try expect(v.beat_count > 5);
}

test "vigil advance and end" {
    var flags = Flags{};
    flags.grant(.oil_resolved);
    var formation = Formation{};

    var v = buildVigil(&flags, &formation);
    while (v.active) {
        _ = v.advance();
    }
    try expect(!v.active);
}

test "vigil without resolution" {
    const flags = Flags{};
    const formation = Formation{};
    const v = buildVigil(&flags, &formation);
    try expect(v.beat_count > 3);
}
