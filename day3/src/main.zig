const std = @import("std");
const print = @import("std").debug.print;
const allocator = std.heap.page_allocator;

pub fn isLower(c: u8) bool {
    return c >= 'a' and c <= 'z';
}

pub fn isUpper(c: u8) bool {
    return c >= 'A' and c <= 'Z';
}

fn generatePrio(char: u8) i32 {
    if (isLower(char)) {
        return @intCast(i32, char - 96);
    }
    return @intCast(i32, char - 38);
}

pub fn main() !void {
    const input = @embedFile("input.txt");

    const part1Total = try part1(input);
    std.debug.print("Part 1: {}\n", .{part1Total});

    const part2Total = try part2(input);
    std.debug.print("Part 2: {}\n", .{part2Total});
}

pub fn part1(input: []const u8) !i32 {
    var total: i32 = 0;

    var rucksacks = std.mem.split(u8, input, "\n");
    var map = std.AutoHashMap(u8, bool).init(allocator);
    defer map.deinit();

    while (rucksacks.next()) |sack| {
        const compartmentLen = sack.len / 2;
        for (sack) |item, index| {
            const found = map.get(item) orelse false;
            if (index < compartmentLen) {
                if (!found) {
                    try map.put(item, true);
                }
            } else if (found) {
                total += generatePrio(item);
                _ = map.remove(item);
            }
        }
        map.clearRetainingCapacity();
    }

    return total;
}

const Item = struct {
    count: u8,
    sack: u16,
};

pub fn part2(input: []const u8) !i32 {
    var total: i32 = 0;

    var rucksacks = std.mem.split(u8, input, "\n");
    var map = std.AutoHashMap(u8, Item).init(allocator);
    defer map.deinit();

    var sackCounter: u16 = 0;
    while (rucksacks.next()) |sack| {
        sackCounter += 1;
        for (sack) |item| {
            const i = map.get(item) orelse Item{ .count = 0, .sack = sackCounter };
            if (i.count == 0 or i.sack != sackCounter) {
                const newCount = i.count + 1;
                try map.put(item, Item{ .count = newCount, .sack = sackCounter });
                if (newCount == 3) {
                    total += generatePrio(item);
                    break;
                }
            }
        }
        if (sackCounter % 3 == 0) {
            map.clearRetainingCapacity();
        }
    }

    return total;
}

test "simple test" {}
