//! Ambient NPCs — one-line characters that give the district life.
//! No quest logic, no branching. Just flavor text. No raylib dependency.

const std = @import("std");
const Flag = @import("flags.zig").Flag;
const Flags = @import("flags.zig").Flags;
const time_mod = @import("time_of_day.zig");
const TimeOfDay = time_mod.TimeOfDay;

/// A background NPC that delivers a single line of flavor dialogue.
/// Ambient NPCs appear based on flag prerequisites and time-of-day windows.
pub const AmbientNpc = struct {
    name: []const u8,
    x: f32,
    y: f32,
    line: []const u8,
    size: f32 = 14,
    requires: Flag = .none,
    min_time: TimeOfDay = .morning,
    max_time: TimeOfDay = .evening,

    /// Returns true if this NPC should be shown, based on the player's current flags and time of day.
    pub fn isVisible(self: *const AmbientNpc, flags: *const Flags, time: TimeOfDay) bool {
        const flag_ok = self.requires == .none or flags.has(self.requires);
        const time_ok = @intFromEnum(time) >= @intFromEnum(self.min_time) and
            @intFromEnum(time) <= @intFromEnum(self.max_time);
        return flag_ok and time_ok;
    }
};

const interaction_radius: f32 = 40.0;

/// Finds the index of the closest visible ambient NPC within interaction radius, or null if none.
pub fn findNearby(npcs: []const AmbientNpc, px: f32, py: f32, flags: *const Flags, time: TimeOfDay) ?usize {
    var closest_dist: f32 = interaction_radius;
    var closest_idx: ?usize = null;

    for (npcs, 0..) |*npc, i| {
        if (!npc.isVisible(flags, time)) continue;
        const dx = npc.x - px;
        const dy = npc.y - py;
        const dist = @sqrt(dx * dx + dy * dy);
        if (dist < closest_dist) {
            closest_dist = dist;
            closest_idx = i;
        }
    }

    return closest_idx;
}

// ============================================================
// Ambient NPC placements
// ============================================================

/// All ambient NPC placements for the Portico Quarter district.
pub const district_ambient = [_]AmbientNpc{
    // Market street
    .{ .name = "Fish Seller", .x = 300, .y = 530, .line = "Fresh from the harbor! Best mackerel in the quarter!", .max_time = .dusk },
    .{ .name = "Cloth Buyer", .x = 500, .y = 560, .line = "This weave is not worth half what he asks. I will try the next stall." },
    .{ .name = "Old Merchant", .x = 650, .y = 520, .line = "Trade has slowed since the new tariffs. Everyone feels it." },
    .{ .name = "Woman at Basin", .x = 380, .y = 580, .line = "The water is clean today, at least. Small mercies." },

    // Church courtyard area
    .{ .name = "Elderly Man", .x = 950, .y = 650, .line = "I have worshipped in this courtyard for forty years. The stones know my knees.", .requires = .spoke_to_theophilos },
    .{ .name = "Acolyte", .x = 1020, .y = 640, .line = "Father Theophilos says the vigil tonight will be beautiful. I must prepare the lamps.", .requires = .spoke_to_theophilos },
    .{ .name = "Young Mother", .x = 1120, .y = 920, .line = "My son asks me every day when the feast is. Children live for feasts.", .requires = .spoke_to_anna },

    // Residential lane
    .{ .name = "Neighbor Woman", .x = 750, .y = 300, .line = "Helena is a good woman. She does not complain, but we all know she struggles.", .requires = .spoke_to_anna },
    .{ .name = "Child", .x = 780, .y = 400, .line = "Are you a new person? I have not seen you before. Do you know any stories?", .requires = .spoke_to_theophilos },
    .{ .name = "Laborer", .x = 720, .y = 480, .line = "Carrying plaster up three flights. My back remembers every step." },

    // Harbor / loading court area
    .{ .name = "Dockworker", .x = 1550, .y = 1150, .line = "Another shipment of amphorae. Wine from Chios, I think. Or vinegar — hard to tell until they open.", .requires = .spoke_to_anna },
    .{ .name = "Sailor", .x = 300, .y = 1430, .line = "Constantinople from the sea is something else. The walls, the domes... you never tire of it." },
    .{ .name = "Boy with Bread", .x = 1650, .y = 1250, .line = "Delivery for the overseer! Make way!", .requires = .spoke_to_anna },

    // Paths and connectors
    .{ .name = "Seated Elder", .x = 870, .y = 700, .line = "Slow down, young one. The city is not going anywhere. But you might miss what is right in front of you." },
    .{ .name = "Sweeping Woman", .x = 860, .y = 400, .line = "Dust and more dust. The Lord said we come from dust, and this street proves it every morning." },

    // Evening-only NPCs
    .{ .name = "Lamp Lighter", .x = 900, .y = 550, .line = "The lamps must be ready before the vigil. Every one matters tonight.", .min_time = .dusk, .requires = .spoke_to_anna },
    .{ .name = "Chanter", .x = 1000, .y = 680, .line = "Lord have mercy. Lord have mercy. Lord have mercy.", .min_time = .evening, .requires = .first_instruction_done },
};

// --- Tests ---

const expect = std.testing.expect;

test "ambient npc visibility with flags" {
    const flags = Flags{};
    // Fish seller has no flag requirement
    try expect(district_ambient[0].isVisible(&flags, .morning));
    // Elderly man requires spoke_to_theophilos
    try expect(!district_ambient[4].isVisible(&flags, .morning));
}

test "ambient npc time filtering" {
    const flags = Flags{};
    // Fish seller only until dusk
    try expect(district_ambient[0].isVisible(&flags, .morning));
    try expect(district_ambient[0].isVisible(&flags, .dusk));
    try expect(!district_ambient[0].isVisible(&flags, .evening));
}

test "find nearby ambient npc" {
    const flags = Flags{};
    const idx = findNearby(&district_ambient, 300, 530, &flags, .morning);
    try expect(idx != null);
    try std.testing.expectEqualStrings("Fish Seller", district_ambient[idx.?].name);
}

test "evening npcs only appear at night" {
    var flags = Flags{};
    flags.grant(.first_instruction_done);
    // Chanter is min_time = .evening
    const chanter = district_ambient[district_ambient.len - 1];
    try expect(!chanter.isVisible(&flags, .afternoon));
    try expect(chanter.isVisible(&flags, .evening));
}
