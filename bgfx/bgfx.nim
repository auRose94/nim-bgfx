# BGFX Wrapper

const BGFX_ATTRIB_COUNT_CONST = 15
const BGFX_TEXTURE_FORMAT_COUNT_CONST = 75
const BGFX_RENDERER_TYPE_COUNT_CONST = 7

include bgfx.constants

when defined(windows):
  const LibName = "bgfx-shared-libRelease.dll"
elif defined(macosx):
  const LibName = "bgfx-shared-libRelease.dylib"
else:
  const LibName = "bgfx-shared-libRelease.so"

{.pragma: BGFX_C_STRUCT, pure.}

type bgfx_renderer_type* = enum
    BGFX_RENDERER_TYPE_NULL, BGFX_RENDERER_TYPE_DIRECT3D9, BGFX_RENDERER_TYPE_DIRECT3D11, BGFX_RENDERER_TYPE_DIRECT3D12, BGFX_RENDERER_TYPE_METAL, BGFX_RENDERER_TYPE_OPENGLES, BGFX_RENDERER_TYPE_OPENGL, BGFX_RENDERER_TYPE_VULKAN, BGFX_RENDERER_TYPE_COUNT

type bgfx_access* = enum
    BGFX_ACCESS_READ, BGFX_ACCESS_WRITE, BGFX_ACCESS_READWRITE, BGFX_ACCESS_COUNT

type bgfx_attrib* = enum
    BGFX_ATTRIB_POSITION, BGFX_ATTRIB_NORMAL, BGFX_ATTRIB_TANGENT, BGFX_ATTRIB_BITANGENT, BGFX_ATTRIB_COLOR0, BGFX_ATTRIB_COLOR1, BGFX_ATTRIB_INDICES, BGFX_ATTRIB_WEIGHT, BGFX_ATTRIB_TEXCOORD0, BGFX_ATTRIB_TEXCOORD1, BGFX_ATTRIB_TEXCOORD2, BGFX_ATTRIB_TEXCOORD3, BGFX_ATTRIB_TEXCOORD4, BGFX_ATTRIB_TEXCOORD5, BGFX_ATTRIB_TEXCOORD6, BGFX_ATTRIB_TEXCOORD7, BGFX_ATTRIB_COUNT

type bgfx_attrib_type* = enum
    BGFX_ATTRIB_TYPE_UINT8, BGFX_ATTRIB_TYPE_UINT10, BGFX_ATTRIB_TYPE_INT16, BGFX_ATTRIB_TYPE_HALF, BGFX_ATTRIB_TYPE_FLOAT, BGFX_ATTRIB_TYPE_COUNT

type bgfx_texture_format* = enum
    BGFX_TEXTURE_FORMAT_BC1, BGFX_TEXTURE_FORMAT_BC2, BGFX_TEXTURE_FORMAT_BC3, BGFX_TEXTURE_FORMAT_BC4, BGFX_TEXTURE_FORMAT_BC5, BGFX_TEXTURE_FORMAT_BC6H, BGFX_TEXTURE_FORMAT_BC7, BGFX_TEXTURE_FORMAT_ETC1, BGFX_TEXTURE_FORMAT_ETC2, BGFX_TEXTURE_FORMAT_ETC2A, BGFX_TEXTURE_FORMAT_ETC2A1, BGFX_TEXTURE_FORMAT_PTC12, BGFX_TEXTURE_FORMAT_PTC14, BGFX_TEXTURE_FORMAT_PTC12A, BGFX_TEXTURE_FORMAT_PTC14A, BGFX_TEXTURE_FORMAT_PTC22, BGFX_TEXTURE_FORMAT_PTC24, BGFX_TEXTURE_FORMAT_UNKNOWN, BGFX_TEXTURE_FORMAT_R1, BGFX_TEXTURE_FORMAT_A8, BGFX_TEXTURE_FORMAT_R8, BGFX_TEXTURE_FORMAT_R8I, BGFX_TEXTURE_FORMAT_R8U, BGFX_TEXTURE_FORMAT_R8S, BGFX_TEXTURE_FORMAT_R16, BGFX_TEXTURE_FORMAT_R16I, BGFX_TEXTURE_FORMAT_R16U, BGFX_TEXTURE_FORMAT_R16F, BGFX_TEXTURE_FORMAT_R16S, BGFX_TEXTURE_FORMAT_R32I, BGFX_TEXTURE_FORMAT_R32U, BGFX_TEXTURE_FORMAT_R32F, BGFX_TEXTURE_FORMAT_RG8, BGFX_TEXTURE_FORMAT_RG8I, BGFX_TEXTURE_FORMAT_RG8U, BGFX_TEXTURE_FORMAT_RG8S, BGFX_TEXTURE_FORMAT_RG16, BGFX_TEXTURE_FORMAT_RG16I, BGFX_TEXTURE_FORMAT_RG16U, BGFX_TEXTURE_FORMAT_RG16F, BGFX_TEXTURE_FORMAT_RG16S, BGFX_TEXTURE_FORMAT_RG32I, BGFX_TEXTURE_FORMAT_RG32U, BGFX_TEXTURE_FORMAT_RG32F, BGFX_TEXTURE_FORMAT_RGB8, BGFX_TEXTURE_FORMAT_RGB8I, BGFX_TEXTURE_FORMAT_RGB8U, BGFX_TEXTURE_FORMAT_RGB8S, BGFX_TEXTURE_FORMAT_RGB9E5F, BGFX_TEXTURE_FORMAT_BGRA8, BGFX_TEXTURE_FORMAT_RGBA8, BGFX_TEXTURE_FORMAT_RGBA8I, BGFX_TEXTURE_FORMAT_RGBA8U, BGFX_TEXTURE_FORMAT_RGBA8S, BGFX_TEXTURE_FORMAT_RGBA16, BGFX_TEXTURE_FORMAT_RGBA16I, BGFX_TEXTURE_FORMAT_RGBA16U, BGFX_TEXTURE_FORMAT_RGBA16F, BGFX_TEXTURE_FORMAT_RGBA16S, BGFX_TEXTURE_FORMAT_RGBA32I, BGFX_TEXTURE_FORMAT_RGBA32U, BGFX_TEXTURE_FORMAT_RGBA32F, BGFX_TEXTURE_FORMAT_R5G6B5, BGFX_TEXTURE_FORMAT_RGBA4, BGFX_TEXTURE_FORMAT_RGB5A1, BGFX_TEXTURE_FORMAT_RGB10A2, BGFX_TEXTURE_FORMAT_R11G11B10F, BGFX_TEXTURE_FORMAT_UNKNOWN_DEPTH, BGFX_TEXTURE_FORMAT_D16, BGFX_TEXTURE_FORMAT_D24, BGFX_TEXTURE_FORMAT_D24S8, BGFX_TEXTURE_FORMAT_D32, BGFX_TEXTURE_FORMAT_D16F, BGFX_TEXTURE_FORMAT_D24F, BGFX_TEXTURE_FORMAT_D32F, BGFX_TEXTURE_FORMAT_D0S8, BGFX_TEXTURE_FORMAT_COUNT

