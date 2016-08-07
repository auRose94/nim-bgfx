# BGFX WRAPPER UTILITIES

import c99.bgfx

proc FromArray*[T](data: seq[T]): ptr bgfx_memory_t {.inline.} =
    bgfx_copy(addr(data), len(data))
