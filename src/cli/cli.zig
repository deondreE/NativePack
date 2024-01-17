const std = @import("std");
const mem = @import("std").mem;

/// commands that are apart of the cli.
var possible_commands = [_][]const u8{ "build", "dev", "help", "doctor", "setup", "start" };

const command_type = enum(i8) { Build = 1, Dev = 2, Help = 3, Doctor = 4, Setup = 5, Start = 6 };

// Each command has it's own parent function that will get called when the command is called.

/// Check that the command given matches the commands possible.
pub fn cli_check_command(command: []const u8) command_type {
    for (possible_commands) |c| {
        // this contains the current command
        if (mem.eql(u8, c, command)) {
            // currently I don't know a better way to do this so I aplogize.
            // TODO: make this look nice.
            if (mem.eql(u8, command, "help")) {
                return command_type.Help;
            }
            if (mem.eql(u8, command, "dev")) {
                return command_type.Dev;
            }
            if (mem.eql(u8, command, "build")) {
                return command_type.Build;
            }
            if (mem.eql(u8, command, "doctor")) {
                return command_type.Doctor;
            }
            if (mem.eql(u8, command, "setup")) {
                return command_type.Setup;
            }
            if (mem.eql(u8, command, "Start")) {
                return command_type.Start;
            }
        }
    }

    return command_type.Help;
}

/// This will take nothing in and print out a large string that explains all commands.
fn help_command() void {
    std.debug.print("The current commands are: \n\n", .{});

    inline for (possible_commands) |command| {
        std.debug.print("\t{s}\n", .{command});
    }
}

/// Run the core of the cli from this one function.
pub fn cli_run() !void {
    const stdout = std.io.getStdOut().writer();
    const args = try std.process.argsAlloc(std.heap.page_allocator);
    defer std.process.argsFree(std.heap.page_allocator, args);

    if (args.len < 2) return error.ExpectedArgument;

    var cm_type = cli_check_command(args[1]);
    _ = switch (cm_type) {
        .Help => help_command(),
        .Build => return,
        .Setup => return,
        .Dev => return,
        .Doctor => return,
        .Start => return,
    };

    try stdout.print("Command Sent: {s}\n", .{args[1]});
}