type bgfx_uniform_type* = enum
    BGFX_UNIFORM_TYPE_INT1, BGFX_UNIFORM_TYPE_END, BGFX_UNIFORM_TYPE_VEC4, BGFX_UNIFORM_TYPE_MAT3, BGFX_UNIFORM_TYPE_MAT4, BGFX_UNIFORM_TYPE_COUNT

type bgfx_backbuffer_ratio* = enum
    BGFX_BACKBUFFER_RATIO_EQUAL, BGFX_BACKBUFFER_RATIO_HALF, BGFX_BACKBUFFER_RATIO_QUARTER, BGFX_BACKBUFFER_RATIO_EIGHTH, BGFX_BACKBUFFER_RATIO_SIXTEENTH, BGFX_BACKBUFFER_RATIO_DOUBLE, BGFX_BACKBUFFER_RATIO_COUNT

type bgfx_occlusion_query_result* = enum
    BGFX_OCCLUSION_QUERY_RESULT_INVISIBLE, BGFX_OCCLUSION_QUERY_RESULT_VISIBLE, BGFX_OCCLUSION_QUERY_RESULT_NORESULT, BGFX_OCCLUSION_QUERY_RESULT_COUNT

type bgfx_topology_convert* = enum
    BGFX_TOPOLOGY_CONVERT_TRI_LIST_FLIP_WINDING, BGFX_TOPOLOGY_CONVERT_TRI_LIST_TO_LINE_LIST, BGFX_TOPOLOGY_CONVERT_TRI_STRIP_TO_TRI_LIST, BGFX_TOPOLOGY_CONVERT_LINE_STRIP_TO_LINE_LIST, BGFX_TOPOLOGY_CONVERT_COUNT

type
    bgfx_dynamic_index_buffer_handle* {.BGFX_C_STRUCT.} = object
        idx: uint16
    bgfx_dynamic_vertex_buffer_handle* {.BGFX_C_STRUCT.} = object
        idx: uint16
    bgfx_frame_buffer_handle* {.BGFX_C_STRUCT.} = object
        idx: uint16
    bgfx_index_buffer_handle* {.BGFX_C_STRUCT.} = object
        idx: uint16
    bgfx_indirect_buffer_handle* {.BGFX_C_STRUCT.} = object
        idx: uint16
    bgfx_occlusion_query_handle* {.BGFX_C_STRUCT.} = object
        idx: uint16
    bgfx_program_handle* {.BGFX_C_STRUCT.} = object
        idx: uint16
    bgfx_shader_handle* {.BGFX_C_STRUCT.} = object
        idx: uint16
    bgfx_texture_handle* {.BGFX_C_STRUCT.} = object
        idx: uint16
    bgfx_uniform_handle* {.BGFX_C_STRUCT.} = object
        idx: uint16
    bgfx_vertex_buffer_handle* {.BGFX_C_STRUCT.} = object
        idx: uint16
    bgfx_vertex_decl_handle* {.BGFX_C_STRUCT.} = object
        idx: uint16

