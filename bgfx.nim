# Copyright 2016 Cory Noll Crimmins - Golden
# License: BSD-2
# Wrapper/binding for bgfx

{.deadCodeElim: on.}

import defines
export defines

when defined(BGFX_SHARED_LIB_API):
    when defined(windows):
        {.pragma: BGFXImport, dynlib: "bgfx-shared-lib(Debug|Release).dll", cdecl.}
    elif defined(macosx):
        {.pragma: BGFXImport, dynlib: "libbgfx-shared-lib(Debug|Release).dylib", cdecl.}
    elif defined(linux):
        {.pragma: BGFXImport, dynlib: "libbgfx-shared-lib(Debug|Release).so", cdecl.}
    else:
        raise newException("Unsupported platform, need lib names for platform")
else:
    when defined(Windows):
        when defined(release):
            {.passL: "-lbgfxRelease -lpsapi -lgdi32".}
        else:
            {.passL: "-lbgfxDebug -lpsapi -lgdi32".}
    {.pragma: BGFXImport, header: "<bgfx/c99/bgfx.h>", cdecl.}

type va_list* {.importc,header:"<stdarg.h>".} = distinct pointer

type
    uint64_t* {.importc,header:"<stdint.h>".} = uint64
    uint32_t* {.importc,header:"<stdint.h>".} = uint32
    uint16_t* {.importc,header:"<stdint.h>".} = uint16
    uint8_t* {.importc,header:"<stdint.h>".} = uint8

    int64_t* {.importc,header:"<stdint.h>".} = int64
    int32_t* {.importc,header:"<stdint.h>".} = int32
    int16_t* {.importc,header:"<stdint.h>".} = int16
    int8_t* {.importc,header:"<stdint.h>".} = int8


type Fatal* {.importc: "bgfx_fatal_t", header: "<bgfx/c99/bgfx.h>".} = enum
    Fatal_DebugCheck
    Fatal_MinimumRequiredSpecs
    Fatal_InvalidShader
    Fatal_UnableToInitialize
    Fatal_UnableToCreateTexture
    Fatal_DeviceLost
    Fatal_Count

type RendererType* {.importc: "bgfx_renderer_type_t", header: "<bgfx/c99/bgfx.h>".} = enum
    RendererType_Null
    RendererType_Direct3D9
    RendererType_Direct3D11
    RendererType_Direct3D12
    RendererType_Metal
    RendererType_OpenGLES
    RendererType_OpenGL
    RendererType_Vulkan
    RendererType_Count

type Access* {.importc: "bgfx_access_t", header: "<bgfx/c99/bgfx.h>".} = enum
    Access_Read
    Access_Write
    Access_ReadWrite
    Access_Count

type Attrib* {.importc: "bgfx_attrib_t", header: "<bgfx/c99/bgfx.h>".} = enum
    Attrib_Position  # a_position
    Attrib_Normal    # a_normal
    Attrib_Tangent   # a_tangent
    Attrib_Bitangent # a_bitangent
    Attrib_Color0    # a_color0
    Attrib_Color1    # a_color1
    Attrib_Indices   # a_indices
    Attrib_Weight    # a_weight
    Attrib_TexCoord0 # a_texcoord0
    Attrib_TexCoord1 # a_texcoord1
    Attrib_TexCoord2 # a_texcoord2
    Attrib_TexCoord3 # a_texcoord3
    Attrib_TexCoord4 # a_texcoord4
    Attrib_TexCoord5 # a_texcoord5
    Attrib_TexCoord6 # a_texcoord6
    Attrib_TexCoord7 # a_texcoord7
    Attrib_Count

type AttribType* {.importc: "bgfx_attrib_type_t", header: "<bgfx/c99/bgfx.h>".} = enum
    AttribType_Uint8  # Uint8
    AttribType_Uint10 # Uint10, availability depends on: `BGFX_CAPS_VERTEX_ATTRIB_UINT10`.
    AttribType_Int16  # Int16
    AttribType_Half   # Half, availability depends on: `BGFX_CAPS_VERTEX_ATTRIB_HALF`.
    AttribType_Float  # Float
    AttribType_Count

