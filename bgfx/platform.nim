# Copyright 2017 Cory Noll Crimmins - Golden
# License: BSD-2
# Wrapper/binding for bgfx platform

import types
export types

{.deadCodeElim: on.}

when defined(BGFX_SHARED_LIB):
    {.pragma: BGFXImport, header: "<bgfx/c99/platform.h>", cdecl.}
elif defined(BGFX_DYNAMIC_LIB):
    when defined(windows):
        {.pragma: BGFXImport, dynlib: "bgfx-shared-lib(Debug|Release).dll", cdecl.}
    elif defined(macosx):
        {.pragma: BGFXImport, dynlib: "libbgfx-shared-lib(Debug|Release).dylib", cdecl.}
    elif defined(linux):
        {.pragma: BGFXImport, dynlib: "libbgfx-shared-lib(Debug|Release).so", cdecl.}
    else:
        raise newException("Unsupported platform")
else:
    {.pragma: BGFXImport, cdecl.}

import defines, bgfx
export defines

type RenderFrameEnum* = enum
    RenderFrame_NoContext,
    RenderFrame_Render,
    RenderFrame_Exiting,
    RenderFrame_Count


type PlatformData* {.importc: "bgfx_platform_data_t", header: "<bgfx/c99/platform.h>".} = object
    ndt* {.importc: "ndt".}: pointer
    nwh* {.importc: "nwh".}: pointer
    context* {.importc: "context".}: pointer
    backBuffer* {.importc: "backBuffer".}: pointer
    backBufferDS* {.importc: "backBufferDS".}: pointer
    session* {.importc: "session"}: pointer


type InternalData* {.importc: "bgfx_internal_data_t", header: "<bgfx/c99/platform.h>".} = object
    caps* {.importc: "caps".}: ptr Caps
    context* {.importc: "context".}: pointer

when defined(BGFX_SHARED_LIB) or defined(BGFX_BUILD_LIB):
    proc Begin*(decl: ptr VertexDecl, renderer: RendererType = RendererType_Noop) =
        {.emit: "bgfx_vertex_decl_begin(`decl`, `renderer`);".} 

    proc RenderFrame*(): RenderFrameEnum {.discardable.} =
        {.emit: "return bgfx_render_frame();".} 
    proc SetPlatformData*(data: ptr PlatformData) =
        {.emit: "bgfx_set_platform_data(`data`);".} 
    proc GetInternalData*(): ptr InternalData {.BGFXImport.} = 
        {.emit: "return bgfx_get_internal_data();".} 
    proc OverrideInternal*(handle: TextureHandle, pntr: pointer): pointer {.BGFXImport.} =
        {.emit: "return bgfx_override_internal_texture_ptr(`handle`, `pntr`);".} 
    proc OverrideInternal*(handle: TextureHandle, width, height: uint16_t, numMips: uint8_t, format: TextureFormat, flags: uint32_t = BGFX_TEXTURE_NONE): pointer {.BGFXImport.} =
        {.emit: "return bgfx_override_internal_texture(`handle`, `width`, `height`, `numMips`, `format`, `flags`);".} 
else:
    proc RenderFrame*(): RenderFrameEnum {.BGFXImport, discardable, importc: "bgfx_render_frame".}
    proc SetPlatformData*(data: ptr PlatformData) {.BGFXImport, importc: "bgfx_set_platform_data".}
    proc GetInternalData*(): ptr InternalData {.BGFXImport, importc: "bgfx_get_internal_data".}
    proc OverrideInternal*(handle: TextureHandle, pntr: pointer): pointer {.BGFXImport, importc: "bgfx_override_internal_texture_ptr".}
    proc OverrideInternal*(handle: TextureHandle, width, height: uint16_t, numMips: uint8_t, format: TextureFormat, flags: uint32_t = BGFX_TEXTURE_NONE): pointer {.BGFXImport, importc: "bgfx_override_internal_texture".}
