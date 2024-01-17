const std = @import("std");
const mem = @import("std").mem;
const commands = @import("./commands.zig");

/// commands that are apart of the cli.
var possible_commands = [_][]const u8{ "build", "dev", "doctor", "help", "setup", "start" };

const command_type = enum(i8) { Build = 1, Dev = 2, Help = 3, Doctor = 4, Setup = 5, Start = 6 };

// Each command has it's own parent function that will get called when the command is called.

/// Check that the command given matches the commands possible.
pub fn cli_check_command(command: []const u8) command_type {
    var i: usize = 0;
    while (i < possible_commands.len) : (i += 1) {
        const c = possible_commands[i];
        if (std.mem.eql(u8, c, command)) {
            return switch (i) {
                0 => command_type.Build,
                1 => command_type.Dev,
                2 => command_type.Doctor,
                3 => command_type.Help,
                4 => command_type.Setup,
                5 => command_type.Start,
                else => unreachable,
            };
        }
    }

    return command_type.Help;
}

/// Run the core of the cli from this one function.
/// Each of the commands is run from here as well, each one will have it's own fuction.
pub fn cli_run() !void {
    const stdout = std.io.getStdOut().writer();
    const args = try std.process.argsAlloc(std.heap.page_allocator);
    defer std.process.argsFree(std.heap.page_allocator, args);

    if (args.len < 2) return error.ExpectedArgument;

    var cm_type = cli_check_command(args[1]);
    _ = switch (cm_type) {
        .Help => commands.help_command(&possible_commands),
        .Build => return,
        .Setup => return,
        .Dev => return,
        .Doctor => return,
        .Start => return,
    };

    try stdout.print("Command Sent: {s}\n", .{args[1]});
}
