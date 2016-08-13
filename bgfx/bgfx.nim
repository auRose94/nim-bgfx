# BGFX WRAPPER

import c99bgfx, strutils, macros

type Fatal* = enum
    Fatal_DebugCheck = BGFX_FATAL_DEBUG_CHECK,
    Fatal_MinimumRequiredSpecs = BGFX_FATAL_MINIMUM_REQUIRED_SPECS,
    Fatal_InvalidShader = BGFX_FATAL_INVALID_SHADER,
    Fatal_UnableToInitialize = BGFX_FATAL_UNABLE_TO_INITIALIZE,
    Fatal_UnableToCreateTexture = BGFX_FATAL_UNABLE_TO_CREATE_TEXTURE,
    Fatal_DeviceLost = BGFX_FATAL_DEVICE_LOST,
    Fatal_Count = BGFX_FATAL_COUNT

type RendererType* = enum
    RendererType_Null = BGFX_RENDERER_TYPE_NULL,
    RendererType_Direct3D9 = BGFX_RENDERER_TYPE_DIRECT3D9,
    RendererType_Direct3D11 = BGFX_RENDERER_TYPE_DIRECT3D11,
    RendererType_Direct3D12 = BGFX_RENDERER_TYPE_DIRECT3D12,
    RendererType_Metal = BGFX_RENDERER_TYPE_METAL,
    RendererType_OpenGLES = BGFX_RENDERER_TYPE_OPENGLES,
    RendererType_OpenGL = BGFX_RENDERER_TYPE_OPENGL,
    RendererType_Vulkan = BGFX_RENDERER_TYPE_VULKAN,
    RendererType_Count = BGFX_RENDERER_TYPE_COUNT

type Access* = enum
    Access_Read = BGFX_ACCESS_READ,
    Access_Write = BGFX_ACCESS_WRITE,
    Access_ReadWrite = BGFX_ACCESS_READWRITE,
    Access_Count = BGFX_ACCESS_COUNT

type Attrib* = enum
    Attrib_Position = BGFX_ATTRIB_POSITION,  # a_position
    Attrib_Normal = BGFX_ATTRIB_NORMAL,    # a_normal
    Attrib_Tangent = BGFX_ATTRIB_TANGENT,   # a_tangent
    Attrib_Bitangent = BGFX_ATTRIB_BITANGENT, # a_bitangent
    Attrib_Color0 = BGFX_ATTRIB_COLOR0,    # a_color0
    Attrib_Color1 = BGFX_ATTRIB_COLOR1,    # a_color1
    Attrib_Indices = BGFX_ATTRIB_INDICES,   # a_indices
    Attrib_Weight = BGFX_ATTRIB_WEIGHT,    # a_weight
    Attrib_TexCoord0 = BGFX_ATTRIB_TEXCOORD0, # a_texcoord0
    Attrib_TexCoord1 = BGFX_ATTRIB_TEXCOORD1, # a_texcoord1
    Attrib_TexCoord2 = BGFX_ATTRIB_TEXCOORD2, # a_texcoord2
    Attrib_TexCoord3 = BGFX_ATTRIB_TEXCOORD3, # a_texcoord3
    Attrib_TexCoord4 = BGFX_ATTRIB_TEXCOORD4, # a_texcoord4
    Attrib_TexCoord5 = BGFX_ATTRIB_TEXCOORD5, # a_texcoord5
    Attrib_TexCoord6 = BGFX_ATTRIB_TEXCOORD6, # a_texcoord6
    Attrib_TexCoord7 = BGFX_ATTRIB_TEXCOORD7, # a_texcoord7
    Attrib_Count = BGFX_ATTRIB_COUNT

type AttribType* = enum
    AttribType_Uint8 = BGFX_ATTRIB_TYPE_UINT8,  # Uint8
    AttribType_Uint10 = BGFX_ATTRIB_TYPE_UINT10, # Uint10, availability depends on: `BGFX_CAPS_VERTEX_ATTRIB_UINT10`.
    AttribType_Int16 = BGFX_ATTRIB_TYPE_INT16,  # Int16
    AttribType_Half = BGFX_ATTRIB_TYPE_HALF,   # Half, availability depends on: `BGFX_CAPS_VERTEX_ATTRIB_HALF`.
    AttribType_Float = BGFX_ATTRIB_TYPE_FLOAT,  # Float
    AttribType_Count = BGFX_ATTRIB_TYPE_COUNT

