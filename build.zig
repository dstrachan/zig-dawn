const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const dawn_dep = switch (target.result.os.tag) {
        .macos => b.lazyDependency("dawn_aarch64_macos", .{}),
        else => |t| std.debug.panic("Unsupported OS: {t}", .{t}),
    } orelse @panic("Missing dawn dependency");

    const translate_c = b.addTranslateC(.{
        .root_source_file = dawn_dep.path("include/webgpu/webgpu.h"),
        .target = target,
        .optimize = optimize,
    });
    translate_c.addIncludePath(dawn_dep.path("include"));

    const mod = b.addModule("root", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .imports = &.{
            .{ .name = "wgpu", .module = translate_c.createModule() },
        },
    });

    const mod_tests = b.addTest(.{
        .root_module = mod,
    });
    linkLibraries(mod_tests);

    const run_mod_tests = b.addRunArtifact(mod_tests);

    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_mod_tests.step);
}

pub fn linkLibraries(compile: *std.Build.Step.Compile) void {
    const b = compile.step.owner;
    const target = compile.rootModuleTarget();
    switch (target.os.tag) {
        .macos => {
            if (b.lazyDependency("dawn_aarch64_macos", .{})) |dawn_dep| {
                compile.root_module.addLibraryPath(dawn_dep.path("lib"));
            }
            compile.root_module.linkSystemLibrary("objc", .{});
            compile.root_module.linkFramework("Metal", .{});
            compile.root_module.linkFramework("Foundation", .{});
            compile.root_module.linkFramework("IOKit", .{});
            compile.root_module.linkFramework("IOSurface", .{});
            compile.root_module.linkFramework("QuartzCore", .{});
            compile.root_module.linkFramework("CoreFoundation", .{});
            compile.root_module.link_libcpp = true;
        },
        else => |t| std.debug.panic("Unsupported OS: {t}", .{t}),
    }
    compile.root_module.linkSystemLibrary("webgpu_dawn", .{});
}