type TextureFormat* {.importc: "bgfx_texture_format_t", header: "<bgfx/c99/bgfx.h>".} = enum
    TextureFormat_BC1    # DXT1
    TextureFormat_BC2    # DXT3
    TextureFormat_BC3    # DXT5
    TextureFormat_BC4    # LATC1/ATI1
    TextureFormat_BC5    # LATC2/ATI2
    TextureFormat_BC6H   # BC6H
    TextureFormat_BC7    # BC7
    TextureFormat_ETC1   # ETC1 RGB8
    TextureFormat_ETC2   # ETC2 RGB8
    TextureFormat_ETC2A  # ETC2 RGBA8
    TextureFormat_ETC2A1 # ETC2 RGB8A1
    TextureFormat_PTC12  # PVRTC1 RGB 2BPP
    TextureFormat_PTC14  # PVRTC1 RGB 4BPP
    TextureFormat_PTC12A # PVRTC1 RGBA 2BPP
    TextureFormat_PTC14A # PVRTC1 RGBA 4BPP
    TextureFormat_PTC22  # PVRTC2 RGBA 2BPP
    TextureFormat_PTC24  # PVRTC2 RGBA 4BPP
    # Compressed formats above.
    TextureFormat_Unknown
    TextureFormat_R1
    TextureFormat_A8
    TextureFormat_R8
    TextureFormat_R8I
    TextureFormat_R8U
    TextureFormat_R8S
    TextureFormat_R16
    TextureFormat_R16I
    TextureFormat_R16U
    TextureFormat_R16F
    TextureFormat_R16S
    TextureFormat_R32I
    TextureFormat_R32U
    TextureFormat_R32F
    TextureFormat_RG8
    TextureFormat_RG8I
    TextureFormat_RG8U
    TextureFormat_RG8S
    TextureFormat_RG16
    TextureFormat_RG16I
    TextureFormat_RG16U
    TextureFormat_RG16F
    TextureFormat_RG16S
    TextureFormat_RG32I
    TextureFormat_RG32U
    TextureFormat_RG32F
    TextureFormat_RGB8
    TextureFormat_RGB8I
    TextureFormat_RGB8U
    TextureFormat_RGB8S
    TextureFormat_RGB9E5F
    TextureFormat_BGRA8
    TextureFormat_RGBA8
    TextureFormat_RGBA8I
    TextureFormat_RGBA8U
    TextureFormat_RGBA8S
    TextureFormat_RGBA16
    TextureFormat_RGBA16I
    TextureFormat_RGBA16U
    TextureFormat_RGBA16F
    TextureFormat_RGBA16S
    TextureFormat_RGBA32I
    TextureFormat_RGBA32U
    TextureFormat_RGBA32F
    TextureFormat_R5G6B5
    TextureFormat_RGBA4
    TextureFormat_RGB5A1
    TextureFormat_RGB10A2
    TextureFormat_R11G11B10F
    TextureFormat_UnknownDepth
    # Depth formats below.
    TextureFormat_D16
    TextureFormat_D24
    TextureFormat_D24S8
    TextureFormat_D32
    TextureFormat_D16F
    TextureFormat_D24F
    TextureFormat_D32F
    TextureFormat_D0S8
    TextureFormat_Count

type UniformType* {.importc: "bgfx_uniform_type_t", header: "<bgfx/c99/bgfx.h>".} = enum
    UniformType_Int1
    UniformType_End
    UniformType_Vec4
    UniformType_Mat3
    UniformType_Mat4
    UniformType_Count

type BackbufferRatio* {.importc: "bgfx_backbuffer_ratio_t", header: "<bgfx/c99/bgfx.h>".} = enum
    BackbufferRatio_Equal     # Equal to backbuffer.
    BackbufferRatio_Half      # One half size of backbuffer.
    BackbufferRatio_Quarter   # One quarter size of backbuffer.
    BackbufferRatio_Eighth    # One eighth size of backbuffer.
    BackbufferRatio_Sixteenth # One sixteenth size of backbuffer.
    BackbufferRatio_Double    # Double size of backbuffer.
    BackbufferRatio_Count

type OcclusionQueryResult* {.importc: "bgfx_occlusion_query_result_t", header: "<bgfx/c99/bgfx.h>".} = enum
    OcclusionQueryResult_Invisible # Query failed test.
    OcclusionQueryResult_Visible   # Query passed test.
    OcclusionQueryResult_NoResult  # Query result is not available yet.
    OcclusionQueryResult_Count

type TopologyConvert* {.importc: "bgfx_topology_convert_t", header: "<bgfx/c99/bgfx.h>".} = enum
    TopologyConvert_TriListFlipWinding  # Flip winding order of triangle list.
    TopologyConvert_TriListToLineList   # Convert triangle list to line list.
    TopologyConvert_TriStripToTriList   # Convert triangle strip to triangle list.
    TopologyConvert_LineStripToLineList # Convert line strip to line list.
    TopologyConvert_Count

type TopologySort* {.importc: "bgfx_topology_sort_t", header: "<bgfx/c99/bgfx.h>".} = enum
    TopologySort_DirectionFrontToBackMin #
    TopologySort_DirectionFrontToBackAvg #
    TopologySort_DirectionFrontToBackMax #
    TopologySort_DirectionBackToFrontMin #
    TopologySort_DirectionBackToFrontAvg #
    TopologySort_DirectionBackToFrontMax #
    TopologySort_DistanceFrontToBackMin  #
    TopologySort_DistanceFrontToBackAvg  #
    TopologySort_DistanceFrontToBackMax  #
    TopologySort_DistanceBackToFrontMin  #
    TopologySort_DistanceBackToFrontAvg  #
    TopologySort_DistanceBackToFrontMax  #
    TopologySort_Count

const invalidHandle* = uint16.high

