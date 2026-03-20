// Pure game logic — no raylib dependency. Rendering is in render.zig.

pub const player_size: f32 = 24;
pub const player_speed: f32 = 160.0;

pub const Direction = enum {
    north,
    south,
    east,
    west,
};

pub const Input = struct {
    up: bool = false,
    down: bool = false,
    left: bool = false,
    right: bool = false,
};

pub const Bounds = struct {
    x: f32,
    y: f32,
    w: f32,
    h: f32,
};

pub const Player = struct {
    x: f32,
    y: f32,
    facing: Direction = .south,

    pub fn init(x: f32, y: f32) Player {
        return .{ .x = x, .y = y };
    }

    pub fn update(self: *Player, input: Input, dt: f32, bounds: Bounds) void {
        var dx: f32 = 0;
        var dy: f32 = 0;

        if (input.up) {
            dy -= 1;
            self.facing = .north;
        }
        if (input.down) {
            dy += 1;
            self.facing = .south;
        }
        if (input.left) {
            dx -= 1;
            self.facing = .west;
        }
        if (input.right) {
            dx += 1;
            self.facing = .east;
        }

        // Normalize diagonal movement
        if (dx != 0 and dy != 0) {
            const inv_sqrt2 = 0.7071067811865475;
            dx *= inv_sqrt2;
            dy *= inv_sqrt2;
        }

        self.x += dx * player_speed * dt;
        self.y += dy * player_speed * dt;

        // Clamp to bounds
        self.x = clamp(self.x, bounds.x, bounds.x + bounds.w - player_size);
        self.y = clamp(self.y, bounds.y, bounds.y + bounds.h - player_size);
    }

    pub fn centerX(self: *const Player) f32 {
        return self.x + player_size / 2.0;
    }

    pub fn centerY(self: *const Player) f32 {
        return self.y + player_size / 2.0;
    }
};

pub fn clamp(val: f32, min: f32, max: f32) f32 {
    if (val < min) return min;
    if (val > max) return max;
    return val;
}

// --- Tests ---

const std = @import("std");
const expect = std.testing.expect;
const expectApprox = std.testing.expectApproxEqAbs;

const test_bounds = Bounds{ .x = 0, .y = 0, .w = 800, .h = 600 };

test "player init sets position" {
    const p = Player.init(100, 200);
    try expectApprox(p.x, 100.0, 0.01);
    try expectApprox(p.y, 200.0, 0.01);
    try expect(p.facing == .south);
}

test "player moves right" {
    var p = Player.init(100, 100);
    p.update(.{ .right = true }, 1.0, test_bounds);
    try expect(p.x > 100.0);
    try expectApprox(p.y, 100.0, 0.01);
    try expect(p.facing == .east);
}

test "player moves up" {
    var p = Player.init(100, 100);
    p.update(.{ .up = true }, 1.0, test_bounds);
    try expectApprox(p.x, 100.0, 0.01);
    try expect(p.y < 100.0);
    try expect(p.facing == .north);
}

test "player diagonal movement is normalized" {
    var p1 = Player.init(100, 100);
    p1.update(.{ .right = true }, 1.0, test_bounds);
    const cardinal_dist = p1.x - 100.0;

    var p2 = Player.init(100, 100);
    p2.update(.{ .right = true, .down = true }, 1.0, test_bounds);
    const diag_dx = p2.x - 100.0;
    const diag_dy = p2.y - 100.0;
    const diag_dist = @sqrt(diag_dx * diag_dx + diag_dy * diag_dy);

    // Diagonal total distance should equal cardinal distance
    try expectApprox(diag_dist, cardinal_dist, 0.01);
}

test "player stays in bounds" {
    var p = Player.init(0, 0);
    p.update(.{ .left = true, .up = true }, 10.0, test_bounds);
    try expect(p.x >= 0);
    try expect(p.y >= 0);

    var p2 = Player.init(790, 590);
    p2.update(.{ .right = true, .down = true }, 10.0, test_bounds);
    try expect(p2.x <= test_bounds.w - player_size);
    try expect(p2.y <= test_bounds.h - player_size);
}

test "no input means no movement" {
    var p = Player.init(100, 100);
    p.update(.{}, 1.0, test_bounds);
    try expectApprox(p.x, 100.0, 0.01);
    try expectApprox(p.y, 100.0, 0.01);
}

test "center calculation" {
    const p = Player.init(100, 200);
    try expectApprox(p.centerX(), 112.0, 0.01);
    try expectApprox(p.centerY(), 212.0, 0.01);
}

test "clamp works" {
    try expectApprox(clamp(5.0, 0.0, 10.0), 5.0, 0.01);
    try expectApprox(clamp(-5.0, 0.0, 10.0), 0.0, 0.01);
    try expectApprox(clamp(15.0, 0.0, 10.0), 10.0, 0.01);
}
