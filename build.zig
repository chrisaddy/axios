const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Check if Steamworks SDK is present
    const enable_steam = b.option(bool, "steam", "Enable Steamworks integration (requires SDK in vendor/steamworks/sdk/)") orelse false;

    const raylib_dep = b.dependency("raylib", .{
        .target = target,
        .optimize = optimize,
    });

    const build_options = b.addOptions();
    build_options.addOption(bool, "enable_steam", enable_steam);

    const exe = b.addExecutable(.{
        .name = "axios",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{
                    .name = "build_options",
                    .module = build_options.createModule(),
                },
            },
        }),
    });

    // Link raylib
    const raylib_artifact = raylib_dep.artifact("raylib");
    exe.root_module.linkLibrary(raylib_artifact);

    // On macOS, ensure framework search paths are set (needed in Nix/devenv shells)
    if (target.result.os.tag == .macos) {
        if (b.graph.environ_map.get("SDKROOT")) |sdkroot| {
            const fw_path: std.Build.LazyPath = .{ .cwd_relative = b.fmt("{s}/System/Library/Frameworks", .{sdkroot}) };
            exe.root_module.addFrameworkPath(fw_path);
            raylib_artifact.root_module.addFrameworkPath(fw_path);
        }
    }

    // Link Steamworks if available
    if (enable_steam) {
        exe.root_module.addIncludePath(b.path("vendor/steamworks/sdk/public/steam"));

        const steam_lib_path = switch (target.result.os.tag) {
            .macos => b.path("vendor/steamworks/sdk/redistributable_bin/osx"),
            .linux => b.path("vendor/steamworks/sdk/redistributable_bin/linux64"),
            .windows => b.path("vendor/steamworks/sdk/redistributable_bin/win64"),
            else => @panic("Unsupported platform for Steamworks"),
        };
        exe.root_module.addLibraryPath(steam_lib_path);

        const steam_lib_name = if (target.result.os.tag == .windows) "steam_api64" else "steam_api";
        exe.root_module.linkSystemLibrary(steam_lib_name, .{});
    }

    b.installArtifact(exe);

    // Install steam_appid.txt next to binary for dev builds
    if (optimize == .Debug) {
        b.installFile("steam_appid.txt", "bin/steam_appid.txt");
    }

    // Run step
    const run_step = b.step("run", "Run Axios");
    const run_cmd = b.addRunArtifact(exe);
    run_step.dependOn(&run_cmd.step);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    // Test step — tests pure logic modules only (no raylib)
    const logic_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/tests.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&b.addRunArtifact(logic_tests).step);
}
