
const token = @import("token.zig");

const std = @import("std");
const testing = std.testing;
const expect = testing.expect;

const Lexer = struct {
    input: []const u8,
    position: usize = 0,
    read_position: usize = 0,
    ch: u8 = 0,
};

fn lexer_read_char(l: *Lexer) void {
    if (l.read_position >= l.input.len) {
        l.ch = 0;
    } else {
        l.ch = l.input[l.read_position];
    }
    l.position = l.read_position;
    l.read_position += 1;
}

const LexerError = error {
    TokenMismatch
};

fn lexer_next_token(l: *Lexer) LexerError!token.Token {


    std.debug.print("char: {c}\n", .{l.ch});

    return switch (l.ch) {
        '=' => token.Token{.token_type = token.ASSIGN, .literal = &.{l.ch}},
        ';' => token.Token{.token_type = token.SEMICOLON, .literal = &.{l.ch}},
        '(' => token.Token{.token_type = token.LPAREN, .literal = &.{l.ch}},
        ')' => token.Token{.token_type = token.RPAREN, .literal = &.{l.ch}},
        ',' => token.Token{.token_type = token.COMMA, .literal = &.{l.ch}},
        '+' => token.Token{.token_type = token.PLUS, .literal = &.{l.ch}},
        '{' => token.Token{.token_type = token.LBRACE, .literal = &.{l.ch}},
        '}' => token.Token{.token_type = token.RBRACE, .literal = &.{l.ch}},
        '0' => token.Token{.token_type = token.EOF, .literal = &.{l.ch}},
        else => LexerError.TokenMismatch,
    };
}

test "NextToken" {
    const input = "=+(){},;";



    const TestCases = struct {
        expected: LexerError!token.Token,
        input: []const u8,
    };

    const tests: [9]TestCases = .{
            .{ .expected = .{ .token_type = token.ASSIGN, .literal = "="}, .input = "=" },
            .{ .expected = .{ .token_type = token.PLUS, .literal = "+"}, .input = "+" },
            .{ .expected = .{ .token_type = token.LPAREN, .literal = "("}, .input = "(" },
            .{ .expected = .{ .token_type = token.RPAREN, .literal = ")"}, .input = ")" },
            .{ .expected = .{ .token_type = token.LBRACE, .literal = "{"}, .input = "{" },
            .{ .expected = .{ .token_type = token.RBRACE, .literal = "}"}, .input = "}" },
            .{ .expected = .{ .token_type = token.COMMA, .literal = ","}, .input = "," },
            .{ .expected = .{ .token_type = token.SEMICOLON, .literal = ";"}, .input = ";" },
            .{ .expected = .{ .token_type = token.EOF, .literal = "0"}, .input = "0" },
        };

    var l = Lexer{ .input = input };
    for (tests) |test_case| {
        const tok = lexer_next_token(&l) catch |err| {
            switch (err) {
                LexerError.TokenMismatch => {
                    try testing.expectEqual(test_case.expected, LexerError.TokenMismatch);
                    },
            }
            return err;
        };
        try testing.expectEqual(test_case.expected, tok);
    }
}