type bgfx_release_fn_t* = (proc(pntr: pointer, userdata: pointer){.cdecl.})

type bgfx_memory* {.BGFX_C_STRUCT.} = object
    data*: ptr uint8
    size*: uint32

type bgfx_transform* {.BGFX_C_STRUCT.} = object
    data*: ptr float
    num*: uint16

type bgfx_hmd_eye* {.BGFX_C_STRUCT.} = object
    rotation*: array[0..3, float]
    translation*: array[0..2, float]
    fov*: array[0..3, float]
    viewOffset*: array[0..2, float]
    projection*: array[0..15, float]
    pixelsPerTanAngle*: array[0..1, float]

type bgfx_hmd* {.BGFX_C_STRUCT.} = object
    eye*: array[0..1, bgfx_hmd_eye]
    width*: uint16
    height*: uint16
    deviceWidth*: uint16
    deviceHeight*: uint16
    flags*: uint8

type bgfx_stats* {.BGFX_C_STRUCT.} = object
    cpuTimeBegin*: uint64
    cpuTimeEnd*: uint64
    cpuTimerFreq*: uint64
    gpuTimeBegin*: uint64
    gpuTimeEnd*: uint64
    gpuTimerFreq*: uint64
    waitRender*: uint64
    waitSubmit*: uint64

type bgfx_vertex_decl* {.BGFX_C_STRUCT.} = object
    hash*: uint32
    stride*: uint16
    offset*: array[0..BGFX_ATTRIB_COUNT_CONST, uint16]
    attributes*: array[0..BGFX_ATTRIB_COUNT_CONST, uint16]

type bgfx_transient_index_buffer* {.BGFX_C_STRUCT.} = object
    data*: ptr uint8
    size*: uint32
    handle*: bgfx_index_buffer_handle
    startIndex*: uint32

type bgfx_transient_vertex_buffer* {.BGFX_C_STRUCT.} = object
    data*: ptr uint8
    size*: uint32
    startVertex*: uint32
    stride*: uint16
    handle*: bgfx_vertex_buffer_handle
    decl*: bgfx_vertex_decl_handle

type bgfx_instance_data_buffer* {.BGFX_C_STRUCT.} = object
    data*: ptr uint8
    size*: uint32
    offset*: uint32
    num*: uint32
    stride*: uint16
    handle*: bgfx_vertex_buffer_handle

type bgfx_texture_info* {.BGFX_C_STRUCT.} = object
    format*: bgfx_texture_format
    storageSize*: uint32
    width*: uint16
    height*: uint16
    depth*: uint16
    numMips*: uint8
    bitsPerPixel*: uint8
    cubeMap*: bool

type bgfx_attachment* {.BGFX_C_STRUCT.} = object
    handle*: bgfx_texture_handle
    mip*: uint16
    layer*: uint16

type bgfx_caps_gpu* {.BGFX_C_STRUCT.} = object
    vendorId*: uint16
    deviceId*: uint16

type bgfx_caps* {.BGFX_C_STRUCT.} = object
    rendererType*: bgfx_renderer_type
    supported*: uint64
    maxDrawCalls*: uint32
    maxTextureSize*: uint16
    maxViews*: uint16
    maxFBAttachments*: uint8
    numGPUs*: uint8
    homogeneousDepth*: bool
    originBottomLeft*: bool
    vendorId*: uint16
    deviceId*: uint16
    gpu*: array[0..3, bgfx_caps_gpu]
    formats*: array[0..BGFX_TEXTURE_FORMAT_COUNT_CONST, uint16]

type bgfx_fatal* = enum
    BGFX_FATAL_DEBUG_CHECK, BGFX_FATAL_MINIMUM_REQUIRED_SPECS, BGFX_FATAL_INVALID_SHADER, BGFX_FATAL_UNABLE_TO_INITIALIZE, BGFX_FATAL_UNABLE_TO_CREATE_TEXTURE, BGFX_FATAL_DEVICE_LOST, BGFX_FATAL_COUNT

