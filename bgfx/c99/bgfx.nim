const BGFX_API_VERSION* = 16

when defined(Windows):
    const BGFXLibraryName = "bgfx-shared-libRelease.dll"
elif defined(MacOSX):
    const BGFXLibraryName = "bgfx-shared-libRelease.dylib"
elif defined(Linux):
    const BGFXLibraryName = "bgfx-shared-libRelease.so"
else:
    const BGFXLibraryName = "Platform Not Supported"

const
    BGFX_STATE_RGB_WRITE* = 0x0000000000000001'u64 #!< Enable RGB write.
    BGFX_STATE_ALPHA_WRITE* = 0x0000000000000002'u64 #!< Enable alpha write.
    BGFX_STATE_DEPTH_WRITE* = 0x0000000000000004'u64 #!< Enable depth write.
    BGFX_STATE_DEPTH_TEST_LESS* = 0x0000000000000010'u64 #!< Enable depth test, less.
    BGFX_STATE_DEPTH_TEST_LEQUAL* = 0x0000000000000020'u64 #!< Enable depth test, less equal.
    BGFX_STATE_DEPTH_TEST_EQUAL* = 0x0000000000000030'u64 #!< Enable depth test, equal.
    BGFX_STATE_DEPTH_TEST_GEQUAL* = 0x0000000000000040'u64 #!< Enable depth test, greater equal.
    BGFX_STATE_DEPTH_TEST_GREATER* = 0x0000000000000050'u64 #!< Enable depth test, greater.
    BGFX_STATE_DEPTH_TEST_NOTEQUAL* = 0x0000000000000060'u64 #!< Enable depth test, not equal.
    BGFX_STATE_DEPTH_TEST_NEVER* = 0x0000000000000070'u64 #!< Enable depth test, never.
    BGFX_STATE_DEPTH_TEST_ALWAYS* = 0x0000000000000080'u64 #!< Enable depth test, always.
    BGFX_STATE_DEPTH_TEST_SHIFT* = 4'u64
    BGFX_STATE_DEPTH_TEST_MASK* = 0x00000000000000F0'u64 #!< Depth test state bit mask.
    BGFX_STATE_BLEND_ZERO* = 0x0000000000001000'u64 #!<
    BGFX_STATE_BLEND_ONE* = 0x0000000000002000'u64 #!<
    BGFX_STATE_BLEND_SRC_COLOR* = 0x0000000000003000'u64 #!<
    BGFX_STATE_BLEND_INV_SRC_COLOR* = 0x0000000000004000'u64 #!<
    BGFX_STATE_BLEND_SRC_ALPHA* = 0x0000000000005000'u64 #!<
    BGFX_STATE_BLEND_INV_SRC_ALPHA* = 0x0000000000006000'u64 #!<
    BGFX_STATE_BLEND_DST_ALPHA* = 0x0000000000007000'u64 #!<
    BGFX_STATE_BLEND_INV_DST_ALPHA* = 0x0000000000008000'u64 #!<
    BGFX_STATE_BLEND_DST_COLOR* = 0x0000000000009000'u64 #!<
    BGFX_STATE_BLEND_INV_DST_COLOR* = 0x000000000000A000'u64 #!<
    BGFX_STATE_BLEND_SRC_ALPHA_SAT* = 0x000000000000B000'u64 #!<
    BGFX_STATE_BLEND_FACTOR* = 0x000000000000C000'u64 #!<
    BGFX_STATE_BLEND_INV_FACTOR* = 0x000000000000D000'u64 #!<
    BGFX_STATE_BLEND_SHIFT* = 12'u64
    BGFX_STATE_BLEND_MASK* = 0x000000000FFFF000'u64 #!< Blend state bit mask.
    BGFX_STATE_BLEND_EQUATION_ADD* = 0x0000000000000000'u64 #!<
    BGFX_STATE_BLEND_EQUATION_SUB* = 0x0000000010000000'u64 #!<
    BGFX_STATE_BLEND_EQUATION_REVSUB* = 0x0000000020000000'u64 #!<
    BGFX_STATE_BLEND_EQUATION_MIN* = 0x0000000030000000'u64 #!<
    BGFX_STATE_BLEND_EQUATION_MAX* = 0x0000000040000000'u64 #!<
    BGFX_STATE_BLEND_EQUATION_SHIFT* = 28'u64
    BGFX_STATE_BLEND_EQUATION_MASK* = 0x00000003F0000000'u64 #!< Blend equation bit mask.
    BGFX_STATE_BLEND_INDEPENDENT* = 0x0000000400000000'u64 #!< Enable blend independent.
    BGFX_STATE_BLEND_ALPHA_TO_COVERAGE* = 0x0000000800000000'u64 #!< Enable alpha to coverage.
    BGFX_STATE_CULL_CW* = 0x0000001000000000'u64 #!< Cull clockwise triangles.
    BGFX_STATE_CULL_CCW* = 0x0000002000000000'u64 #!< Cull counter-clockwise triangles.
    BGFX_STATE_CULL_SHIFT* = 36'u64
    BGFX_STATE_CULL_MASK* = 0x0000003000000000'u64 #!< Culling mode bit mask.

const
    BGFX_STATE_ALPHA_REF_SHIFT* = 40'u64
    BGFX_STATE_ALPHA_REF_MASK* = 0x0000FF0000000000'u64 #!< Alpha reference bit mask.
    BGFX_STATE_PT_TRISTRIP* = 0x0001000000000000'u64 #!< Tristrip.
    BGFX_STATE_PT_LINES* = 0x0002000000000000'u64 #!< Lines.
    BGFX_STATE_PT_LINESTRIP* = 0x0003000000000000'u64 #!< Line strip.
    BGFX_STATE_PT_POINTS* = 0x0004000000000000'u64 #!< Points.
    BGFX_STATE_PT_SHIFT* = 48'u64
    BGFX_STATE_PT_MASK* = 0x0007000000000000'u64 #!< Primitive type bit mask.
    BGFX_STATE_POINT_SIZE_SHIFT* = 52'u64
    BGFX_STATE_POINT_SIZE_MASK* = 0x00F0000000000000'u64 #!< Point size bit mask.

const
    BGFX_STATE_MSAA* = 0x0100000000000000'u64 #!< Enable MSAA rasterization.
    BGFX_STATE_LINEAA* = 0x0200000000000000'u64 #!< Enable line AA rasterization.
    BGFX_STATE_CONSERVATIVE_RASTER* = 0x0400000000000000'u64 #!< Enable conservative rasterization.

const
    BGFX_STATE_RESERVED_SHIFT* = 61'u64
    BGFX_STATE_RESERVED_MASK* = 0xE000000000000000'u64 #!< Internal bits mask.

const
    BGFX_STATE_NONE* = 0x0000000000000000'u64 #!< No state.
    BGFX_STATE_MASK* = 0xFFFFFFFFFFFFFFFF'u64 #!< State mask.