type
    DynamicIndexBufferHandle* {.importc: "bgfx_dynamic_index_buffer_handle_t", header: "<bgfx/c99/bgfx.h>".} = object
        idx*: uint16_t
    DynamicVertexBufferHandle* {.importc: "bgfx_dynamic_vertex_buffer_handle_t", header: "<bgfx/c99/bgfx.h>".} = object
        idx*: uint16_t
    FrameBufferHandle* {.importc: "bgfx_frame_buffer_handle_t", header: "<bgfx/c99/bgfx.h>".} = object
        idx*: uint16_t
    IndexBufferHandle* {.importc: "bgfx_index_buffer_handle_t", header: "<bgfx/c99/bgfx.h>".} = object
        idx*: uint16_t
    IndirectBufferHandle* {.importc: "bgfx_indirect_buffer_handle_t", header: "<bgfx/c99/bgfx.h>".} = object
        idx*: uint16_t
    OcclusionQueryHandle* {.importc: "bgfx_occlusion_query_handle_t", header: "<bgfx/c99/bgfx.h>".} = object
        idx*: uint16_t
    ProgramHandle* {.importc: "bgfx_program_handle_t", header: "<bgfx/c99/bgfx.h>".} = object
        idx*: uint16_t
    ShaderHandle* {.importc: "bgfx_shader_handle_t", header: "<bgfx/c99/bgfx.h>".} = object
        idx*: uint16_t
    TextureHandle* {.importc: "bgfx_texture_handle_t", header: "<bgfx/c99/bgfx.h>".} = object
        idx*: uint16_t
    UniformHandle* {.importc: "bgfx_uniform_handle_t", header: "<bgfx/c99/bgfx.h>".} = object
        idx*: uint16_t
    VertexBufferHandle* {.importc: "bgfx_vertex_buffer_handle_t", header: "<bgfx/c99/bgfx.h>".} = object
        idx*: uint16_t
    VertexDeclHandle* {.importc: "bgfx_vertex_decl_handle_t", header: "<bgfx/c99/bgfx.h>".} = object
        idx*: uint16_t

type
    CBFatalProc* = proc (this: ptr CallbackI; code: Fatal; str: cstring) {.cdecl.}
    CBTraceVargsProc* = proc (this: ptr CallbackI; filePath: cstring; line: uint16; format: cstring, argList: va_list) {.cdecl.}
    CBCacheReadSizeProc* = proc (this: ptr CallbackI; id: uint64): uint32 {.cdecl.}
    CBCacheReadProc* = proc (this: ptr CallbackI; id: uint64; data: pointer; size: uint32): bool {.cdecl.}
    CBCacheWriteProc* = proc (this: ptr CallbackI; id: uint64; data: pointer; size: uint32) {.cdecl.}
    CBScreenShotProc* = proc (this: ptr CallbackI; filePath: cstring; width: uint32; height: uint32; pitch: uint32; data: pointer; size: uint32; yflip: bool) {.cdecl.}
    CBCaptureBegin* = proc (this: ptr CallbackI; width: uint32; height: uint32; pitch: uint32; format: TextureFormat; yflip: bool) {.cdecl.}
    CBCaptureEnd* = proc (this: ptr CallbackI) {.cdecl.}
    CBCaptureFrame* = proc (this: ptr CallbackI; data: pointer; size: uint32) {.cdecl.}
    CallbackVTable* {.importc: "bgfx_callback_vtbl_t", header: "<bgfx/c99/bgfx.h>".} = object
        fatal* {.importc: "fatal".}: CBFatalProc
        trace_vargs* {.importc: "trace_vargs".}: CBTraceVargsProc
        cache_read_size* {.importc: "cache_read_size".}: CBCacheReadSizeProc
        cache_read* {.importc: "cache_read".}: CBCacheReadProc
        cache_write* {.importc: "cache_write".}: CBCacheWriteProc
        screen_shot* {.importc: "screen_shot".}: CBScreenShotProc
        capture_begin* {.importc: "capture_begin".}: CBCaptureBegin
        capture_end* {.importc: "capture_end".}: CBCaptureEnd
        capture_frame* {.importc: "capture_frame".}: CBCaptureFrame
    CallbackI* {.importc: "bgfx_callback_interface_t", header: "<bgfx/c99/bgfx.h>".} = object
        vtbl* {.importc: "vtbl".}: ptr CallbackVTable

type
    AllocatorVTable* {.importc: "bgfx_allocator_vtbl_t", header: "<bgfx/c99/bgfx.h>".} = object
        realloc* {.importc: "realloc".}: proc (this: ptr CallbackI; pntr: pointer, size: csize, align: csize, file: cstring, line: uint32_t)
    AllocatorI* {.importc: "bgfx_allocator_interface_t", header: "<bgfx/c99/bgfx.h>".} = object
        vtbl* {.importc: "vtbl".}: ptr CallbackVTable

type ReleaseFn* {.importc: "bgfx_release_fn_t", header: "<bgfx/c99/bgfx.h>".} = proc(pointer, userData: pointer)

type Memory* {.importc: "bgfx_memory_t", header: "<bgfx/c99/bgfx.h>".} = object
        data* {.importc: "data".}: ptr uint8_t
        size* {.importc: "size".}: uint32_t

type CapsGPU* {.importc: "bgfx_caps_gpu_t", header: "<bgfx/c99/bgfx.h>".} = object
        vendorId* {.importc: "vendorId".}: uint16_t
        deviceId* {.importc: "deviceId".}: uint16_t

