// Central raylib import so all modules use the same @cImport
pub const c = @cImport({
    @cInclude("raylib.h");
    @cInclude("raymath.h");
});
