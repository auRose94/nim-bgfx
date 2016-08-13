# BGFX WRAPPER UTILITIES

import c99bgfx

proc FromArray*[T](data: var seq[T]): ptr bgfx_memory_t {.inline.} =
    return bgfx_copy(cast[pointer](addr(data)), cast[uint32](len(data)))