type Caps* {.importc: "bgfx_caps_t", header: "<bgfx/c99/bgfx.h>".} = object
    rendererType* {.importc: "rendererType".}: RendererType
    supported* {.importc: "supported".}: uint64_t
    maxDrawCalls* {.importc: "maxDrawCalls".}: uint32_t
    maxTextureSize* {.importc: "maxTextureSize".}: uint16_t
    maxViews* {.importc: "maxViews".}: uint16_t
    maxFBAttachments* {.importc: "maxFBAttachments".}: uint8_t
    numGPUs* {.importc: "numGPUs".}: uint8_t
    homogeneousDepth* {.importc: "homogeneousDepth".}: bool
    originBottomLeft* {.importc: "originBottomLeft".}: bool
    vendorId* {.importc: "vendorId".}: uint16_t
    deviceId* {.importc: "deviceId".}: uint16_t
    gpu* {.importc: "gpu".}: array[4, CapsGPU]
    formats* {.importc: "formats".}: array[TextureFormat_Count, uint16_t]

type TransientIndexBuffer* {.importc: "bgfx_transient_index_buffer_t", header: "<bgfx/c99/bgfx.h>".} = object
    data* {.importc: "data".}: ptr uint8_t
    size* {.importc: "size".}: uint32_t
    startIndex* {.importc: "startIndex".}: uint32_t
    handle* {.importc: "handle".}: IndexBufferHandle

type TransientVertexBuffer* {.importc: "bgfx_transient_vertex_buffer_t", header: "<bgfx/c99/bgfx.h>".} = object
    data* {.importc: "data".}: ptr uint8_t
    size* {.importc: "size".}: uint32_t
    startVertex* {.importc: "startVertex".}: uint32_t
    stride* {.importc: "stride".}: uint16_t
    handle* {.importc: "handle".}: VertexBufferHandle
    decl* {.importc: "decl".}: VertexDeclHandle

type InstanceDataBuffer* {.importc: "bgfx_instance_data_buffer_t", header: "<bgfx/c99/bgfx.h>".} = object
    data* {.importc: "data".}: ptr uint8_t
    size* {.importc: "size".}: uint32_t
    offset* {.importc: "offset".}: uint32_t
    num* {.importc: "num".}: uint32_t
    stride* {.importc: "stride".}: uint16_t
    handle* {.importc: "handle".}: VertexBufferHandle

type TextureInfo* {.importc: "bgfx_texture_info_t", header: "<bgfx/c99/bgfx.h>".} = object
    format* {.importc: "format".}: TextureFormat
    storageSize* {.importc: "storageSize".}: uint32_t
    width* {.importc: "width".}: uint16_t
    height* {.importc: "height".}: uint16_t
    depth* {.importc: "depth".}: uint16_t
    numMips* {.importc: "numMips".}: uint8_t
    bitsPerPixel* {.importc: "bitsPerPixel".}: uint8_t
    cubeMap* {.importc: "cubeMap".}: bool

type Attachment* {.importc: "bgfx_attachment_t", header: "<bgfx/c99/bgfx.h>".} = object
    handle* {.importc: "handle".}: TextureHandle
    mip* {.importc: "mip".}: uint16_t
    layer* {.importc: "layer".}: uint16_t

type Transform* {.importc: "bgfx_transform_t", header: "<bgfx/c99/bgfx.h>".} = object
    data* {.importc: "data".}: ptr cfloat
    size* {.importc: "num".}: uint32_t

type HMDeye* {.importc: "bgfx_hmd_eye_t", header: "<bgfx/c99/bgfx.h>".} = object
    rotation* {.importc: "rotation".}: array[4, cfloat]
    translation* {.importc: "translation".}: array[3, cfloat]
    fov* {.importc: "fov".}: array[4, cfloat]
    viewOffset* {.importc: "viewOffset".}: array[3, cfloat]
    projection* {.importc: "projection".}: array[16, cfloat]
    pixelsPerTanAngle* {.importc: "pixelsPerTanAngle".}: array[2, cfloat]

type HMD* {.importc: "bgfx_hmd_t", header: "<bgfx/c99/bgfx.h>".} = object
    eye* {.importc: "eye".}: array[2, HMDeye]
    width* {.importc: "width".}: uint16_t
    height* {.importc: "height".}: uint16_t
    deviceWidth* {.importc: "deviceWidth".}: uint32_t
    deviceHeight* {.importc: "deviceHeight".}: uint32_t
    flags* {.importc: "flags".}: uint8_t

type Stats* {.importc: "bgfx_stats_t", header: "<bgfx/c99/bgfx.h>".} = object
    cpuTimeBegin* {.importc: "cpuTimeBegin".}: uint64_t
    cpuTimeEnd* {.importc: "cpuTimeEnd".}: uint64_t
    cpuTimerFreq* {.importc: "cpuTimerFreq".}: uint64_t
    gpuTimeBegin* {.importc: "gpuTimeBegin".}: uint64_t
    gpuTimeEnd* {.importc: "gpuTimeEnd".}: uint64_t
    gpuTimerFreq* {.importc: "gpuTimerFreq".}: uint64_t
    waitRender* {.importc: "waitRender".}: int64_t
    waitSubmit* {.importc: "waitSubmit".}: int64_t

