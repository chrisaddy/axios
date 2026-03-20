// Time-of-day system. Advances based on quest progress, not real time.
// No raylib dependency.

const std = @import("std");
const Flag = @import("flags.zig").Flag;
const Flags = @import("flags.zig").Flags;

pub const TimeOfDay = enum {
    morning,
    afternoon,
    dusk,
    evening,

    pub fn label(self: TimeOfDay) []const u8 {
        return switch (self) {
            .morning => "Morning",
            .afternoon => "Afternoon",
            .dusk => "Dusk",
            .evening => "Evening",
        };
    }

    // RGBA tint overlay for the scene
    pub fn tintR(self: TimeOfDay) u8 {
        return switch (self) {
            .morning => 0,
            .afternoon => 0,
            .dusk => 40,
            .evening => 20,
        };
    }
    pub fn tintG(self: TimeOfDay) u8 {
        return switch (self) {
            .morning => 0,
            .afternoon => 0,
            .dusk => 15,
            .evening => 10,
        };
    }
    pub fn tintB(self: TimeOfDay) u8 {
        return switch (self) {
            .morning => 0,
            .afternoon => 0,
            .dusk => 0,
            .evening => 30,
        };
    }
    pub fn tintA(self: TimeOfDay) u8 {
        return switch (self) {
            .morning => 0,
            .afternoon => 0,
            .dusk => 60,
            .evening => 90,
        };
    }
};

// Time advances based on quest milestones, not a clock.
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