type TextureFormat* = enum
    TextureFormat_BC1 = BGFX_TEXTURE_FORMAT_BC1,          # DXT1
    TextureFormat_BC2 = BGFX_TEXTURE_FORMAT_BC2,          # DXT3
    TextureFormat_BC3 = BGFX_TEXTURE_FORMAT_BC3,          # DXT5
    TextureFormat_BC4 = BGFX_TEXTURE_FORMAT_BC4,          # LATC1/ATI1
    TextureFormat_BC5 = BGFX_TEXTURE_FORMAT_BC5,          # LATC2/ATI2
    TextureFormat_BC6H = BGFX_TEXTURE_FORMAT_BC6H,         # BC6H
    TextureFormat_BC7 = BGFX_TEXTURE_FORMAT_BC7,          # BC7
    TextureFormat_ETC1 = BGFX_TEXTURE_FORMAT_ETC1,         # ETC1 RGB8
    TextureFormat_ETC2 = BGFX_TEXTURE_FORMAT_ETC2,         # ETC2 RGB8
    TextureFormat_ETC2A = BGFX_TEXTURE_FORMAT_ETC2A,        # ETC2 RGBA8
    TextureFormat_ETC2A1 = BGFX_TEXTURE_FORMAT_ETC2A1,       # ETC2 RGB8A1
    TextureFormat_PTC12 = BGFX_TEXTURE_FORMAT_PTC12,        # PVRTC1 RGB 2BPP
    TextureFormat_PTC14 = BGFX_TEXTURE_FORMAT_PTC14,        # PVRTC1 RGB 4BPP
    TextureFormat_PTC12A = BGFX_TEXTURE_FORMAT_PTC12A,       # PVRTC1 RGBA 2BPP
    TextureFormat_PTC14A = BGFX_TEXTURE_FORMAT_PTC14A,       # PVRTC1 RGBA 4BPP
    TextureFormat_PTC22 = BGFX_TEXTURE_FORMAT_PTC22,        # PVRTC2 RGBA 2BPP
    TextureFormat_PTC24 = BGFX_TEXTURE_FORMAT_PTC24,        # PVRTC2 RGBA 4BPP
    # Compressed formats above.
    TextureFormat_Unknown = BGFX_TEXTURE_FORMAT_UNKNOWN,
    TextureFormat_R1 = BGFX_TEXTURE_FORMAT_R1,
    TextureFormat_A8 = BGFX_TEXTURE_FORMAT_A8,
    TextureFormat_R8 = BGFX_TEXTURE_FORMAT_R8,
    TextureFormat_R8I = BGFX_TEXTURE_FORMAT_R8I,
    TextureFormat_R8U = BGFX_TEXTURE_FORMAT_R8U,
    TextureFormat_R8S = BGFX_TEXTURE_FORMAT_R8S,
    TextureFormat_R16 = BGFX_TEXTURE_FORMAT_R16,
    TextureFormat_R16I = BGFX_TEXTURE_FORMAT_R16I,
    TextureFormat_R16U = BGFX_TEXTURE_FORMAT_R16U,
    TextureFormat_R16F = BGFX_TEXTURE_FORMAT_R16F,
    TextureFormat_R16S = BGFX_TEXTURE_FORMAT_R16S,
    TextureFormat_R32I = BGFX_TEXTURE_FORMAT_R32I,
    TextureFormat_R32U = BGFX_TEXTURE_FORMAT_R32U,
    TextureFormat_R32F = BGFX_TEXTURE_FORMAT_R32F,
    TextureFormat_RG8 = BGFX_TEXTURE_FORMAT_RG8,
    TextureFormat_RG8I = BGFX_TEXTURE_FORMAT_RG8I,
    TextureFormat_RG8U = BGFX_TEXTURE_FORMAT_RG8U,
    TextureFormat_RG8S = BGFX_TEXTURE_FORMAT_RG8S,
    TextureFormat_RG16 = BGFX_TEXTURE_FORMAT_RG16,
    TextureFormat_RG16I = BGFX_TEXTURE_FORMAT_RG16I,
    TextureFormat_RG16U = BGFX_TEXTURE_FORMAT_RG16U,
    TextureFormat_RG16F = BGFX_TEXTURE_FORMAT_RG16F,
    TextureFormat_RG16S = BGFX_TEXTURE_FORMAT_RG16S,
    TextureFormat_RG32I = BGFX_TEXTURE_FORMAT_RG32I,
    TextureFormat_RG32U = BGFX_TEXTURE_FORMAT_RG32U,
    TextureFormat_RG32F = BGFX_TEXTURE_FORMAT_RG32F,
    TextureFormat_RGB8 = BGFX_TEXTURE_FORMAT_RGB8,
    TextureFormat_RGB8I = BGFX_TEXTURE_FORMAT_RGB8I,
    TextureFormat_RGB8U = BGFX_TEXTURE_FORMAT_RGB8U,
    TextureFormat_RGB8S = BGFX_TEXTURE_FORMAT_RGB8S,
    TextureFormat_RGB9E5F = BGFX_TEXTURE_FORMAT_RGB9E5F,
    TextureFormat_BGRA8 = BGFX_TEXTURE_FORMAT_BGRA8,
    TextureFormat_RGBA8 = BGFX_TEXTURE_FORMAT_RGBA8,
    TextureFormat_RGBA8I = BGFX_TEXTURE_FORMAT_RGBA8I,
    TextureFormat_RGBA8U = BGFX_TEXTURE_FORMAT_RGBA8U,
    TextureFormat_RGBA8S = BGFX_TEXTURE_FORMAT_RGBA8S,
    TextureFormat_RGBA16 = BGFX_TEXTURE_FORMAT_RGBA16,
    TextureFormat_RGBA16I = BGFX_TEXTURE_FORMAT_RGBA16I,
    TextureFormat_RGBA16U = BGFX_TEXTURE_FORMAT_RGBA16U,
    TextureFormat_RGBA16F = BGFX_TEXTURE_FORMAT_RGBA16F,
    TextureFormat_RGBA16S = BGFX_TEXTURE_FORMAT_RGBA16S,
    TextureFormat_RGBA32I = BGFX_TEXTURE_FORMAT_RGBA32I,
    TextureFormat_RGBA32U = BGFX_TEXTURE_FORMAT_RGBA32U,
    TextureFormat_RGBA32F = BGFX_TEXTURE_FORMAT_RGBA32F,
    TextureFormat_R5G6B5 = BGFX_TEXTURE_FORMAT_R5G6B5,
    TextureFormat_RGBA4 = BGFX_TEXTURE_FORMAT_RGBA4,
    TextureFormat_RGB5A1 = BGFX_TEXTURE_FORMAT_RGB5A1,
    TextureFormat_RGB10A2 = BGFX_TEXTURE_FORMAT_RGB10A2,
    TextureFormat_R11G11B10F = BGFX_TEXTURE_FORMAT_R11G11B10F,
    TextureFormat_UnknownDepth = BGFX_TEXTURE_FORMAT_UNKNOWN_DEPTH,
    # Depth formats below.
    TextureFormat_D16 = BGFX_TEXTURE_FORMAT_D16,
    TextureFormat_D24 = BGFX_TEXTURE_FORMAT_D24,
    TextureFormat_D24S8 = BGFX_TEXTURE_FORMAT_D24S8,
    TextureFormat_D32 = BGFX_TEXTURE_FORMAT_D32,
    TextureFormat_D16F = BGFX_TEXTURE_FORMAT_D16F,
    TextureFormat_D24F = BGFX_TEXTURE_FORMAT_D24F,
    TextureFormat_D32F = BGFX_TEXTURE_FORMAT_D32F,
    TextureFormat_D0S8 = BGFX_TEXTURE_FORMAT_D0S8,
    TextureFormat_Count = BGFX_TEXTURE_FORMAT_COUNT

type UniformType* = enum
    UniformType_Int1 = BGFX_UNIFORM_TYPE_INT1,
    UniformType_End = BGFX_UNIFORM_TYPE_END,
    UniformType_Vec4 = BGFX_UNIFORM_TYPE_VEC4,
    UniformType_Mat3 = BGFX_UNIFORM_TYPE_MAT3,
    UniformType_Mat4 = BGFX_UNIFORM_TYPE_MAT4,
    UniformType_Count = BGFX_UNIFORM_TYPE_COUNT

