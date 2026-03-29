//! Time-of-day system. Advances based on quest progress, not real time.
//! No raylib dependency.

const std = @import("std");
const Flag = @import("flags.zig").Flag;
const Flags = @import("flags.zig").Flags;

/// Represents the current period of the day. The game world transitions through
/// these periods as the player completes quest milestones.
pub const TimeOfDay = enum {
    morning,
    afternoon,
    dusk,
    evening,

    /// Returns the human-readable display name for this time of day.
    pub fn label(self: TimeOfDay) []const u8 {
        return switch (self) {
            .morning => "Morning",
            .afternoon => "Afternoon",
            .dusk => "Dusk",
            .evening => "Evening",
        };
    }

    /// Returns the red component of the scene tint overlay for this time of day.
    pub fn tintR(self: TimeOfDay) u8 {
        return switch (self) {
            .morning => 0,
            .afternoon => 0,
            .dusk => 40,
            .evening => 20,
        };
    }
    /// Returns the green component of the scene tint overlay for this time of day.
    pub fn tintG(self: TimeOfDay) u8 {
        return switch (self) {
            .morning => 0,
            .afternoon => 0,
            .dusk => 15,
            .evening => 10,
        };
    }
    /// Returns the blue component of the scene tint overlay for this time of day.
    pub fn tintB(self: TimeOfDay) u8 {
        return switch (self) {
            .morning => 0,
            .afternoon => 0,
            .dusk => 0,
            .evening => 30,
        };
    }
    /// Returns the alpha component of the scene tint overlay for this time of day.
    pub fn tintA(self: TimeOfDay) u8 {
        return switch (self) {
            .morning => 0,
            .afternoon => 0,
            .dusk => 60,
            .evening => 90,
        };
    }
};

/// Derives the current time of day from quest milestone flags.
/// Time advances based on quest milestones, not a real-time clock.
pub fn computeTimeOfDay(flags: *const Flags) TimeOfDay {
    if (flags.has(.oil_resolved)) return .evening;
    if (flags.has(.widows_oil_done)) return .evening;
    if (flags.has(.spoke_to_diodoros) or flags.has(.spoke_to_markos)) return .dusk;
    if (flags.has(.spoke_to_anna)) return .afternoon;
    return .morning;
}

// --- Tests ---

const expect = std.testing.expect;
const expectEqualStrings = std.testing.expectEqualStrings;

test "morning at start" {
    const flags = Flags{};
    try expect(computeTimeOfDay(&flags) == .morning);
}

test "afternoon after anna" {
    var flags = Flags{};
    flags.grant(.spoke_to_anna);
    try expect(computeTimeOfDay(&flags) == .afternoon);
}

test "dusk during investigation" {
    var flags = Flags{};
    flags.grant(.spoke_to_anna);
    flags.grant(.spoke_to_markos);
    try expect(computeTimeOfDay(&flags) == .dusk);
}

test "evening after resolution" {
    var flags = Flags{};
    flags.grant(.oil_resolved);
    try expect(computeTimeOfDay(&flags) == .evening);
}

test "time label" {
    try expectEqualStrings("Morning", TimeOfDay.morning.label());
    try expectEqualStrings("Evening", TimeOfDay.evening.label());
}
