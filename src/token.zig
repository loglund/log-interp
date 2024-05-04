/// Interpreter Tokens
const std = @import("std");
const testing = std.testing;

pub const Token = struct {
    token_type: []const u8,
    literal: []const u8,
};


pub const ILLEGAL = "ILLEGAL";
pub const EOF = "EOF";

pub const IDENT = "IDENT";
pub const INT = "INT";

pub const ASSIGN = "=";
pub const PLUS = "+";

pub const COMMA = ",";
pub const SEMICOLON = ";";

pub const LPAREN = "(";
pub const RPAREN = ")";
pub const LBRACE = "{";
pub const RBRACE = "}";
pub const FUNCTION = "FUNCTION";
pub const LET = "LET";
