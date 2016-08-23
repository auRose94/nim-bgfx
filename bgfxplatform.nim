# Copyright 2016 Cory Noll Crimmins - Golden
# License: BSD-2
# Wrapper/binding for bgfx platform

{.deadCodeElim: on.}

import defines, bgfx
export defines

type RenderFrameEnum* = enum
    RenderFrame_NoContext,
    RenderFrame_Render,
    RenderFrame_Exiting,
    RenderFrame_Count

proc RenderFrame*(): RenderFrameEnum {.discardable, importc: "bgfx_render_frame", header: "<bgfx/c99/bgfxplatform.h>".}

type PlatformData* {.importc: "bgfx_platform_data_t", header: "<bgfx/c99/bgfxplatform.h>".} = object
    ndt* {.importc: "ndt".}: pointer
    nwh* {.importc: "nwh".}: pointer
    context* {.importc: "context".}: pointer
    backBuffer* {.importc: "backBuffer".}: pointer
    backBufferDS* {.importc: "backBufferDS".}: pointer

proc SetPlatformData*(data: ptr PlatformData) {.importc: "bgfx_set_platform_data", header: "<bgfx/c99/bgfxplatform.h>".}

type InternalData* {.importc: "bgfx_internal_data_t", header: "<bgfx/c99/bgfxplatform.h>".} = object
    caps* {.importc: "caps".}: ptr Caps
    context* {.importc: "context".}: pointer

proc GetInternalData*(): ptr InternalData {.importc: "bgfx_get_internal_data", header: "<bgfx/c99/bgfxplatform.h>".}
proc OverrideInternal*(handle: TextureHandle, pntr: pointer): pointer {.importc: "bgfx_override_internal_texture_ptr", header: "<bgfx/c99/bgfxplatform.h>".}
proc OverrideInternal*(handle: TextureHandle, width, height: uint16_t, numMips: uint8_t, format: TextureFormat, flags: uint32_t = BGFX_TEXTURE_NONE): pointer {.importc: "bgfx_override_internal_texture", header: "<bgfx/c99/bgfxplatform.h>".}