type BackbufferRatio* = enum
    BackbufferRatio_Equal = BGFX_BACKBUFFER_RATIO_EQUAL,     # Equal to backbuffer.
    BackbufferRatio_Half = BGFX_BACKBUFFER_RATIO_HALF,      # One half size of backbuffer.
    BackbufferRatio_Quarter = BGFX_BACKBUFFER_RATIO_QUARTER,   # One quarter size of backbuffer.
    BackbufferRatio_Eighth = BGFX_BACKBUFFER_RATIO_EIGHTH,    # One eighth size of backbuffer.
    BackbufferRatio_Sixteenth = BGFX_BACKBUFFER_RATIO_SIXTEENTH, # One sixteenth size of backbuffer.
    BackbufferRatio_Double = BGFX_BACKBUFFER_RATIO_DOUBLE,    # Double size of backbuffer.
    BackbufferRatio_Count = BGFX_BACKBUFFER_RATIO_COUNT

type OcclusionQueryResult* = enum
    OcclusionQueryResult_Invisible = BGFX_OCCLUSION_QUERY_RESULT_INVISIBLE, # Query failed test.
    OcclusionQueryResult_Visible = BGFX_OCCLUSION_QUERY_RESULT_VISIBLE,   # Query passed test.
    OcclusionQueryResult_NoResult = BGFX_OCCLUSION_QUERY_RESULT_NORESULT,  # Query result is not available yet.
    OcclusionQueryResult_Count = BGFX_OCCLUSION_QUERY_RESULT_COUNT

type TopologyConvert* = enum
    TopologyConvert_TriListFlipWinding = BGFX_TOPOLOGY_CONVERT_TRI_LIST_FLIP_WINDING,  # Flip winding order of triangle list.
    TopologyConvert_TriListToLineList = BGFX_TOPOLOGY_CONVERT_TRI_LIST_TO_LINE_LIST,   # Convert triangle list to line list.
    TopologyConvert_TriStripToTriList = BGFX_TOPOLOGY_CONVERT_TRI_STRIP_TO_TRI_LIST,   # Convert triangle strip to triangle list.
    TopologyConvert_LineStripToLineList = BGFX_TOPOLOGY_CONVERT_LINE_STRIP_TO_LINE_LIST, # Convert line strip to line list.
    TopologyConvert_Count = BGFX_TOPOLOGY_CONVERT_COUNT

type TopologySort* = enum
    TopologySort_DirectionFrontToBackMin = BGFX_TOPOLOGY_SORT_DIRECTION_FRONT_TO_BACK_MIN, #
    TopologySort_DirectionFrontToBackAvg = BGFX_TOPOLOGY_SORT_DIRECTION_FRONT_TO_BACK_AVG, #
    TopologySort_DirectionFrontToBackMax = BGFX_TOPOLOGY_SORT_DIRECTION_FRONT_TO_BACK_MAX, #
    TopologySort_DirectionBackToFrontMin = BGFX_TOPOLOGY_SORT_DIRECTION_BACK_TO_FRONT_MIN, #
    TopologySort_DirectionBackToFrontAvg = BGFX_TOPOLOGY_SORT_DIRECTION_BACK_TO_FRONT_AVG, #
    TopologySort_DirectionBackToFrontMax = BGFX_TOPOLOGY_SORT_DIRECTION_BACK_TO_FRONT_MAX, #
    TopologySort_DistanceFrontToBackMin = BGFX_TOPOLOGY_SORT_DISTANCE_FRONT_TO_BACK_MIN,  #
    TopologySort_DistanceFrontToBackAvg = BGFX_TOPOLOGY_SORT_DISTANCE_FRONT_TO_BACK_AVG,  #
    TopologySort_DistanceFrontToBackMax = BGFX_TOPOLOGY_SORT_DISTANCE_FRONT_TO_BACK_MAX,  #
    TopologySort_DistanceBackToFrontMin = BGFX_TOPOLOGY_SORT_DISTANCE_BACK_TO_FRONT_MIN,  #
    TopologySort_DistanceBackToFrontAvg = BGFX_TOPOLOGY_SORT_DISTANCE_BACK_TO_FRONT_AVG,  #
    TopologySort_DistanceBackToFrontMax = BGFX_TOPOLOGY_SORT_DISTANCE_BACK_TO_FRONT_MAX,  #
    TopologySort_Count = BGFX_TOPOLOGY_SORT_COUNT

type DynamicIndexBuffer* = bgfx_dynamic_index_buffer_handle_t
type DynamicVertexBuffer* = bgfx_dynamic_vertex_buffer_handle_t
type FrameBuffer* = bgfx_frame_buffer_handle_t
type IndexBuffer* = bgfx_index_buffer_handle_t
type IndirectBuffer* = bgfx_indirect_buffer_handle_t
type OcclusionQuery* = bgfx_occlusion_query_handle_t
type Program* = bgfx_program_handle_t
type Shader* = bgfx_shader_handle_t
type Texture* = bgfx_texture_handle_t
type Uniform* = bgfx_uniform_handle_t
type VertexBuffer* = bgfx_vertex_buffer_handle_t
type VertexDeclaration* = bgfx_vertex_decl_handle_t

const InvalidHandle* = uint16.high

type CallbackI* = bgfx_callback_vtbl_t

type AllocatorI* = bgfx_allocator_interface_t

type ReleaseFn* = bgfx_release_fn_t

type Memory* = ptr bgfx_memory_t

type Caps* = ptr bgfx_caps_t

type TransientIndexBuffer* = ptr bgfx_transient_index_buffer_t

type TransientVertexBuffer* = ptr bgfx_transient_vertex_buffer_t

type InstanceDataBuffer* = ptr bgfx_instance_data_buffer_t

type TextureInfo* = ptr bgfx_texture_info_t

type Attachment* = bgfx_attachment_t

type Transform* = ptr bgfx_transform_t

type HMD* = ptr bgfx_hmd_t

type Stats* = bgfx_stats_t

type VertexDecl* = ptr bgfx_vertex_decl_t

proc newVertexDecl*(): VertexDecl = return create(bgfx_vertex_decl_t)

method Begin*(self: VertexDecl, renderer: RendererType = RendererType_Null): VertexDecl {.base.} =
    bgfx_vertex_decl_begin(cast[ptr bgfx_vertex_decl_t](self), cast[bgfx_renderer_type_t](renderer))
    return self

method End*(self: VertexDecl) {.base.} =
    bgfx_vertex_decl_end(cast[ptr bgfx_vertex_decl_t](self))

