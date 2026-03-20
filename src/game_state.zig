// Pure game state machine — no raylib dependency.

const std = @import("std");
const Player = @import("player.zig").Player;
const Bounds = @import("player.zig").Bounds;
const Input = @import("player.zig").Input;
const clamp = @import("player.zig").clamp;

pub const screen_width: f32 = 1280;
pub const screen_height: f32 = 720;
pub const world_w: f32 = 2400;
pub const world_h: f32 = 1800;
pub const world_bounds = Bounds{ .x = 0, .y = 0, .w = world_w, .h = world_h };

pub const Scene = enum {
    title,
    gameplay,
    paused,
};

pub const MenuAction = enum {
    none,
    resume_game,
    quit_to_title,
};

pub const GameState = struct {
    scene: Scene = .title,
    player: Player = Player.init(1050, 750),
    camera_x: f32 = 0,
    camera_y: f32 = 0,

    pub fn init() GameState {
        return .{};
    }

    pub fn startGame(self: *GameState) void {
        self.scene = .gameplay;
        self.player = Player.init(1050, 750);
        self.camera_x = 0;
        self.camera_y = 0;
    }

    pub fn updateGameplay(self: *GameState, input: Input, dt: f32) void {
        self.player.update(input, dt, world_bounds);

        // Camera follows player, centered
        self.camera_x = self.player.centerX() - screen_width / 2.0;
        self.camera_y = self.player.centerY() - screen_height / 2.0;

        // Clamp camera to world
        self.camera_x = clamp(self.camera_x, 0, world_w - screen_width);
        self.camera_y = clamp(self.camera_y, 0, world_h - screen_height);
    }

    pub fn pause(self: *GameState) void {
        if (self.scene == .gameplay) {
            self.scene = .paused;
        }
    }

    pub fn applyMenuAction(self: *GameState, action: MenuAction) void {
        switch (action) {
            .none => {},
            .resume_game => {
                if (self.scene == .paused) self.scene = .gameplay;
            },
            .quit_to_title => {
                self.scene = .title;
            },
        }
    }

    // Serializable snapshot for save/load
    pub const SaveData = struct {
        player_x: f32,
        player_y: f32,
        player_facing: u8,
        camera_x: f32,
        camera_y: f32,
        version: u32 = 1,
    };

    pub fn toSaveData(self: *const GameState) SaveData {
        return .{
            .player_x = self.player.x,
            .player_y = self.player.y,
            .player_facing = @intFromEnum(self.player.facing),
            .camera_x = self.camera_x,
            .camera_y = self.camera_y,
        };
    }

    pub fn fromSaveData(data: SaveData) GameState {
        return .{
            .scene = .gameplay,
            .player = .{
                .x = data.player_x,
                .y = data.player_y,
                .facing = @enumFromInt(data.player_facing),
            },
            .camera_x = data.camera_x,
            .camera_y = data.camera_y,
        };
    }
};

// --- Tests ---

const expect = std.testing.expect;
const expectApprox = std.testing.expectApproxEqAbs;

test "initial state is title" {
    const gs = GameState.init();
    try expect(gs.scene == .title);
}

test "startGame transitions to gameplay" {
    var gs = GameState.init();
    gs.startGame();
    try expect(gs.scene == .gameplay);
    try expectApprox(gs.player.x, 1050.0, 0.01);
    try expectApprox(gs.player.y, 750.0, 0.01);
}

test "pause transitions to paused" {
    var gs = GameState.init();
    gs.startGame();
    gs.pause();
    try expect(gs.scene == .paused);
}

test "pause only works from gameplay" {
    var gs = GameState.init();
    gs.pause();
    try expect(gs.scene == .title);
}

test "resume returns to gameplay" {
    var gs = GameState.init();
    gs.startGame();
    gs.pause();
    gs.applyMenuAction(.resume_game);
    try expect(gs.scene == .gameplay);
}

test "quit_to_title returns to title" {
    var gs = GameState.init();
    gs.startGame();
    gs.pause();
    gs.applyMenuAction(.quit_to_title);
    try expect(gs.scene == .title);
}

test "gameplay updates player position" {
    var gs = GameState.init();
    gs.startGame();
    const start_x = gs.player.x;
    gs.updateGameplay(.{ .right = true }, 0.5);
    try expect(gs.player.x > start_x);
}

test "camera follows player" {
    var gs = GameState.init();
    gs.startGame();
    gs.updateGameplay(.{ .right = true }, 0.5);
    // Camera should be offset from player center
    try expectApprox(gs.camera_x, gs.player.centerX() - screen_width / 2.0, 1.0);
}

test "save/load roundtrip preserves state" {
    var gs = GameState.init();
    gs.startGame();
    gs.updateGameplay(.{ .right = true, .down = true }, 1.0);

    const save = gs.toSaveData();
    const loaded = GameState.fromSaveData(save);

    try expectApprox(loaded.player.x, gs.player.x, 0.01);
    try expectApprox(loaded.player.y, gs.player.y, 0.01);
    try expect(loaded.player.facing == gs.player.facing);
    try expect(loaded.scene == .gameplay);
}

test "save data version is set" {
    const gs = GameState.init();
    const save = gs.toSaveData();
    try expect(save.version == 1);
}