type
    bgfx_fatal_fn_t* = (proc(this: ptr bgfx_callback_interface, code: bgfx_fatal, str: cstring) {.cdecl.})
    bgfx_trace_vargs_fn_t* = (proc(this: ptr bgfx_callback_interface, filePath: cstring, line: uint16, format: cstring) {.cdecl, varargs.})
    bgfx_cache_read_size_fn_t* = (proc(this: ptr bgfx_callback_interface, id: uint64): uint32 {.cdecl.})
    bgfx_cache_read_fn_t* = (proc(this: ptr bgfx_callback_interface, id: uint64, data: pointer, size: uint32): bool {.cdecl.})
    bgfx_cache_write_fn_t* = (proc(this: ptr bgfx_callback_interface, id: uint64, data: pointer, size: uint32) {.cdecl.})
    bgfx_screen_shot_fn_t* = (proc(this: ptr bgfx_callback_interface, filePath: cstring, width: uint32, height: uint32, pitch: uint32, data: pointer, size: uint32, yflip: bool) {.cdecl.})
    bgfx_capture_begin_fn_t* = (proc(this: ptr bgfx_callback_interface, width: uint32, height: uint32, pitch: uint32, format: bgfx_texture_format, yflip: bool) {.cdecl.})
    bgfx_capture_end_fn_t* = (proc(this: ptr bgfx_callback_interface) {.cdecl.})
    bgfx_capture_frame_fn_t* = (proc(this: ptr bgfx_callback_interface, data: pointer, size: uint32){.cdecl.})

    bgfx_callback_vtbl* {.BGFX_C_STRUCT.} = object
        fatal: ptr bgfx_fatal_fn_t
        trace_vargs: ptr bgfx_trace_vargs_fn_t
        cache_read_size: ptr bgfx_cache_read_size_fn_t
        cache_read: ptr bgfx_cache_read_fn_t
        cache_write: ptr bgfx_cache_write_fn_t
        screen_shot: ptr bgfx_screen_shot_fn_t
        capture_begin: ptr bgfx_capture_begin_fn_t
        capture_end: ptr bgfx_capture_end_fn_t
        capture_frame: ptr bgfx_capture_frame_fn_t

    bgfx_callback_interface* {.BGFX_C_STRUCT.} = object
        vtbl: ptr bgfx_callback_vtbl

type
    bgfx_realloc_fn_t* = (proc(this: ptr bgfx_allocator_interface, pntr: pointer, size: csize, align: csize, file: cstring, line: uint32): pointer {.cdecl.})

    bgfx_allocator_vtbl* {.BGFX_C_STRUCT.} = object
        realloc: ptr bgfx_realloc_fn_t

    bgfx_allocator_interface* {.BGFX_C_STRUCT.} = object
        vtbl: ptr bgfx_allocator_vtbl

{.pragma: BGFX_C_API, importc, dynlib:LibName, cdecl.}

proc bgfx_vertex_decl_begin*(decl: ptr bgfx_vertex_decl, renderer: bgfx_renderer_type) {.BGFX_C_API.}

proc bgfx_vertex_decl_add*(decl: ptr bgfx_vertex_decl, attrib: bgfx_attrib, num: uint8, attrib_type: bgfx_attrib_type, normalized: bool, asInt: bool) {.BGFX_C_API.}

proc bgfx_vertex_decl_skip*(decl: ptr bgfx_vertex_decl, num: uint8) {.BGFX_C_API.}

proc bgfx_vertex_decl_end*(decl: ptr bgfx_vertex_decl) {.BGFX_C_API.}

proc bgfx_vertex_pack*(input: array[0..3, float], inputNormalized: bool, attr: bgfx_attrib, decl: ptr bgfx_vertex_decl, data: pointer, index: uint32) {.BGFX_C_API.}

proc bgfx_vertex_unpack*(output: array[0..3, float], attr: bgfx_attrib, decl: ptr bgfx_vertex_decl, data: pointer, index: uint32) {.BGFX_C_API.}

proc bgfx_vertex_convert*(destDecl: ptr bgfx_vertex_decl, destData: pointer, srcDecl: ptr bgfx_vertex_decl, srcData: pointer, num: uint32) {.BGFX_C_API.}

proc bgfx_weld_vertices*(output: uint16, decl: ptr bgfx_vertex_decl, data: pointer, num: uint16, epsilon: float): uint16 {.BGFX_C_API.}

proc bgfx_image_swizzle_bgra8*(width, height, pitch: uint32, src: pointer, dst: pointer) {.BGFX_C_API.}

proc bgfx_image_rgba8_downsample_2x2*(width, height, pitch: uint32, src: pointer, dst: pointer) {.BGFX_C_API.}

proc bgfx_get_supported_renderers*(e: array[0..BGFX_RENDERER_TYPE_COUNT_CONST, bgfx_renderer_type]): uint8 {.BGFX_C_API.}

proc bgfx_get_renderer_name*(renderer_type: bgfx_renderer_type) : cstring {.BGFX_C_API.}

proc bgfx_init*(renderer_type: bgfx_renderer_type, vendorId: uint16, deviceId: uint16, callback: ptr bgfx_callback_interface, allocator: ptr bgfx_allocator_interface) : bool {.BGFX_C_API.}

proc bgfx_shutdown*() {.BGFX_C_API.}

proc bgfx_reset*(width, height: uint32, flags: uint32) {.BGFX_C_API.}

proc bgfx_frame*(capture: bool): uint32 {.BGFX_C_API.}

proc bgfx_get_renderer_type*(): bgfx_renderer_type {.BGFX_C_API.}

proc bgfx_get_caps*(): ptr bgfx_caps {.BGFX_C_API.}

proc bgfx_get_hmd*(): ptr bgfx_hmd {.BGFX_C_API.}

proc bgfx_get_stats*(): ptr bgfx_stats {.BGFX_C_API.}

