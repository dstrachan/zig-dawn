const std = @import("std");
const builtin = @import("builtin");

pub const wgpu = @import("wgpu.zig");

test {
    std.testing.refAllDecls(@This());
}

pub fn createSurface(instance: wgpu.Instance, ns_window: ?*anyopaque) !wgpu.Surface {
    switch (builtin.os.tag) {
        .macos => {
            const ns_view = objc.msgSend(ns_window, "contentView", .{}, *anyopaque);

            objc.msgSend(ns_view, "setWantsLayer:", .{true}, void);
            const layer = objc.msgSend(objc.objc_getClass("CAMetalLayer"), "layer", .{}, ?*anyopaque) orelse {
                std.log.err("Failed to create Metal layer", .{});
                return error.CreateSurfaceFailed;
            };
            objc.msgSend(ns_view, "setLayer:", .{layer}, void);

            const next: wgpu.SurfaceSourceMetalLayer = .{
                .chain = .{ .s_type = .surface_source_metal_layer },
                .layer = layer,
            };
            const desc: wgpu.SurfaceDescriptor = .{
                .next_in_chain = @ptrCast(&next),
            };
            return instance.createSurface(&desc);
        },
        else => |t| @compileError("Unsupported OS: " ++ @tagName(t)),
    }
}

pub fn requestAdapter(instance: wgpu.Instance, options: wgpu.RequestAdapterOptions) !wgpu.Adapter {
    const callback = struct {
        fn callback(
            status: wgpu.RequestAdapterStatus,
            adapter: wgpu.Adapter,
            message: wgpu.StringView,
            userdata1: ?*anyopaque,
            _: ?*anyopaque,
        ) callconv(.c) void {
            if (status == .success) {
                const data: *wgpu.Adapter = @ptrCast(@alignCast(userdata1));
                data.* = adapter;
            } else {
                std.log.err("Failed to get GPU adapter: (status: {t}, message: {s})", .{
                    status,
                    message.toSlice(),
                });
            }
        }
    }.callback;

    var data: wgpu.Adapter = undefined;
    const future = instance.requestAdapter(&options, .{
        .callback = callback,
        .userdata1 = @ptrCast(&data),
    });

    var futures = [_]wgpu.FutureWaitInfo{.{ .future = future }};
    while (instance.waitAny(&futures, std.time.ns_per_ms * 5) == .timed_out) {}

    if (futures[0].completed == .true) return data;
    return error.RequestAdapterFailed;
}

pub fn requestDevice(adapter: wgpu.Adapter, desc: wgpu.DeviceDescriptor) !wgpu.Device {
    const callback = struct {
        fn callback(
            status: wgpu.RequestDeviceStatus,
            device: wgpu.Device,
            message: wgpu.StringView,
            userdata1: ?*anyopaque,
            _: ?*anyopaque,
        ) callconv(.c) void {
            if (status == .success) {
                const data: *wgpu.Device = @ptrCast(@alignCast(userdata1));
                data.* = device;
            } else {
                std.log.err("Failed to get GPU device: (status: {t}, message: {s})", .{
                    status,
                    message.toSlice(),
                });
            }
        }
    }.callback;

    var data: wgpu.Device = undefined;
    const future = adapter.requestDevice(&desc, .{
        .callback = callback,
        .userdata1 = @ptrCast(&data),
    });

    var futures = [_]wgpu.FutureWaitInfo{.{ .future = future }};
    const instance = adapter.getInstance();
    defer instance.release();
    while (instance.waitAny(&futures, std.time.ns_per_ms * 5) == .timed_out) {}

    if (futures[0].completed == .true) return data;
    return error.RequestDeviceFailed;
}

pub fn getTextureFormat(surface: wgpu.Surface, adapter: wgpu.Adapter) !wgpu.TextureFormat {
    var capabilities: wgpu.SurfaceCapabilities = .{};
    if (surface.getCapabilities(adapter, &capabilities) == .err) {
        std.log.err("Failed to get surface capabilities", .{});
        return error.GetCapabilitiesFailed;
    }
    defer capabilities.freeMembers();

    return capabilities.formats.?[0];
}

const objc = struct {
    const SEL = ?*opaque {};
    const Class = ?*opaque {};

    extern fn sel_getUid(str: [*:0]const u8) SEL;
    extern fn objc_getClass(name: [*:0]const u8) Class;
    extern fn objc_msgSend() void;

    fn msgSend(obj: anytype, sel_name: [:0]const u8, args: anytype, comptime T: type) T {
        const fields = std.meta.fields(@TypeOf(args));
        comptime var field_types: [fields.len]type = undefined;
        inline for (&field_types, fields) |*t, f| t.* = f.type;
        const param_types = .{ @TypeOf(obj), SEL } ++ &field_types;
        const FnType = *const @Fn(param_types, &@splat(.{}), T, .{ .@"callconv" = .c });

        const func: FnType = @ptrCast(&objc_msgSend);
        const sel = sel_getUid(sel_name.ptr);

        return @call(.never_inline, func, .{ obj, sel } ++ args);
    }
};
