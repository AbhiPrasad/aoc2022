const std = @import("std");
const ArrayList = std.ArrayList;
const allocator = std.heap.page_allocator;

pub fn main() !void {
    const input = @embedFile("input.txt");

    const part1Total = try part1(input);
    std.debug.print("Part 1: {}\n", .{part1Total});

    const part2Total = part2(input);
    std.debug.print("Part 2: {}\n", .{part2Total});
}

pub fn part1(input: []const u8) !i32 {
    var elvesList = std.mem.split(u8, input, "\n\n");

    var total: i32 = 0;
    while (elvesList.next()) |elf| {
        var elfItems = std.mem.split(u8, elf, "\n");

        var calories: i32 = 0;
        while (elfItems.next()) |item| {
            calories += try std.fmt.parseInt(i32, item, 10);
        }

        if (total < calories) {
            total = calories;
        }
    }

    return total;
}

pub fn part2(input: []const u8) i32 {
    var elvesList = std.mem.split(u8, input, "\n\n");
    var list = ArrayList(i32).init(allocator);
    defer list.deinit();

    while (elvesList.next()) |elf| {
        var elfItems = std.mem.split(u8, elf, "\n");

        var calories: i32 = 0;
        while (elfItems.next()) |item| {
            calories += std.fmt.parseInt(i32, item, 10) catch unreachable;
        }

        list.append(calories) catch unreachable;
    }

    std.sort.sort(i32, list.items, {}, std.sort.desc(i32));
    return list.items[0] + list.items[1] + list.items[2];
}

test "simple test" {}
