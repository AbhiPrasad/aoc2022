const std = @import("std");

const Score = enum(i32) {
    loss = 0,
    draw = 3,
    win = 6,
};

const Play = enum(i32) {
    rock = 1,
    paper = 2,
    scissors = 3,

    pub fn opponent(self: Play) u8 {
        return switch (self) {
            .rock => 'A',
            .paper => 'B',
            .scissors => 'C',
        };
    }

    pub fn you(self: Play) u8 {
        return switch (self) {
            .rock => 'X',
            .paper => 'Y',
            .scissors => 'Z',
        };
    }
};

pub fn playMatch(opponent: Play, you: Play) Score {
    return switch (you) {
        .rock => switch (opponent) {
            .rock => Score.draw,
            .paper => Score.loss,
            .scissors => Score.win,
        },
        .paper => switch (opponent) {
            .rock => Score.win,
            .paper => Score.draw,
            .scissors => Score.loss,
        },
        .scissors => switch (opponent) {
            .rock => Score.loss,
            .paper => Score.win,
            .scissors => Score.draw,
        },
    };
}

pub fn generatePlan(opponent: Play, you: u8) Play {
    return switch (you) {
        // lose
        'X' => switch (opponent) {
            .rock => Play.scissors,
            .paper => Play.rock,
            .scissors => Play.paper,
        },
        // draw
        'Y' => switch (opponent) {
            .rock => Play.rock,
            .paper => Play.paper,
            .scissors => Play.scissors,
        },
        // win
        'Z' => switch (opponent) {
            .rock => Play.paper,
            .paper => Play.scissors,
            .scissors => Play.rock,
        },
        else => unreachable,
    };
}

pub fn stringToPlay(s: u8) Play {
    return switch (s) {
        Play.rock.opponent() => Play.rock,
        Play.rock.you() => Play.rock,
        Play.paper.opponent() => Play.paper,
        Play.paper.you() => Play.paper,
        Play.scissors.opponent() => Play.scissors,
        Play.scissors.you() => Play.scissors,
        else => unreachable,
    };
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
    var rounds = std.mem.split(u8, input, "\n");
    while (rounds.next()) |round| {
        var plays = std.mem.split(u8, round, " ");

        const opponent = plays.next().?[0];
        const you = plays.next().?[0];

        const opponentPlay = stringToPlay(opponent);
        const yourPlay = stringToPlay(you);

        const score = playMatch(opponentPlay, yourPlay);

        total += @enumToInt(score);
        total += @enumToInt(yourPlay);
    }

    return total;
}

pub fn part2(input: []const u8) !i32 {
    var total: i32 = 0;

    var rounds = std.mem.split(u8, input, "\n");
    while (rounds.next()) |round| {
        var plays = std.mem.split(u8, round, " ");

        const opponent = plays.next().?[0];
        const plan = plays.next().?[0];

        const opponentPlay = stringToPlay(opponent);

        const yourPlay = generatePlan(opponentPlay, plan);
        const score = playMatch(opponentPlay, yourPlay);

        total += @enumToInt(score);
        total += @enumToInt(yourPlay);
    }

    return total;
}

test "simple test" {}
