# Copyright 2017 Cory Noll Crimmins - Golden
# License: BSD-2
# Wrapper/binding for bgfx types

type va_list* {.importc,header:"<stdarg.h>".} = object

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
    Fatal_InvalidShader
    Fatal_UnableToInitialize
    Fatal_UnableToCreateTexture
    Fatal_DeviceLost
    Fatal_Count

type RendererType* {.importc: "bgfx_renderer_type_t", header: "<bgfx/c99/bgfx.h>".} = enum
    RendererType_Noop
    RendererType_Direct3D9
    RendererType_Direct3D11
    RendererType_Direct3D12
    RendererType_Gnm
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
    CBFatalProc* = proc (this: ptr CallbackI; code: Fatal; str: cstring)
    CBTraceVargsProc* = proc (this: ptr CallbackI; filePath: cstring; line: uint16; format: cstring, argList: va_list)
    CBCacheReadSizeProc* = proc (this: ptr CallbackI; id: uint64): uint32
    CBCacheReadProc* = proc (this: ptr CallbackI; id: uint64; data: pointer; size: uint32): bool
    CBCacheWriteProc* = proc (this: ptr CallbackI; id: uint64; data: pointer; size: uint32)
    CBScreenShotProc* = proc (this: ptr CallbackI; filePath: cstring; width: uint32; height: uint32; pitch: uint32; data: pointer; size: uint32; yflip: bool)
    CBCaptureBegin* = proc (this: ptr CallbackI; width: uint32; height: uint32; pitch: uint32; format: TextureFormat; yflip: bool)
    CBCaptureEnd* = proc (this: ptr CallbackI)
    CBCaptureFrame* = proc (this: ptr CallbackI; data: pointer; size: uint32)
    CallbackVTable* {.importc: "bgfx_callback_vtbl_t", header: "<bgfx/c99/bgfx.h>".} = object
        fatal* {.importc: "fatal".}: pointer # CBFatalProc
        trace_vargs* {.importc: "trace_vargs".}: pointer # CBTraceVargsProc
        cache_read_size* {.importc: "cache_read_size".}: pointer # CBCacheReadSizeProc
        cache_read* {.importc: "cache_read".}: pointer # CBCacheReadProc
        cache_write* {.importc: "cache_write".}: pointer # CBCacheWriteProc
        screen_shot* {.importc: "screen_shot".}: pointer # CBScreenShotProc
        capture_begin* {.importc: "capture_begin".}: pointer # CBCaptureBegin
        capture_end* {.importc: "capture_end".}: pointer # CBCaptureEnd
        capture_frame* {.importc: "capture_frame".}: pointer # CBCaptureFrame
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

type Limits* {.importc: "bgfx_caps_limits_t", header: "<bgfx/c99/bgfx.h>".} = object
    maxDrawCalls* {.importc: "maxDrawCalls".}: uint32_t
    maxBlits* {.importc: "maxBlits".}: uint32_t
    maxTextureSize* {.importc: "maxTextureSize".}: uint32_t
    maxViews* {.importc: "maxViews".}: uint32_t
    maxFrameBuffers* {.importc: "maxFrameBuffers".}: uint32_t
    maxFBAttachments* {.importc: "maxFBAttachments".}: uint32_t
    maxPrograms* {.importc: "maxPrograms".}: uint32_t
    maxShaders* {.importc: "maxShaders".}: uint32_t
    maxTextures* {.importc: "maxTextures".}: uint32_t
    maxTextureSamplers* {.importc: "maxTextureSamplers".}: uint32_t
    maxVertexDecls* {.importc: "maxVertexDecls".}: uint32_t
    maxVertexStreams* {.importc: "maxVertexStreams".}: uint32_t
    maxIndexBuffers* {.importc: "maxIndexBuffers".}: uint32_t
    maxVertexBuffers* {.importc: "maxVertexBuffers".}: uint32_t
    maxDynamicIndexBuffers* {.importc: "maxDynamicIndexBuffers".}: uint32_t
    maxDynamicVertexBuffers* {.importc: "maxDynamicVertexBuffers".}: uint32_t
    maxUniforms* {.importc: "maxUniforms".}: uint32_t
    maxOcclusionQueries* {.importc: "maxOcclusionQueries".}: uint32_t

type Caps* {.importc: "bgfx_caps_t", header: "<bgfx/c99/bgfx.h>".} = object
    rendererType* {.importc: "rendererType".}: RendererType
    supported* {.importc: "supported".}: uint64_t
    vendorId* {.importc: "vendorId".}: uint16_t
    deviceId* {.importc: "deviceId".}: uint16_t
    homogeneousDepth* {.importc: "homogeneousDepth".}: bool
    originBottomLeft* {.importc: "originBottomLeft".}: bool
    numGPUs* {.importc: "numGPUs".}: uint8
    gpu* {.importc: "gpu".}: array[4, CapsGPU]
    limits* {.importc: "limits".}: Limits
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
    numLayers* {.importc: "numLayers".}: uint16_t
    numMips* {.importc: "numMips".}: uint8_t
    bitsPerPixel* {.importc: "bitsPerPixel".}: uint8_t
    cubeMap* {.importc: "cubeMap".}: bool

type UniformInfo* {.importc: "bgfx_uniform_info_t", header: "<bgfx/c99/bgfx.h>".} = object
    name* {.importc: "name".}: array[256, char]
    uniformType* {.importc: "type".}: UniformType
    size* {.importc: "num".}: uint16_t

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
    numDraw* {.importc: "numDraw"}: uint32_t
    numCompute* {.importc: "numCompute"}: uint32_t
    maxGpuLatency* {.importc: "maxGpuLatency"}: uint32_t
    width* {.importc: "width"}: uint16_t
    height* {.importc: "height"}: uint16_t
    textWidth* {.importc: "textWidth"}: uint16_t
    textHeight* {.importc: "textHeight".}: uint16_t

type VertexDecl* {.importc: "bgfx_vertex_decl_t", header: "<bgfx/c99/bgfx.h>".} = object
    hash* {.importc: "hash".}: uint32_t
    stride* {.importc: "stride".}: uint16_t
    offset* {.importc: "offset".}: array[Attrib_Count, uint16_t]
    attributes* {.importc: "attributes".}: array[Attrib_Count, uint16_t]
