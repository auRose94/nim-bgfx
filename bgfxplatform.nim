# Copyright 2016 Cory Noll Crimmins - Golden
# License: BSD-2
# Wrapper/binding for bgfx platform

{.deadCodeElim: on.}

when defined(BGFX_SHARED_LIB_API):
    when defined(windows):
        {.pragma: BGFXImport, dynlib: "bgfx-shared-lib(Debug|Release).dll", cdecl.}
    elif defined(macosx):
        {.pragma: BGFXImport, dynlib: "libbgfx-shared-lib(Debug|Release).dylib", cdecl.}
    elif defined(linux):
        {.pragma: BGFXImport, dynlib: "libbgfx-shared-lib(Debug|Release).so", cdecl.}
    else:
        raise newException("Unsupported platform, need lib names")
else:
    {.pragma: BGFXImport, header: "<bgfx/c99/bgfxplatform.h>", cdecl.}

import defines, bgfx
export defines

type RenderFrameEnum* = enum
    RenderFrame_NoContext,
    RenderFrame_Render,
    RenderFrame_Exiting,
    RenderFrame_Count

proc RenderFrame*(): RenderFrameEnum {.BGFXImport, discardable, importc: "bgfx_render_frame".}

type PlatformData* {.importc: "bgfx_platform_data_t", header: "<bgfx/c99/bgfxplatform.h>".} = object
    ndt* {.importc: "ndt".}: pointer
    nwh* {.importc: "nwh".}: pointer
    context* {.importc: "context".}: pointer
    backBuffer* {.importc: "backBuffer".}: pointer
    backBufferDS* {.importc: "backBufferDS".}: pointer

proc SetPlatformData*(data: ptr PlatformData) {.BGFXImport, importc: "bgfx_set_platform_data".}

type InternalData* {.importc: "bgfx_internal_data_t", header: "<bgfx/c99/bgfxplatform.h>".} = object
    caps* {.importc: "caps".}: ptr Caps
    context* {.importc: "context".}: pointer

proc GetInternalData*(): ptr InternalData {.BGFXImport, importc: "bgfx_get_internal_data".}
proc OverrideInternal*(handle: TextureHandle, pntr: pointer): pointer {.BGFXImport, importc: "bgfx_override_internal_texture_ptr".}
proc OverrideInternal*(handle: TextureHandle, width, height: uint16_t, numMips: uint8_t, format: TextureFormat, flags: uint32_t = BGFX_TEXTURE_NONE): pointer {.BGFXImport, importc: "bgfx_override_internal_texture".}