proc bgfx_alloc*(size: uint32): ptr bgfx_memory {.BGFX_C_API.}

proc bgfx_copy*(data: pointer, size: uint32): ptr bgfx_memory {.BGFX_C_API.}

proc bgfx_make_ref*(data: pointer, size: uint32): ptr bgfx_memory {.BGFX_C_API.}

proc bgfx_make_ref_release*(data: pointer, size: uint32, releaseFn: ptr bgfx_release_fn_t, userData: pointer): ptr bgfx_memory {.BGFX_C_API.}

proc bgfx_set_debug*(debug: uint32) {.BGFX_C_API.}

proc bgfx_dbg_text_clear*(attr: uint8, small: bool) {.BGFX_C_API.}

proc bgfx_dbg_text_printf*(x, y: uint16, attr: uint8, format: cstring) {.BGFX_C_API, varargs.}

proc bgfx_dbg_text_image*(x, y, width, height: uint16, data: pointer, pitch: uint16) {.BGFX_C_API.}

proc bgfx_create_index_buffer*(mem: ptr bgfx_memory, flags: uint16): bgfx_index_buffer_handle {.BGFX_C_API.}

proc bgfx_destroy_index_buffer*(handle: bgfx_index_buffer_handle) {.BGFX_C_API.}

proc bgfx_create_vertex_buffer*(mem: ptr bgfx_memory, decl: ptr bgfx_vertex_decl, flags: uint16): bgfx_vertex_buffer_handle {.BGFX_C_API.}

proc bgfx_destroy_vertex_buffer*(handle: bgfx_vertex_buffer_handle) {.BGFX_C_API.}

proc bgfx_create_dynamic_index_buffer*(num: uint32, flags: uint16): bgfx_dynamic_index_buffer_handle {.BGFX_C_API.}

proc bgfx_create_dynamic_index_buffer_mem*(mem: ptr bgfx_memory, flags: uint16): bgfx_dynamic_index_buffer_handle {.BGFX_C_API.}

proc bgfx_update_dynamic_index_buffer*(handle: bgfx_dynamic_index_buffer_handle, startIndex: uint32, mem: ptr bgfx_memory) {.BGFX_C_API.}

proc bgfx_destroy_dynamic_index_buffer*(handle: bgfx_dynamic_index_buffer_handle) {.BGFX_C_API.}

proc bgfx_create_dynamic_vertex_buffer*(num: uint32, decl: ptr bgfx_vertex_decl, flags: uint16): bgfx_dynamic_vertex_buffer_handle {.BGFX_C_API.}

proc bgfx_create_dynamic_vertex_buffer_mem*(mem: ptr bgfx_memory, decl: ptr bgfx_vertex_decl, flags: uint16): bgfx_dynamic_vertex_buffer_handle {.BGFX_C_API.}

proc bgfx_update_dynamic_vertex_buffer*(handle: bgfx_dynamic_vertex_buffer_handle, startVertex: uint32, mem: ptr bgfx_memory) {.BGFX_C_API.}

proc bgfx_destroy_dynamic_vertex_buffer*(handle: bgfx_dynamic_vertex_buffer_handle) {.BGFX_C_API.}

proc bgfx_check_avail_transient_index_buffer*(num: uint32):bool {.BGFX_C_API.}

proc bgfx_check_avail_transient_vertex_buffer*(num: uint32, decl: ptr bgfx_vertex_decl): bool {.BGFX_C_API.}

proc bgfx_check_avail_instance_data_buffer*(num: uint32, stride: uint16): bool {.BGFX_C_API.}

proc bgfx_check_avail_transient_buffers*(numVertices: uint32, decl: ptr bgfx_vertex_decl, numIndices: uint32): bool {.BGFX_C_API.}

proc bgfx_alloc_transient_index_buffer*(tib: ptr bgfx_transient_index_buffer, num: uint32) {.BGFX_C_API.}

proc bgfx_alloc_transient_vertex_buffer*(tvb: ptr bgfx_transient_vertex_buffer, num: uint32, decl: ptr bgfx_vertex_decl) {.BGFX_C_API.}

proc bgfx_alloc_transient_buffers*(tvb: ptr bgfx_transient_vertex_buffer, decl: ptr bgfx_vertex_decl, numVertices: uint32, tib: ptr bgfx_transient_index_buffer, numIndices: uint32): bool {.BGFX_C_API.}

proc bgfx_alloc_instance_data_buffer*(num: uint32, stride: uint16): ptr bgfx_instance_data_buffer {.BGFX_C_API.}

proc bgfx_create_indirect_buffer*(num: uint32): bgfx_indirect_buffer_handle {.BGFX_C_API.}

proc bgfx_destroy_indirect_buffer*(handle: bgfx_indirect_buffer_handle) {.BGFX_C_API.}

proc bgfx_create_shader*(mem: ptr bgfx_memory): bgfx_shader_handle {.BGFX_C_API.}

