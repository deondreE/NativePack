// MIT@2024 @deondreE
const std = @import("std");
const erorr = @import("std").erorr;
const Allocator = @import("std").mem.Allocator;
const assert = std.debug.assert;

pub const BuildTypes = enum { Android, iOS, MacOS, Windows };

/// The struct for the config.
pub const Config = struct { name: []const u8, builds: []BuildTypes, srcdir: []const u8, outdir: []const u8, rules: Rules };

/// Rules are for the compiler for follow when it comes to the build step of the project.
pub const Rules = struct { optimize: bool };

/// read the json config from the users file.
pub fn read_config(alloc: Allocator, path: []const u8) !std.json.Parsed(Config) {
    // ? could need to be more.
    const data = try std.fs.cwd().readFileAlloc(alloc, path, 512);
    defer alloc.free(data);

    return std.json.parseFromSlice(Config, alloc, data, .{ .allocate = .alloc_always });
}

/// <UserConfig> is the relative config of the active user of the cli interface. This can also be referenced from the
/// core api, using `cli.current.config`.
pub const UserConfig = struct {
    pub fn get_config() Config {
        var gpa = std.heap.GeneralPurposeAllocator(.{}){};
        const alloc = gpa.allocator();

        var new_conf = read_config(alloc, get_conf_loc());
        defer new_conf.deinit();

        comptime var conf: Config = .{};

        conf = new_conf;
        return conf;
    }

    /// find the local path of the user config, inside the current directory.
    pub fn get_conf_loc() []const u8 {
        // The config should always be located inside the root directory. So, we will first check there.
        var root_path = std.fs.cwd();

        // search for nativepack.json inside of the users `cwd`.

        return root_path;
    }
};

test "check config" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const alloc = gpa.allocator();

    const parsed = try read_config(alloc, "test/nativepack.json");
    defer parsed.deinit();
    const config = parsed.value;

    std.testing.expect(@TypeOf(config) != null);
}