method Add*(self: VertexDecl, attrib: Attrib, num: Natural, attribType: AttribType, normalized: bool = false, asInt: bool = false): VertexDecl {.base.} =
    bgfx_vertex_decl_add(cast[ptr bgfx_vertex_decl_t](self), cast[bgfx_attrib_t](attrib), cast[uint8](num), cast[bgfx_attrib_type_t](attribType), normalized, asInt)
    return self

method Skip*(self: VertexDecl, num: Natural): VertexDecl {.base.} =
    bgfx_vertex_decl_skip(cast[ptr bgfx_vertex_decl_t](self), cast[uint8](num))
    return self

# TODO PORT VertexDecl::decode from C++

method Has*(self: VertexDecl, attrib: Attrib): bool {.base.} =
    return uint16.high != self.attributes[attrib]

method GetOffset*(self: VertexDecl, attrib: Attrib): Natural {.base.}=
    return self.offset[attrib]

method GetStride*(self: VertexDecl): Natural {.base.} =
    return self.stride

method GetSize*(self: VertexDecl, num: Natural): Natural {.base.} =
    return cast[uint16](num) * self.stride

proc vertexPack*(input: array[4, float], inputNormalized: bool, attr: Attrib, decl: VertexDecl, data: ptr auto, index: Natural = 0) =
    bgfx_vertex_pack(input, inputNormalized, cast[ptr bgfx_attrib_t](attr), cast[ptr bgfx_vertex_decl_t](decl), cast[pointer](data), cast[uint32](index))

proc vertexUnpack*(output: array[4, float], attr: Attrib, decl: VertexDecl, data: ptr auto, index: Natural = 0) =
    bgfx_vertex_unpack(output, attr, cast[ptr bgfx_vertex_decl_t](decl), cast[pointer](data), cast[uint32](index))

proc vertexConvert*(destDecl: VertexDecl, destData: ptr auto, srcDecl: VertexDecl, srcData: ptr auto, num: Natural = 1) =
    bgfx_vertex_convert(cast[bgfx_vertex_decl_t](destDecl), cast[pointer](destData), cast[bgfx_vertex_decl_t](srcDecl), cast[pointer](srcData), cast[uint32](num))

proc weldVertices*(output: var seq[uint16], decl: VertexDecl, data: ptr auto, num: Natural, epsilon: float = 0.001): uint =
    return bgfx_weld_vertices(cast[ptr uint16](output), cast[bgfx_vertex_decl_t](decl), cast[pointer](data), cast[uint16](num), epsilon)

proc topologyConvert*(conversion: TopologyConvert, dst: ptr auto, dstSize: Natural, indices: ptr auto, numIndices: Natural, index32: bool): uint =
    return bgfx_topology_convert(cast[bgfx_topology_convert_t](conversion), cast[pointer](dst), cast[uint32](dstSize), cast[pointer](indices), cast[uint32](numIndices), index32)

proc topologySortTriList*(sort: TopologySort, dst: ptr auto, dstSize: Natural, dir: array[3, float], pos: array[3, float], vertices: ptr auto, stride: Natural, indicies: ptr auto, numIndices: Natural, index32: bool) =
    bgfx_topology_sort_tri_list(cast[bgfx_topology_convert_t](sort), cast[pointer](dst), cast[uint32](dstSize), dir, pos, cast[pointer](vertices), cast[uint32](stride), cast[pointer](indicies), cast[uint32](numIndices), index32)

proc imageSwizzleBgra8*(width, height, pitch: Natural, src: ptr auto, dst: ptr auto) =
    bgfx_image_swizzle_bgra8(cast[uint32](width), cast[uint32](height), cast[uint32](pitch), cast[pointer](src), cast[pointer](dst))

proc imageRgba8Downsample2x2*(width, height, pitch: Natural, src: ptr auto, dst: ptr auto) =
    imageRgba8Downsample2x2(cast[uint32](width), cast[uint32](height), cast[uint32](pitch), cast[pointer](src), cast[pointer](dst))

proc getSupportedRenderers*(en: array[RendererType.RendererType_Count, RendererType]): uint =
    return bgfx_get_supported_renderers(cast[array[BGFX_RENDERER_TYPE_COUNT, bgfx_renderer_type_t]](en))

proc getRendererName*(rendererType: RendererType): string =
    return $bgfx_get_renderer_name(cast[bgfx_renderer_type_t](rendererType))

proc init*(rendererType: RendererType = RendererType_Null, vendorId: Natural = BGFX_PCI_ID_NONE, deviceId: Natural = 0, callback: auto, allocator: auto): bool =
    return bgfx_init(cast[bgfx_renderer_type_t](rendererType), cast[uint16](vendorId), cast[uint16](deviceId), cast[CallbackI](callback), cast[AllocatorI](allocator))

proc shutdown*() =
    bgfx_shutdown()

proc reset*(width, height: Natural, flags: uint32) =
    bgfx_reset(cast[uint32](width), cast[uint32](height), flags)

proc frame*(capture: bool): uint =
    return bgfx_frame(capture)

proc getRendererType*(): RendererType =
    return cast[RendererType](bgfx_get_renderer_type())

proc getCaps*(): Caps =
    return cast[Caps](bgfx_get_caps())

proc getHMD*(): HMD =
    return cast[HMD](bgfx_get_hmd())

proc getStats*(): Stats =
    return cast[Stats](bgfx_get_stats())

proc alloc*(size: Natural): Memory =
    return bgfx_alloc(cast[uint32](size))

proc copy*(data: ptr auto, size: Natural): Memory =
    return bgfx_copy(cast[pointer](data), cast[uint32](Natural))

proc makeRef*(data: ptr auto, size: Natural, releaseFn: ReleaseFn = nil, userData: ptr auto = nil): Memory =
    return bgfx_make_ref_release(cast[pointer](data), cast[uint32](size), cast[bgfx_release_fn_t](releaseFn), cast[pointer](userData))

proc setDebug*(debugFlag: uint32) =
    bgfx_set_debug(debugFlag)