proc bgfx_get_shader_uniforms*(handle: bgfx_shader_handle, uniforms: ptr bgfx_uniform_handle, max: uint16) : uint16 {.BGFX_C_API.}

proc bgfx_destroy_shader*(handle: bgfx_shader_handle) {.BGFX_C_API.}

proc bgfx_create_program*(vsh: bgfx_shader_handle, fsh: bgfx_shader_handle, destroyShaders: bool): bgfx_program_handle {.BGFX_C_API.}

proc bgfx_create_compute_program*(csh: bgfx_shader_handle, destroyShader: bool): bgfx_program_handle {.BGFX_C_API.}

proc bgfx_destroy_program*(handle: bgfx_program_handle) {.BGFX_C_API.}

proc bgfx_calc_texture_size*(info: ptr bgfx_texture_info, width, height, depth: uint16, cubeMap: bool, numMips: uint8, format: bgfx_texture_format) {.BGFX_C_API.}

proc bgfx_create_texture*(mem: ptr bgfx_memory, flags: uint32, skip: uint8, info: ptr bgfx_texture_info): bgfx_texture_handle {.BGFX_C_API.}

proc bgfx_create_texture_2d*(width, height: uint16, numMips: uint8, format: bgfx_texture_format, flags: uint32, mem: ptr bgfx_memory): bgfx_texture_handle {.BGFX_C_API.}

proc bgfx_create_texture_2d_scaled*(ratio: bgfx_backbuffer_ratio, numMips: uint8, format: bgfx_texture_format, flags: uint32): bgfx_texture_handle {.BGFX_C_API.}

proc bgfx_create_texture_3d*(width, height, depth: uint16, numMip: uint8, format: bgfx_texture_format, flags: uint32, mem: ptr bgfx_memory): bgfx_texture_handle {.BGFX_C_API.}

proc bgfx_create_texture_cube*(size: uint16, numMips: uint8, format: bgfx_texture_format, flags: uint32, mem: ptr bgfx_memory): bgfx_texture_handle {.BGFX_C_API.}

proc bgfx_update_texture_2d*(handle: bgfx_texture_handle, mip: uint8, x,y,width, height:uint16, mem: ptr bgfx_memory, pitch: uint16) {.BGFX_C_API.}

proc bgfx_update_texture_3d*(handle: bgfx_texture_handle, mip: uint8, x, y, z, width, height, depth: uint16, mem: ptr bgfx_memory) {.BGFX_C_API.}

proc bgfx_update_texture_cube*(handle: bgfx_texture_handle, side: uint8, mip: uint8, x, y, width, height: uint16, mem: ptr bgfx_memory, pitch: uint16) {.BGFX_C_API.}

proc bgfx_read_texture*(handle: bgfx_texture_handle, data: pointer): uint32 {.BGFX_C_API.}

proc bgfx_read_frame_buffer*(handle: bgfx_frame_buffer_handle, attachment: uint8, data: pointer): uint32 {.BGFX_C_API.}

proc bgfx_destroy_texture*(handle: bgfx_texture_handle) {.BGFX_C_API.}

proc bgfx_create_frame_buffer*(width, height: uint16, format: bgfx_texture_format, textureFlags: uint32): bgfx_frame_buffer_handle {.BGFX_C_API.}

proc bgfx_create_frame_buffer_scaled*(ratio: bgfx_backbuffer_ratio, format: bgfx_texture_format, textureFlags: uint32): bgfx_frame_buffer_handle {.BGFX_C_API.}

proc bgfx_create_frame_buffer_from_attachment*(num: uint8, attachment: ptr bgfx_attachment, destroyTextures: bool): bgfx_frame_buffer_handle {.BGFX_C_API.}

proc bgfx_create_frame_buffer_from_nwh*(nwh: pointer, width, height: uint16, depthFormat: bgfx_texture_format): bgfx_frame_buffer_handle {.BGFX_C_API.}

proc bgfx_destroy_frame_buffer*(handle: bgfx_frame_buffer_handle) {.BGFX_C_API.}

proc bgfx_create_uniform*(name: cstring, uniform_type: bgfx_uniform_type, num: uint16): bgfx_uniform_handle {.BGFX_C_API.}

proc bgfx_destroy_uniform*(handle: bgfx_uniform_handle) {.BGFX_C_API.}

proc bgfx_create_occlusion_query*() {.BGFX_C_API.}

proc bgfx_get_result*(handle: bgfx_occlusion_query_handle): bgfx_occlusion_query_result {.BGFX_C_API.}

proc bgfx_destroy_occlusion_query*(handle: bgfx_occlusion_query_handle) {.BGFX_C_API.}

proc bgfx_set_palette_color*(index: uint8, rgba: array[0..3, float]) {.BGFX_C_API.}

proc bgfx_set_view_name*(id: uint8, name: cstring) {.BGFX_C_API.}

proc bgfx_set_view_rect*(id: uint8, x, y, width, height: uint16) {.BGFX_C_API.}

proc bgfx_set_view_rect_auto*(id: uint8, x, y: uint16, ratio: bgfx_backbuffer_ratio) {.BGFX_C_API.}