type VertexDecl* {.importc: "bgfx_vertex_decl_t", header: "<bgfx/c99/bgfx.h>".} = object
    hash* {.importc: "hash".}: uint32_t
    stride* {.importc: "stride".}: uint16_t
    offset* {.importc: "offset".}: array[Attrib_Count, uint16_t]
    attributes* {.importc: "attributes".}: array[Attrib_Count, uint16_t]

proc Begin*(decl: ptr VertexDecl, renderer: RendererType = RendererType_Null) {.BGFXImport, importc: "bgfx_vertex_decl_begin".}
proc End*(decl: ptr VertexDecl) {.BGFXImport, importc: "bgfx_vertex_decl_end".}
proc Add*(decl: ptr VertexDecl, attrib: Attrib; num: uint8_t; typ: AttribType; normalized: bool = false; asInt: bool = false) {.BGFXImport, importc: "bgfx_vertex_decl_add".}
proc Skip*(decl: ptr VertexDecl, num: uint8_t) {.BGFXImport, importc: "bgfx_vertex_decl_skip".}
proc Has*(decl: ptr VertexDecl, attrib: Attrib): bool = decl.attributes[attrib] != invalidHandle
proc GetOffset*(decl: ptr VertexDecl, attrib: Attrib): uint16_t = decl.offset[attrib]
proc GetStride*(decl: ptr VertexDecl): uint16_t = decl.stride
proc GetSize*(decl: ptr VertexDecl, num: uint32_t): uint32_t = num*decl.stride

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