proc dbgTextClear*(attr: uint8 = 0'u8, small: bool = false) =
    bgfx_dbg_text_clear(attr, small)

proc dbgTextPrintfNim*(x, y: uint16; attr: uint8; format: string; a: varargs[string, `$`]) =
    let fstr = format($format, a)
    bgfx_dbg_text_printf(x, y, attr, "%s", fstr)

proc dbgTextImage*(x, y, width, height: Natural, data: ptr auto, pitch: Natural) =
    bgfx_dbg_text_image(cast[uint16](x), cast[uint16](y), cast[uint16](width), cast[uint16](height), cast[pointer](data), cast[uint16](pitch))

proc createIndexBuffer*(mem: Memory, flags: uint16 = BGFX_BUFFER_NONE): IndexBuffer =
    return bgfx_create_index_buffer(cast[ptr bgfx_memory_t](mem), flags)

proc destroyIndexBuffer*(handle: IndexBuffer) =
    bgfx_destroy_index_buffer(handle)

proc createVertexBuffer*(mem: Memory, decl: VertexDecl, flags: uint16 = BGFX_BUFFER_NONE): VertexBuffer =
    return bgfx_create_vertex_buffer(cast[ptr bgfx_memory_t](mem), cast[ptr bgfx_vertex_decl_t](decl), flags)

proc destroyVertexBuffer*(handle: VertexBuffer) =
    bgfx_destroy_vertex_buffer(handle)

proc createDynamicIndexBuffer*(num: Natural, flags: uint16 = BGFX_BUFFER_NONE): DynamicIndexBuffer =
    return bgfx_create_dynamic_index_buffer(cast[uint32](num), flags)

proc createDynamicIndexBuffer*(mem: Memory, flags: uint16 = BGFX_BUFFER_NONE): DynamicIndexBuffer =
    return bgfx_create_dynamic_index_buffer_mem(cast[ptr bgfx_memory_t](mem), flags)

proc updateDynamicIndexBuffer*(handle: DynamicIndexBuffer, startIndex: Natural, mem: Memory) =
    bgfx_update_dynamic_index_buffer(handle, cast[uint32](startIndex), cast[ptr bgfx_memory_t](mem))

proc destroyDynamicIndexBuffer*(handle: DynamicIndexBuffer) =
    bgfx_destroy_dynamic_index_buffer(handle)

proc createDynamicVertexBuffer*(num: Natural, decl: VertexDecl, flags: uint16 = BGFX_BUFFER_NONE): DynamicVertexBuffer =
    return bgfx_create_dynamic_vertex_buffer(cast[uint32](num), cast[ptr bgfx_vertex_decl_t](decl), flags)

proc createDynamicVertexBuffer*(mem: Memory, decl: VertexDecl, flags: uint16 = BGFX_BUFFER_NONE): DynamicVertexBuffer =
    return bgfx_create_dynamic_vertex_buffer_mem(cast[ptr bgfx_memory_t](mem), cast[ptr bgfx_vertex_decl_t](decl), flags)

proc updateDynamicVertexBuffer*(handle: DynamicVertexBuffer, startIndex: Natural, mem: Memory) =
    bgfx_update_dynamic_vertex_buffer(handle, cast[uint32](startIndex), cast[ptr bgfx_memory_t](mem))

proc destroyDynamicVertexBuffer*(handle: DynamicVertexBuffer) =
    bgfx_destroy_dynamic_vertex_buffer(handle)

proc checkAvailTransientIndexBuffer*(num: Natural): bool =
    return bgfx_check_avail_transient_index_buffer(cast[uint32](num))

proc checkAvailTransientVertexBuffer*(num: Natural, decl: VertexDecl): bool =
    return bgfx_check_avail_transient_vertex_buffer(cast[uint32](num), cast[ptr bgfx_vertex_decl_t](decl))

proc checkAvailInstanceDataBuffer*(num, stride: Natural): bool =
    return bgfx_check_avail_instance_data_buffer(cast[uint32](num), cast[uint16](stride))

proc checkAvailTransientBuffers*(numVertices: Natural, decl: VertexDecl, numIndices: Natural): bool =
    return checkAvailTransientBuffers(cast[uint32](numVertices), cast[ptr bgfx_vertex_decl_t](decl), cast[uint32](numIndices))

proc allocTransientIndexBuffer*(tib: TransientIndexBuffer, num: Natural) =
    bgfx_alloc_transient_index_buffer(tib, cast[uint32](num))

proc allocTransientBuffers*(tvb: TransientVertexBuffer, decl: VertexDecl, numVertices: Natural, tib: TransientIndexBuffer, numIndices: Natural): bool =
    return bgfx_alloc_transient_buffers(tvb, decl, cast[uint32](numVertices), tib, cast[uint32](numIndices))

proc allocInstanceDataBuffer*(num, stride: Natural): InstanceDataBuffer =
    return bgfx_alloc_instance_data_buffer(cast[uint32](num), cast[uint16](stride))

proc destroyIndirectBuffer*(handle: IndirectBuffer) =
    bgfx_destroy_indirect_buffer(handle)

proc createShader*(mem: Memory): Shader =
    return bgfx_create_shader(mem)

proc getShaderUniforms*(handle: Shader, uniforms: ptr Uniform = nil, max: Natural = 0): Natural =
    return cast[Natural](bgfx_get_shader_uniforms(handle, uniforms, cast[uint16](max)))

proc destroyShader*(handle: Shader) =
    bgfx_destroy_shader(handle)

proc createProgram*(vsh, fsh: Shader, destroyShaders: bool = false): Program =
    return bgfx_create_program(vsh, fsh, destroyShaders)

proc createProgram*(csh: Shader, destroyShader: bool = false): Program =
    return bgfx_create_compute_program(csh, destroyShader)

proc destroyProgram*(handle: Program) =
    bgfx_destroy_program(handle)

proc calcTextureSize*(info: TextureInfo, width, height, depth: Natural, cubemap: bool, numMip: Natural, format: TextureFormat) =
    bgfx_calc_texture_size(info, cast[uint16](width), cast[uint16](height), cast[uint16](depth), cubemap, cast[uint8](numMip), cast[bgfx_texture_format_t](format))

proc createTexture*(mem: Memory, flags: uint32 = BGFX_TEXTURE_NONE, skip: Natural = 0, info: TextureInfo = nil): Texture =
    return bgfx_create_texture(mem, flags, cast[uint8](skip), info)

proc createTexture2D*(width, height, numMips: Natural, format: TextureFormat, flags: uint32 = BGFX_TEXTURE_NONE, mem: Memory = nil): Texture =
    return bgfx_create_texture_2d(cast[uint16](width), cast[uint16](height), cast[uint8](numMips), cast[bgfx_texture_format_t](format), flags, mem)

proc createTexture2D*(ratio: BackbufferRatio, numMips: Natural, format: TextureFormat, flags: uint32 = BGFX_TEXTURE_NONE): Texture =
    return bgfx_create_texture_2d_scaled(cast[bgfx_backbuffer_ratio_t](ratio), cast[uint8](numMips), cast[bgfx_texture_format_t](format), flags)

proc createTexture3D*(width, height, depth, numMips: Natural, format: TextureFormat, flags: uint32 = BGFX_TEXTURE_NONE, mem: Memory = nil): Texture =
    return bgfx_create_texture_3d(cast[uint16](width), cast[uint16](height), cast[uint16](depth), cast[uint8](numMips), cast[bgfx_texture_format_t](format), flags, mem)

proc createTextureCube*(size, numMips: Natural, format: TextureFormat, flags: uint32 = BGFX_TEXTURE_NONE, mem: Memory = nil): Texture =
    return bgfx_create_texture_cube(cast[uint16](size), cast[uint8](numMips), cast[bgfx_texture_format_t](format), flags, mem)

proc updateTexture2D*(handle: Texture, mip, x, y, width, height: Natural, mem: Memory, pitch: Natural = uint16.high) =
    bgfx_update_texture_2d(handle, cast[uint8](mip), cast[uint16](x), cast[uint16](y), cast[uint16](width), cast[uint16](height), mem, cast[uint16](pitch))

proc updateTexture3D*(handle: Texture, mip, x, y, z, width, height, depth: Natural, mem: Memory) =
    bgfx_update_texture_3d(handle, cast[uint8](mip), cast[uint16](x), cast[uint16](y), cast[uint16](z), cast[uint16](width), cast[uint16](height), cast[uint16](depth), mem)

proc updateTextureCube*(handle: Texture, side, mip, x, y, width, height: Natural, mem: Memory, pitch: Natural = uint16.high) =
    bgfx_update_texture_cube(handle, cast[uint8](side), cast[uint8](mip), cast[uint16](x), cast[uint16](y), cast[uint16](width), cast[uint16](height), mem, cast[uint16](pitch))

proc readTexture*(handle: Texture, data: ptr auto): Natural =
    return bgfx_read_texture(handle, cast[pointer](data))

proc readTexture*(handle: FrameBuffer, attachment: Natural, data: ptr auto): Natural =
    return bgfx_read_frame_buffer(handle, cast[uint8](attachment), cast[pointer](data))

proc destroyTexture*(handle: Texture) =
    bgfx_destroy_texture(handle)

proc createFrameBuffer*(width, height: Natural, format: TextureFormat, textureFlags: uint32 = BGFX_TEXTURE_U_CLAMP or BGFX_TEXTURE_V_CLAMP): FrameBuffer =
    return bgfx_create_frame_buffer(cast[uint16](width), cast[uint16](height), cast[bgfx_texture_format_t](format), textureFlags)

proc createFrameBuffer*(ratio: BackbufferRatio, format: TextureFormat, textureFlags: uint32 = BGFX_TEXTURE_U_CLAMP or BGFX_TEXTURE_V_CLAMP): FrameBuffer =
    return bgfx_create_frame_buffer_scaled(cast[bgfx_backbuffer_ratio_t](ratio), cast[bgfx_texture_format_t](format), textureFlags)

proc createFrameBuffer*(num: Natural, handles: seq[Texture], destroyTextures: bool = false): FrameBuffer =
    raise newException(LibraryError, "bgfx_create_frame_buffer_from_handles is not in C99bgfx")

proc createFrameBuffer*(num: Natural, handles: seq[Attachment], destroyTextures: bool = false): FrameBuffer =
    raise newException(LibraryError, "bgfx_create_frame_buffer_from_handles is not in C99bgfx")

proc createFrameBuffer*(nwh: pointer, width, height: Natural, depthFormat: TextureFormat = TextureFormat_UnknownDepth): FrameBuffer =
    return bgfx_create_frame_buffer_from_nwh(nwh, cast[uint16](width), cast[uint16](height), cast[bgfx_texture_format_t](depthFormat))

proc destroyFrameBuffer*(handle: FrameBuffer) =
    bgfx_destroy_frame_buffer(handle)

proc createUniform*(name: string, uniType: UniformType, num: Natural = 1): Uniform =
    return bgfx_create_uniform(name, cast[bgfx_uniform_type_t](uniType), cast[uint16](num))

proc destroyUniform*(handle: Uniform) =
    bgfx_destroy_uniform(handle)

proc createOcclusionQuery*(): OcclusionQuery =
    return bgfx_create_occlusion_query()

proc getResult*(handle: OcclusionQuery): OcclusionQueryResult =
    return cast[OcclusionQueryResult](bgfx_get_result(handle))

proc destroyOcclusionQuery*(handle: OcclusionQuery) =
    bgfx_destroy_occlusion_query(handle)

proc setPaletteColor*(index: Natural, rgba: uint32) =
    let rr = uint8(rgba shr 24)
    let gg = uint8(rgba shr 16)
    let bb = uint8(rgba shr 8)
    let aa = uint8(rgba shr 0)

    var frgba: array[4, cfloat] = [
        cast[cfloat](rr) * 1.0'f32 / 255.0'f32,
        cast[cfloat](gg) * 1.0'f32 / 255.0'f32,
        cast[cfloat](bb) * 1.0'f32 / 255.0'f32,
        cast[cfloat](aa) * 1.0'f32 / 255.0'f32]

    bgfx_set_palette_color(cast[uint8](index), frgba)

proc setPaletteColor*(index: Natural, r, g, b, a: float) =
    var frgba: array[4, cfloat] = [ cast[cfloat](r), cast[cfloat](g), cast[cfloat](b), cast[cfloat](a) ]
    bgfx_set_palette_color(cast[uint8](index), frgba)

proc setPaletteColor*(index: Natural, rgba: array[4, float]) =
    var frgba: array[4, cfloat] = [ cast[cfloat](rgba[0]), cast[cfloat](rgba[1]), cast[cfloat](rgba[2]), cast[cfloat](rgba[3]) ]
    bgfx_set_palette_color(cast[uint8](index), frgba)

proc setViewName*(id: Natural, name: string) =
    bgfx_set_view_name(cast[uint8](id), name)

proc setViewRect*(id: Natural, x, y, width, height: Natural) =
    bgfx_set_view_rect(cast[uint8](id), cast[uint16](x), cast[uint16](y), cast[uint16](width), cast[uint16](height))

proc setViewRect*(id: Natural, x, y: Natural, ratio: BackbufferRatio) =
    bgfx_set_view_rect_auto(cast[uint8](id), cast[uint16](x), cast[uint16](y), cast[bgfx_backbuffer_ratio_t](ratio))

proc setViewScissor*(id: Natural, x, y, width, height: Natural) =
    bgfx_set_view_scissor(cast[uint8](id), cast[uint16](x), cast[uint16](y), cast[uint16](width), cast[uint16](height))

proc setViewClear*(id: Natural, flags: uint16, rgba: uint32, depth: float, stencil: Natural) =
    bgfx_set_view_clear(cast[uint8](id), flags, rgba, cast[cfloat](depth), cast[uint8](stencil))

proc setViewClear*(id: Natural, flags: uint16, depth: float, stencil, i0: Natural = uint8.high, i1: Natural = uint8.high, i2: Natural = uint8.high, i3: Natural = uint8.high, i4: Natural = uint8.high, i5: Natural = uint8.high, i6: Natural = uint8.high, i7: Natural = uint8.high) =
    bgfx_set_view_clear_mrt(cast[uint8](id), flags, depth, cast[uint8](stencil), cast[uint8](i0), cast[uint8](i1), cast[uint8](i2), cast[uint8](i3), cast[uint8](i4), cast[uint8](i5), cast[uint8](i6), cast[uint8](i7))

proc setViewSeq*(id: Natural, enabled: bool) =
    bgfx_set_view_seq(cast[uint8](id), enabled)

proc setViewFrameBuffer*(id: Natural, handle: FrameBuffer) =
    bgfx_set_view_frame_buffer(cast[uint8](id), handle)

proc setViewTransform*(id: Natural, view: var seq[float], projL: var seq[float], flags: uint8 = BGFX_VIEW_STEREO, projR: ptr seq[float] = nil) =
    if flags == BGFX_VIEW_NONE:
        bgfx_set_view_transform(cast[uint8](id), view.addr, projL.addr)
    elif flags == BGFX_VIEW_STEREO and not projR.isNil:
        bgfx_set_view_transform_stereo(cast[uint8](id), view.addr, projL.addr, flags, projR)

proc setViewRemap*(id:Natural = 0, num: Natural = uint8.high, remap: pointer = nil) =
    bgfx_set_view_remap(cast[uint8](id), cast[uint8](num), remap)

proc resetView*(id: Natural) =
    bgfx_reset_view(cast[uint8](id))

proc setMarker*(marker: string) =
    bgfx_set_marker(marker)

proc setState*(stateFlag: uint32, rgba: uint32 = 0) =
    bgfx_set_state(stateFlag, rgba)

proc setCondition*(handle: OcclusionQuery, visible: bool) =
    bgfx_set_condition(handle, visible)

proc setStencil*(frontStencilFlag: uint32, backStencilFlag: uint32 = BGFX_STENCIL_NONE) =
    bgfx_set_stencil(frontStencilFlag, backStencilFlag)

proc setScissor*(x, y, width, height: Natural): Natural =
    return bgfx_set_scissor(cast[uint16](x), cast[uint16](y), cast[uint16](width), cast[uint16](height))

proc setScissor*(cache: Natural) =
    bgfx_set_scissor_cached(cast[uint16](cache))

proc setTransform*(mtx: var seq[float], num: Natural = 1): Natural =
    return bgfx_set_transform(mtx.addr, cast[uint16](num))

proc allocTransform*(transform: Transform, num: Natural): Natural =
    return bgfx_alloc_transform(transform, cast[uint16](num))

proc setTransform*(cache: Natural, num: Natural = 1) =
    bgfx_set_transform_cached(cast[uint16](cache), cast[uint16](num))

proc setUniform*(handle: Uniform, value: pointer, num: Natural = 1) =
    bgfx_set_uniform(handle, value, cast[uint16](num))

proc setIndexBuffer*(handle: IndexBuffer) =
    bgfx_set_index_buffer(handle, 0, uint32.high)

proc setIndexBuffer*(handle: IndexBuffer, firstIndex, numIndices: Natural) =
    bgfx_set_index_buffer(handle, cast[uint32](firstIndex), cast[uint32](numIndices))

proc setIndexBuffer*(handle: DynamicIndexBuffer) =
    bgfx_set_dynamic_index_buffer(handle, 0, uint32.high)

proc setIndexBuffer*(handle: DynamicIndexBuffer, firstIndex, numIndices: Natural) =
    bgfx_set_dynamic_index_buffer(handle, cast[uint32](firstIndex), cast[uint32](numIndices))

proc setIndexBuffer*(tib: TransientIndexBuffer) =
    bgfx_set_transient_index_buffer(tib, 0, uint32.high)

proc setIndexBuffer*(tib: TransientIndexBuffer, firstIndex, numIndices: Natural) =
    bgfx_set_transient_index_buffer(tib, cast[uint32](firstIndex), cast[uint32](numIndices))

proc setVertexBuffer*(handle: VertexBuffer) =
    bgfx_set_vertex_buffer(handle, 0, uint32.high)

proc setVertexBuffer*(handle: VertexBuffer, startVertex, numVertices: Natural) =
    bgfx_set_vertex_buffer(handle, cast[uint32](startVertex), cast[uint32](numVertices))

proc setVertexBuffer*(handle: DynamicVertexBuffer) =
    bgfx_set_dynamic_vertex_buffer(handle, 0, uint32.high)

proc setVertexBuffer*(handle: DynamicVertexBuffer, startVertex, numVertices: Natural) =
    bgfx_set_dynamic_vertex_buffer(handle, cast[uint32](startVertex), cast[uint32](numVertices))

proc setVertexBuffer*(tvb: TransientVertexBuffer) =
    bgfx_set_transient_vertex_buffer(tvb, 0, uint32.high)

proc setVertexBuffer*(handle: TransientVertexBuffer, startVertex, numVertices: Natural) =
    bgfx_set_transient_vertex_buffer(handle, cast[uint32](startVertex), cast[uint32](numVertices))

proc setInstanceDataBuffer*(idb: InstanceDataBuffer, num: Natural = uint32.high) =
    bgfx_set_instance_data_buffer(idb, cast[uint32](num))

proc setInstanceDataBuffer*(handle: VertexBuffer, startVertex, num: Natural) =
    bgfx_set_instance_data_from_vertex_buffer(handle, cast[uint32](startVertex), cast[uint32](num))

proc setInstanceDataBuffer*(handle: DynamicVertexBuffer, startVertex, num: Natural) =
    bgfx_set_instance_data_from_dynamic_vertex_buffer(handle, cast[uint32](startVertex), cast[uint32](num))

proc setTexture*(stage: Natural, sampler: Uniform, handle: Texture, flags: uint32 = uint32.high) =
    bgfx_set_texture(cast[uint8](stage), sampler, handle, flags)

proc setTexture*(stage: Natural, sampler: Uniform, handle: FrameBuffer, attachment: Natural = 0, flags: uint32 = uint32.high) =
    bgfx_set_texture_from_frame_buffer(cast[uint8](stage), sampler, handle, cast[uint8](attachment), flags)

proc touch*(id: Natural): Natural =
    return bgfx_touch(cast[uint8](id))

proc submit*(id: Natural, program: Program, depth: Natural = 0, preserveState: bool = false): Natural =
    return bgfx_submit(cast[uint8](id), program, cast[int32](depth), preserveState)

proc submit*(id: Natural, program: Program, occlusionQuery: OcclusionQuery, depth: Natural = 0, preserveState: bool = false): Natural =
    return bgfx_submit_occlusion_query(cast[uint8](id), program, occlusionQuery, cast[int32](depth), preserveState)

proc submit*(id: Natural, program: Program, indirectBuffer: IndirectBuffer, start: Natural = 0, num: Natural = 1, depth: Natural = 0, preserveState: bool = false): Natural =
    return bgfx_submit_indirect(cast[uint8](id), program, indirectBuffer, cast[uint16](start), cast[uint16](num), cast[int32](depth), preserveState)

proc setBuffer*(stage: Natural, handle: IndexBuffer, access: Access) =
    bgfx_set_compute_index_buffer(cast[uint8](stage), handle, cast[bgfx_access_t](access))

proc setBuffer*(stage: Natural, handle: VertexBuffer, access: Access) =
    bgfx_set_compute_vertex_buffer(cast[uint8](stage), handle, cast[bgfx_access_t](access))

proc setBuffer*(stage: Natural, handle: DynamicIndexBuffer, access: Access) =
    bgfx_set_compute_dynamic_index_buffer(cast[uint8](stage), handle, cast[bgfx_access_t](access))

proc setBuffer*(stage: Natural, handle: DynamicVertexBuffer, access: Access) =
    bgfx_set_compute_dynamic_vertex_buffer(cast[uint8](stage), handle, cast[bgfx_access_t](access))

proc setBuffer*(stage: Natural, handle: IndirectBuffer, access: Access) =
    bgfx_set_compute_indirect_buffer(cast[uint8](stage), handle, cast[bgfx_access_t](access))

proc setImage*(stage: Natural, sampler: Uniform, handle: Texture, mip: Natural, access: Access, format: TextureFormat = TextureFormat_Count) =
    bgfx_set_image(cast[uint8](stage), sampler, handle, cast[uint8](mip), cast[bgfx_access_t](access), cast[bgfx_texture_format_t](format))

proc setImage*(stage: Natural, sampler: Uniform, handle: FrameBuffer, Attachment: Natural, access: Access, format: TextureFormat) =
    bgfx_set_image_from_frame_buffer(cast[uint8](stage), sampler, handle, cast[uint8](Attachment), cast[bgfx_access_t](access), cast[bgfx_texture_format_t](format))

proc dispatch*(id: Natural, handle: Program, numX: Natural = 1, numY: Natural = 1, numZ: Natural = 1, flags: uint8 = BGFX_SUBMIT_EYE_FIRST): Natural =
    return bgfx_dispatch(cast[uint8](id), handle, cast[uint16](numX), cast[uint16](numY), cast[uint16](numZ), flags)

proc dispatch*(id: Natural, handle: Program, indirectBuffer: IndirectBuffer, start: Natural = 0, num: Natural = 1, flags: uint8 = BGFX_SUBMIT_EYE_FIRST): Natural =
    return bgfx_dispatch_indirect(cast[uint8](id), handle, indirectBuffer, cast[uint16](start), cast[uint16](num), flags)

proc `discard`*() = bgfx_discard()

proc blit*(id: Natural, dst: Texture, dstX: Natural, dstY: Natural, src: Texture, srcX: Natural = 0, srcY: Natural = 0, width: Natural = uint16.high, height: Natural = uint16.high) =
    bgfx_blit(cast[uint8](id), dst, 0'u8, cast[uint16](dstX), cast[uint16](dstY), 0'u16, src, 0'u8, cast[uint16](srcX), cast[uint16](srcY), 0'u16, cast[uint16](width), cast[uint16](height), 0'u16)

proc blit*(id: Natural, dst: Texture, dstX: Natural, dstY: Natural, src: FrameBuffer, attachment: Natural = 0, srcX: Natural = 0, srcY: Natural = 0, width: Natural = uint16.high, height: Natural = uint16.high) =
    bgfx_blit_frame_buffer(cast[uint8](id), dst, 0'u8, cast[uint16](dstX), cast[uint16](dstY), 0'u16, src, cast[uint8](attachment), 0'u8, cast[uint16](srcX), cast[uint16](srcY), 0'u16, cast[uint16](width), cast[uint16](height), 0'u16)

proc blit*(id: Natural, dst: Texture, dstMip: Natural, dstX: Natural, dstY: Natural, dstZ: Natural, src: Texture, srcMip: Natural = 0, srcX: Natural = 0, srcY: Natural = 0, srcZ: Natural = 0, width: Natural = uint16.high, height: Natural = uint16.high, depth: Natural = uint16.high) =
    bgfx_blit(cast[uint8](id), dst, cast[uint8](dstMip), cast[uint16](dstX), cast[uint16](dstY), cast[uint16](dstZ), src, cast[uint8](srcMip), cast[uint16](srcX), cast[uint16](srcY), cast[uint16](srcZ), cast[uint16](width), cast[uint16](height), cast[uint16](depth))

proc blit*(id: Natural, dst: Texture, dstMip: Natural, dstX: Natural, dstY: Natural, dstZ: Natural, src: FrameBuffer, attachment: Natural = 0, srcMip: Natural = 0, srcX: Natural = 0, srcY: Natural = 0, srcZ: Natural = 0, width: Natural = uint16.high, height: Natural = uint16.high, depth: Natural = uint16.high) =
    bgfx_blit_frame_buffer(cast[uint8](id), dst, cast[uint8](dstMip), cast[uint16](dstX), cast[uint16](dstY), cast[uint16](dstZ), src, cast[uint8](attachment), cast[uint8](srcMip), cast[uint16](srcX), cast[uint16](srcY), cast[uint16](srcZ), cast[uint16](width), cast[uint16](height), cast[uint16](depth))

proc saveScreenShot*(filePath: string) =
    bgfx_save_screen_shot(filePath)
