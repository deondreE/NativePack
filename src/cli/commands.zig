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

/// doctor makes sure the user has all things isntalled that they are supposed to.
pub fn doctor() void {
    var platform = "";
    _ = platform;
}

/// Runs the project scaffold command.
pub fn scaffold() void {
    // TODO: find the process of asking the user a question.
    // TODO: run the doctor script, inside of Clang.
    // TODO: figure out what framework the user is going to use.
}
