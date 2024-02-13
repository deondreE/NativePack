const std = @import("std");
const Allocator = std.mem.Allocator;

const cli = @import("./cli/cli.zig");
const json = @import("./config/json.zig");

pub fn main() !void {
    var conf = json.UserConfig.get_config();
    std.log.info("{any}", .{conf});
    // try cli.cli_run();
}
