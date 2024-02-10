const std = @import("std");
const Allocator = std.mem.Allocator;

const cli = @import("./cli/cli.zig");
const json = @import("./config/json.zig");

pub fn main() !void {

    // try cli.cli_run();
}

test "config struct" {
    var conf = json.UserConfig.get_conf_loc();
    std.log.debug("{s}", .{conf});
    // std.testing.expect(conf.builds != null);
}
