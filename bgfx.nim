# Copyright 2017 Cory Noll Crimmins - Golden
# License: BSD-2
# Wrapper/binding for bgfx

{.deadCodeElim: on.}

import bgfx_defines
export bgfx_defines
import strutils
import bgfx_types
export bgfx_types

proc getCurrentDir(): string = 
    let sourcePath = currentSourcePath()
    return sourcePath.substr(0,sourcePath.find("bgfx.nim")-1) 

proc relInclude(): string =
    let dir = getCurrentDir()
    var paths = @[
        "embed/bgfx/3rdparty",
        "embed/bgfx/3rdparty/dxsdk/include",
        "embed/bx/include",
        "embed/bgfx/3rdparty/khronos",
        "embed/bgfx/include"]
    when defined(macosx):
        paths.add("embed/bx/include/compat/osx")
    var includes: string = ""
    for path in items(paths):
        includes = includes & " -I" & dir & path
    return includes
{.passC: relInclude().}

when defined(BGFX_SHARED_LIB):
    {.passL:"-Wl,-rpath,. -Wl,-rpath,/usr/local/lib".}
    {.emit: "#include <bgfx/c99/bgfx.h>".}
    when defined(linux):
        {.pragma: BGFXImport, cdecl.}
        when defined(release):
            {.passL: "-lstdc++ -lbgfx-shared-libRelease -lrt -ldl -lX11 -lGL -lpthread".}
        else:
            {.passL: "-lstdc++ -lbgfx-shared-libDebug -lrt -ldl -lX11 -lGL -lpthread".}
    elif defined(macosx):
        when defined(release):
            {.passL: "libbgfx-shared-libRelease.dylib -framework Cocoa -framework QuartzCore -framework OpenGL -weak_framework Metal -weak_framework MetalKit".}   
        else:
            {.passL: "libbgfx-shared-libDebug.dylib -framework Cocoa -framework QuartzCore -framework OpenGL -weak_framework Metal -weak_framework MetalKit".}   
    else:
        raise newException("Unsupported platform")
elif defined(BGFX_DYNAMIC_LIB):
    when defined(windows):
        {.pragma: BGFXImport, dynlib: "bgfx-shared-lib(Debug|Release).dll", cdecl.}
    elif defined(macosx):
        {.pragma: BGFXImport, dynlib: "libbgfx-shared-lib(Debug|Release).dylib", cdecl.}
    elif defined(linux):
        {.pragma: BGFXImport, dynlib: "libbgfx-shared-lib(Debug|Release).so", cdecl.}
        {.passL: "-lpthread".}
    else:
        raise newException("Unsupported platform")
elif defined(BGFX_BUILD_LIB) or not defined(BGFX_DYNAMIC_LIB) or not defined(BGFX_SHARED_LIB) and not defined(macosx):
    {.compile: "bx_amalgamated.cpp".}
    when defined(macosx):
        {.compile: "bgfx_amalgamated.mm".}
    else:
        {.compile: "bgfx_amalgamated.cpp".}
    when defined(release):
        {.passC: "-DNDEBUG".}
    else:
        {.passC: "-D_DEBUG -DBGFX_CONFIG_DEBUG=1".}
    {.passC: "-I/usr/local/include -DBX_CONFIG_ENABLE_MSVC_LEVEL4_WARNINGS=1 -D__STDC_LIMIT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_CONSTANT_MACROS".}
    {.passL: "-lstdc++".} 
    when defined(linux):
        {.passC: "-std=c++11".} 
        {.passL: "-lrt -ldl -lX11 -lGL -lpthread".}
    elif defined(macosx):
        {.passL: "-framework Cocoa -framework QuartzCore -framework OpenGL -weak_framework Metal -weak_framework MetalKit".}   
    elif defined(windows):
        {.passC: "-std=c++11".} 
        {.passL: "-lgdi32 -lpsapi".}
    {.pragma: BGFXImport, cdecl.}  
else:
    raise newException("Unsupported platform")



