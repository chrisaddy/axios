// Journal / codex system. Pure data, no raylib dependency.
// Tracks quest log, people met, and terms learned.

const std = @import("std");
const Flags = @import("flags.zig").Flags;
const Flag = @import("flags.zig").Flag;
const QuestLog = @import("quest.zig").QuestLog;
const QuestId = @import("quest.zig").QuestId;

pub const Tab = enum {
    quests,
    people,
    codex,
};

pub const PersonEntry = struct {
    name: []const u8,
    description: []const u8,
    requires: Flag,
};

pub const CodexEntry = struct {
    term: []const u8,
    definition: []const u8,
    requires: Flag,
};

pub const people_entries = [_]PersonEntry{
    .{ .name = "Father Theophilos", .description = "Priest and catechist at the parish church. Warm, serious, perceptive.", .requires = .spoke_to_theophilos },
    .{ .name = "Anna", .description = "Deaconess who organizes charitable work. Composed, intelligent, quietly formidable.", .requires = .spoke_to_anna },
    .{ .name = "Stephanos", .description = "Fellow catechumen. Earnest, flawed, relatable.", .requires = .spoke_to_stephanos },
    .{ .name = "Markos", .description = "Oil merchant at the market. Personable, defensive, worldly.", .requires = .spoke_to_markos },
    .{ .name = "Helena", .description = "A widow in the residential lane. Restrained, dignified, perceptive.", .requires = .spoke_to_helena },
    .{ .name = "Diodoros", .description = "Porter at the loading court. Blunt, practical, observant.", .requires = .spoke_to_diodoros },
};

pub const codex_entries = [_]CodexEntry{
    .{ .term = "Catechumen", .definition = "One preparing for baptism through instruction, prayer, and moral formation.", .requires = .spoke_to_theophilos },
    .{ .term = "Deaconess", .definition = "A woman ordained to serve the church through charitable work and ministry.", .requires = .spoke_to_anna },
    .{ .term = "Almsgiving", .definition = "Giving to those in need as an act of mercy and faithfulness.", .requires = .spoke_to_helena },
    .{ .term = "Vigil", .definition = "An evening prayer service of watching and preparation.", .requires = .first_instruction_done },
    .{ .term = "Narthex", .definition = "The entrance hall of a church, where catechumens gather before baptism.", .requires = .spoke_to_theophilos },
    .{ .term = "Discernment", .definition = "The practice of distinguishing truth from falsehood, wisdom from cleverness.", .requires = .spoke_to_stephanos },
};

pub const JournalState = struct {
    open: bool = false,
    tab: Tab = .quests,

    pub fn toggle(self: *JournalState) void {
        self.open = !self.open;
    }

    pub fn nextTab(self: *JournalState) void {
        self.tab = switch (self.tab) {
            .quests => .people,
            .people => .codex,
            .codex => .quests,
        };
    }

    pub fn prevTab(self: *JournalState) void {
        self.tab = switch (self.tab) {
            .quests => .codex,
            .people => .quests,
            .codex => .people,
        };
    }
};

pub fn countVisiblePeople(flags: *const Flags) u8 {
    var count: u8 = 0;
    for (people_entries) |entry| {
        if (flags.has(entry.requires)) count += 1;
    }
    return count;
}

pub fn countVisibleCodex(flags: *const Flags) u8 {
    var count: u8 = 0;
    for (codex_entries) |entry| {
        if (flags.has(entry.requires)) count += 1;
    }
    return count;
}

// --- Tests ---

const expect = std.testing.expect;

test "no people visible at start" {
    const flags = Flags{};
    try expect(countVisiblePeople(&flags) == 0);
}

test "people visible after flags" {
    var flags = Flags{};
    flags.grant(.spoke_to_theophilos);
    flags.grant(.spoke_to_anna);
    try expect(countVisiblePeople(&flags) == 2);
}

test "codex entries unlock" {
    var flags = Flags{};
    try expect(countVisibleCodex(&flags) == 0);
    flags.grant(.spoke_to_theophilos);
    try expect(countVisibleCodex(&flags) >= 1);
}

test "journal tab cycling" {
    var j = JournalState{};
    try expect(j.tab == .quests);
    j.nextTab();
    try expect(j.tab == .people);
    j.nextTab();
    try expect(j.tab == .codex);
    j.nextTab();
    try expect(j.tab == .quests);
    j.prevTab();
    try expect(j.tab == .codex);
}
