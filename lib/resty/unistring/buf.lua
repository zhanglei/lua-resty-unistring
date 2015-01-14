local require      = require
local ffi          = require "ffi"
local ffi_gc       = ffi.gc
local ffi_new      = ffi.new
local ffi_typeof   = ffi.typeof
local C            = ffi.C
local uint8t = ffi_typeof "uint8_t[?]"
local buf = {}
function buf.u8(size)
    return ffi_gc(ffi_new(uint8t, size), C.free)
end
buf[8] = buf.u8
local mt = {}
function mt:__call(size, type)
    if not type then return self.u8(size) end
    return self[type](size)
end
return setmetatable(buf, mt)
