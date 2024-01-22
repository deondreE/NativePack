const std = @import("std");

// ! Write all new commands here.

/// Prints all the commands that are possible for the cli.
pub fn help_command(possible_commands: [][]const u8) void {
    std.debug.print("The current commands are: \n\n", .{});

    for (possible_commands) |command| {
        std.debug.print("\t{s}\n", .{command});
    }
}

/// Runs the users core project.
pub fn run_project() void {}