const BGFX_STATE_DEFAULT* = (0'u64 or BGFX_STATE_RGB_WRITE or BGFX_STATE_ALPHA_WRITE or BGFX_STATE_DEPTH_TEST_LESS or BGFX_STATE_DEPTH_WRITE or BGFX_STATE_CULL_CW or BGFX_STATE_MSAA)

template BGFX_STATE_ALPHA_REF*(refer: expr): expr = (((refer) shl BGFX_STATE_ALPHA_REF_SHIFT) and BGFX_STATE_ALPHA_REF_MASK)

template BGFX_STATE_POINT_SIZE*(size: expr): expr = (((size) shl BGFX_STATE_POINT_SIZE_SHIFT) and BGFX_STATE_POINT_SIZE_MASK)

template BGFX_STATE_BLEND_FUNC_SEPARATE*(srcRGB, dstRGB, srcA, dstA: expr): expr = (0'u64) or (((srcRGB) or ((dstRGB) shl 4)) or (((srcA) or ((dstA) shl 4)) shl 8))

template BGFX_STATE_BLEND_EQUATION_SEPARATE*(rgb, a: expr): expr = ((rgb) or ((a) shl 3))

template BGFX_STATE_BLEND_FUNC*(src, dst: expr): expr = BGFX_STATE_BLEND_FUNC_SEPARATE(src, dst, src, dst)

template BGFX_STATE_BLEND_EQUATION*(equation: expr): expr = BGFX_STATE_BLEND_EQUATION_SEPARATE(equation, equation)

const
    BGFX_STATE_BLEND_ADD* = (BGFX_STATE_BLEND_FUNC(BGFX_STATE_BLEND_ONE, BGFX_STATE_BLEND_ONE))
    BGFX_STATE_BLEND_ALPHA* = (BGFX_STATE_BLEND_FUNC(BGFX_STATE_BLEND_SRC_ALPHA, BGFX_STATE_BLEND_INV_SRC_ALPHA))
    BGFX_STATE_BLEND_DARKEN* = (BGFX_STATE_BLEND_FUNC(BGFX_STATE_BLEND_ONE, BGFX_STATE_BLEND_ONE) or BGFX_STATE_BLEND_EQUATION(BGFX_STATE_BLEND_EQUATION_MIN))
    BGFX_STATE_BLEND_LIGHTEN* = (BGFX_STATE_BLEND_FUNC(BGFX_STATE_BLEND_ONE, BGFX_STATE_BLEND_ONE) or BGFX_STATE_BLEND_EQUATION(BGFX_STATE_BLEND_EQUATION_MAX))
    BGFX_STATE_BLEND_MULTIPLY* = (BGFX_STATE_BLEND_FUNC(BGFX_STATE_BLEND_DST_COLOR, BGFX_STATE_BLEND_ZERO))
    BGFX_STATE_BLEND_NORMAL* = (BGFX_STATE_BLEND_FUNC(BGFX_STATE_BLEND_ONE, BGFX_STATE_BLEND_INV_SRC_ALPHA))
    BGFX_STATE_BLEND_SCREEN* = (BGFX_STATE_BLEND_FUNC(BGFX_STATE_BLEND_ONE, BGFX_STATE_BLEND_INV_SRC_COLOR))
    BGFX_STATE_BLEND_LINEAR_BURN* = (BGFX_STATE_BLEND_FUNC(BGFX_STATE_BLEND_DST_COLOR, BGFX_STATE_BLEND_INV_DST_COLOR) or BGFX_STATE_BLEND_EQUATION(BGFX_STATE_BLEND_EQUATION_SUB))

template BGFX_STATE_BLEND_FUNC_RT_x*(src, dst: expr): expr = (0'u64 or (uint32((src) shr BGFX_STATE_BLEND_SHIFT) or (uint32((dst) shr BGFX_STATE_BLEND_SHIFT) shl 4)))

template BGFX_STATE_BLEND_FUNC_RT_xE*(src, dst, equation: expr): expr = (0'u64 or BGFX_STATE_BLEND_FUNC_RT_x(src, dst) or (uint32((equation) shr BGFX_STATE_BLEND_EQUATION_SHIFT) shl 8))

template BGFX_STATE_BLEND_FUNC_RT_1*(src, dst: expr): expr = (BGFX_STATE_BLEND_FUNC_RT_x(src, dst) shl 0)

template BGFX_STATE_BLEND_FUNC_RT_2*(src, dst: expr): expr = (BGFX_STATE_BLEND_FUNC_RT_x(src, dst) shl 11)

template BGFX_STATE_BLEND_FUNC_RT_3*(src, dst: expr): expr = (BGFX_STATE_BLEND_FUNC_RT_x(src, dst) shl 22)

template BGFX_STATE_BLEND_FUNC_RT_1E*(src, dst, equation: expr): expr = (BGFX_STATE_BLEND_FUNC_RT_xE(src, dst, equation) shl 0)

template BGFX_STATE_BLEND_FUNC_RT_2E*(src, dst, equation: expr): expr = (BGFX_STATE_BLEND_FUNC_RT_xE(src, dst, equation) shl 11)

template BGFX_STATE_BLEND_FUNC_RT_3E*(src, dst, equation: expr): expr = (BGFX_STATE_BLEND_FUNC_RT_xE(src, dst, equation) shl 22)

const
    BGFX_STENCIL_FUNC_REF_SHIFT* = 0'u32
    BGFX_STENCIL_FUNC_REF_MASK* = 0x000000FF'u32 #!<
    BGFX_STENCIL_FUNC_RMASK_SHIFT* = 8'u32
    BGFX_STENCIL_FUNC_RMASK_MASK* = 0x0000FF00'u32 #!<
    BGFX_STENCIL_TEST_LESS* = 0x00010000'u32 #!< Enable stencil test, less.
    BGFX_STENCIL_TEST_LEQUAL* = 0x00020000'u32 #!<
    BGFX_STENCIL_TEST_EQUAL* = 0x00030000'u32 #!<
    BGFX_STENCIL_TEST_GEQUAL* = 0x00040000'u32 #!<
    BGFX_STENCIL_TEST_GREATER* = 0x00050000'u32 #!<
    BGFX_STENCIL_TEST_NOTEQUAL* = 0x00060000'u32 #!<
    BGFX_STENCIL_TEST_NEVER* = 0x00070000'u32 #!<
    BGFX_STENCIL_TEST_ALWAYS* = 0x00080000'u32 #!<
    BGFX_STENCIL_TEST_SHIFT* = 16'u32
    BGFX_STENCIL_TEST_MASK* = 0x000F0000'u32 #!< Stencil test bit mask.
    BGFX_STENCIL_OP_FAIL_S_ZERO* = 0x00000000'u32 #!< Zero.
    BGFX_STENCIL_OP_FAIL_S_KEEP* = 0x00100000'u32 #!< Keep.
    BGFX_STENCIL_OP_FAIL_S_REPLACE* = 0x00200000'u32 #!< Replace.
    BGFX_STENCIL_OP_FAIL_S_INCR* = 0x00300000'u32 #!< Increment and wrap.
    BGFX_STENCIL_OP_FAIL_S_INCRSAT* = 0x00400000'u32 #!< Increment and clamp.
    BGFX_STENCIL_OP_FAIL_S_DECR* = 0x00500000'u32 #!< Decrement and wrap.
    BGFX_STENCIL_OP_FAIL_S_DECRSAT* = 0x00600000'u32 #!< Decrement and clamp.
    BGFX_STENCIL_OP_FAIL_S_INVERT* = 0x00700000'u32 #!< Invert.
    BGFX_STENCIL_OP_FAIL_S_SHIFT* = 20'u32
    BGFX_STENCIL_OP_FAIL_S_MASK* = 0x00F00000'u32 #!< Stencil operation fail bit mask.
    BGFX_STENCIL_OP_FAIL_Z_ZERO* = 0x00000000'u32 #!<
    BGFX_STENCIL_OP_FAIL_Z_KEEP* = 0x01000000'u32 #!<
    BGFX_STENCIL_OP_FAIL_Z_REPLACE* = 0x02000000'u32 #!<
    BGFX_STENCIL_OP_FAIL_Z_INCR* = 0x03000000'u32 #!<
    BGFX_STENCIL_OP_FAIL_Z_INCRSAT* = 0x04000000'u32 #!<
    BGFX_STENCIL_OP_FAIL_Z_DECR* = 0x05000000'u32 #!<
    BGFX_STENCIL_OP_FAIL_Z_DECRSAT* = 0x06000000'u32 #!<
    BGFX_STENCIL_OP_FAIL_Z_INVERT* = 0x07000000'u32 #!<
    BGFX_STENCIL_OP_FAIL_Z_SHIFT* = 24'u32
    BGFX_STENCIL_OP_FAIL_Z_MASK* = 0x0F000000'u32 #!< Stencil operation fail depth bit mask.
    BGFX_STENCIL_OP_PASS_Z_ZERO* = 0x00000000'u32 #!<
    BGFX_STENCIL_OP_PASS_Z_KEEP* = 0x10000000'u32 #!<
    BGFX_STENCIL_OP_PASS_Z_REPLACE* = 0x20000000'u32 #!<
    BGFX_STENCIL_OP_PASS_Z_INCR* = 0x30000000'u32 #!<
    BGFX_STENCIL_OP_PASS_Z_INCRSAT* = 0x40000000'u32 #!<
    BGFX_STENCIL_OP_PASS_Z_DECR* = 0x50000000'u32 #!<
    BGFX_STENCIL_OP_PASS_Z_DECRSAT* = 0x60000000'u32 #!<
    BGFX_STENCIL_OP_PASS_Z_INVERT* = 0x70000000'u32 #!<
    BGFX_STENCIL_OP_PASS_Z_SHIFT* = 28'u32
    BGFX_STENCIL_OP_PASS_Z_MASK* = 0xF0000000'u32 #!< Stencil operation pass depth bit mask.
    BGFX_STENCIL_NONE* = 0x00000000'u32 #!<
    BGFX_STENCIL_MASK* = 0xFFFFFFFF'u32 #!<
    BGFX_STENCIL_DEFAULT* = 0x00000000'u32 #!<

template BGFX_STENCIL_FUNC_REF*(refer: expr): expr = ((uint32(refer) shl BGFX_STENCIL_FUNC_REF_SHIFT) and BGFX_STENCIL_FUNC_REF_MASK)

template BGFX_STENCIL_FUNC_RMASK*(mask: expr): expr = ((uint32(mask) shl BGFX_STENCIL_FUNC_RMASK_SHIFT) and BGFX_STENCIL_FUNC_RMASK_MASK)

const
    BGFX_CLEAR_NONE* = 0x00000000'u16 #!< No clear flags.
    BGFX_CLEAR_COLOR* = 0x00000001'u16 #!< Clear color.
    BGFX_CLEAR_DEPTH* = 0x00000002'u16 #!< Clear depth.
    BGFX_CLEAR_STENCIL* = 0x00000004'u16 #!< Clear stencil.
    BGFX_CLEAR_DISCARD_COLOR_0* = 0x00000008'u16 #!< Discard frame buffer attachment 0.
    BGFX_CLEAR_DISCARD_COLOR_1* = 0x00000010'u16 #!< Discard frame buffer attachment 1.
    BGFX_CLEAR_DISCARD_COLOR_2* = 0x00000020'u16 #!< Discard frame buffer attachment 2.
    BGFX_CLEAR_DISCARD_COLOR_3* = 0x00000040'u16 #!< Discard frame buffer attachment 3.
    BGFX_CLEAR_DISCARD_COLOR_4* = 0x00000080'u16 #!< Discard frame buffer attachment 4.
    BGFX_CLEAR_DISCARD_COLOR_5* = 0x00000100'u16 #!< Discard frame buffer attachment 5.
    BGFX_CLEAR_DISCARD_COLOR_6* = 0x00000200'u16 #!< Discard frame buffer attachment 6.
    BGFX_CLEAR_DISCARD_COLOR_7* = 0x00000400'u16 #!< Discard frame buffer attachment 7.
    BGFX_CLEAR_DISCARD_DEPTH* = 0x00000800'u16 #!< Discard frame buffer depth attachment.
    BGFX_CLEAR_DISCARD_STENCIL* = 0x00001000'u16 #!< Discard frame buffer stencil attachment.
    BGFX_CLEAR_DISCARD_COLOR_MASK* = (0'u16 or BGFX_CLEAR_DISCARD_COLOR_0 or BGFX_CLEAR_DISCARD_COLOR_1 or BGFX_CLEAR_DISCARD_COLOR_2 or BGFX_CLEAR_DISCARD_COLOR_3 or BGFX_CLEAR_DISCARD_COLOR_4 or BGFX_CLEAR_DISCARD_COLOR_5 or BGFX_CLEAR_DISCARD_COLOR_6 or BGFX_CLEAR_DISCARD_COLOR_7)
    BGFX_CLEAR_DISCARD_MASK* = (0'u16 or BGFX_CLEAR_DISCARD_COLOR_MASK or BGFX_CLEAR_DISCARD_DEPTH or BGFX_CLEAR_DISCARD_STENCIL)
    BGFX_DEBUG_NONE* = 0x00000000'u16 #!< No debug.
    BGFX_DEBUG_WIREFRAME* = 0x00000001'u16 #!< Enable wireframe for all primitives.
    BGFX_DEBUG_IFH* = 0x00000002'u16 #!< Enable infinitely fast hardware test. No draw calls will be submitted to driver. It’s useful when profiling to quickly assess bottleneck between CPU and GPU.
    BGFX_DEBUG_STATS* = 0x00000004'u16 #!< Enable statistics display.
    BGFX_DEBUG_TEXT* = 0x00000008'u16 #!< Enable debug text display.

const
    BGFX_BUFFER_NONE* = 0x00000000'u32 #!<
    BGFX_BUFFER_COMPUTE_FORMAT_8x1* = 0x00000001'u32 #!<
    BGFX_BUFFER_COMPUTE_FORMAT_8x2* = 0x00000002'u32 #!<
    BGFX_BUFFER_COMPUTE_FORMAT_8x4* = 0x00000003'u32 #!<
    BGFX_BUFFER_COMPUTE_FORMAT_16x1* = 0x00000004'u32 #!<
    BGFX_BUFFER_COMPUTE_FORMAT_16x2* = 0x00000005'u32 #!<
    BGFX_BUFFER_COMPUTE_FORMAT_16x4* = 0x00000006'u32 #!<
    BGFX_BUFFER_COMPUTE_FORMAT_32x1* = 0x00000007'u32 #!<
    BGFX_BUFFER_COMPUTE_FORMAT_32x2* = 0x00000008'u32 #!<
    BGFX_BUFFER_COMPUTE_FORMAT_32x4* = 0x00000009'u32 #!<
    BGFX_BUFFER_COMPUTE_FORMAT_SHIFT* = 0'u32
    BGFX_BUFFER_COMPUTE_FORMAT_MASK* = 0x0000000F'u32 #!<
    BGFX_BUFFER_COMPUTE_TYPE_UINT* = 0x00000010'u32 #!<
    BGFX_BUFFER_COMPUTE_TYPE_INT* = 0x00000020'u32 #!<
    BGFX_BUFFER_COMPUTE_TYPE_FLOAT* = 0x00000030'u32 #!<
    BGFX_BUFFER_COMPUTE_TYPE_SHIFT* = 4'u32
    BGFX_BUFFER_COMPUTE_TYPE_MASK* = 0x00000030'u32 #!<
    BGFX_BUFFER_COMPUTE_READ* = 0x00000100'u32 #!< Buffer will be read by shader.
    BGFX_BUFFER_COMPUTE_WRITE* = 0x00000200'u32 #!< Buffer will be used for writing.
    BGFX_BUFFER_DRAW_INDIRECT* = 0x00000400'u32 #!< Buffer will be used for storing draw indirect commands.
    BGFX_BUFFER_ALLOW_RESIZE* = 0x00000800'u32 #!<
    BGFX_BUFFER_INDEX32* = 0x00001000'u32 #!<
    BGFX_BUFFER_COMPUTE_READ_WRITE* = (0'u32 or BGFX_BUFFER_COMPUTE_READ or BGFX_BUFFER_COMPUTE_WRITE)

const
    BGFX_TEXTURE_NONE* = 0x00000000'u32 #!<
    BGFX_TEXTURE_U_MIRROR* = 0x00000001'u32 #!<
    BGFX_TEXTURE_U_CLAMP* = 0x00000002'u32 #!<
    BGFX_TEXTURE_U_BORDER* = 0x00000003'u32 #!<
    BGFX_TEXTURE_U_SHIFT* = 0'u32
    BGFX_TEXTURE_U_MASK* = 0x00000003'u32 #!<
    BGFX_TEXTURE_V_MIRROR* = 0x00000004'u32 #!<
    BGFX_TEXTURE_V_CLAMP* = 0x00000008'u32 #!<
    BGFX_TEXTURE_V_BORDER* = 0x0000000C'u32 #!<
    BGFX_TEXTURE_V_SHIFT* = 2'u32
    BGFX_TEXTURE_V_MASK* = 0x0000000C'u32 #!<
    BGFX_TEXTURE_W_MIRROR* = 0x00000010'u32 #!<
    BGFX_TEXTURE_W_CLAMP* = 0x00000020'u32 #!<
    BGFX_TEXTURE_W_BORDER* = 0x00000030'u32 #!<
    BGFX_TEXTURE_W_SHIFT* = 4'u32
    BGFX_TEXTURE_W_MASK* = 0x00000030'u32 #!<
    BGFX_TEXTURE_MIN_POINT* = 0x00000040'u32 #!<
    BGFX_TEXTURE_MIN_ANISOTROPIC* = 0x00000080'u32 #!<
    BGFX_TEXTURE_MIN_SHIFT* = 6'u32
    BGFX_TEXTURE_MIN_MASK* = 0x000000C0'u32 #!<
    BGFX_TEXTURE_MAG_POINT* = 0x00000100'u32 #!<
    BGFX_TEXTURE_MAG_ANISOTROPIC* = 0x00000200'u32 #!<
    BGFX_TEXTURE_MAG_SHIFT* = 8'u32
    BGFX_TEXTURE_MAG_MASK* = 0x00000300'u32 #!<
    BGFX_TEXTURE_MIP_POINT* = 0x00000400'u32 #!<
    BGFX_TEXTURE_MIP_SHIFT* = 10'u32
    BGFX_TEXTURE_MIP_MASK* = 0x00000400'u32 #!<
    BGFX_TEXTURE_MSAA_SAMPLE* = 0x00000800'u32 #!<
    BGFX_TEXTURE_RT* = 0x00001000'u32 #!<
    BGFX_TEXTURE_RT_MSAA_X2* = 0x00002000'u32 #!<
    BGFX_TEXTURE_RT_MSAA_X4* = 0x00003000'u32 #!<
    BGFX_TEXTURE_RT_MSAA_X8* = 0x00004000'u32 #!<
    BGFX_TEXTURE_RT_MSAA_X16* = 0x00005000'u32 #!<
    BGFX_TEXTURE_RT_MSAA_SHIFT* = 12'u32
    BGFX_TEXTURE_RT_MSAA_MASK* = 0x00007000'u32 #!<
    BGFX_TEXTURE_RT_WRITE_ONLY* = 0x00008000'u32 #!<
    BGFX_TEXTURE_RT_MASK* = 0x0000F000'u32 #!<
    BGFX_TEXTURE_COMPARE_LESS* = 0x00010000'u32 #!<
    BGFX_TEXTURE_COMPARE_LEQUAL* = 0x00020000'u32 #!<
    BGFX_TEXTURE_COMPARE_EQUAL* = 0x00030000'u32 #!<
    BGFX_TEXTURE_COMPARE_GEQUAL* = 0x00040000'u32 #!<
    BGFX_TEXTURE_COMPARE_GREATER* = 0x00050000'u32 #!<
    BGFX_TEXTURE_COMPARE_NOTEQUAL* = 0x00060000'u32 #!<
    BGFX_TEXTURE_COMPARE_NEVER* = 0x00070000'u32 #!<
    BGFX_TEXTURE_COMPARE_ALWAYS* = 0x00080000'u32 #!<
    BGFX_TEXTURE_COMPARE_SHIFT* = 16'u32
    BGFX_TEXTURE_COMPARE_MASK* = 0x000F0000'u32 #!<
    BGFX_TEXTURE_COMPUTE_WRITE* = 0x00100000'u32 #!<
    BGFX_TEXTURE_SRGB* = 0x00200000'u32 #!<
    BGFX_TEXTURE_BLIT_DST* = 0x00400000'u32 #!<
    BGFX_TEXTURE_READ_BACK* = 0x00800000'u32 #!<
    BGFX_TEXTURE_BORDER_COLOR_SHIFT* = 24'u32
    BGFX_TEXTURE_BORDER_COLOR_MASK* = 0x0F000000'u32 #!<
    BGFX_TEXTURE_RESERVED_SHIFT* = 28'u32
    BGFX_TEXTURE_RESERVED_MASK* = 0xF0000000'u32 #!<

template BGFX_TEXTURE_BORDER_COLOR*(index: expr): expr = ((index shl BGFX_TEXTURE_BORDER_COLOR_SHIFT) and BGFX_TEXTURE_BORDER_COLOR_MASK)

const BGFX_TEXTURE_SAMPLER_BITS_MASK* = (0'u32 or BGFX_TEXTURE_U_MASK or BGFX_TEXTURE_V_MASK or BGFX_TEXTURE_W_MASK or BGFX_TEXTURE_MIN_MASK or BGFX_TEXTURE_MAG_MASK or BGFX_TEXTURE_MIP_MASK or BGFX_TEXTURE_COMPARE_MASK)

const
    BGFX_RESET_NONE* = 0x00000000'u32 #!< No reset flags.
    BGFX_RESET_FULLSCREEN* = 0x00000001'u32 #!< Not supported yet.
    BGFX_RESET_FULLSCREEN_SHIFT* = 0'u32
    BGFX_RESET_FULLSCREEN_MASK* = 0x00000001'u32 #!< Fullscreen bit mask.
    BGFX_RESET_MSAA_X2* = 0x00000010'u32 #!< Enable 2x MSAA.
    BGFX_RESET_MSAA_X4* = 0x00000020'u32 #!< Enable 4x MSAA.
    BGFX_RESET_MSAA_X8* = 0x00000030'u32 #!< Enable 8x MSAA.
    BGFX_RESET_MSAA_X16* = 0x00000040'u32 #!< Enable 16x MSAA.
    BGFX_RESET_MSAA_SHIFT* = 4'u32
    BGFX_RESET_MSAA_MASK* = 0x00000070'u32 #!< MSAA mode bit mask.
    BGFX_RESET_VSYNC* = 0x00000080'u32 #!< Enable V-Sync.
    BGFX_RESET_MAXANISOTROPY* = 0x00000100'u32 #!< Turn on/off max anisotropy.
    BGFX_RESET_CAPTURE* = 0x00000200'u32 #!< Begin screen capture.
    BGFX_RESET_HMD* = 0x00000400'u32 #!< HMD stereo rendering.
    BGFX_RESET_HMD_DEBUG* = 0x00000800'u32 #!< HMD stereo rendering debug mode.
    BGFX_RESET_HMD_RECENTER* = 0x00001000'u32 #!< HMD calibration.
    BGFX_RESET_FLUSH_AFTER_RENDER* = 0x00002000'u32 #!< Flush rendering after submitting to GPU.
    BGFX_RESET_FLIP_AFTER_RENDER* = 0x00004000'u32 #!< This flag  specifies where flip occurs. Default behavior is that flip occurs before rendering new frame. This flag only has effect when `BGFX_CONFIG_MULTITHREADED=0`.
    BGFX_RESET_SRGB_BACKBUFFER* = 0x00008000'u32 #!< Enable sRGB backbuffer.
    BGFX_RESET_HIDPI* = 0x00010000'u32 #!< Enable HiDPI rendering.
    BGFX_RESET_DEPTH_CLAMP* = 0x00020000'u32 #!< Enable depth clamp.
    BGFX_RESET_SUSPEND* = 0x00040000'u32 #!< Suspend rendering.
    BGFX_RESET_RESERVED_SHIFT* = 31'u32
    BGFX_RESET_RESERVED_MASK* = 0x80000000'u32 #!< Internal bits mask.

const
    BGFX_CAPS_TEXTURE_COMPARE_LEQUAL* = 0x0000000000000001'u64 #!< Texture compare less equal mode is supported.
    BGFX_CAPS_TEXTURE_COMPARE_ALL* = 0x0000000000000003'u64 #!< All texture compare modes are supported.
    BGFX_CAPS_TEXTURE_3D* = 0x0000000000000004'u64 #!< 3D textures are supported.
    BGFX_CAPS_VERTEX_ATTRIB_HALF* = 0x0000000000000008'u64 #!< Vertex attribute half-float is supported.
    BGFX_CAPS_VERTEX_ATTRIB_UINT10* = 0x0000000000000010'u64 #!< Vertex attribute 10_10_10_2 is supported.
    BGFX_CAPS_INSTANCING* = 0x0000000000000020'u64 #!< Instancing is supported.
    BGFX_CAPS_RENDERER_MULTITHREADED* = 0x0000000000000040'u64 #!< Renderer is on separate thread.
    BGFX_CAPS_FRAGMENT_DEPTH* = 0x0000000000000080'u64 #!< Fragment depth is accessible in fragment shader.
    BGFX_CAPS_BLEND_INDEPENDENT* = 0x0000000000000100'u64 #!< Blend independent is supported.
    BGFX_CAPS_COMPUTE* = 0x0000000000000200'u64 #!< Compute shaders are supported.
    BGFX_CAPS_FRAGMENT_ORDERING* = 0x0000000000000400'u64 #!< Fragment ordering is available in fragment shader.
    BGFX_CAPS_SWAP_CHAIN* = 0x0000000000000800'u64 #!< Multiple windows are supported.
    BGFX_CAPS_HMD* = 0x0000000000001000'u64 #!< Head Mounted Display is available.
    BGFX_CAPS_INDEX32* = 0x0000000000002000'u64 #!< 32-bit indices are supported.
    BGFX_CAPS_DRAW_INDIRECT* = 0x0000000000004000'u64 #!< Draw indirect is supported.
    BGFX_CAPS_HIDPI* = 0x0000000000008000'u64 #!< HiDPI rendering is supported.
    BGFX_CAPS_TEXTURE_BLIT* = 0x0000000000010000'u64 #!< Texture blit is supported.
    BGFX_CAPS_TEXTURE_READ_BACK* = 0x0000000000020000'u64 #!< Read-back texture is supported.
    BGFX_CAPS_OCCLUSION_QUERY* = 0x0000000000040000'u64 #!< Occlusion query is supported.
    BGFX_CAPS_ALPHA_TO_COVERAGE* = 0x0000000000080000'u64 #!< Alpha to coverage is supported.
    BGFX_CAPS_CONSERVATIVE_RASTER* = 0x0000000000100000'u64 #!< Conservative rasterization is supported.

const
    BGFX_CAPS_FORMAT_TEXTURE_NONE* = 0x00000000'u32 #!< Texture format is not supported.
    BGFX_CAPS_FORMAT_TEXTURE_2D* = 0x00000001'u32 #!< Texture format is supported.
    BGFX_CAPS_FORMAT_TEXTURE_2D_SRGB* = 0x00000002'u32 #!< Texture as sRGB format is supported.
    BGFX_CAPS_FORMAT_TEXTURE_2D_EMULATED* = 0x00000004'u32 #!< Texture format is emulated.
    BGFX_CAPS_FORMAT_TEXTURE_3D* = 0x00000008'u32 #!< Texture format is supported.
    BGFX_CAPS_FORMAT_TEXTURE_3D_SRGB* = 0x00000010'u32 #!< Texture as sRGB format is supported.
    BGFX_CAPS_FORMAT_TEXTURE_3D_EMULATED* = 0x00000020'u32 #!< Texture format is emulated.
    BGFX_CAPS_FORMAT_TEXTURE_CUBE* = 0x00000040'u32 #!< Texture format is supported.
    BGFX_CAPS_FORMAT_TEXTURE_CUBE_SRGB* = 0x00000080'u32 #!< Texture as sRGB format is supported.
    BGFX_CAPS_FORMAT_TEXTURE_CUBE_EMULATED* = 0x00000100'u32 #!< Texture format is emulated.
    BGFX_CAPS_FORMAT_TEXTURE_VERTEX* = 0x00000200'u32 #!< Texture format can be used from vertex shader.
    BGFX_CAPS_FORMAT_TEXTURE_IMAGE* = 0x00000400'u32 #!< Texture format can be used as image from compute shader.
    BGFX_CAPS_FORMAT_TEXTURE_FRAMEBUFFER* = 0x00000800'u32 #!< Texture format can be used as frame buffer.
    BGFX_CAPS_FORMAT_TEXTURE_FRAMEBUFFER_MSAA* = 0x00001000'u32 #!< Texture format can be used as MSAA frame buffer.
    BGFX_CAPS_FORMAT_TEXTURE_MSAA* = 0x00002000'u32 #!< Texture can be sampled as MSAA.
    BGFX_CAPS_FORMAT_TEXTURE_MIP_AUTOGEN* = 0x00004000'u32 #!< Texture format supports auto-generated mips.

const
    BGFX_VIEW_NONE* = 0x00000000'u32 #!<
    BGFX_VIEW_STEREO* = 0x00000001'u32 #!< View will be rendered in stereo mode.

const
    BGFX_SUBMIT_EYE_LEFT* = 0x00000001'u32 #!< Submit to left eye.
    BGFX_SUBMIT_EYE_RIGHT* = 0x00000002'u32 #!< Submit to right eye.
    BGFX_SUBMIT_EYE_MASK* = 0x00000003'u32 #!<
    BGFX_SUBMIT_EYE_FIRST* = BGFX_SUBMIT_EYE_LEFT
    BGFX_SUBMIT_RESERVED_SHIFT* = 7'u32
    BGFX_SUBMIT_RESERVED_MASK* = 0x00000080'u32 #!< Internal bits mask.

const
    BGFX_PCI_ID_NONE* = 0x00000000'u16 #!< Autoselect adapter.
    BGFX_PCI_ID_SOFTWARE_RASTERIZER* = 0x00000001'u16 #!< Software rasterizer.
    BGFX_PCI_ID_AMD* = 0x00001002'u16 #!< AMD adapter.
    BGFX_PCI_ID_INTEL* = 0x00008086'u16 #!< Intel adapter.
    BGFX_PCI_ID_NVIDIA* = 0x000010DE'u16 #!< nVidia adapter.

const
    BGFX_HMD_NONE* = 0x00000000'u32 #!< None.
    BGFX_HMD_DEVICE_RESOLUTION* = 0x00000001'u32 #!< Has HMD native resolution.
    BGFX_HMD_RENDERING* = 0x00000002'u32 #!< Rendering to HMD.

const
    BGFX_CUBE_MAP_POSITIVE_X* = 0x00000000'u32 #!< Cubemap +x.
    BGFX_CUBE_MAP_NEGATIVE_X* = 0x00000001'u32 #!< Cubemap -x.
    BGFX_CUBE_MAP_POSITIVE_Y* = 0x00000002'u32 #!< Cubemap +y.
    BGFX_CUBE_MAP_NEGATIVE_Y* = 0x00000003'u32 #!< Cubemap -y.
    BGFX_CUBE_MAP_POSITIVE_Z* = 0x00000004'u32 #!< Cubemap +z.
    BGFX_CUBE_MAP_NEGATIVE_Z* = 0x00000005'u32 #!< Cubemap -z.

type
    bgfx_render_frame_t* = enum
        BGFX_RENDER_FRAME_NO_CONTEXT, BGFX_RENDER_FRAME_RENDER,
        BGFX_RENDER_FRAME_EXITING, BGFX_RENDER_FRAME_COUNT

    bgfx_platform_data_t* = object
        ndt*: pointer
        nwh*: pointer
        context*: pointer
        backBuffer*: pointer
        backBufferDS*: pointer

    bgfx_renderer_type_t* = enum
        BGFX_RENDERER_TYPE_NULL, BGFX_RENDERER_TYPE_DIRECT3D9,
        BGFX_RENDERER_TYPE_DIRECT3D11, BGFX_RENDERER_TYPE_DIRECT3D12,
        BGFX_RENDERER_TYPE_METAL, BGFX_RENDERER_TYPE_OPENGLES,
        BGFX_RENDERER_TYPE_OPENGL, BGFX_RENDERER_TYPE_VULKAN, BGFX_RENDERER_TYPE_COUNT

    bgfx_access_t* = enum
        BGFX_ACCESS_READ, BGFX_ACCESS_WRITE, BGFX_ACCESS_READWRITE, BGFX_ACCESS_COUNT

    bgfx_attrib_t* = enum
        BGFX_ATTRIB_POSITION, BGFX_ATTRIB_NORMAL, BGFX_ATTRIB_TANGENT,
        BGFX_ATTRIB_BITANGENT, BGFX_ATTRIB_COLOR0, BGFX_ATTRIB_COLOR1,
        BGFX_ATTRIB_INDICES, BGFX_ATTRIB_WEIGHT, BGFX_ATTRIB_TEXCOORD0,
        BGFX_ATTRIB_TEXCOORD1, BGFX_ATTRIB_TEXCOORD2, BGFX_ATTRIB_TEXCOORD3,
        BGFX_ATTRIB_TEXCOORD4, BGFX_ATTRIB_TEXCOORD5, BGFX_ATTRIB_TEXCOORD6,
        BGFX_ATTRIB_TEXCOORD7, BGFX_ATTRIB_COUNT

    bgfx_attrib_type_t* = enum
        BGFX_ATTRIB_TYPE_UINT8, BGFX_ATTRIB_TYPE_UINT10, BGFX_ATTRIB_TYPE_INT16,
        BGFX_ATTRIB_TYPE_HALF, BGFX_ATTRIB_TYPE_FLOAT, BGFX_ATTRIB_TYPE_COUNT

    bgfx_texture_format_t* = enum
        BGFX_TEXTURE_FORMAT_BC1, BGFX_TEXTURE_FORMAT_BC2, BGFX_TEXTURE_FORMAT_BC3,
        BGFX_TEXTURE_FORMAT_BC4, BGFX_TEXTURE_FORMAT_BC5, BGFX_TEXTURE_FORMAT_BC6H,
        BGFX_TEXTURE_FORMAT_BC7, BGFX_TEXTURE_FORMAT_ETC1, BGFX_TEXTURE_FORMAT_ETC2,
        BGFX_TEXTURE_FORMAT_ETC2A, BGFX_TEXTURE_FORMAT_ETC2A1,
        BGFX_TEXTURE_FORMAT_PTC12, BGFX_TEXTURE_FORMAT_PTC14,
        BGFX_TEXTURE_FORMAT_PTC12A, BGFX_TEXTURE_FORMAT_PTC14A,
        BGFX_TEXTURE_FORMAT_PTC22, BGFX_TEXTURE_FORMAT_PTC24,
        BGFX_TEXTURE_FORMAT_UNKNOWN, BGFX_TEXTURE_FORMAT_R1, BGFX_TEXTURE_FORMAT_A8,
        BGFX_TEXTURE_FORMAT_R8, BGFX_TEXTURE_FORMAT_R8I, BGFX_TEXTURE_FORMAT_R8U,
        BGFX_TEXTURE_FORMAT_R8S, BGFX_TEXTURE_FORMAT_R16, BGFX_TEXTURE_FORMAT_R16I,
        BGFX_TEXTURE_FORMAT_R16U, BGFX_TEXTURE_FORMAT_R16F, BGFX_TEXTURE_FORMAT_R16S,
        BGFX_TEXTURE_FORMAT_R32I, BGFX_TEXTURE_FORMAT_R32U, BGFX_TEXTURE_FORMAT_R32F,
        BGFX_TEXTURE_FORMAT_RG8, BGFX_TEXTURE_FORMAT_RG8I, BGFX_TEXTURE_FORMAT_RG8U,
        BGFX_TEXTURE_FORMAT_RG8S, BGFX_TEXTURE_FORMAT_RG16, BGFX_TEXTURE_FORMAT_RG16I,
        BGFX_TEXTURE_FORMAT_RG16U, BGFX_TEXTURE_FORMAT_RG16F,
        BGFX_TEXTURE_FORMAT_RG16S, BGFX_TEXTURE_FORMAT_RG32I,
        BGFX_TEXTURE_FORMAT_RG32U, BGFX_TEXTURE_FORMAT_RG32F,
        BGFX_TEXTURE_FORMAT_RGB8, BGFX_TEXTURE_FORMAT_RGB8I,
        BGFX_TEXTURE_FORMAT_RGB8U, BGFX_TEXTURE_FORMAT_RGB8S,
        BGFX_TEXTURE_FORMAT_RGB9E5F, BGFX_TEXTURE_FORMAT_BGRA8,
        BGFX_TEXTURE_FORMAT_RGBA8, BGFX_TEXTURE_FORMAT_RGBA8I,
        BGFX_TEXTURE_FORMAT_RGBA8U, BGFX_TEXTURE_FORMAT_RGBA8S,
        BGFX_TEXTURE_FORMAT_RGBA16, BGFX_TEXTURE_FORMAT_RGBA16I,
        BGFX_TEXTURE_FORMAT_RGBA16U, BGFX_TEXTURE_FORMAT_RGBA16F,
        BGFX_TEXTURE_FORMAT_RGBA16S, BGFX_TEXTURE_FORMAT_RGBA32I,
        BGFX_TEXTURE_FORMAT_RGBA32U, BGFX_TEXTURE_FORMAT_RGBA32F,
        BGFX_TEXTURE_FORMAT_R5G6B5, BGFX_TEXTURE_FORMAT_RGBA4,
        BGFX_TEXTURE_FORMAT_RGB5A1, BGFX_TEXTURE_FORMAT_RGB10A2,
        BGFX_TEXTURE_FORMAT_R11G11B10F, BGFX_TEXTURE_FORMAT_UNKNOWN_DEPTH,
        BGFX_TEXTURE_FORMAT_D16, BGFX_TEXTURE_FORMAT_D24, BGFX_TEXTURE_FORMAT_D24S8,
        BGFX_TEXTURE_FORMAT_D32, BGFX_TEXTURE_FORMAT_D16F, BGFX_TEXTURE_FORMAT_D24F,
        BGFX_TEXTURE_FORMAT_D32F, BGFX_TEXTURE_FORMAT_D0S8, BGFX_TEXTURE_FORMAT_COUNT

    bgfx_uniform_type_t* = enum
        BGFX_UNIFORM_TYPE_INT1, BGFX_UNIFORM_TYPE_END, BGFX_UNIFORM_TYPE_VEC4,
        BGFX_UNIFORM_TYPE_MAT3, BGFX_UNIFORM_TYPE_MAT4, BGFX_UNIFORM_TYPE_COUNT

    bgfx_backbuffer_ratio_t* = enum
        BGFX_BACKBUFFER_RATIO_EQUAL, BGFX_BACKBUFFER_RATIO_HALF,
        BGFX_BACKBUFFER_RATIO_QUARTER, BGFX_BACKBUFFER_RATIO_EIGHTH,
        BGFX_BACKBUFFER_RATIO_SIXTEENTH, BGFX_BACKBUFFER_RATIO_DOUBLE,
        BGFX_BACKBUFFER_RATIO_COUNT

    bgfx_occlusion_query_result_t* = enum
        BGFX_OCCLUSION_QUERY_RESULT_INVISIBLE, BGFX_OCCLUSION_QUERY_RESULT_VISIBLE,
        BGFX_OCCLUSION_QUERY_RESULT_NORESULT, BGFX_OCCLUSION_QUERY_RESULT_COUNT

    bgfx_topology_convert_t* = enum
        BGFX_TOPOLOGY_CONVERT_TRI_LIST_FLIP_WINDING,
        BGFX_TOPOLOGY_CONVERT_TRI_LIST_TO_LINE_LIST,
        BGFX_TOPOLOGY_CONVERT_TRI_STRIP_TO_TRI_LIST,
        BGFX_TOPOLOGY_CONVERT_LINE_STRIP_TO_LINE_LIST, BGFX_TOPOLOGY_CONVERT_COUNT

    bgfx_dynamic_index_buffer_handle_t* = object
        idx*: uint16

    bgfx_dynamic_vertex_buffer_handle_t* = object
        idx*: uint16

    bgfx_frame_buffer_handle_t* = object
        idx*: uint16

    bgfx_index_buffer_handle_t* = object
        idx*: uint16

    bgfx_indirect_buffer_handle_t* = object
        idx*: uint16

    bgfx_occlusion_query_handle_t* = object
        idx*: uint16

    bgfx_program_handle_t* = object
        idx*: uint16

    bgfx_shader_handle_t* = object
        idx*: uint16

    bgfx_texture_handle_t* = object
        idx*: uint16

    bgfx_uniform_handle_t* = object
        idx*: uint16

    bgfx_vertex_buffer_handle_t* = object
        idx*: uint16

    bgfx_vertex_decl_handle_t* = object
        idx*: uint16

    bgfx_caps_t* = object
        rendererType*: bgfx_renderer_type_t
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
        gpu*: array[4, bgfx_caps_gpu_t]
        formats*: array[BGFX_TEXTURE_FORMAT_COUNT, uint16]

    bgfx_release_fn_t* = proc (pntr: pointer; userData: pointer) {.cdecl.}

    bgfx_memory_t* = object
        data*: ptr uint8
        size*: uint32

    bgfx_transform_t* = object
        data*: ptr cfloat
        num*: uint16

    bgfx_hmd_eye_t* = object
        rotation*: array[4, cfloat]
        translation*: array[3, cfloat]
        fov*: array[4, cfloat]
        viewOffset*: array[3, cfloat]
        projection*: array[16, cfloat]
        pixelsPerTanAngle*: array[2, cfloat]

    bgfx_hmd_t* = object
        eye*: array[2, bgfx_hmd_eye_t]
        width*: uint16
        height*: uint16
        deviceWidth*: uint32
        deviceHeight*: uint32
        flags*: uint8

    bgfx_stats_t* = object
        cpuTimeBegin*: uint64
        cpuTimeEnd*: uint64
        cpuTimerFreq*: uint64
        gpuTimeBegin*: uint64
        gpuTimeEnd*: uint64
        gpuTimerFreq*: uint64
        waitRender*: int64
        waitSubmit*: int64

    bgfx_vertex_decl_t* = object
        hash*: uint32
        stride*: uint16
        offset*: array[BGFX_ATTRIB_COUNT, uint16]
        attributes*: array[BGFX_ATTRIB_COUNT, uint16]

    bgfx_transient_index_buffer_t* = object
        data*: ptr uint8
        size*: uint32
        handle*: bgfx_index_buffer_handle_t
        startIndex*: uint32

    bgfx_transient_vertex_buffer_t* = object
        data*: ptr uint8
        size*: uint32
        startVertex*: uint32
        stride*: uint16
        handle*: bgfx_vertex_buffer_handle_t
        decl*: bgfx_vertex_decl_handle_t

    bgfx_instance_data_buffer_t* = object
        data*: ptr uint8
        size*: uint32
        offset*: uint32
        num*: uint32
        stride*: uint16
        handle*: bgfx_vertex_buffer_handle_t

    bgfx_texture_info_t* = object
        format*: bgfx_texture_format_t
        storageSize*: uint32
        width*: uint16
        height*: uint16
        depth*: uint16
        numMips*: uint8
        bitsPerPixel*: uint8
        cubeMap*: bool

    bgfx_attachment_t* = object
        handle*: bgfx_texture_handle_t
        mip*: uint16
        layer*: uint16

    bgfx_caps_gpu_t* = object
        vendorId*: uint16
        deviceId*: uint16

    bgfx_fatal_t* = enum
        BGFX_FATAL_DEBUG_CHECK, BGFX_FATAL_MINIMUM_REQUIRED_SPECS,
        BGFX_FATAL_INVALID_SHADER, BGFX_FATAL_UNABLE_TO_INITIALIZE,
        BGFX_FATAL_UNABLE_TO_CREATE_TEXTURE, BGFX_FATAL_DEVICE_LOST, BGFX_FATAL_COUNT


    bgfx_callback_vtbl_t* = object
        fatal*: proc (this: ptr bgfx_callback_interface_t; code: bgfx_fatal_t; str: cstring) {.cdecl.}
        trace_vargs*: proc (this: ptr bgfx_callback_interface_t; filePath: cstring; line: uint16; format: cstring) {.cdecl, varargs.}
        cache_read_size*: proc (this: ptr bgfx_callback_interface_t; id: uint64): uint32 {.cdecl.}
        cache_read*: proc (this: ptr bgfx_callback_interface_t; id: uint64; data: pointer; size: uint32): bool {.cdecl.}
        cache_write*: proc (this: ptr bgfx_callback_interface_t; id: uint64; data: pointer; size: uint32) {.cdecl.}
        screen_shot*: proc (this: ptr bgfx_callback_interface_t; filePath: cstring; width: uint32; height: uint32; pitch: uint32; data: pointer; size: uint32; yflip: bool) {.cdecl.}
        capture_begin*: proc (this: ptr bgfx_callback_interface_t; width: uint32; height: uint32; pitch: uint32; format: bgfx_texture_format_t; yflip: bool) {.cdecl.}
        capture_end*: proc (this: ptr bgfx_callback_interface_t) {.cdecl.}
        capture_frame*: proc (this: ptr bgfx_callback_interface_t; data: pointer; size: uint32) {.cdecl.}

    bgfx_allocator_vtbl_t* = object
        realloc*: proc (this: ptr bgfx_allocator_interface_t; pntr: pointer; size: csize; align: csize; file: cstring; line: uint32): pointer {.cdecl.}

    bgfx_allocator_interface_t* = object
        vtbl*: ptr bgfx_allocator_vtbl_t

    bgfx_callback_interface_t* = object
        vtbl*: ptr bgfx_callback_vtbl_t

    bgfx_internal_data_t* = object
        caps*: ptr bgfx_caps_t
        context*: pointer

    bgfx_interface_vtbl_t* = object
        render_frame*: proc (): bgfx_render_frame_t {.cdecl.}
        set_platform_data*: proc (data: ptr bgfx_platform_data_t) {.cdecl.}
        get_internal_data*: proc (): ptr bgfx_internal_data_t {.cdecl.}
        override_internal_texture_ptr*: proc (handle: bgfx_texture_handle_t; pntr: pointer): pointer {.cdecl.}
        override_internal_texture*: proc (handle: bgfx_texture_handle_t; width: uint16; height: uint16; numMips: uint8; format: bgfx_texture_format_t; flags: uint32): pointer {.cdecl.}
        vertex_decl_begin*: proc (decl: ptr bgfx_vertex_decl_t; renderer: bgfx_renderer_type_t) {.cdecl.}
        vertex_decl_add*: proc (decl: ptr bgfx_vertex_decl_t; attrib: bgfx_attrib_t; num: uint8; typ: bgfx_attrib_type_t; normalized: bool; asInt: bool) {.cdecl.}
        vertex_decl_skip*: proc (decl: ptr bgfx_vertex_decl_t; num: uint8) {.cdecl.}
        vertex_decl_end*: proc (decl: ptr bgfx_vertex_decl_t) {.cdecl.}
        vertex_pack*: proc (input: array[4, cfloat]; inputNormalized: bool; attr: bgfx_attrib_t; decl: ptr bgfx_vertex_decl_t; data: pointer; index: uint32) {.cdecl.}
        vertex_unpack*: proc (output: array[4, cfloat]; attr: bgfx_attrib_t; decl: ptr bgfx_vertex_decl_t; data: pointer; index: uint32) {.cdecl.}
        vertex_convert*: proc (destDecl: ptr bgfx_vertex_decl_t; destData: pointer; srcDecl: ptr bgfx_vertex_decl_t; srcData: pointer; num: uint32) {.cdecl.}
        weld_vertices*: proc (output: ptr uint16; decl: ptr bgfx_vertex_decl_t; data: pointer; num: uint16; epsilon: cfloat): uint16 {. cdecl.}
        topology_convert*: proc (conversion: bgfx_topology_convert_t; dst: pointer; dstSize: uint32; indices: pointer; numIndices: uint32; index32: bool): uint32 {.cdecl.}
        image_swizzle_bgra8*: proc (width: uint32; height: uint32; pitch: uint32; src: pointer; dst: pointer) {.cdecl.}
        image_rgba8_downsample_2x2*: proc (width: uint32; height: uint32; pitch: uint32; src: pointer; dst: pointer) {.cdecl.}
        get_supported_renderers*: proc (enm: array[BGFX_RENDERER_TYPE_COUNT, bgfx_renderer_type_t]): uint8 {.cdecl.}
        get_renderer_name*: proc (typ: bgfx_renderer_type_t): cstring {.cdecl.}
        init*: proc (typ: bgfx_renderer_type_t; vendorId: uint16; deviceId: uint16; callback: ptr bgfx_callback_interface_t; allocator: ptr bgfx_allocator_interface_t): bool {.cdecl.}
        shutdown*: proc () {.cdecl.}
        reset*: proc (width: uint32; height: uint32; flags: uint32) {.cdecl.}
        frame*: proc (capture: bool): uint32 {.cdecl.}
        get_renderer_type*: proc (): bgfx_renderer_type_t {.cdecl.}
        get_caps*: proc (): ptr bgfx_caps_t {.cdecl.}
        get_hmd*: proc (): ptr bgfx_hmd_t {.cdecl.}
        get_stats*: proc (): ptr bgfx_stats_t {.cdecl.}
        alloc*: proc (size: uint32): ptr bgfx_memory_t {.cdecl.}
        copy*: proc (data: pointer; size: uint32): ptr bgfx_memory_t {.cdecl.}
        make_ref*: proc (data: pointer; size: uint32): ptr bgfx_memory_t {.cdecl.}
        make_ref_release*: proc (data: pointer; size: uint32; releaseFn: bgfx_release_fn_t; userData: pointer): ptr bgfx_memory_t {.cdecl.}
        set_debug*: proc (debug: uint32) {.cdecl.}
        dbg_text_clear*: proc (attr: uint8; small: bool) {.cdecl.}
        dbg_text_printf*: proc (x: uint16; y: uint16; attr: uint8; format: cstring) {.cdecl, varargs.}
        dbg_text_image*: proc (x: uint16; y: uint16; width: uint16; height: uint16; data: pointer; pitch: uint16) {.cdecl.}
        create_index_buffer*: proc (mem: ptr bgfx_memory_t; flags: uint16): bgfx_index_buffer_handle_t {.cdecl.}
        destroy_index_buffer*: proc (handle: bgfx_index_buffer_handle_t) {.cdecl.}
        create_vertex_buffer*: proc (mem: ptr bgfx_memory_t; decl: ptr bgfx_vertex_decl_t; flags: uint16): bgfx_vertex_buffer_handle_t {.cdecl.}
        destroy_vertex_buffer*: proc (handle: bgfx_vertex_buffer_handle_t) {.cdecl.}
        create_dynamic_index_buffer*: proc (num: uint32; flags: uint16): bgfx_dynamic_index_buffer_handle_t {.cdecl.}
        create_dynamic_index_buffer_mem*: proc (mem: ptr bgfx_memory_t; flags: uint16): bgfx_dynamic_index_buffer_handle_t {.cdecl.}
        update_dynamic_index_buffer*: proc (handle: bgfx_dynamic_index_buffer_handle_t;startIndex: uint32;mem: ptr bgfx_memory_t) {.cdecl.}
        destroy_dynamic_index_buffer*: proc (handle: bgfx_dynamic_index_buffer_handle_t) {.cdecl.}
        create_dynamic_vertex_buffer*: proc (num: uint32;decl: ptr bgfx_vertex_decl_t;flags: uint16): bgfx_dynamic_vertex_buffer_handle_t {.cdecl.}
        create_dynamic_vertex_buffer_mem*: proc (mem: ptr bgfx_memory_t;decl: ptr bgfx_vertex_decl_t; flags: uint16): bgfx_dynamic_vertex_buffer_handle_t {.cdecl.}
        update_dynamic_vertex_buffer*: proc (handle: bgfx_dynamic_vertex_buffer_handle_t;startVertex: uint32;mem: ptr bgfx_memory_t) {.cdecl.}
        destroy_dynamic_vertex_buffer*: proc (handle: bgfx_dynamic_vertex_buffer_handle_t) {.cdecl.}
        check_avail_transient_index_buffer*: proc (num: uint32): bool {.cdecl.}
        check_avail_transient_vertex_buffer*: proc (num: uint32;decl: ptr bgfx_vertex_decl_t): bool {.cdecl.}
        check_avail_instance_data_buffer*: proc (num: uint32; stride: uint16): bool {.cdecl.}
        check_avail_transient_buffers*: proc (numVertices: uint32;decl: ptr bgfx_vertex_decl_t;numIndices: uint32): bool {.cdecl.}
        alloc_transient_index_buffer*: proc (tib: ptr bgfx_transient_index_buffer_t;num: uint32) {.cdecl.}
        alloc_transient_vertex_buffer*: proc (tvb: ptr bgfx_transient_vertex_buffer_t;num: uint32;decl: ptr bgfx_vertex_decl_t) {.cdecl.}
        alloc_transient_buffers*: proc (tvb: ptr bgfx_transient_vertex_buffer_t;decl: ptr bgfx_vertex_decl_t;numVertices: uint32;tib: ptr bgfx_transient_index_buffer_t;numIndices: uint32): bool {.cdecl.}
        alloc_instance_data_buffer*: proc (num: uint32; stride: uint16): ptr bgfx_instance_data_buffer_t {.cdecl.}
        create_indirect_buffer*: proc (num: uint32): bgfx_indirect_buffer_handle_t {.cdecl.}
        destroy_indirect_buffer*: proc (handle: bgfx_indirect_buffer_handle_t) {.cdecl.}
        create_shader*: proc (mem: ptr bgfx_memory_t): bgfx_shader_handle_t {.cdecl.}
        get_shader_uniforms*: proc (handle: bgfx_shader_handle_t;uniforms: ptr bgfx_uniform_handle_t; max: uint16): uint16 {.cdecl.}
        destroy_shader*: proc (handle: bgfx_shader_handle_t) {.cdecl.}
        create_program*: proc (vsh: bgfx_shader_handle_t; fsh: bgfx_shader_handle_t;destroyShaders: bool): bgfx_program_handle_t {.cdecl.}
        create_compute_program*: proc (csh: bgfx_shader_handle_t; destroyShaders: bool): bgfx_program_handle_t {.cdecl.}
        destroy_program*: proc (handle: bgfx_program_handle_t) {.cdecl.}
        calc_texture_size*: proc (info: ptr bgfx_texture_info_t; width: uint16;height: uint16; depth: uint16; cubeMap: bool;numMips: uint8; format: bgfx_texture_format_t) {.cdecl.}
        create_texture*: proc (mem: ptr bgfx_memory_t; flags: uint32; skip: uint8;info: ptr bgfx_texture_info_t): bgfx_texture_handle_t {.cdecl.}
        create_texture_2d*: proc (width: uint16; height: uint16; numMips: uint8;format: bgfx_texture_format_t; flags: uint32;mem: ptr bgfx_memory_t): bgfx_texture_handle_t {.cdecl.}
        create_texture_2d_scaled*: proc (ratio: bgfx_backbuffer_ratio_t;numMips: uint8;format: bgfx_texture_format_t;flags: uint32): bgfx_texture_handle_t {.cdecl.}
        create_texture_3d*: proc (width: uint16; height: uint16; depth: uint16;numMips: uint8; format: bgfx_texture_format_t;flags: uint32; mem: ptr bgfx_memory_t): bgfx_texture_handle_t {.cdecl.}
        create_texture_cube*: proc (size: uint16; numMips: uint8;format: bgfx_texture_format_t; flags: uint32;mem: ptr bgfx_memory_t): bgfx_texture_handle_t {.cdecl.}
        update_texture_2d*: proc (handle: bgfx_texture_handle_t; mip: uint8;x: uint16; y: uint16; width: uint16;height: uint16; mem: ptr bgfx_memory_t;pitch: uint16) {.cdecl.}
        update_texture_3d*: proc (handle: bgfx_texture_handle_t; mip: uint8;x: uint16; y: uint16; z: uint16;width: uint16; height: uint16; depth: uint16;mem: ptr bgfx_memory_t) {.cdecl.}
        update_texture_cube*: proc (handle: bgfx_texture_handle_t; side: uint8;mip: uint8; x: uint16; y: uint16;width: uint16; height: uint16;mem: ptr bgfx_memory_t; pitch: uint16) {.cdecl.}
        destroy_texture*: proc (handle: bgfx_texture_handle_t) {.cdecl.}
        create_frame_buffer*: proc (width: uint16; height: uint16;format: bgfx_texture_format_t;textureFlags: uint32): bgfx_frame_buffer_handle_t {.cdecl.}
        create_frame_buffer_scaled*: proc (ratio: bgfx_backbuffer_ratio_t;format: bgfx_texture_format_t;textureFlags: uint32): bgfx_frame_buffer_handle_t {.cdecl.}
        create_frame_buffer_from_attachment*: proc (num: uint8;attachment: ptr bgfx_attachment_t; destroyTextures: bool): bgfx_frame_buffer_handle_t {.cdecl.}
        create_frame_buffer_from_nwh*: proc (nwh: pointer; width: uint16;height: uint16;depthFormat: bgfx_texture_format_t): bgfx_frame_buffer_handle_t {.cdecl.}
        destroy_frame_buffer*: proc (handle: bgfx_frame_buffer_handle_t) {.cdecl.}
        create_uniform*: proc (name: cstring; typ: bgfx_uniform_type_t; num: uint16): bgfx_uniform_handle_t {.cdecl.}
        destroy_uniform*: proc (handle: bgfx_uniform_handle_t) {.cdecl.}
        create_occlusion_query*: proc (): bgfx_occlusion_query_handle_t {.cdecl.}
        get_result*: proc (handle: bgfx_occlusion_query_handle_t): bgfx_occlusion_query_result_t {.cdecl.}
        destroy_occlusion_query*: proc (handle: bgfx_occlusion_query_handle_t) {.cdecl.}
        set_palette_color*: proc (index: uint8; rgba: array[4, cfloat]) {.cdecl.}
        set_view_name*: proc (id: uint8; name: cstring) {.cdecl.}
        set_view_rect*: proc (id: uint8; x: uint16; y: uint16; width: uint16;height: uint16) {.cdecl.}
        set_view_scissor*: proc (id: uint8; x: uint16; y: uint16; width: uint16;height: uint16) {.cdecl.}
        set_view_clear*: proc (id: uint8; flags: uint16; rgba: uint32;depth: cfloat; stencil: uint8) {.cdecl.}
        set_view_clear_mrt*: proc (id: uint8; flags: uint16; depth: cfloat;stencil: uint8; c0: uint8; c1: uint8; c2: uint8;c3: uint8; c4: uint8; c5: uint8; c6: uint8;c7: uint8) {.cdecl.}
        set_view_seq*: proc (id: uint8; enabled: bool) {.cdecl.}
        set_view_frame_buffer*: proc (id: uint8; handle: bgfx_frame_buffer_handle_t) {.cdecl.}
        set_view_transform*: proc (id: uint8; view: pointer; proj: pointer) {.cdecl.}
        set_view_transform_stereo*: proc (id: uint8; view: pointer; projL: pointer;flags: uint8; projR: pointer) {.cdecl.}
        set_view_remap*: proc (id: uint8; num: uint8; remap: pointer) {.cdecl.}
        set_marker*: proc (marker: cstring) {.cdecl.}
        set_state*: proc (state: uint64; rgba: uint32) {.cdecl.}
        set_condition*: proc (handle: bgfx_occlusion_query_handle_t; visible: bool) {.cdecl.}
        set_stencil*: proc (fstencil: uint32; bstencil: uint32) {.cdecl.}
        set_scissor*: proc (x: uint16; y: uint16; width: uint16; height: uint16): uint16 {.cdecl.}
        set_scissor_cached*: proc (cache: uint16) {.cdecl.}
        set_transform*: proc (mtx: pointer; num: uint16): uint32 {.cdecl.}
        alloc_transform*: proc (transform: ptr bgfx_transform_t; num: uint16): uint32 {.    cdecl.}
        set_transform_cached*: proc (cache: uint32; num: uint16) {.cdecl.}
        set_uniform*: proc (handle: bgfx_uniform_handle_t; value: pointer;num: uint16) {.cdecl.}
        set_index_buffer*: proc (handle: bgfx_index_buffer_handle_t;firstIndex: uint32; numIndices: uint32) {.cdecl.}
        set_dynamic_index_buffer*: proc (handle: bgfx_dynamic_index_buffer_handle_t;firstIndex: uint32; numIndices: uint32) {.cdecl.}
        set_transient_index_buffer*: proc (tib: ptr bgfx_transient_index_buffer_t;firstIndex: uint32; numIndices: uint32) {.cdecl.}
        set_vertex_buffer*: proc (handle: bgfx_vertex_buffer_handle_t;startVertex: uint32; numVertices: uint32) {.cdecl.}
        set_dynamic_vertex_buffer*: proc (handle: bgfx_dynamic_vertex_buffer_handle_t;startVertex: uint32; numVertices: uint32) {.cdecl.}
        set_transient_vertex_buffer*: proc (tvb: ptr bgfx_transient_vertex_buffer_t;startVertex: uint32;numVertices: uint32) {.cdecl.}
        set_instance_data_buffer*: proc (idb: ptr bgfx_instance_data_buffer_t;num: uint32) {.cdecl.}
        set_instance_data_from_vertex_buffer*: proc (handle: bgfx_vertex_buffer_handle_t; startVertex: uint32; num: uint32) {.cdecl.}
        set_instance_data_from_dynamic_vertex_buffer*: proc (handle: bgfx_dynamic_vertex_buffer_handle_t; startVertex: uint32;num: uint32) {.cdecl.}
        set_texture*: proc (stage: uint8; sampler: bgfx_uniform_handle_t;handle: bgfx_texture_handle_t; flags: uint32) {.cdecl.}
        set_texture_from_frame_buffer*: proc (stage: uint8;sampler: bgfx_uniform_handle_t;handle: bgfx_frame_buffer_handle_t;attachment: uint8; flags: uint32) {.cdecl.}
        touch*: proc (id: uint8): uint32 {.cdecl.}
        submit*: proc (id: uint8; handle: bgfx_program_handle_t; depth: int32;preserveState: bool): uint32 {.cdecl.}
        submit_occlusion_query*: proc (id: uint8; program: bgfx_program_handle_t;occlusionQuery: bgfx_occlusion_query_handle_t; depth: int32;preserveState: bool): uint32 {.cdecl.}
        submit_indirect*: proc (id: uint8; handle: bgfx_program_handle_t;indirectHandle: bgfx_indirect_buffer_handle_t;start: uint16; num: uint16; depth: int32;preserveState: bool): uint32 {.cdecl.}
        set_image*: proc (stage: uint8; sampler: bgfx_uniform_handle_t;handle: bgfx_texture_handle_t; mip: uint8;access: bgfx_access_t; format: bgfx_texture_format_t) {.cdecl.}
        set_image_from_frame_buffer*: proc (stage: uint8;sampler: bgfx_uniform_handle_t;handle: bgfx_frame_buffer_handle_t;attachment: uint8;access: bgfx_access_t;format: bgfx_texture_format_t) {.cdecl.}
        set_compute_index_buffer*: proc (stage: uint8;handle: bgfx_index_buffer_handle_t;access: bgfx_access_t) {.cdecl.}
        set_compute_vertex_buffer*: proc (stage: uint8;handle: bgfx_vertex_buffer_handle_t;access: bgfx_access_t) {.cdecl.}
        set_compute_dynamic_index_buffer*: proc (stage: uint8;handle: bgfx_dynamic_index_buffer_handle_t; access: bgfx_access_t) {.cdecl.}
        set_compute_dynamic_vertex_buffer*: proc (stage: uint8;handle: bgfx_dynamic_vertex_buffer_handle_t; access: bgfx_access_t) {.cdecl.}
        set_compute_indirect_buffer*: proc (stage: uint8;handle: bgfx_indirect_buffer_handle_t;access: bgfx_access_t) {.cdecl.}
        dispatch*: proc (id: uint8; handle: bgfx_program_handle_t; numX: uint16;numY: uint16; numZ: uint16; flags: uint8): uint32 {.cdecl.}
        dispatch_indirect*: proc (id: uint8; handle: bgfx_program_handle_t;indirectHandle: bgfx_indirect_buffer_handle_t;start: uint16; num: uint16; flags: uint8): uint32 {.cdecl.}
        `discard`*: proc () {.cdecl.}
        blit*: proc (id: uint8; dst: bgfx_texture_handle_t; dstMip: uint8;dstX: uint16; dstY: uint16; dstZ: uint16;src: bgfx_texture_handle_t; srcMip: uint8; srcX: uint16;srcY: uint16; srcZ: uint16; width: uint16; height: uint16;depth: uint16) {.cdecl.}
        save_screen_shot*: proc (filePath: cstring) {.cdecl.}

    PFN_BGFX_GET_INTERFACE* = proc (version: uint32): ptr bgfx_interface_vtbl_t {.cdecl.}


proc bgfx_vertex_decl_begin*(decl: ptr bgfx_vertex_decl_t; renderer: bgfx_renderer_type_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_vertex_decl_add*(decl: ptr bgfx_vertex_decl_t; attrib: bgfx_attrib_t; num: uint8; typ: bgfx_attrib_type_t; normalized: bool; asInt: bool) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_vertex_decl_skip*(decl: ptr bgfx_vertex_decl_t; num: uint8) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_vertex_decl_end*(decl: ptr bgfx_vertex_decl_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_vertex_pack*(input: array[4, cfloat]; inputNormalized: bool; attr: bgfx_attrib_t; decl: ptr bgfx_vertex_decl_t; data: pointer; index: uint32) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_vertex_unpack*(output: array[4, cfloat]; attr: bgfx_attrib_t; decl: ptr bgfx_vertex_decl_t; data: pointer; index: uint32) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_vertex_convert*(destDecl: ptr bgfx_vertex_decl_t; destData: pointer; srcDecl: ptr bgfx_vertex_decl_t; srcData: pointer; num: uint32) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_weld_vertices*(output: ptr uint16; decl: ptr bgfx_vertex_decl_t; data: pointer; num: uint16; epsilon: cfloat): uint16 {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_image_swizzle_bgra8*(width: uint32; height: uint32; pitch: uint32; src: pointer; dst: pointer) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_image_rgba8_downsample_2x2*(width: uint32; height: uint32; pitch: uint32; src: pointer; dst: pointer) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_get_supported_renderers*(enm: array[BGFX_RENDERER_TYPE_COUNT, bgfx_renderer_type_t]): uint8 {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_get_renderer_name*(typ: bgfx_renderer_type_t): cstring {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_init*(typ: bgfx_renderer_type_t; vendorId: uint16; deviceId: uint16; callback: ptr bgfx_callback_interface_t; allocator: ptr bgfx_allocator_interface_t): bool {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_shutdown*() {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_reset*(width: uint32; height: uint32; flags: uint32) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_frame*(capture: bool): uint32 {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_get_renderer_type*(): bgfx_renderer_type_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_get_caps*(): ptr bgfx_caps_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_get_hmd*(): ptr bgfx_hmd_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_get_stats*(): ptr bgfx_stats_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_alloc*(size: uint32): ptr bgfx_memory_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_copy*(data: pointer; size: uint32): ptr bgfx_memory_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_make_ref*(data: pointer; size: uint32): ptr bgfx_memory_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_make_ref_release*(data: pointer; size: uint32; releaseFn: bgfx_release_fn_t; userData: pointer): ptr bgfx_memory_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_debug*(debug: uint32) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_dbg_text_clear*(attr: uint8; small: bool) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_dbg_text_printf*(x: uint16; y: uint16; attr: uint8; format: cstring) {.varargs, importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_dbg_text_image*(x: uint16; y: uint16; width: uint16; height: uint16; data: pointer; pitch: uint16) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_create_index_buffer*(mem: ptr bgfx_memory_t; flags: uint16): bgfx_index_buffer_handle_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_destroy_index_buffer*(handle: bgfx_index_buffer_handle_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_create_vertex_buffer*(mem: ptr bgfx_memory_t; decl: ptr bgfx_vertex_decl_t; flags: uint16): bgfx_vertex_buffer_handle_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_destroy_vertex_buffer*(handle: bgfx_vertex_buffer_handle_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_create_dynamic_index_buffer*(num: uint32; flags: uint16): bgfx_dynamic_index_buffer_handle_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_create_dynamic_index_buffer_mem*(mem: ptr bgfx_memory_t; flags: uint16): bgfx_dynamic_index_buffer_handle_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_update_dynamic_index_buffer*(handle: bgfx_dynamic_index_buffer_handle_t; startIndex: uint32; mem: ptr bgfx_memory_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_destroy_dynamic_index_buffer*(handle: bgfx_dynamic_index_buffer_handle_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_create_dynamic_vertex_buffer*(num: uint32; decl: ptr bgfx_vertex_decl_t; flags: uint16): bgfx_dynamic_vertex_buffer_handle_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_create_dynamic_vertex_buffer_mem*(mem: ptr bgfx_memory_t; decl: ptr bgfx_vertex_decl_t; flags: uint16): bgfx_dynamic_vertex_buffer_handle_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_update_dynamic_vertex_buffer*(handle: bgfx_dynamic_vertex_buffer_handle_t; startVertex: uint32; mem: ptr bgfx_memory_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_destroy_dynamic_vertex_buffer*(handle: bgfx_dynamic_vertex_buffer_handle_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_check_avail_transient_index_buffer*(num: uint32): bool {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_check_avail_transient_vertex_buffer*(num: uint32;decl: ptr bgfx_vertex_decl_t): bool {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_check_avail_instance_data_buffer*(num: uint32; stride: uint16): bool {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_check_avail_transient_buffers*(numVertices: uint32; decl: ptr bgfx_vertex_decl_t; numIndices: uint32): bool {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_alloc_transient_index_buffer*(tib: ptr bgfx_transient_index_buffer_t; num: uint32) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_alloc_transient_vertex_buffer*(tvb: ptr bgfx_transient_vertex_buffer_t; num: uint32; decl: ptr bgfx_vertex_decl_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_alloc_transient_buffers*(tvb: ptr bgfx_transient_vertex_buffer_t; decl: ptr bgfx_vertex_decl_t; numVertices: uint32; tib: ptr bgfx_transient_index_buffer_t; numIndices: uint32): bool {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_alloc_instance_data_buffer*(num: uint32; stride: uint16): ptr bgfx_instance_data_buffer_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_create_indirect_buffer*(num: uint32): bgfx_indirect_buffer_handle_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_destroy_indirect_buffer*(handle: bgfx_indirect_buffer_handle_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_create_shader*(mem: ptr bgfx_memory_t): bgfx_shader_handle_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_get_shader_uniforms*(handle: bgfx_shader_handle_t; uniforms: ptr bgfx_uniform_handle_t; max: uint16): uint16 {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_destroy_shader*(handle: bgfx_shader_handle_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_create_program*(vsh: bgfx_shader_handle_t; fsh: bgfx_shader_handle_t; destroyShaders: bool): bgfx_program_handle_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_create_compute_program*(csh: bgfx_shader_handle_t; destroyShaders: bool): bgfx_program_handle_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_destroy_program*(handle: bgfx_program_handle_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_calc_texture_size*(info: ptr bgfx_texture_info_t; width: uint16; height: uint16; depth: uint16; cubeMap: bool; numMips: uint8; format: bgfx_texture_format_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_create_texture*(mem: ptr bgfx_memory_t; flags: uint32; skip: uint8; info: ptr bgfx_texture_info_t): bgfx_texture_handle_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_create_texture_2d*(width: uint16; height: uint16; numMips: uint8; format: bgfx_texture_format_t; flags: uint32; mem: ptr bgfx_memory_t): bgfx_texture_handle_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_create_texture_2d_scaled*(ratio: bgfx_backbuffer_ratio_t; numMips: uint8; format: bgfx_texture_format_t; flags: uint32): bgfx_texture_handle_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_create_texture_3d*(width: uint16; height: uint16; depth: uint16; numMips: uint8; format: bgfx_texture_format_t; flags: uint32; mem: ptr bgfx_memory_t): bgfx_texture_handle_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_create_texture_cube*(size: uint16; numMips: uint8; format: bgfx_texture_format_t; flags: uint32; mem: ptr bgfx_memory_t): bgfx_texture_handle_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_update_texture_2d*(handle: bgfx_texture_handle_t; mip: uint8; x: uint16; y: uint16; width: uint16; height: uint16; mem: ptr bgfx_memory_t; pitch: uint16) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_update_texture_3d*(handle: bgfx_texture_handle_t; mip: uint8; x: uint16; y: uint16; z: uint16; width: uint16; height: uint16; depth: uint16; mem: ptr bgfx_memory_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_update_texture_cube*(handle: bgfx_texture_handle_t; side: uint8; mip: uint8; x: uint16; y: uint16; width: uint16; height: uint16; mem: ptr bgfx_memory_t; pitch: uint16) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_read_texture*(handle: bgfx_texture_handle_t; data: pointer): uint32 {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_read_frame_buffer*(handle: bgfx_frame_buffer_handle_t; attachment: uint8; data: pointer): uint32 {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_destroy_texture*(handle: bgfx_texture_handle_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_create_frame_buffer*(width: uint16; height: uint16; format: bgfx_texture_format_t; textureFlags: uint32): bgfx_frame_buffer_handle_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_create_frame_buffer_scaled*(ratio: bgfx_backbuffer_ratio_t; format: bgfx_texture_format_t; textureFlags: uint32): bgfx_frame_buffer_handle_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_create_frame_buffer_from_attachment*(num: uint8; attachment: ptr bgfx_attachment_t; destroyTextures: bool): bgfx_frame_buffer_handle_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_create_frame_buffer_from_nwh*(nwh: pointer; width: uint16; height: uint16; depthFormat: bgfx_texture_format_t): bgfx_frame_buffer_handle_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_destroy_frame_buffer*(handle: bgfx_frame_buffer_handle_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_create_uniform*(name: cstring; typ: bgfx_uniform_type_t; num: uint16): bgfx_uniform_handle_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_destroy_uniform*(handle: bgfx_uniform_handle_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_create_occlusion_query*(): bgfx_occlusion_query_handle_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_get_result*(handle: bgfx_occlusion_query_handle_t): bgfx_occlusion_query_result_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_destroy_occlusion_query*(handle: bgfx_occlusion_query_handle_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_palette_color*(index: uint8; rgba: array[4, cfloat]) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_view_name*(id: uint8; name: cstring) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_view_rect*(id: uint8; x: uint16; y: uint16; width: uint16; height: uint16) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_view_rect_auto*(id: uint8; x: uint16; y: uint16; ratio: bgfx_backbuffer_ratio_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_view_scissor*(id: uint8; x: uint16; y: uint16; width: uint16; height: uint16) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_view_clear*(id: uint8; flags: uint16; rgba: uint32; depth: cfloat; stencil: uint8) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_view_clear_mrt*(id: uint8; flags: uint16; depth: cfloat; stencil: uint8; c0: uint8; c1: uint8; c2: uint8; c3: uint8; c4: uint8; c5: uint8; c6: uint8; c7: uint8) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_view_seq*(id: uint8; enabled: bool) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_view_frame_buffer*(id: uint8; handle: bgfx_frame_buffer_handle_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_view_transform*(id: uint8; view: pointer; proj: pointer) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_view_transform_stereo*(id: uint8; view: pointer; projL: pointer;flags: uint8; projR: pointer) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_view_remap*(id: uint8; num: uint8; remap: pointer) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_reset_view*(id: uint8) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_marker*(marker: cstring) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_state*(state: uint64; rgba: uint32) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_condition*(handle: bgfx_occlusion_query_handle_t; visible: bool) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_stencil*(fstencil: uint32; bstencil: uint32) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_scissor*(x: uint16; y: uint16; width: uint16; height: uint16): uint16 {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_scissor_cached*(cache: uint16) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_transform*(mtx: pointer; num: uint16): uint32 {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_alloc_transform*(transform: ptr bgfx_transform_t; num: uint16): uint32 {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_transform_cached*(cache: uint32; num: uint16) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_uniform*(handle: bgfx_uniform_handle_t; value: pointer; num: uint16) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_index_buffer*(handle: bgfx_index_buffer_handle_t; firstIndex: uint32; numIndices: uint32) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_dynamic_index_buffer*(handle: bgfx_dynamic_index_buffer_handle_t; firstIndex: uint32; numIndices: uint32) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_transient_index_buffer*(tib: ptr bgfx_transient_index_buffer_t; firstIndex: uint32; numIndices: uint32) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_vertex_buffer*(handle: bgfx_vertex_buffer_handle_t; startVertex: uint32; numVertices: uint32) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_dynamic_vertex_buffer*(handle: bgfx_dynamic_vertex_buffer_handle_t; startVertex: uint32; numVertices: uint32) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_transient_vertex_buffer*(tvb: ptr bgfx_transient_vertex_buffer_t; startVertex: uint32; numVertices: uint32) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_instance_data_buffer*(idb: ptr bgfx_instance_data_buffer_t; num: uint32) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_instance_data_from_vertex_buffer*(handle: bgfx_vertex_buffer_handle_t; startVertex: uint32; num: uint32) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_instance_data_from_dynamic_vertex_buffer*(handle: bgfx_dynamic_vertex_buffer_handle_t; startVertex: uint32;num: uint32) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_texture*(stage: uint8; sampler: bgfx_uniform_handle_t;handle: bgfx_texture_handle_t; flags: uint32) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_texture_from_frame_buffer*(stage: uint8;sampler: bgfx_uniform_handle_t;handle: bgfx_frame_buffer_handle_t;attachment: uint8; flags: uint32) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_touch*(id: uint8): uint32 {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_submit*(id: uint8; handle: bgfx_program_handle_t; depth: int32;preserveState: bool): uint32 {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_submit_occlusion_query*(id: uint8; program: bgfx_program_handle_t;occlusionQuery: bgfx_occlusion_query_handle_t; depth: int32;preserveState: bool): uint32 {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_submit_indirect*(id: uint8; handle: bgfx_program_handle_t;indirectHandle: bgfx_indirect_buffer_handle_t;start: uint16; num: uint16; depth: int32;preserveState: bool): uint32 {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_image*(stage: uint8; sampler: bgfx_uniform_handle_t;handle: bgfx_texture_handle_t; mip: uint8;access: bgfx_access_t; format: bgfx_texture_format_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_image_from_frame_buffer*(stage: uint8;sampler: bgfx_uniform_handle_t;handle: bgfx_frame_buffer_handle_t;attachment: uint8;access: bgfx_access_t;format: bgfx_texture_format_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_compute_index_buffer*(stage: uint8;handle: bgfx_index_buffer_handle_t;access: bgfx_access_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_compute_vertex_buffer*(stage: uint8;handle: bgfx_vertex_buffer_handle_t;access: bgfx_access_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_compute_dynamic_index_buffer*(stage: uint8;handle: bgfx_dynamic_index_buffer_handle_t; access: bgfx_access_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_compute_dynamic_vertex_buffer*(stage: uint8;handle: bgfx_dynamic_vertex_buffer_handle_t; access: bgfx_access_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_compute_indirect_buffer*(stage: uint8;handle: bgfx_indirect_buffer_handle_t;access: bgfx_access_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_dispatch*(id: uint8; handle: bgfx_program_handle_t; numX: uint16; numY: uint16; numZ: uint16; flags: uint8): uint32 {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_dispatch_indirect*(id: uint8; handle: bgfx_program_handle_t;indirectHandle: bgfx_indirect_buffer_handle_t;start: uint16; num: uint16; flags: uint8): uint32 {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_discard*() {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_blit*(id: uint8; dst: bgfx_texture_handle_t; dstMip: uint8;dstX: uint16; dstY: uint16; dstZ: uint16;src: bgfx_texture_handle_t; srcMip: uint8; srcX: uint16;srcY: uint16; srcZ: uint16; width: uint16; height: uint16;depth: uint16) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_blit_frame_buffer*(id: uint8; dst: bgfx_texture_handle_t; dstMip: uint8; dstX: uint16; dstY: uint16; dstZ: uint16; src: bgfx_frame_buffer_handle_t; attachment: uint8; srcMip: uint8; srcX: uint16; srcY: uint16; srcZ: uint16; width: uint16; height: uint16; depth: uint16) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_save_screen_shot*(filePath: cstring) {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_get_internal_data*(): ptr bgfx_internal_data_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_override_internal_texture_ptr*(handle: bgfx_texture_handle_t; pntr: pointer): pointer {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_override_internal_texture*(handle: bgfx_texture_handle_t; width: uint16; height: uint16; numMips: uint8; format: bgfx_texture_format_t; flags: uint32): pointer {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_render_frame*(): bgfx_render_frame_t {.importc, dynlib: BGFXLibraryName, cdecl.}
proc bgfx_set_platform_data*(data: ptr bgfx_platform_data_t) {.importc, dynlib: BGFXLibraryName, cdecl.}