proc bgfx_set_view_scissor*(id: uint8, x, y, width, height: uint16) {.BGFX_C_API.}

proc bgfx_set_view_clear*(id: uint8, flags: uint16, rgba: uint32, depth: float, stencil: uint8) {.BGFX_C_API.}

proc bgfx_set_view_clear_mrt*(id: uint8, flags: uint16, depth: float, stencil: uint8, index0, index1, index2, index3, index4, index5, index6, index7: uint8) {.BGFX_C_API.}

proc bgfx_set_view_seq*(id: uint8, enabled: bool) {.BGFX_C_API.}

proc bgfx_set_view_frame_buffer*(id: uint8, handle: bgfx_frame_buffer_handle) {.BGFX_C_API.}

proc bgfx_set_view_transform*(id: uint8, view, proj: pointer) {.BGFX_C_API.}

proc bgfx_set_view_transform_stereo*(id: uint8, view, projL, flags, projR: pointer) {.BGFX_C_API.}

proc bgfx_set_view_remap*(id, num: uint8, remap: pointer) {.BGFX_C_API.}

proc bgfx_reset_view*(id: uint8) {.BGFX_C_API.}

proc bgfx_set_marker*(marker: cstring) {.BGFX_C_API.}

proc bgfx_set_state*(state: uint64, rgba: uint32) {.BGFX_C_API.}

proc bgfx_set_condition*(handle: bgfx_occlusion_query_handle, visible: bool) {.BGFX_C_API.}

proc bgfx_set_stencil*(fstencil: uint32, bstencil: uint32) {.BGFX_C_API.}

proc bgfx_set_scissor*(x, y, width, height: uint16): uint16 {.BGFX_C_API.}

proc bgfx_set_scissor_cached*(cache: uint16) {.BGFX_C_API.}

proc bgfx_set_transform*(mtx: pointer, num: uint16) : uint32 {.BGFX_C_API, discardable.}

proc bgfx_alloc_transform*(transform: ptr bgfx_transform, num: uint16): uint32 {.BGFX_C_API.}

proc bgfx_set_transform_cached*(cache: uint32, num: uint16) {.BGFX_C_API.}

proc bgfx_set_uniform*(handle: bgfx_uniform_handle, value: pointer, num: uint16) {.BGFX_C_API.}

proc bgfx_set_index_buffer*(handle: bgfx_index_buffer_handle, firstIndex, numIndices: uint32) {.BGFX_C_API.}

proc bgfx_set_dynamic_index_buffer*(handle: bgfx_dynamic_index_buffer_handle, firstIndex, numIndices: uint32) {.BGFX_C_API.}

proc bgfx_set_transient_index_buffer*(tib: ptr bgfx_transient_index_buffer, firstIndex, numIndices: uint32) {.BGFX_C_API.}

proc bgfx_set_vertex_buffer*(handle: bgfx_vertex_buffer_handle, startVertx, numVertices: uint32)  {.BGFX_C_API.}

proc bgfx_set_dynamic_vertex_buffer*(handle: bgfx_dynamic_vertex_buffer_handle, startVertex, numVertices: uint32) {.BGFX_C_API.}

proc bgfx_set_transient_vertex_buffer*(tvb: ptr bgfx_transient_vertex_buffer, startVertex, numVertices: uint32) {.BGFX_C_API.}

proc bgfx_set_instance_data_buffer*(idb: ptr bgfx_instance_data_buffer, num: uint32) {.BGFX_C_API.}

proc bgfx_set_instance_data_from_vertex_buffer*(handle: bgfx_vertex_buffer_handle, startVertex, num: uint32) {.BGFX_C_API.}

proc bgfx_set_instance_data_from_dynamic_vertex_buffer*(handle: bgfx_dynamic_vertex_buffer_handle, startVertex, num: uint32) {.BGFX_C_API.}

proc bgfx_set_texture*(stage: uint8, sampler: bgfx_uniform_handle, handle: bgfx_texture_handle, flags: uint32) {.BGFX_C_API.}

proc bgfx_set_texture_from_frame_buffer*(stage: uint8, sampler: bgfx_uniform_handle, handle: bgfx_frame_buffer_handle, attachment: uint8, flags: uint32) {.BGFX_C_API.}

proc bgfx_touch*(id: uint8): uint32 {.BGFX_C_API.}

proc bgfx_submit*(id: uint8, handle: bgfx_program_handle, depth: int32, preserveState: bool): uint32 {.BGFX_C_API, discardable.}

proc bgfx_submit_occlusion_query*(id: uint8, program: bgfx_program_handle, occlusionQuery: bgfx_occlusion_query_handle, depth: uint32, preserveState: bool): uint32 {.BGFX_C_API.}

proc bgfx_submit_indirect*(id: uint8, handle: bgfx_program_handle, indirectHandle: bgfx_indirect_buffer_handle, start, num: uint16, depth: uint32, preserveState: bool): uint32 {.BGFX_C_API.}

