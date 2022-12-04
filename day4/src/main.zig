const std = @import("std");

const ElfError = error{
    ReadError,
};

pub fn main() !void {
    const input = @embedFile("input.txt");

    const part1Total = try part1(input);
    std.debug.print("Part 1: {}\n", .{part1Total});

    const part2Total = try part2(input);
    std.debug.print("Part 2: {}\n", .{part2Total});
}

pub fn part1(input: []const u8) !i32 {
    var total: i32 = 0;

    var pairList = std.mem.split(u8, input, "\n");

    while (pairList.next()) |pair| {
        var elves = std.mem.split(u8, pair, ",");

        var elf1 = elves.next() orelse return ElfError.ReadError;
        var elf1Range = std.mem.split(u8, elf1, "-");

        var elf2 = elves.next() orelse return ElfError.ReadError;
        var elf2Range = std.mem.split(u8, elf2, "-");

        var elf1Start = try std.fmt.parseInt(u8, elf1Range.next() orelse return ElfError.ReadError, 10);
        var elf1End = try std.fmt.parseInt(u8, elf1Range.next() orelse return ElfError.ReadError, 10);

        var elf2Start = try std.fmt.parseInt(u8, elf2Range.next() orelse return ElfError.ReadError, 10);
        var elf2End = try std.fmt.parseInt(u8, elf2Range.next() orelse return ElfError.ReadError, 10);

        if (elf1Start <= elf2Start and elf1End >= elf2End) {
            total += 1;
        } else if (elf1Start >= elf2Start and elf1End <= elf2End) {
            total += 1;
        }
    }

    return total;
}

pub fn part2(input: []const u8) !i32 {
    var total: i32 = 0;

    var pairList = std.mem.split(u8, input, "\n");

    while (pairList.next()) |pair| {
        var elves = std.mem.split(u8, pair, ",");

        var elf1 = elves.next() orelse return ElfError.ReadError;
        var elf1Range = std.mem.split(u8, elf1, "-");

        var elf2 = elves.next() orelse return ElfError.ReadError;
        var elf2Range = std.mem.split(u8, elf2, "-");

        var elf1Start = try std.fmt.parseInt(u8, elf1Range.next() orelse return ElfError.ReadError, 10);
        var elf1End = try std.fmt.parseInt(u8, elf1Range.next() orelse return ElfError.ReadError, 10);

        var elf2Start = try std.fmt.parseInt(u8, elf2Range.next() orelse return ElfError.ReadError, 10);
        var elf2End = try std.fmt.parseInt(u8, elf2Range.next() orelse return ElfError.ReadError, 10);

        if (!(elf1End < elf2Start) and !(elf1Start > elf2End)) {
            total += 1;
        }
    }

    return total;
}

test "simple test" {}
