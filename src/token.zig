/// Interpreter Tokens
const std = @import("std");
const testing = std.testing;

const Token = struct {
    token_type: []const u8,
    literal: []const u8,
};


const ILLEGAL = "ILLEGAL";
const EOF = "EOF";

const IDENT = "IDENT";
const INT = "INT";

const ASSIGN = "=";
const PLUS = "+";

const COMMA = ",";
const SEMICOLON = ";";

const LPAREN = "(";
const RPAREN = ")";
const LBRACE = "{";
const RBRACE = "}";
const FUNCTION = "FUNCTION";
const LET = "LET";
