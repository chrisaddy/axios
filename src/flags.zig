//! Game progression flags. Tracks what the player has unlocked through dialogue and quests.

const std = @import("std");

/// Named progression flags representing dialogue milestones, quest states, and knowledge gained.
pub const Flag = enum(u8) {
    none = 0,
    spoke_to_theophilos,
    spoke_to_anna,
    spoke_to_helena,
    spoke_to_markos,
    spoke_to_stephanos,
    spoke_to_diodoros,
    knows_about_oil,
    // Widow's Oil resolution paths
    oil_confronted_markos,
    oil_appealed_markos,
    oil_covered_gap,
    oil_resolved,
    // Quest completion
    first_instruction_done,
    widows_oil_done,
    // Vigil
    vigil_triggered,
    _,
};

const max_flags = 32;

/// A fixed-size boolean array that stores which progression flags have been granted.
pub const Flags = struct {
    set: [max_flags]bool = [_]bool{false} ** max_flags,

    /// Returns true if the given flag has been granted.
    pub fn has(self: *const Flags, flag: Flag) bool {
        const idx = @intFromEnum(flag);
        if (idx >= max_flags) return false;
        return self.set[idx];
    }

    /// Grants (sets to true) the given flag.
    pub fn grant(self: *Flags, flag: Flag) void {
        const idx = @intFromEnum(flag);
        if (idx >= max_flags) return;
        self.set[idx] = true;
    }

    /// Resets all flags to false.
    pub fn reset(self: *Flags) void {
        self.set = [_]bool{false} ** max_flags;
    }
};

// --- Tests ---

const expect = std.testing.expect;

test "flags default to false" {
    const f = Flags{};
    try expect(!f.has(.spoke_to_theophilos));
    try expect(!f.has(.spoke_to_anna));
}

test "grant and check flag" {
    var f = Flags{};
    f.grant(.spoke_to_theophilos);
    try expect(f.has(.spoke_to_theophilos));
    try expect(!f.has(.spoke_to_anna));
}

test "reset clears all flags" {
    var f = Flags{};
    f.grant(.spoke_to_theophilos);
    f.grant(.spoke_to_anna);
    f.reset();
    try expect(!f.has(.spoke_to_theophilos));
    try expect(!f.has(.spoke_to_anna));
}