proc bgfx_set_image*(stage: uint8, sampler: bgfx_uniform_handle, handle: bgfx_texture_handle, mip: uint8, access: bgfx_access, format: bgfx_texture_format) {.BGFX_C_API.}

proc bgfx_set_image_from_frame_buffer*(stage: uint8, sampler: bgfx_uniform_handle, handle: bgfx_frame_buffer_handle, attachment: uint8, access: bgfx_access, format: bgfx_texture_format) {.BGFX_C_API.}

proc bgfx_set_compute_index_buffer*(stage: uint8, handle: bgfx_index_buffer_handle, access: bgfx_access) {.BGFX_C_API.}

proc bgfx_set_compute_vertex_buffer*(stage: uint8, handle: bgfx_vertex_buffer_handle, access: bgfx_access) {.BGFX_C_API.}

proc bgfx_set_compute_dynamic_index_buffer*(stage: uint8, handle: bgfx_dynamic_index_buffer_handle, access: bgfx_access) {.BGFX_C_API.}

proc bgfx_set_compute_dynamic_vertex_buffer*(stage: uint8, handle: bgfx_dynamic_vertex_buffer_handle, access: bgfx_access) {.BGFX_C_API.}

proc bgfx_set_compute_indirect_buffer*(stage: uint8, handle: bgfx_indirect_buffer_handle, access: bgfx_access) {.BGFX_C_API.}

proc bgfx_dispatch*(id: uint8, handle: bgfx_program_handle, numX, numY, numZ: uint16, flags: uint8): uint32 {.BGFX_C_API.}

proc bgfx_dispatch_indirect*(id: uint8, handle: bgfx_program_handle, indirecHandle: bgfx_indirect_buffer_handle, start, num: uint16, flags: uint8): uint32 {.BGFX_C_API.}

proc bgfx_discard*() {.BGFX_C_API.}

proc bgfx_blit*(id: uint8, dst: bgfx_texture_handle, dstMip: uint8, dstX, dstY, dstZ: uint16, src: bgfx_texture_handle, srcMip: uint8, srcX, srcY, srcZ, width, height, depth: uint16 ) {.BGFX_C_API.}

proc bgfx_blit_frame_buffer*(id: uint8, dst: bgfx_texture_handle, dstMip: uint8, dstX, dstY, dstZ: uint16, src: bgfx_frame_buffer_handle, attachment, srcMip: uint8, srcX, srcY, srcZ, width,height, depth : uint16) {.BGFX_C_API.}

proc bgfx_save_screen_shot*(filePath: cstring) {.BGFX_C_API.}

type bgfx_render_frame* = enum
    BGFX_RENDER_FRAME_NO_CONTEXT, BGFX_RENDER_FRAME_RENDER, BGFX_RENDER_FRAME_EXITING, BGFX_RENDER_FRAME_COUNT

type bgfx_platform_data* {.pure.} = object
    ndt*: pointer
    nwh*: pointer
    context*: pointer
    backBuffer*: pointer
    backBufferDS*: pointer

proc bgfx_set_platform_data*(data: ptr bgfx_platform_data) {.BGFX_C_API.}

type bgfx_internal_data* {.pure.} = object
    caps*: ptr bgfx_caps
    context*: pointer

proc bgfx_get_internal_data*(): ptr bgfx_internal_data {.BGFX_C_API.}

proc bgfx_override_internal_texture_ptr*(handle: bgfx_texture_handle, pntr: cuint): cuint {.BGFX_C_API.}

proc bgfx_override_internal_texture*(handle: bgfx_texture_handle, width, height: uint16, numMips: uint8, format: bgfx_texture_format, flags: uint32): cuint {.BGFX_C_API.}

# Ported C++ methods

method isValid*(self: bgfx_dynamic_index_buffer_handle): bool {.inline, base.} =
    return self.idx != uint16.high

method isValid*(self: bgfx_dynamic_vertex_buffer_handle): bool {.inline, base.} =
    return self.idx != uint16.high

method isValid*(self: bgfx_frame_buffer_handle): bool {.inline, base.} =
    return self.idx != uint16.high

method isValid*(self: bgfx_index_buffer_handle): bool {.inline, base.} =
    return self.idx != uint16.high

method isValid*(self: bgfx_indirect_buffer_handle): bool {.inline, base.} =
    return self.idx != uint16.high

method isValid*(self: bgfx_program_handle): bool {.inline, base.} =
    return self.idx != uint16.high

method isValid*(self: bgfx_shader_handle): bool {.inline, base.} =
    return self.idx != uint16.high

method isValid*(self: bgfx_texture_handle): bool {.inline, base.} =
    return self.idx != uint16.high

method isValid*(self: bgfx_uniform_handle): bool {.inline, base.} =
    return self.idx != uint16.high

method isValid*(self: bgfx_vertex_buffer_handle): bool {.inline, base.} =
    return self.idx != uint16.high

method isValid*(self: bgfx_vertex_decl_handle): bool {.inline, base.} =
    return self.idx != uint16.high