proc VertexPack*(input: array[4, cfloat]; inputNormalized: bool; attr: Attrib; decl: ptr VertexDecl; data: pointer; index: uint32_t = 0) {.BGFXImport, importc: "bgfx_vertex_pack".}
proc VertexUnpack*(output: array[4, cfloat]; attr: Attrib; decl: ptr VertexDecl; data: pointer; index: uint32_t = 0) {.BGFXImport, importc: "bgfx_vertex_unpack".}
proc VertexConvert*(destDecl: ptr VertexDecl; destData: pointer; srcDecl: ptr VertexDecl; srcData: pointer; num: uint32_t = 1) {.BGFXImport, importc: "bgfx_vertex_convert".}
proc WeldVertices*(output: ptr uint16_t; decl: ptr VertexDecl; data: pointer; num: uint16_t; epsilon: cfloat = 0.001): uint16_t {.BGFXImport, importc: "bgfx_weld_vertices".}
proc ConvertTopology*(conversion: TopologyConvert, dst: pointer, dstSize: uint32_t, indicies: pointer, numIndices: uint32_t, index32: bool): uint32_t {.BGFXImport, importc: "bgfx_topology_convert".}
proc TopologySortTriList*(sort: TopologySort, dst: pointer, dstSize: uint32_t, dir: array[3,cfloat], pos: array[3, cfloat], vertices: pointer, stride: uint32_t, indices: pointer, numIndices: uint32_t, index32:bool) {.BGFXImport, importc: "bgfx_topology_sort_tri_list".}
proc ImageSwizzleBgra8*(width: uint32_t; height: uint32_t; pitch: uint32_t; src: pointer; dst: pointer) {.BGFXImport, importc: "bgfx_image_swizzle_bgra8".}
proc ImageRgba8Downsample2x2*(width: uint32_t; height: uint32_t; pitch: uint32_t; src: pointer; dst: pointer) {.BGFXImport, importc: "bgfx_image_rgba8_downsample_2x2".}
proc GetSupportedRenderers*(enm: array[RendererType_Count, RendererType]): uint8_t {.BGFXImport, importc: "bgfx_get_supported_renderers".}
proc GetRendererName*(typ: RendererType): cstring {.BGFXImport, importc: "bgfx_get_renderer_name".}
proc Init*(typ: RendererType = RendererType_Count; vendorId: uint16_t = BGFX_PCI_ID_NONE; deviceId: uint16_t = 0; callback: ptr CallbackI = nil; allocator: pointer = nil): bool {.BGFXImport, discardable, importc: "bgfx_init".}
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
proc DbgTextClear*(attr: uint8_t = 0; small: bool = false) {.BGFXImport, importc: "bgfx_dbg_text_clear".}
proc DbgTextPrintf*(x: uint16_t; y: uint16_t; attr: uint8_t; format: cstring) {.BGFXImport, varargs, importc: "bgfx_dbg_text_printf".}
proc DbgTextImage*(x: uint16_t; y: uint16_t; width: uint16_t; height: uint16_t; data: pointer; pitch: uint16_t) {.BGFXImport, importc: "bgfx_dbg_text_image".}
proc CreateIndexBuffer*(mem: ptr Memory; flags: uint16_t = BGFX_BUFFER_NONE): IndexBufferHandle {.BGFXImport, importc: "bgfx_create_index_buffer".}
proc DestroyIndexBuffer*(handle: IndexBufferHandle) {.BGFXImport, importc: "bgfx_destroy_index_buffer".}
proc CreateVertexBuffer*(mem: ptr Memory; decl: ptr VertexDecl; flags: uint16_t = BGFX_BUFFER_NONE): VertexBufferHandle {.BGFXImport, importc: "bgfx_create_vertex_buffer".}
proc DestroyVertexBuffer*(handle: VertexBufferHandle) {.BGFXImport, importc: "bgfx_destroy_vertex_buffer".}
proc CreateDynamicIndexBuffer*(num: uint32_t; flags: uint16_t = BGFX_BUFFER_NONE): DynamicIndexBufferHandle {.BGFXImport, importc: "bgfx_create_dynamic_index_buffer".}
proc CreateDynamicIndexBuffer*(mem: ptr Memory; flags: uint16_t = BGFX_BUFFER_NONE): DynamicIndexBufferHandle {.BGFXImport, importc: "bgfx_create_dynamic_index_buffer_mem".}
proc UpdateDynamicIndexBuffer*(handle: DynamicIndexBufferHandle; startIndex: uint32_t; mem: ptr Memory) {.BGFXImport, importc: "bgfx_update_dynamic_index_buffer".}
proc DestroyDynamicIndexBuffer*(handle: DynamicIndexBufferHandle) {.BGFXImport, importc: "bgfx_destroy_dynamic_index_buffer".}
proc CreateDynamicVertexBuffer*(num: uint32_t; decl: ptr VertexDecl; flags: uint16_t = BGFX_BUFFER_NONE): DynamicVertexBufferHandle {.BGFXImport, importc: "bgfx_create_dynamic_vertex_buffer".}
proc CreateDynamicVertexBufferMem*(mem: ptr Memory; decl: ptr VertexDecl; flags: uint16_t = BGFX_BUFFER_NONE): DynamicVertexBufferHandle {.BGFXImport, importc: "bgfx_create_dynamic_vertex_buffer_mem".}
proc UpdateDynamicVertexBuffer*(handle: DynamicVertexBufferHandle; startVertex: uint32_t; mem: ptr Memory) {.BGFXImport, importc: "bgfx_update_dynamic_vertex_buffer".}
proc DestroyDynamicVertexBuffer*(handle: DynamicVertexBufferHandle) {.BGFXImport, importc: "bgfx_destroy_dynamic_vertex_buffer".}
proc CheckAvailTransientIndexBuffer*(num: uint32_t): bool {.BGFXImport, importc: "bgfx_check_avail_transient_index_buffer".}
proc CheckAvailTransientVertexBuffer*(num: uint32_t;decl: ptr VertexDecl): bool {.BGFXImport, importc: "bgfx_check_avail_transient_vertex_buffer".}
proc CheckAvailInstanceDataBuffer*(num: uint32_t; stride: uint16_t): bool {.BGFXImport, importc: "bgfx_check_avail_instance_data_buffer".}
proc CheckAvailTransientBuffers*(numVertices: uint32_t; decl: ptr VertexDecl; numIndices: uint32_t): bool {.BGFXImport, importc: "bgfx_check_avail_transient_buffers".}
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
proc CalcTextureSize*(info: ptr TextureInfo; width: uint16_t; height: uint16_t; depth: uint16_t; cubeMap: bool; numMips: uint8_t; format: TextureFormat) {.BGFXImport, importc: "bgfx_calc_texture_size".}
proc CreateTexture*(mem: ptr Memory; flags: uint32_t = BGFX_TEXTURE_NONE; skip: uint8_t = 0; info: ptr TextureInfo = nil): TextureHandle {.BGFXImport, importc: "bgfx_create_texture".}
proc CreateTexture2d*(width: uint16_t; height: uint16_t; numMips: uint8_t; format: TextureFormat; flags: uint32_t = BGFX_TEXTURE_NONE; mem: ptr Memory = nil): TextureHandle {.BGFXImport, importc: "bgfx_create_texture_2d".}
proc CreateTexture2d*(ratio: BackbufferRatio; numMips: uint8_t; format: TextureFormat; flags: uint32_t = BGFX_TEXTURE_NONE): TextureHandle {.BGFXImport, importc: "bgfx_create_texture_2d_scaled".}
proc CreateTexture3d*(width: uint16_t; height: uint16_t; depth: uint16_t; numMips: uint8_t; format: TextureFormat; flags: uint32_t = BGFX_TEXTURE_NONE; mem: ptr Memory = nil): TextureHandle {.BGFXImport, importc: "bgfx_create_texture_3d".}
proc CreateTextureCube*(size: uint16_t; numMips: uint8_t; format: TextureFormat; flags: uint32_t = BGFX_TEXTURE_NONE; mem: ptr Memory = nil): TextureHandle {.BGFXImport, importc: "bgfx_create_texture_cube".}
proc UpdateTexture2d*(handle: TextureHandle; mip: uint8_t; x: uint16_t; y: uint16_t; width: uint16_t; height: uint16_t; mem: ptr Memory; pitch: uint16_t = uint16.high) {.BGFXImport, importc: "bgfx_update_texture_2d".}
proc UpdateTexture3d*(handle: TextureHandle; mip: uint8_t; x: uint16_t; y: uint16_t; z: uint16_t; width: uint16_t; height: uint16_t; depth: uint16_t; mem: ptr Memory) {.BGFXImport, importc: "bgfx_update_texture_3d".}
proc UpdateTextureCube*(handle: TextureHandle; side: uint8_t; mip: uint8_t; x: uint16_t; y: uint16_t; width: uint16_t; height: uint16_t; mem: ptr Memory; pitch: uint16_t = uint16.high) {.BGFXImport, importc: "bgfx_update_texture_cube".}
proc ReadTexture*(handle: TextureHandle; data: pointer): uint32_t {.BGFXImport, importc: "bgfx_read_texture".}
proc ReadTexture*(handle: FrameBufferHandle; attachment: uint8_t; data: pointer): uint32_t {.BGFXImport, importc: "bgfx_read_frame_buffer".}
proc DestroyTexture*(handle: TextureHandle) {.BGFXImport, importc: "bgfx_destroy_texture".}
proc CreateFrameBuffer*(width: uint16_t; height: uint16_t; format: TextureFormat; textureFlags: uint32_t = BGFX_TEXTURE_U_CLAMP or BGFX_TEXTURE_V_CLAMP): FrameBufferHandle {.BGFXImport, importc: "bgfx_create_frame_buffer".}
proc CreateFrameBuffer*(ratio: BackbufferRatio; format: TextureFormat; textureFlags: uint32_t = BGFX_TEXTURE_U_CLAMP or BGFX_TEXTURE_V_CLAMP): FrameBufferHandle {.BGFXImport, importc: "bgfx_create_frame_buffer_scaled".}
proc CreateFrameBuffer*(num: uint8_t; attachment: ptr TextureHandle; destroyTextures: bool = false): FrameBufferHandle {.BGFXImport, importc: "bgfx_create_frame_buffer_from_handles".}
proc CreateFrameBuffer*(num: uint8_t; attachment: ptr Attachment; destroyTextures: bool = false): FrameBufferHandle {.BGFXImport, importc: "bgfx_create_frame_buffer_from_attachment".}
proc CreateFrameBuffer*(nwh: pointer; width: uint16_t; height: uint16_t; depthFormat: TextureFormat = TextureFormat_Unknown): FrameBufferHandle {.BGFXImport, importc: "bgfx_create_frame_buffer_from_nwh".}
proc DestroyFrameBuffer*(handle: FrameBufferHandle) {.BGFXImport, importc: "bgfx_destroy_frame_buffer".}
proc CreateUniform*(name: cstring; typ: UniformType; num: uint16_t = 1): UniformHandle {.BGFXImport, importc: "bgfx_create_uniform".}
proc DestroyUniform*(handle: UniformHandle) {.BGFXImport, importc: "bgfx_destroy_uniform".}
proc CreateOcclusionQuery*(): OcclusionQueryHandle {.BGFXImport, importc: "bgfx_create_occlusion_query".}
proc GetResult*(handle: OcclusionQueryHandle): OcclusionQueryResult {.BGFXImport, importc: "bgfx_get_result".}
proc DestroyOcclusionQuery*(handle: OcclusionQueryHandle) {.BGFXImport, importc: "bgfx_destroy_occlusion_query".}
proc SetPaletteColor*(index: uint8_t; rgba: array[4,cfloat]) {.BGFXImport, importc: "bgfx_set_palette_color".}
proc SetPaletteColor*(index: uint8_t; rgba: uint32_t) =
    SetPaletteColor(index, [
        cast[cfloat](cast[uint8](rgba shr 24)) * 1.0'f32 / 255.0'f32,
        cast[cfloat](cast[uint8](rgba shr 16)) * 1.0'f32 / 255.0'f32,
        cast[cfloat](cast[uint8](rgba shr 8))  * 1.0'f32 / 255.0'f32,
        cast[cfloat](cast[uint8](rgba shr 0))  * 1.0'f32 / 255.0'f32,])
