//! Central raylib import so all modules use the same @cImport.

/// Re-exported C namespace containing all raylib and raymath symbols.
pub const c = @cImport({
    @cInclude("raylib.h");
    @cInclude("raymath.h");
});
