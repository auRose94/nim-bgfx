# BGFX WRAPPER UTILITIES

import bgfx

proc FromArray*[T](data: seq[T]): ptr bgfx_memory =
    bgfx_copy(addr(data), len(data))
