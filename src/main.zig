const std = @import("std");
const cli = @import("./cli/cli.zig");

pub fn main() !void {
    // var args = std.process.args();

    //  _ = cli.cli_check_command("testinsksjdhgkdfshg");
    try cli.cli_run();
}