#[ Casted argument functions ]#
when defined(BGFX_SHARED_LIB) or defined(BGFX_BUILD_LIB):
    proc Begin*(decl: ptr VertexDecl, renderer: RendererType = RendererType_Noop) =
        {.emit: "bgfx_vertex_decl_begin(`decl`, `renderer`);".} 
    proc End*(decl: ptr VertexDecl) =
        {.emit: "bgfx_vertex_decl_end(`decl`);".} 
    proc Add*(decl: ptr VertexDecl, attrib: Attrib; num: uint8_t; typ: AttribType; normalized: bool = false; asInt: bool = false) =
        {.emit: "bgfx_vertex_decl_add(`decl`, `attrib`, `num`, `typ`, `normalized`, `asInt`);".} 
    proc Skip*(decl: ptr VertexDecl, num: uint8_t) =
        {.emit: "bgfx_vertex_decl_skip(`decl`, `num`);".} 
    proc VertexPack*(input: array[4, cfloat]; inputNormalized: bool; attr: Attrib; decl: ptr VertexDecl; data: pointer; index: uint32_t = 0) =
        {.emit: "bgfx_vertex_pack(`input`, `inputNormalized`, `attr`, `decl`, (const void*)`data`, `index`);".}
    proc VertexUnpack*(output: array[4, cfloat]; attr: Attrib; decl: ptr VertexDecl; data: pointer; index: uint32_t = 0) =
        {.emit: "bgfx_vertex_unpack(`output`, `attr`, `decl`, (const void*)`data`, `index`);".}
    proc VertexConvert*(destDecl: ptr VertexDecl; destData: pointer; srcDecl: ptr VertexDecl; srcData: pointer; num: uint32_t = 1) =
        {.emit: "bgfx_vertex_convert(`destDecl`, `destData`, `srcDecl`, `srcData`, `num`);".}
    proc WeldVertices*(output: ptr uint16_t; decl: ptr VertexDecl; data: pointer; num: uint16_t; epsilon: cfloat = 0.001): uint16_t =
        {.emit: "return bgfx_weld_vertices(`output`, `decl`, `data`, `num`, `epsilon`);".}
    proc ConvertTopology*(conversion: TopologyConvert, dst: pointer, dstSize: uint32_t, indicies: pointer, numIndices: uint32_t, index32: bool): uint32_t =
        {.emit: "return bgfx_topology_convert(`conversion`, `dst`, `dstSize`, `indicies`, `numIndices`, `index32`);".}
    proc TopologySortTriList*(sort: TopologySort, dst: pointer, dstSize: uint32_t, dir: array[3,cfloat], pos: array[3, cfloat], vertices: pointer, stride: uint32_t, indices: pointer, numIndices: uint32_t, index32:bool) =
        {.emit: "bgfx_topology_sort_tri_list(`sort`, `dst`, `dstSize`, `dir`, `pos`, `vertices`, `stride`, `indices`, `numIndices`, `index32`);".}
    proc ImageSwizzleBgra8*(dst: pointer; width: uint32_t; height: uint32_t; pitch: uint32_t; src: pointer) =
        {.emit: "bgfx_image_swizzle_bgra8(`dst`, `width`, `height`, `pitch`, `src`);".}
    proc ImageRgba8Downsample2x2*(dst: pointer; width: uint32_t; height: uint32_t; pitch: uint32_t; src: pointer) =
        {.emit: "bgfx_image_rgba8_downsample_2x2(`dst`, `width`, `height`, `pitch`, `src`);".}
    proc GetSupportedRenderers*(max: uint8_t = 0; enm: ptr RendererType = nil): uint8_t =
        {.emit: "return bgfx_get_supported_renderers(`max`, `enm`);".}
    proc GetRendererName*(typ: RendererType): cstring =
        {.emit: "return bgfx_get_renderer_name(`typ`);".}
    proc Init*(typ: RendererType = RendererType_Count; vendorId: uint16_t = BGFX_PCI_ID_NONE; deviceId: uint16_t = 0; callback: ptr CallbackI = nil; allocator: ptr AllocatorI = nil): bool {.discardable.} =
        {.emit: "return bgfx_init(`typ`, `vendorId`, `deviceId`, `callback`, `allocator`);".}
    proc Shutdown*() =
        {.emit: "bgfx_shutdown();".}
    proc Reset*(width: uint32_t; height: uint32_t; flags: uint32_t = BGFX_RESET_NONE) =
        {.emit: "bgfx_reset(`width`, `height`, `flags`);".}
    proc Frame*(capture: bool = false): uint32_t {.discardable.} =
        {.emit: "return bgfx_frame(`capture`);".}
    proc GetRendererType*(): RendererType =
        {.emit: "return bgfx_get_renderer_type();".}
    proc GetCaps*(): ptr Caps =
        {.emit: "return bgfx_get_caps();".}
    proc GetHmd*(): ptr HMD =
        {.emit: "return (bgfx_hmd_t *)bgfx_get_hmd();".}
    proc GetStats*(): ptr Stats =
        {.emit: "return bgfx_get_stats();".}
    proc Alloc*(size: uint32_t): ptr Memory =
        {.emit: "return (bgfx_memory_t *)bgfx_alloc(`size`);".}
    proc Copy*(data: pointer; size: uint32_t): ptr Memory =
        {.emit: "return bgfx_copy(`data`, `size`);".}
    proc MakeRef*(data: pointer; size: uint32_t; releaseFn: ReleaseFn = nil; userData: pointer = nil): ptr Memory =
        {.emit: "return bgfx_make_ref_release(`data`, `size`, `releaseFn`, `userData`);".}
    proc SetDebug*(debug: uint32_t) =
        {.emit: "bgfx_set_debug(`debug`);".}
    proc DebugTextClear*(attr: uint8_t = 0; small: bool = false) =
        {.emit: "bgfx_dbg_text_clear(`attr`, `small`);".}
    proc DebugTextPrintf*(x: uint16_t; y: uint16_t; attr: uint8_t; format: cstring) {.importc: "bgfx_dbg_text_printf", nodecl, varargs.}
    proc DebugTextVPrintf*(x: uint16_t; y: uint16_t; attr: uint8_t; format: cstring, argList: va_list) =
        {.emit: "bgfx_dbg_text_vprintf(`x`, `y`, `attr`, `format`, `argList`);".}
    proc DebugTextImage*(x: uint16_t; y: uint16_t; width: uint16_t; height: uint16_t; data: auto; pitch: uint16_t) =
        {.emit: "bgfx_dbg_text_image(`x`, `y`, `width`, `height`, (const void*)`data`, `pitch`);".} 
    proc CreateIndexBuffer*(mem: ptr Memory; flags: uint16_t = BGFX_BUFFER_NONE): IndexBufferHandle =
        {.emit: "return bgfx_create_index_buffer(`mem`, `flags`);".}
    proc DestroyIndexBuffer*(handle: IndexBufferHandle) =
        {.emit: "bgfx_destroy_index_buffer(`handle`);".}
    proc CreateVertexBuffer*(mem: ptr Memory; decl: ptr VertexDecl; flags: uint16_t = BGFX_BUFFER_NONE): VertexBufferHandle =
        {.emit: "return bgfx_create_vertex_buffer(`mem`, `decl`, `flags`);".}
    proc DestroyVertexBuffer*(handle: VertexBufferHandle) =
        {.emit: "bgfx_destroy_vertex_buffer(`handle`);".}
    proc CreateDynamicIndexBuffer*(num: uint32_t; flags: uint16_t = BGFX_BUFFER_NONE): DynamicIndexBufferHandle =
        {.emit: "return bgfx_create_dynamic_index_buffer(`num`, `flags`);".}
    proc CreateDynamicIndexBuffer*(mem: ptr Memory; flags: uint16_t = BGFX_BUFFER_NONE): DynamicIndexBufferHandle =
        {.emit: "return bgfx_create_dynamic_index_buffer(`mem`, `flags`);"}
    proc UpdateDynamicIndexBuffer*(handle: DynamicIndexBufferHandle; startIndex: uint32_t; mem: ptr Memory) =
        {.emit: "bgfx_update_dynamic_index_buffer(`handle`, `startIndex`, `mem`);".}
    proc DestroyDynamicIndexBuffer*(handle: DynamicIndexBufferHandle) =
        {.emit: "bgfx_destroy_dynamic_index_buffer(`handle`);".}
    proc CreateDynamicVertexBuffer*(num: uint32_t; decl: ptr VertexDecl; flags: uint16_t = BGFX_BUFFER_NONE): DynamicVertexBufferHandle =
        {.emit: "return bgfx_create_dynamic_vertex_buffer(`num`, `decl`, `flags`);".}
    proc CreateDynamicVertexBuffer*(mem: ptr Memory; decl: ptr VertexDecl; flags: uint16_t = BGFX_BUFFER_NONE): DynamicVertexBufferHandle =
        {.emit: "return bgfx_create_dynamic_vertex_buffer(`mem`, `decl`, `flags`);".}
    proc UpdateDynamicVertexBuffer*(handle: DynamicVertexBufferHandle; startVertex: uint32_t; mem: ptr Memory) =
        {.emit: "bgfx_update_dynamic_vertex_buffer(`handle`, `startVertex`, `mem`);".}
    proc DestroyDynamicVertexBuffer*(handle: DynamicVertexBufferHandle) =
        {.emit: "bgfx_destroy_dynamic_vertex_buffer(`handle`);".}
    proc GetAvailTransientIndexBuffer*(num: uint32_t): uint32_t =
        {.emit: "return bgfx_get_avail_transient_index_buffer(`num`);".}
    proc GetAvailTransientVertexBuffer*(num: uint32_t; decl: ptr VertexDecl): uint32_t =
        {.emit: "return bgfx_get_avail_transient_vertex_buffer(`num`, `decl`);".}
    proc GetAvailInstanceDataBuffer*(num: uint32_t; stride: uint16_t): uint32_t =
        {.emit: "return bgfx_get_avail_instance_data_buffer(`num`, `stride`);".}
    proc AllocTransientIndexBuffer*(tib: ptr TransientIndexBuffer; num: uint32_t) =
        {.emit: "bgfx_alloc_transient_index_buffer(`tib`, `num`);".}
    proc AllocTransientVertexBuffer*(tvb: ptr TransientVertexBuffer; num: uint32_t; decl: ptr VertexDecl) =
        {.emit: "bgfx_alloc_transient_vertex_buffer(`tvb`, `num`, `decl`);".}
    proc AllocTransientBuffers*(tvb: ptr TransientVertexBuffer; decl: ptr VertexDecl; numVertices: uint32_t; tib: ptr TransientIndexBuffer; numIndices: uint32_t): bool =
        {.emit: "return bgfx_alloc_transient_buffers(`tvb`, `decl`, `numVertices`, `tib`, `numIndices`);".}
    proc AllocInstanceDataBuffer*(num: uint32_t; stride: uint16_t): ptr InstanceDataBuffer =
        {.emit: "return bgfx_alloc_instance_data_buffer(`num`, `stride`);".}
    proc CreateIndirectBuffer*(num: uint32_t): IndirectBufferHandle =
        {.emit: "return bgfx_create_indirect_buffer(`num`);".}
    proc DestroyIndirectBuffer*(handle: IndirectBufferHandle) =
        {.emit: "bgfx_destroy_index_buffer(`handle`);".}
    proc CreateShader*(mem: ptr Memory): ShaderHandle =
        {.emit: "return bgfx_create_shader(`mem`);".}
    proc GetShaderUniforms*(handle: ShaderHandle; uniforms: ptr UniformHandle = nil; max: uint16_t = 0): uint16_t =
        {.emit: "return bgfx_get_shader_uniforms(`handle`, `uniforms`, `max`);".}
    proc DestroyShader*(handle: ShaderHandle) =
        {.emit: "bgfx_destroy_shader(`handle`);".}
    proc CreateProgram*(vsh: ShaderHandle; fsh: ShaderHandle; destroyShaders: bool = false): ProgramHandle =
        {.emit: "return bgfx_create_program(`vsh`, `fsh`, `DestroyShader`);".}
    proc CreateProgram*(csh: ShaderHandle; destroyShaders: bool = false): ProgramHandle =
        {.emit: "return bgfx_create_compute_program(`csh`, `destroyShaders`);".}
    proc DestroyProgram*(handle: ProgramHandle) =
        {.emit: "bgfx_destroy_program(`handle`);".}
    proc IsTextureValid*(depth: uint16_t, cubeMap: bool, numLayers: uint16_t, format: TextureFormat, flags: uint32_t): bool =
        {.emit: "return bgfx_is_texture_valid(`depth`, `cubeMap`, `numLayers`, `format`, `flags`);".}
    proc CalcTextureSize*(info: ptr TextureInfo; width: uint16_t; height: uint16_t; depth: uint16_t; cubeMap: bool; hasMips: bool; numLayers: uint16_t; format: TextureFormat) =
        {.emit: "bgfx_calc_texture_size(`info`, `width`, `height`, `depth`, `cubeMap`, `hasMips`, `numLayers`, `format`);".}
    proc CreateTexture*(mem: ptr Memory; flags: uint32_t = BGFX_TEXTURE_NONE; skip: uint8_t = 0; info: ptr TextureInfo = nil): TextureHandle =
        {.emit: "return bgfx_create_texture(`mem`, `flags`, `skip`, `info`);".}
    proc CreateTexture2d*(width: uint16_t; height: uint16_t; hasMips: bool; numLayers: uint16_t; format: TextureFormat; flags: uint32_t = BGFX_TEXTURE_NONE; mem: ptr Memory = nil): TextureHandle =
        {.emit: "return bgfx_create_texture_2d(`width`, `height`, `hasMips`, `numLayers`, `format`, `flags`, `mem`);".}
    proc CreateTexture2d*(ratio: BackbufferRatio; hasMips: bool; numLayers: uint16_t; format: TextureFormat; flags: uint32_t = BGFX_TEXTURE_NONE): TextureHandle =
        {.emit: "return bgfx_create_texture_2d(`ratio`, `hasMips`, `numLayers`, `format`, `flags`);".}
    proc CreateTexture3d*(width: uint16_t; height: uint16_t; depth: uint16_t; hasMips: bool; format: TextureFormat; flags: uint32_t = BGFX_TEXTURE_NONE; mem: ptr Memory = nil): TextureHandle =
        {.emit: "return bgfx_create_texture_3d(`width`, `height`, `depth`, `hasMips`, `format`, `flags`, `mem`);".}
    proc CreateTextureCube*(size: uint16_t; hasMips: bool; numLayers: uint16_t; format: TextureFormat; flags: uint32_t = BGFX_TEXTURE_NONE; mem: ptr Memory = nil): TextureHandle =
        {.emit: "return bgfx_create_texture_cube(`size`, `hasMips`, `numLayers`, `format`, `flags`, `mem`);".}
    proc UpdateTexture2d*(handle: TextureHandle; layer: uint16_t; mip: uint8_t; x: uint16_t; y: uint16_t; width: uint16_t; height: uint16_t; mem: ptr Memory; pitch: uint16_t = uint16.high) =
        {.emit: "bgfx_update_texture_2d(`handle`, `layer`, `mip`, `x`, `y`, `width`, `height`, `mem`, `pitch`);".}
    proc UpdateTexture3d*(handle: TextureHandle; mip: uint8_t; x: uint16_t; y: uint16_t; z: uint16_t; width: uint16_t; height: uint16_t; depth: uint16_t; mem: ptr Memory) =
        {.emit: "bgfx_update_texture_3d(`handle`, `mip`, `x`, `y`, `z`, `width`, `height`, `depth`, `mem`);".}
    proc UpdateTextureCube*(handle: TextureHandle; layer: uint16_t; side: uint8_t; mip: uint8_t; x: uint16_t; y: uint16_t; width: uint16_t; height: uint16_t; mem: ptr Memory; pitch: uint16_t = uint16.high) =
        {.emit: "bgfx_update_texture_cube(`handle`, `layer`, `side`, `mip`, `x`, `y`, `width`, `height`, `mem`, `pitch`);".}
    proc ReadTexture*(handle: TextureHandle; data: pointer, mip: uint8_t = 0): uint32_t =
        {.emit: "return bgfx_read_texture(`handle`, `data`, `mip`);".}
    proc GetTexture*(handle: FrameBufferHandle; attachment: uint8_t): TextureHandle =
        {.emit: "return bgfx_get_texture(`handle`, `attachment`);".}
    proc DestroyTexture*(handle: TextureHandle) =
        {.emit: "bgfx_destroy_texture(`handle`);".}
    proc CreateFrameBuffer*(width: uint16_t; height: uint16_t; format: TextureFormat; textureFlags: uint32_t = BGFX_TEXTURE_U_CLAMP or BGFX_TEXTURE_V_CLAMP): FrameBufferHandle =
        {.emit: "return bgfx_create_frame_buffer(`width`, `height`, `format`, `textureFlags`);".}
    proc CreateFrameBuffer*(ratio: BackbufferRatio; format: TextureFormat; textureFlags: uint32_t = BGFX_TEXTURE_U_CLAMP or BGFX_TEXTURE_V_CLAMP): FrameBufferHandle =
        {.emit: "return bgfx_create_frame_buffer(`ratio`, `format`, `textureFlags`);".}
    proc CreateFrameBuffer*(num: uint8_t; attachment: ptr TextureHandle; destroyTextures: bool = false): FrameBufferHandle =
        {.emit: "return bgfx_create_frame_buffer(`num`, `attachment`, `destroyTextures`);".}
    proc CreateFrameBuffer*(num: uint8_t; attachment: ptr Attachment; destroyTextures: bool = false): FrameBufferHandle =
        {.emit: "return bgfx_create_frame_buffer(`num`, `attachment`, `destroyTextures`);".}
    proc CreateFrameBuffer*(nwh: pointer; width: uint16_t; height: uint16_t; depthFormat: TextureFormat = TextureFormat_Unknown): FrameBufferHandle =
        {.emit: "return bgfx_create_frame_buffer(`nwh`, `width`, `height`, `depthFormat`);".}
    proc DestroyFrameBuffer*(handle: FrameBufferHandle) =
        {.emit: "bgfx_destroy_frame_buffer(`handle`);".}
    proc CreateUniform*(name: cstring; typ: UniformType; num: uint16_t = 1): UniformHandle =
        {.emit: "return bgfx_create_uniform(`name`, `typ`, `num`);".}
    proc GetUniformInfo*(handle: UniformHandle, info: ptr UniformInfo) =
        {.emit: "bgfx_get_uniform_info(`handle`, `info`);".}
    proc DestroyUniform*(handle: UniformHandle) =
        {.emit: "bgfx_destroy_uniform(`handle`);".}
    proc CreateOcclusionQuery*(): OcclusionQueryHandle =
        {.emit: "return bgfx_create_occlusion_query();".}
    proc GetResult*(handle: OcclusionQueryHandle): OcclusionQueryResult =
        {.emit: "return bgfx_get_result(`handle`);".}
    proc DestroyOcclusionQuery*(handle: OcclusionQueryHandle) =
        {.emit: "bgfx_destroy_occlusion_query(`handle`);".}
    proc SetPaletteColor*(index: uint8_t; rgba: array[4,cfloat]) =
        {.emit: "bgfx_set_palette_color(`index`, `rgba`);".}
    proc SetViewName*(id: uint8_t; name: cstring) =
        {.emit: "bgfx_set_view_name(`id`, `name`);".}
    proc SetViewRect*(id: uint8_t; x: uint16_t; y: uint16_t; width: uint16_t; height: uint16_t) =
        {.emit: "bgfx_set_view_rect(`id`, `x`, `y`, `width`, `height`);".}
    proc SetViewRect*(id: uint8_t; x: uint16_t; y: uint16_t; ratio: BackbufferRatio) =
        {.emit: "bgfx_set_view_rect(`id`, `x`, `y`, `ratio`);".}
    proc SetViewScissor*(id: uint8_t; x: uint16_t = 0; y: uint16_t = 0; width: uint16_t = 0; height: uint16_t = 0) =
        {.emit: "bgfx_set_view_scissor(`id`, `x`, `y`, `width`, `height`);".}
    proc SetViewClear*(id: uint8_t; flags: uint16_t; rgba: uint32_t = 0x000000ff; depth: cfloat = 1.0; stencil: uint8_t = 0) =
        {.emit: "bgfx_set_view_clear(`id`, `flags`, `rgba`, `depth`, `stencil`);".}
    proc SetViewClear*(id: uint8_t; flags: uint16_t; depth: cfloat; stencil: uint8_t; c0: uint8_t = uint8.high; c1: uint8_t = uint8.high; c2: uint8_t = uint8.high; c3: uint8_t = uint8.high; c4: uint8_t = uint8.high; c5: uint8_t = uint8.high; c6: uint8_t = uint8.high; c7: uint8_t) =
        {.emit: "bgfx_set_view_clear(`id`, `flags`, `depth`, `stencil`, `c0`, `c1`, `c2`, `c3`, `c4`, `c5`, `c6`, `c7`);".}
    proc SetViewSeq*(id: uint8_t; enabled: bool) =
        {.emit: "bgfx_set_view_seq(`id`, `enabled`);".}
    proc SetViewFrameBuffer*(id: uint8_t; handle: FrameBufferHandle) =
        {.emit: "bgfx_set_view_frame_buffer(`id`, `handle`);".}
    proc SetViewTransform*(id: uint8_t; view: pointer; projL: pointer; flags: uint8_t = BGFX_VIEW_STEREO; projR: pointer = nil) =
        {.emit: "bgfx_set_view_transform_stereo(`id`, `view`, `projL`, `flags`, `projR`);".}
    proc SetViewOrder*(id: uint8_t = 0; num: uint8_t = uint8.high; remap: pointer = nil) =
        {.emit: "bgfx_set_view_order(`id`, `num`, `remap`);".}
    proc ResetView*(id: uint8_t) =
        {.emit: "bgfx_reset_view(`id`);".}
    proc SetMarker*(marker: cstring) =
        {.emit: "bgfx_set_marker(`marker`);".}
    proc SetState*(state: uint64_t; rgba: uint32_t = 0) =
        {.emit: "bgfx_set_state(`state`, `rgba`);".}
    proc SetCondition*(handle: OcclusionQueryHandle; visible: bool) =
        {.emit: "bgfx_set_condition(`handle`, `visible`);".}
    proc SetStencil*(fstencil: uint32_t; bstencil: uint32_t = BGFX_STENCIL_NONE) =
        {.emit: "bgfx_set_stencil(`fstencil`, `bstencil`);".}
    proc SetScissor*(x: uint16_t; y: uint16_t; width: uint16_t; height: uint16_t): uint16_t =
        {.emit: "return bgfx_set_scissor(`x`, `y`, `width`, `height`);".}
    proc SetScissor*(cache: uint16_t = uint16.high) =
        {.emit: "bgfx_set_scissor(`cache`);".}
    proc SetTransform*(mtx: pointer; num: uint16_t = 1'u16): uint32_t {.discardable.} =
        {.emit: "return bgfx_set_transform(`mtx`, `num`);".}
    proc AllocTransform*(transform: ptr Transform; num: uint16_t): uint32_t =
        {.emit: "return bgfx_alloc_transform(`transform`, `num`);".}
    proc SetTransformCached*(cache: uint32_t; num: uint16_t) =
        {.emit: "bgfx_set_transform(`cache`, `num`);".}
    proc SetUniform*(handle: UniformHandle; value: pointer; num: uint16_t) =
        {.emit: "bgfx_set_uniform(`handle`, `value`, `num`);".}
    proc SetIndexBuffer*(handle: IndexBufferHandle; firstIndex: uint32_t = 0; numIndices: uint32_t = uint32.high) =
        {.emit: "bgfx_set_index_buffer(`handle`, `firstIndex`, `numIndices`);".}
    proc SetIndexBuffer*(handle: DynamicIndexBufferHandle; firstIndex: uint32_t = 0; numIndices: uint32_t = uint32.high) =
        {.emit: "bgfx_set_index_buffer(`handle`, `firstIndex`, `numIndices`);".}
    proc SetIndexBuffer*(tib: ptr TransientIndexBuffer; firstIndex: uint32_t = 0; numIndices: uint32_t = uint32.high) =
        {.emit: "bgfx_set_index_buffer(`tib`, `firstIndex`, `numIndices`);".}
    proc SetVertexBuffer*(handle: VertexBufferHandle; startVertex: uint32_t = 0; numVertices: uint32_t = uint32.high) =
        {.emit: "bgfx_set_vertex_buffer(`handle`, `startVertex`, `numVertices`);".}
    proc SetVertexBuffer*(handle: DynamicVertexBufferHandle; startVertex: uint32_t = 0; numVertices: uint32_t = uint32.high) =
        {.emit: "bgfx_set_dynamic_vertex_buffer(`handle`, `startVertex`, `numVertices`);".}
    proc SetVertexBuffer*(tvb: ptr TransientVertexBuffer; startVertex: uint32_t = 0; numVertices: uint32_t = uint32.high) =
        {.emit: "bgfx_set_transient_vertex_buffer(`tvb`, `startVertex`, `numVertices`);".}
    proc SetInstanceDataBuffer*(idb: ptr InstanceDataBuffer; num: uint32_t = uint32.high) =
        {.emit: "bgfx_set_instance_data_buffer(`idb`, `num`);".}
    proc SetInstanceDataBuffer*(handle: VertexBufferHandle; startVertex: uint32_t; num: uint32_t) =
        {.emit: "bgfx_set_instance_data_buffer(`handle`, `startVertex`, `num`);".}
    proc SetInstanceDataBuffer*(handle: DynamicVertexBufferHandle; startVertex: uint32_t; num: uint32_t) =
        {.emit: "bgfx_set_instance_data_buffer(`handle`, `startVertex`, `num`);".}
    proc SetTexture*(stage: uint8_t; sampler: UniformHandle; handle: TextureHandle; flags: uint32_t = uint32.high) =
        {.emit: "bgfx_set_texture(`stage`, `sampler`, `handle`, `flags`);".}
    proc Touch*(id: uint8_t): uint32_t {.discardable.} =
        {.emit: "return bgfx_touch(`id`);".}
    proc Submit*(id: uint8_t; handle: ProgramHandle; depth: int32_t = 0;preserveState: bool = false): uint32_t {.discardable.} =
        {.emit: "return bgfx_submit(`id`, `handle`, `depth`, `preserveState`);".}
    proc Submit*(id: uint8_t; program: ProgramHandle; occlusionQuery: OcclusionQueryHandle; depth: int32_t = 0; preserveState: bool = false): uint32_t {.discardable.} =
        {.emit: "return bgfx_submit(`id`, `program`, `occlusionQuery`, `depth`, `preserveState`);".}
    proc Submit*(id: uint8_t; handle: ProgramHandle; indirectHandle: IndirectBufferHandle; start: uint16_t = 0; num: uint16_t = 1; depth: int32_t = 0; preserveState: bool = false): uint32_t {.discardable.} =
        {.emit: "return bgfx_submit(`id`, `handle`, `indirectHandle`, `start`, `num`, `depth`, `preserveState`);".}
    proc SetImage*(stage: uint8_t; sampler: UniformHandle; handle: TextureHandle; mip: uint8_t; access: Access; format: TextureFormat = TextureFormat_Count) =
        {.emit: "bgfx_set_image(`stage`, `sampler`, `handle`, `mip`, `access`, `format`);".}
    proc SetBuffer*(stage: uint8_t; handle: IndexBufferHandle; access: Access) =
        {.emit: "bgfx_set_index_buffer(`stage`, `handle`, `access`);".}
    proc SetBuffer*(stage: uint8_t; handle: VertexBufferHandle; access: Access) =
        {.emit: "bgfx_set_vertex_buffer(`stage`, `handle`, `access`);".}
    proc SetBuffer*(stage: uint8_t; handle: DynamicIndexBufferHandle; access: Access) =
        {.emit: "bgfx_set_dynamic_index_buffer(`stage`, `handle`, `access`);".}
    proc SetBuffer*(stage: uint8_t; handle: DynamicVertexBufferHandle; access: Access) =
        {.emit: "bgfx_set_dynamic_vertex_buffer(`stage`, `handle`, `access`);".}
    proc SetBuffer*(stage: uint8_t; handle: IndirectBufferHandle; access: Access) =
        {.emit: "bgfx_set_compute_indirect_buffer(`stage`, `handle`, `access`);".}
    proc Dispatch*(id: uint8_t; handle: ProgramHandle; numX: uint16_t = 1; numY: uint16_t = 1; numZ: uint16_t = 1; flags: uint8_t = BGFX_SUBMIT_EYE_FIRST): uint32_t =
        {.emit: "return bgfx_dispatch(`id`, `handle`, `numX`, `numY`, `numZ`, `flags`);".}
    proc Dispatch*(id: uint8_t; handle: ProgramHandle; indirectHandle: IndirectBufferHandle; start: uint16_t = 0; num: uint16_t = 1; flags: uint8_t = BGFX_SUBMIT_EYE_FIRST): uint32_t =
        {.emit: "return bgfx_dispatch(`id`, `handle`, `indirectHandle`, `start`, `num`, `flags`);".}
    proc Discard*() =
        {.emit: "bgfx_discard();".}
    proc Blit*(id: uint8_t; dst: TextureHandle; dstMip: uint8_t; dstX: uint16_t; dstY: uint16_t; dstZ: uint16_t; src: TextureHandle; srcMip: uint8_t; srcX: uint16_t = 0; srcY: uint16_t = 0; srcZ: uint16_t; width: uint16_t = uint16.high; height: uint16_t = uint16.high; depth: uint16_t = uint16.high) =
        {.emit: "bgfx_blit(`id`, `dst`, `dstMip`, `dstX`, `dstY`, `dstZ`, `src`, `srcMip`, `srcX`, `srcY`, `srcZ`, `width`, `height`, `depth`);".}
    proc SaveScreenShot*(filePath: cstring) =
        {.emit: "bgfx_save_screen_shot(`filePath`);".}
else:
    proc Begin*(decl: ptr VertexDecl, renderer: RendererType = RendererType_Noop) {.BGFXImport, importc: "bgfx_vertex_decl_begin".}
    proc End*(decl: ptr VertexDecl) {.BGFXImport, importc: "bgfx_vertex_decl_end".}
    proc Add*(decl: ptr VertexDecl, attrib: Attrib; num: uint8_t; typ: AttribType; normalized: bool = false; asInt: bool = false) {.BGFXImport, importc: "bgfx_vertex_decl_add".}
    proc Skip*(decl: ptr VertexDecl, num: uint8_t) {.BGFXImport, importc: "bgfx_vertex_decl_skip".}
    proc VertexPack*(input: array[4, cfloat]; inputNormalized: bool; attr: Attrib; decl: ptr VertexDecl; data: pointer; index: uint32_t = 0) {.BGFXImport, importc: "bgfx_vertex_pack".}
    proc VertexUnpack*(output: array[4, cfloat]; attr: Attrib; decl: ptr VertexDecl; data: pointer; index: uint32_t = 0) {.BGFXImport, importc: "bgfx_vertex_unpack".}
    proc VertexConvert*(destDecl: ptr VertexDecl; destData: pointer; srcDecl: ptr VertexDecl; srcData: pointer; num: uint32_t = 1) {.BGFXImport, importc: "bgfx_vertex_convert".}
    proc WeldVertices*(output: ptr uint16_t; decl: ptr VertexDecl; data: pointer; num: uint16_t; epsilon: cfloat = 0.001): uint16_t {.BGFXImport, importc: "bgfx_weld_vertices".}
    proc ConvertTopology*(conversion: TopologyConvert, dst: pointer, dstSize: uint32_t, indicies: pointer, numIndices: uint32_t, index32: bool): uint32_t {.BGFXImport, importc: "bgfx_topology_convert".}
    proc TopologySortTriList*(sort: TopologySort, dst: pointer, dstSize: uint32_t, dir: array[3,cfloat], pos: array[3, cfloat], vertices: pointer, stride: uint32_t, indices: pointer, numIndices: uint32_t, index32:bool) {.BGFXImport, importc: "bgfx_topology_sort_tri_list".}
    proc ImageSwizzleBgra8*(dst: pointer; width: uint32_t; height: uint32_t; pitch: uint32_t; src: pointer) {.BGFXImport, importc: "bgfx_image_swizzle_bgra8".}
    proc ImageRgba8Downsample2x2*(dst: pointer; width: uint32_t; height: uint32_t; pitch: uint32_t; src: pointer) {.BGFXImport, importc: "bgfx_image_rgba8_downsample_2x2".}
    proc GetSupportedRenderers*(max: uint8_t = 0; enm: ptr RendererType = nil): uint8_t {.BGFXImport, importc: "bgfx_get_supported_renderers".}
    proc GetRendererName*(typ: RendererType): cstring {.BGFXImport, importc: "bgfx_get_renderer_name".}
    proc Init*(typ: RendererType = RendererType_Count; vendorId: uint16_t = BGFX_PCI_ID_NONE; deviceId: uint16_t = 0; callback: ptr CallbackI = nil; allocator: ptr AllocatorI = nil): bool {.BGFXImport, discardable, importc: "bgfx_init".}
    proc Shutdown*() {.BGFXImport, importc: "bgfx_shutdown".}
    proc Reset*(width: uint32_t; height: uint32_t; flags: uint32_t = BGFX_RESET_NONE) {.BGFXImport, importc: "bgfx_reset".}
    proc Frame*(capture: bool = false): uint32_t {.BGFXImport, discardable, importc: "bgfx_frame".}
    proc GetRendererType*(): RendererType {.BGFXImport, importc: "bgfx_get_renderer_type".}
    proc GetCaps*(): ptr Caps {.BGFXImport, importc: "bgfx_get_caps".}
    proc GetHmd*(): ptr HMD {.BGFXImport, importc: "bgfx_get_hmd".}
    proc GetStats*(): ptr Stats {.BGFXImport, importc: "bgfx_get_stats".}
    proc Alloc*(size: uint32_t): ptr Memory {.BGFXImport, importc: "bgfx_alloc".}
    proc Copy*(data: pointer; size: uint32_t): ptr Memory {.BGFXImport, importc: "bgfx_copy".}
    proc MakeRef*(data: pointer; size: uint32_t; releaseFn: ReleaseFn = nil; userData: pointer = nil): ptr Memory {.BGFXImport, importc: "bgfx_make_ref_release".}
    proc SetDebug*(debug: uint32_t) {.BGFXImport, importc: "bgfx_set_debug".}
    proc DebugTextClear*(attr: uint8_t = 0; small: bool = false) {.BGFXImport, importc: "bgfx_dbg_text_clear".}
    proc DebugTextPrintf*(x: uint16_t; y: uint16_t; attr: uint8_t; format: cstring) {.BGFXImport, varargs, importc: "bgfx_dbg_text_printf".}
    proc DebugTextVPrintf*(x: uint16_t; y: uint16_t; attr: uint8_t; format: cstring, argList: va_list) {.BGFXImport, importc: "bgfx_dbg_text_vprintf".}
    proc DebugTextImage*(x: uint16_t; y: uint16_t; width: uint16_t; height: uint16_t; data: auto; pitch: uint16_t) {.BGFXImport, importc: "bgfx_dbg_text_image".}
    proc CreateIndexBuffer*(mem: ptr Memory; flags: uint16_t = BGFX_BUFFER_NONE): IndexBufferHandle {.BGFXImport, importc: "bgfx_create_index_buffer".}
    proc DestroyIndexBuffer*(handle: IndexBufferHandle) {.BGFXImport, importc: "bgfx_destroy_index_buffer".}
    proc CreateVertexBuffer*(mem: ptr Memory; decl: ptr VertexDecl; flags: uint16_t = BGFX_BUFFER_NONE): VertexBufferHandle {.BGFXImport, importc: "bgfx_create_vertex_buffer".}
    proc DestroyVertexBuffer*(handle: VertexBufferHandle) {.BGFXImport, importc: "bgfx_destroy_vertex_buffer".}
    proc CreateDynamicIndexBuffer*(num: uint32_t; flags: uint16_t = BGFX_BUFFER_NONE): DynamicIndexBufferHandle {.BGFXImport, importc: "bgfx_create_dynamic_index_buffer".}
    proc CreateDynamicIndexBuffer*(mem: ptr Memory; flags: uint16_t = BGFX_BUFFER_NONE): DynamicIndexBufferHandle {.BGFXImport, importc: "bgfx_create_dynamic_index_buffer_mem".}
    proc UpdateDynamicIndexBuffer*(handle: DynamicIndexBufferHandle; startIndex: uint32_t; mem: ptr Memory) {.BGFXImport, importc: "bgfx_update_dynamic_index_buffer".}
    proc DestroyDynamicIndexBuffer*(handle: DynamicIndexBufferHandle) {.BGFXImport, importc: "bgfx_destroy_dynamic_index_buffer".}
    proc CreateDynamicVertexBuffer*(num: uint32_t; decl: ptr VertexDecl; flags: uint16_t = BGFX_BUFFER_NONE): DynamicVertexBufferHandle {.BGFXImport, importc: "bgfx_create_dynamic_vertex_buffer".}
    proc CreateDynamicVertexBuffer*(mem: ptr Memory; decl: ptr VertexDecl; flags: uint16_t = BGFX_BUFFER_NONE): DynamicVertexBufferHandle {.BGFXImport, importc: "bgfx_create_dynamic_vertex_buffer_mem".}
    proc UpdateDynamicVertexBuffer*(handle: DynamicVertexBufferHandle; startVertex: uint32_t; mem: ptr Memory) {.BGFXImport, importc: "bgfx_update_dynamic_vertex_buffer".}
    proc DestroyDynamicVertexBuffer*(handle: DynamicVertexBufferHandle) {.BGFXImport, importc: "bgfx_destroy_dynamic_vertex_buffer".}
    proc GetAvailTransientIndexBuffer*(num: uint32_t): uint32_t {.BGFXImport, importc: "bgfx_get_avail_transient_index_buffer".}
    proc GetAvailTransientVertexBuffer*(num: uint32_t;decl: ptr VertexDecl): uint32_t {.BGFXImport, importc: "bgfx_get_avail_transient_vertex_buffer".}
    proc GetAvailInstanceDataBuffer*(num: uint32_t; stride: uint16_t): uint32_t {.BGFXImport, importc: "bgfx_get_avail_instance_data_buffer".}
    proc AllocTransientIndexBuffer*(tib: ptr TransientIndexBuffer; num: uint32_t) {.BGFXImport, importc: "bgfx_alloc_transient_index_buffer".}
    proc AllocTransientVertexBuffer*(tvb: ptr TransientVertexBuffer; num: uint32_t; decl: ptr VertexDecl) {.BGFXImport, importc: "bgfx_alloc_transient_vertex_buffer".}
    proc AllocTransientBuffers*(tvb: ptr TransientVertexBuffer; decl: ptr VertexDecl; numVertices: uint32_t; tib: ptr TransientIndexBuffer; numIndices: uint32_t): bool {.BGFXImport, importc: "bgfx_alloc_transient_buffers".}
    proc AllocInstanceDataBuffer*(num: uint32_t; stride: uint16_t): ptr InstanceDataBuffer {.BGFXImport, importc: "bgfx_alloc_instance_data_buffer".}
    proc CreateIndirectBuffer*(num: uint32_t): IndirectBufferHandle {.BGFXImport, importc: "bgfx_create_indirect_buffer".}
    proc DestroyIndirectBuffer*(handle: IndirectBufferHandle) {.BGFXImport, importc: "bgfx_destroy_indirect_buffer".}
    proc CreateShader*(mem: ptr Memory): ShaderHandle {.BGFXImport, importc: "bgfx_create_shader".}
    proc GetShaderUniforms*(handle: ShaderHandle; uniforms: ptr UniformHandle = nil; max: uint16_t = 0): uint16_t {.BGFXImport, importc: "bgfx_get_shader_uniforms".}
    proc DestroyShader*(handle: ShaderHandle) {.BGFXImport, importc: "bgfx_destroy_shader".}
    proc CreateProgram*(vsh: ShaderHandle; fsh: ShaderHandle; destroyShaders: bool = false): ProgramHandle {.BGFXImport, importc: "bgfx_create_program".}
    proc CreateProgram*(csh: ShaderHandle; destroyShaders: bool = false): ProgramHandle {.BGFXImport, importc: "bgfx_create_compute_program".}
    proc DestroyProgram*(handle: ProgramHandle) {.BGFXImport, importc: "bgfx_destroy_program".}
    proc IsTextureValid*(depth: uint16_t, cubeMap: bool, numLayers: uint16_t, format: TextureFormat, flags: uint32_t): bool {.BGFXImport, importc: "bgfx_is_texture_valid".}
    proc CalcTextureSize*(info: ptr TextureInfo; width: uint16_t; height: uint16_t; depth: uint16_t; cubeMap: bool; hasMips: bool; numLayers: uint16_t; format: TextureFormat) {.BGFXImport, importc: "bgfx_calc_texture_size".}
    proc CreateTexture*(mem: ptr Memory; flags: uint32_t = BGFX_TEXTURE_NONE; skip: uint8_t = 0; info: ptr TextureInfo = nil): TextureHandle {.BGFXImport, importc: "bgfx_create_texture".}
    proc CreateTexture2d*(width: uint16_t; height: uint16_t; hasMips: bool; numLayers: uint16_t; format: TextureFormat; flags: uint32_t = BGFX_TEXTURE_NONE; mem: ptr Memory = nil): TextureHandle {.BGFXImport, importc: "bgfx_create_texture_2d".}
    proc CreateTexture2d*(ratio: BackbufferRatio; hasMips: bool; numLayers: uint16_t; format: TextureFormat; flags: uint32_t = BGFX_TEXTURE_NONE): TextureHandle {.BGFXImport, importc: "bgfx_create_texture_2d_scaled".}
    proc CreateTexture3d*(width: uint16_t; height: uint16_t; depth: uint16_t; hasMips: bool; format: TextureFormat; flags: uint32_t = BGFX_TEXTURE_NONE; mem: ptr Memory = nil): TextureHandle {.BGFXImport, importc: "bgfx_create_texture_3d".}
    proc CreateTextureCube*(size: uint16_t; hasMips: bool; numLayers: uint16_t; format: TextureFormat; flags: uint32_t = BGFX_TEXTURE_NONE; mem: ptr Memory = nil): TextureHandle {.BGFXImport, importc: "bgfx_create_texture_cube".}
    proc UpdateTexture2d*(handle: TextureHandle; layer: uint16_t; mip: uint8_t; x: uint16_t; y: uint16_t; width: uint16_t; height: uint16_t; mem: ptr Memory; pitch: uint16_t = uint16.high) {.BGFXImport, importc: "bgfx_update_texture_2d".}
    proc UpdateTexture3d*(handle: TextureHandle; mip: uint8_t; x: uint16_t; y: uint16_t; z: uint16_t; width: uint16_t; height: uint16_t; depth: uint16_t; mem: ptr Memory) {.BGFXImport, importc: "bgfx_update_texture_3d".}
    proc UpdateTextureCube*(handle: TextureHandle; layer: uint16_t; side: uint8_t; mip: uint8_t; x: uint16_t; y: uint16_t; width: uint16_t; height: uint16_t; mem: ptr Memory; pitch: uint16_t = uint16.high) {.BGFXImport, importc: "bgfx_update_texture_cube".}
    proc ReadTexture*(handle: TextureHandle; data: pointer, mip: uint8_t = 0): uint32_t {.BGFXImport, importc: "bgfx_read_texture".}
    proc GetTexture*(handle: FrameBufferHandle; attachment: uint8_t): TextureHandle {.BGFXImport, importc: "bgfx_get_texture".}
    proc DestroyTexture*(handle: TextureHandle) {.BGFXImport, importc: "bgfx_destroy_texture".}
    proc CreateFrameBuffer*(width: uint16_t; height: uint16_t; format: TextureFormat; textureFlags: uint32_t = BGFX_TEXTURE_U_CLAMP or BGFX_TEXTURE_V_CLAMP): FrameBufferHandle {.BGFXImport, importc: "bgfx_create_frame_buffer".}
    proc CreateFrameBuffer*(ratio: BackbufferRatio; format: TextureFormat; textureFlags: uint32_t = BGFX_TEXTURE_U_CLAMP or BGFX_TEXTURE_V_CLAMP): FrameBufferHandle {.BGFXImport, importc: "bgfx_create_frame_buffer_scaled".}
    proc CreateFrameBuffer*(num: uint8_t; attachment: ptr TextureHandle; destroyTextures: bool = false): FrameBufferHandle {.BGFXImport, importc: "bgfx_create_frame_buffer_from_handles".}
    proc CreateFrameBuffer*(num: uint8_t; attachment: ptr Attachment; destroyTextures: bool = false): FrameBufferHandle {.BGFXImport, importc: "bgfx_create_frame_buffer_from_attachment".}
    proc CreateFrameBuffer*(nwh: pointer; width: uint16_t; height: uint16_t; depthFormat: TextureFormat = TextureFormat_Unknown): FrameBufferHandle {.BGFXImport, importc: "bgfx_create_frame_buffer_from_nwh".}
    proc DestroyFrameBuffer*(handle: FrameBufferHandle) {.BGFXImport, importc: "bgfx_destroy_frame_buffer".}
    proc CreateUniform*(name: cstring; typ: UniformType; num: uint16_t = 1): UniformHandle {.BGFXImport, importc: "bgfx_create_uniform".}
    proc GetUniformInfo*(handle: UniformHandle, info: ptr UniformInfo) {.BGFXImport, importc: "bgfx_get_uniform_info".}
    proc DestroyUniform*(handle: UniformHandle) {.BGFXImport, importc: "bgfx_destroy_uniform".}
    proc CreateOcclusionQuery*(): OcclusionQueryHandle {.BGFXImport, importc: "bgfx_create_occlusion_query".}
    proc GetResult*(handle: OcclusionQueryHandle): OcclusionQueryResult {.BGFXImport, importc: "bgfx_get_result".}
    proc DestroyOcclusionQuery*(handle: OcclusionQueryHandle) {.BGFXImport, importc: "bgfx_destroy_occlusion_query".}
    proc SetPaletteColor*(index: uint8_t; rgba: array[4,cfloat]) {.BGFXImport, importc: "bgfx_set_palette_color".}
    proc SetViewName*(id: uint8_t; name: cstring) {.BGFXImport, importc: "bgfx_set_view_name".}
    proc SetViewRect*(id: uint8_t; x: uint16_t; y: uint16_t; width: uint16_t; height: uint16_t) {.BGFXImport, importc: "bgfx_set_view_rect".}
    proc SetViewRect*(id: uint8_t; x: uint16_t; y: uint16_t; ratio: BackbufferRatio) {.BGFXImport, importc: "bgfx_set_view_rect_auto".}
    proc SetViewScissor*(id: uint8_t; x: uint16_t = 0; y: uint16_t = 0; width: uint16_t = 0; height: uint16_t = 0) {.BGFXImport, importc: "bgfx_set_view_scissor".}
    proc SetViewClear*(id: uint8_t; flags: uint16_t; rgba: uint32_t = 0x000000ff; depth: cfloat = 1.0; stencil: uint8_t = 0) {.BGFXImport, importc: "bgfx_set_view_clear".}
    proc SetViewClear*(id: uint8_t; flags: uint16_t; depth: cfloat; stencil: uint8_t; c0: uint8_t = uint8.high; c1: uint8_t = uint8.high; c2: uint8_t = uint8.high; c3: uint8_t = uint8.high; c4: uint8_t = uint8.high; c5: uint8_t = uint8.high; c6: uint8_t = uint8.high; c7: uint8_t) {.BGFXImport, importc: "bgfx_set_view_clear_mrt".}
    proc SetViewSeq*(id: uint8_t; enabled: bool) {.BGFXImport, importc: "bgfx_set_view_seq".}
    proc SetViewFrameBuffer*(id: uint8_t; handle: FrameBufferHandle) {.BGFXImport, importc: "bgfx_set_view_frame_buffer".}
    proc SetViewTransform*(id: uint8_t; view: pointer; projL: pointer;flags: uint8_t = BGFX_VIEW_STEREO; projR: pointer = nil) {.BGFXImport, importc: "bgfx_set_view_transform_stereo".}
    proc SetViewOrder*(id: uint8_t = 0; num: uint8_t = uint8.high; remap: pointer = nil) {.BGFXImport, importc: "bgfx_set_view_order".}
    proc ResetView*(id: uint8_t) {.BGFXImport, importc: "bgfx_reset_view".}
    proc SetMarker*(marker: cstring) {.BGFXImport, importc: "bgfx_set_marker".}
    proc SetState*(state: uint64_t; rgba: uint32_t = 0) {.BGFXImport, importc: "bgfx_set_state".}
    proc SetCondition*(handle: OcclusionQueryHandle; visible: bool) {.BGFXImport, importc: "bgfx_set_condition".}
    proc SetStencil*(fstencil: uint32_t; bstencil: uint32_t = BGFX_STENCIL_NONE) {.BGFXImport, importc: "bgfx_set_stencil".}
    proc SetScissor*(x: uint16_t; y: uint16_t; width: uint16_t; height: uint16_t): uint16_t {.BGFXImport, importc: "bgfx_set_scissor".}
    proc SetScissor*(cache: uint16_t = uint16.high) {.BGFXImport, importc: "bgfx_set_scissor_cached".}
    proc SetTransform*(mtx: pointer; num: uint16_t = 1'u16): uint32_t {.BGFXImport, discardable, importc: "bgfx_set_transform".}
    proc AllocTransform*(transform: ptr Transform; num: uint16_t): uint32_t {.BGFXImport, importc: "bgfx_alloc_transform".}
    proc SetTransformCached*(cache: uint32_t; num: uint16_t) {.BGFXImport, importc: "bgfx_set_transform_cached".}
    proc SetUniform*(handle: UniformHandle; value: pointer; num: uint16_t) {.BGFXImport, importc: "bgfx_set_uniform".}
    proc SetIndexBuffer*(handle: IndexBufferHandle; firstIndex: uint32_t = 0; numIndices: uint32_t = uint32.high) {.BGFXImport, importc: "bgfx_set_index_buffer".}
    proc SetIndexBuffer*(handle: DynamicIndexBufferHandle; firstIndex: uint32_t = 0; numIndices: uint32_t = uint32.high) {.BGFXImport, importc: "bgfx_set_dynamic_index_buffer".}
    proc SetIndexBuffer*(tib: ptr TransientIndexBuffer; firstIndex: uint32_t = 0; numIndices: uint32_t = uint32.high) {.BGFXImport, importc: "bgfx_set_transient_index_buffer".}
    proc SetVertexBuffer*(handle: VertexBufferHandle; startVertex: uint32_t = 0; numVertices: uint32_t = uint32.high) {.BGFXImport, importc: "bgfx_set_vertex_buffer".}
    proc SetVertexBuffer*(handle: DynamicVertexBufferHandle; startVertex: uint32_t = 0; numVertices: uint32_t = uint32.high) {.BGFXImport, importc: "bgfx_set_dynamic_vertex_buffer".}
    proc SetVertexBuffer*(tvb: ptr TransientVertexBuffer; startVertex: uint32_t = 0; numVertices: uint32_t = uint32.high) {.BGFXImport, importc: "bgfx_set_transient_vertex_buffer".}
    proc SetInstanceDataBuffer*(idb: ptr InstanceDataBuffer; num: uint32_t = uint32.high) {.BGFXImport, importc: "bgfx_set_instance_data_buffer".}
    proc SetInstanceDataBuffer*(handle: VertexBufferHandle; startVertex: uint32_t; num: uint32_t) {.BGFXImport, importc: "bgfx_set_instance_data_from_vertex_buffer".}
    proc SetInstanceDataBuffer*(handle: DynamicVertexBufferHandle; startVertex: uint32_t;num: uint32_t) {.BGFXImport, importc: "bgfx_set_instance_data_from_dynamic_vertex_buffer".}
    proc SetTexture*(stage: uint8_t; sampler: UniformHandle; handle: TextureHandle; flags: uint32_t = uint32.high) {.BGFXImport, importc: "bgfx_set_texture".}
    proc Touch*(id: uint8_t): uint32_t {.BGFXImport, discardable, importc: "bgfx_touch".}
    proc Submit*(id: uint8_t; handle: ProgramHandle; depth: int32_t = 0;preserveState: bool = false): uint32_t {.BGFXImport, discardable, importc: "bgfx_submit".}
    proc Submit*(id: uint8_t; program: ProgramHandle;occlusionQuery: OcclusionQueryHandle; depth: int32_t = 0;preserveState: bool = false): uint32_t {.BGFXImport, discardable, importc: "bgfx_submit_occlusion_query".}
    proc Submit*(id: uint8_t; handle: ProgramHandle;indirectHandle: IndirectBufferHandle;start: uint16_t = 0; num: uint16_t = 1; depth: int32_t = 0;preserveState: bool = false): uint32_t {.BGFXImport, discardable, importc: "bgfx_submit_indirect".}
    proc SetImage*(stage: uint8_t; sampler: UniformHandle;handle: TextureHandle; mip: uint8_t;access: Access; format: TextureFormat = TextureFormat_Count) {.BGFXImport, importc: "bgfx_set_image".}
    proc SetBuffer*(stage: uint8_t;handle: IndexBufferHandle;access: Access) {.BGFXImport, importc: "bgfx_set_compute_index_buffer".}
    proc SetBuffer*(stage: uint8_t;handle: VertexBufferHandle;access: Access) {.BGFXImport, importc: "bgfx_set_compute_vertex_buffer".}
    proc SetBuffer*(stage: uint8_t;handle: DynamicIndexBufferHandle; access: Access) {.BGFXImport, importc: "bgfx_set_compute_dynamic_index_buffer".}
    proc SetBuffer*(stage: uint8_t;handle: DynamicVertexBufferHandle; access: Access) {.BGFXImport, importc: "bgfx_set_compute_dynamic_vertex_buffer".}
    proc SetBuffer*(stage: uint8_t;handle: IndirectBufferHandle;access: Access) {.BGFXImport, importc: "bgfx_set_compute_indirect_buffer".}
    proc Dispatch*(id: uint8_t; handle: ProgramHandle; numX: uint16_t = 1; numY: uint16_t = 1; numZ: uint16_t = 1; flags: uint8_t = BGFX_SUBMIT_EYE_FIRST): uint32_t {.BGFXImport, importc: "bgfx_dispatch".}
    proc Dispatch*(id: uint8_t; handle: ProgramHandle;indirectHandle: IndirectBufferHandle;start: uint16_t = 0; num: uint16_t = 1; flags: uint8_t = BGFX_SUBMIT_EYE_FIRST): uint32_t {.BGFXImport, importc: "bgfx_dispatch_indirect".}
    proc Discard*() {.BGFXImport, importc: "bgfx_discard".}
    proc Blit*(id: uint8_t; dst: TextureHandle; dstMip: uint8_t;dstX: uint16_t; dstY: uint16_t; dstZ: uint16_t;src: TextureHandle; srcMip: uint8_t; srcX: uint16_t = 0;srcY: uint16_t = 0; srcZ: uint16_t; width: uint16_t = uint16.high; height: uint16_t = uint16.high;depth: uint16_t = uint16.high) {.BGFXImport, importc: "bgfx_blit".}
    proc SaveScreenShot*(filePath: cstring) {.BGFXImport, importc: "bgfx_save_screen_shot".}

proc Has*(decl: ptr VertexDecl, attrib: Attrib): bool =
    decl.attributes[attrib] != invalidHandle
proc GetOffset*(decl: ptr VertexDecl, attrib: Attrib): uint16_t =
    decl.offset[attrib]
proc GetStride*(decl: ptr VertexDecl): uint16_t =
    decl.stride
proc GetSize*(decl: ptr VertexDecl, num: uint32_t): uint32_t =
    num*decl.stride
proc isValid*(self: DynamicIndexBufferHandle): bool = self.idx != invalidHandle
proc isValid*(self: DynamicVertexBufferHandle): bool = self.idx != invalidHandle
proc isValid*(self: FrameBufferHandle): bool = self.idx != invalidHandle
proc isValid*(self: IndexBufferHandle): bool = self.idx != invalidHandle
proc isValid*(self: IndirectBufferHandle): bool = self.idx != invalidHandle
proc isValid*(self: OcclusionQueryHandle): bool = self.idx != invalidHandle
proc isValid*(self: ProgramHandle): bool = self.idx != invalidHandle
proc isValid*(self: ShaderHandle): bool = self.idx != invalidHandle
proc isValid*(self: TextureHandle): bool = self.idx != invalidHandle
proc isValid*(self: UniformHandle): bool = self.idx != invalidHandle
proc isValid*(self: VertexBufferHandle): bool = self.idx != invalidHandle
proc isValid*(self: VertexDeclHandle): bool = self.idx != invalidHandle    
proc SetPaletteColor*(index: uint8_t; rgba: uint32_t) =
    SetPaletteColor(index, [
        cast[cfloat](cast[uint8](rgba shr 24)) * 1.0'f32 / 255.0'f32,
        cast[cfloat](cast[uint8](rgba shr 16)) * 1.0'f32 / 255.0'f32,
        cast[cfloat](cast[uint8](rgba shr 8))  * 1.0'f32 / 255.0'f32,
        cast[cfloat](cast[uint8](rgba shr 0))  * 1.0'f32 / 255.0'f32,])
proc SetPaletteColor*(index: uint8_t; r, g, b, a: cfloat) =
    SetPaletteColor(index, [r, g, b, a])