proc SetPaletteColor*(index: uint8_t; r, g, b, a: cfloat) =
    SetPaletteColor(index, [r, g, b, a])
proc SetViewName*(id: uint8_t; name: cstring) {.BGFXImport, importc: "bgfx_set_view_name".}
proc SetViewRect*(id: uint8_t; x: uint16_t; y: uint16_t; width: uint16_t; height: uint16_t) {.BGFXImport, importc: "bgfx_set_view_rect".}
proc SetViewRect*(id: uint8_t; x: uint16_t; y: uint16_t; ratio: BackbufferRatio) {.BGFXImport, importc: "bgfx_set_view_rect_auto".}
proc SetViewScissor*(id: uint8_t; x: uint16_t = 0; y: uint16_t = 0; width: uint16_t = 0; height: uint16_t = 0) {.BGFXImport, importc: "bgfx_set_view_scissor".}
proc SetViewClear*(id: uint8_t; flags: uint16_t; rgba: uint32_t = 0x000000ff; depth: cfloat = 1.0; stencil: uint8_t = 0) {.BGFXImport, importc: "bgfx_set_view_clear".}
proc SetViewClear*(id: uint8_t; flags: uint16_t; depth: cfloat; stencil: uint8_t; c0: uint8_t = uint8.high; c1: uint8_t = uint8.high; c2: uint8_t = uint8.high; c3: uint8_t = uint8.high; c4: uint8_t = uint8.high; c5: uint8_t = uint8.high; c6: uint8_t = uint8.high; c7: uint8_t) {.BGFXImport, importc: "bgfx_set_view_clear_mrt".}
proc SetViewSeq*(id: uint8_t; enabled: bool) {.BGFXImport, importc: "bgfx_set_view_seq".}
proc SetViewFrameBuffer*(id: uint8_t; handle: FrameBufferHandle) {.BGFXImport, importc: "bgfx_set_view_frame_buffer".}
proc SetViewTransform*(id: uint8_t; view: pointer; projL: pointer;flags: uint8_t = BGFX_VIEW_STEREO; projR: pointer = nil) {.BGFXImport, importc: "bgfx_set_view_transform_stereo".}
proc SetViewRemap*(id: uint8_t = 0; num: uint8_t = uint8.high; remap: pointer = nil) {.BGFXImport, importc: "bgfx_set_view_remap".}
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
proc SetTexture*(stage: uint8_t; sampler: UniformHandle;handle: TextureHandle; flags: uint32_t = uint32.high) {.BGFXImport, importc: "bgfx_set_texture".}
proc SetTexture*(stage: uint8_t;sampler: UniformHandle;handle: FrameBufferHandle;attachment: uint8_t = 0; flags: uint32_t = uint32.high) {.BGFXImport, importc: "bgfx_set_texture_from_frame_buffer".}
proc Touch*(id: uint8_t): uint32_t {.BGFXImport, discardable, importc: "bgfx_touch".}
proc Submit*(id: uint8_t; handle: ProgramHandle; depth: int32_t = 0;preserveState: bool = false): uint32_t {.BGFXImport, discardable, importc: "bgfx_submit".}
proc Submit*(id: uint8_t; program: ProgramHandle;occlusionQuery: OcclusionQueryHandle; depth: int32_t = 0;preserveState: bool = false): uint32_t {.BGFXImport, discardable, importc: "bgfx_submit_occlusion_query".}
proc Submit*(id: uint8_t; handle: ProgramHandle;indirectHandle: IndirectBufferHandle;start: uint16_t = 0; num: uint16_t = 1; depth: int32_t = 0;preserveState: bool = false): uint32_t {.BGFXImport, discardable, importc: "bgfx_submit_indirect".}
proc SetImage*(stage: uint8_t; sampler: UniformHandle;handle: TextureHandle; mip: uint8_t;access: Access; format: TextureFormat = TextureFormat_Count) {.BGFXImport, importc: "bgfx_set_image".}
proc SetImage*(stage: uint8_t;sampler: UniformHandle;handle: FrameBufferHandle;attachment: uint8_t;access: Access;format: TextureFormat = TextureFormat_Count) {.BGFXImport, importc: "bgfx_set_image_from_frame_buffer".}
proc SetBuffer*(stage: uint8_t;handle: IndexBufferHandle;access: Access) {.BGFXImport, importc: "bgfx_set_compute_index_buffer".}
proc SetBuffer*(stage: uint8_t;handle: VertexBufferHandle;access: Access) {.BGFXImport, importc: "bgfx_set_compute_vertex_buffer".}
proc SetBuffer*(stage: uint8_t;handle: DynamicIndexBufferHandle; access: Access) {.BGFXImport, importc: "bgfx_set_compute_dynamic_index_buffer".}
proc SetBuffer*(stage: uint8_t;handle: DynamicVertexBufferHandle; access: Access) {.BGFXImport, importc: "bgfx_set_compute_dynamic_vertex_buffer".}
proc SetBuffer*(stage: uint8_t;handle: IndirectBufferHandle;access: Access) {.BGFXImport, importc: "bgfx_set_compute_indirect_buffer".}
proc Dispatch*(id: uint8_t; handle: ProgramHandle; numX: uint16_t = 1; numY: uint16_t = 1; numZ: uint16_t = 1; flags: uint8_t = BGFX_SUBMIT_EYE_FIRST): uint32_t {.BGFXImport, importc: "bgfx_dispatch".}
proc Dispatch*(id: uint8_t; handle: ProgramHandle;indirectHandle: IndirectBufferHandle;start: uint16_t = 0; num: uint16_t = 1; flags: uint8_t = BGFX_SUBMIT_EYE_FIRST): uint32_t {.BGFXImport, importc: "bgfx_dispatch_indirect".}
proc Discard*() {.BGFXImport, importc: "bgfx_discard".}
proc Blit*(id: uint8_t; dst: TextureHandle; dstMip: uint8_t;dstX: uint16_t; dstY: uint16_t; dstZ: uint16_t;src: TextureHandle; srcMip: uint8_t; srcX: uint16_t = 0;srcY: uint16_t = 0; srcZ: uint16_t; width: uint16_t = uint16.high; height: uint16_t = uint16.high;depth: uint16_t = uint16.high) {.BGFXImport, importc: "bgfx_blit".}
proc Blit*(id: uint8_t; dst: TextureHandle; dstMip: uint8_t; dstX: uint16_t; dstY: uint16_t; dstZ: uint16_t; src: FrameBufferHandle; attachment: uint8_t = 0; srcMip: uint8_t = 0; srcX: uint16_t = 0; srcY: uint16_t = 0; srcZ: uint16_t = 0; width: uint16_t = uint16.high; height: uint16_t = uint16.high; depth: uint16_t = uint16.high) {.BGFXImport, importc: "bgfx_blit_frame_buffer".}
proc SaveScreenShot*(filePath: cstring) {.BGFXImport, importc: "bgfx_save_screen_shot".}
