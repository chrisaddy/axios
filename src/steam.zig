//! Steamworks SDK integration. Provides a stub when compiled without `-Dsteam=true`.

const std = @import("std");
const builtin = @import("builtin");

// When the Steamworks SDK is available, these will resolve via @cImport.
// Until then, we provide a stub implementation so the game runs without Steam.

const has_steam = @import("build_options").enable_steam;

// Steam C API bindings (from steam_api_flat.h)
const steam_c = if (has_steam) @cImport({
    @cInclude("steam_api_flat.h");
}) else struct {};

/// Wraps the Steamworks API behind a compile-time feature gate.
/// When Steam is disabled, all methods are safe no-ops.
pub const Steam = struct {
    initialized: bool = false,

    /// Initializes the Steamworks API, or returns an uninitialized stub if Steam is unavailable.
    pub fn init() Steam {
        if (!has_steam) {
            std.log.info("Steam SDK not available — running in standalone mode", .{});
            return .{ .initialized = false };
        }

        if (steam_c.SteamAPI_RestartAppIfNecessary(480)) {
            std.log.info("Restarting through Steam client...", .{});
            std.process.exit(0);
        }

        if (steam_c.SteamAPI_Init()) {
            std.log.info("Steam initialized successfully", .{});
            return .{ .initialized = true };
        } else {
            std.log.warn("Steam initialization failed — running in standalone mode", .{});
            return .{ .initialized = false };
        }
    }

    /// Shuts down the Steamworks API if it was initialized.
    pub fn deinit(self: *Steam) void {
        if (has_steam and self.initialized) {
            steam_c.SteamAPI_Shutdown();
            std.log.info("Steam shutdown", .{});
        }
        self.initialized = false;
    }

    /// Pumps the Steam callback queue. Should be called once per frame.
    pub fn runCallbacks(self: *const Steam) void {
        if (has_steam and self.initialized) {
            steam_c.SteamAPI_RunCallbacks();
        }
    }

    /// Returns true if the Steamworks API was successfully initialized.
    pub fn isRunning(self: *const Steam) bool {
        return self.initialized;
    }
};
