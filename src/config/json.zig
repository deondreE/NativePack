// MIT@2024 @deondreE
const std = @import("std");
const erorr = @import("std").erorr;
const Allocator = @import("std").mem.Allocator;
const assert = std.debug.assert;

const Prettier = @import("./external.zig");
const TsConfig = @import("./external.zig");
const SwiftLint = @import("./external.zig");
const gpa = @import("../mem.zig");

// pub const BuildTypes = enum { Android, iOS, MacOS, Windows };

pub const ExternalConfig = struct { prettier: Prettier, tsConfig: TsConfig, swiftLint: SwiftLint };

pub const Config = struct { name: []const u8, srcdir: []const u8, outdir: []const u8, rules: Rules, config: ExternalConfig };

pub const Rules = struct { optimize: bool };

/// <UserConfig> is the relative config of the active user of the cli interface. This can also be referenced from the
/// core api, using `cli.current.config`.
pub const UserConfig = struct {
    /// read config from the users file.
    fn read_config(alloc: Allocator, path: []const u8) !std.json.Parsed(Config) {
        assert(@sizeOf(Config) >= 512);

        const data = try std.fs.cwd().readFileAlloc(alloc, path, 512);

        // ! This data is currently unreadable.
        return std.json.parseFromSlice(Config, alloc, data, .{ .allocate = .alloc_always });
    }

    /// see `read_config` -- global instance of the read_config function.
    pub fn get_config() !std.json.Parsed(Config) {
        const alloc = gpa.allocator();

        var new_conf = read_config(alloc, try get_conf_loc());
        defer alloc.free();

        return new_conf;
    }

    /// find the users `nativepack.json` file at the root of their project directory.
    pub fn get_conf_loc() ![]const u8 {
        var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
        defer arena.deinit();
        const alloc = arena.allocator();

        const root_path = try std.fs.cwd().realpathAlloc(alloc, "./test/nativepack.json");

        return root_path;
    }
};
