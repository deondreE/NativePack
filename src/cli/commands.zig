const std = @import("std");
const config = @import("../config/json.zig");

// ! Write all new commands here.

/// Prints all the commands that are possible for the cli.
pub fn help_command(possible_commands: [][]const u8) void {
    std.debug.print("The current commands are: \n\n", .{});

    for (possible_commands) |command| {
        std.debug.print("\t{s}\n", .{command});
    }
}

/// Runs the users core project.
pub fn run_project() void {
    var b = config.UserConfig.get_conf_loc();
    std.debug.print("{s}", .{b});
}
