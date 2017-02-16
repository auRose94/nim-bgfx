# Copyright 2017 Cory Noll Crimmins - Golden
# License: BSD-2
# Port of bgfx cubes example 01 to nim and nim-bgfx

import bgfx
import ../bgfx_utils
import ../fpu_math
when defined(useSDL):
    import ../sdl_platform
elif defined(useGLFW) or not defined(useSDL):
    import ../glfw_platform
import parseopt2
import os

type ExampleCubes = ref object
    m_width*: uint32
    m_height*: uint32
    m_window_width*: uint32
    m_window_height*: uint32
    m_debug*: uint32
    m_reset*: uint32
    m_vbh*: bgfx.VertexBufferHandle
    m_ibh*: bgfx.IndexBufferHandle
    m_program*: bgfx.ProgramHandle

type PosColorVertex {.packed, pure.} = object
    x*, y*, z*: float32
    abgr*: uint32

var s_cubeVertices_Decl: ptr bgfx.VertexDecl

proc Start(self: ExampleCubes) =

    var m_renderer_type = bgfx.RendererType.RendererType_Count
    var m_pciID = 0'u16

    self.m_width = 1280
    self.m_height = 1280
    self.m_debug = BGFX_DEBUG_TEXT # or BGFX_DEBUG_STATS
    self.m_reset = 0'u32 # BGFX_RESET_VSYNC

    # Seperate Thread
    bgfx.Init(m_renderer_type, m_pciID, 0, nil, nil)
    bgfx.Reset(self.m_width, self.m_height, self.m_reset)

    # Enable Debug Text
    bgfx.SetDebug(self.m_debug)

    # Set view 0 clear state
    bgfx.SetViewClear(0, BGFX_CLEAR_COLOR or BGFX_CLEAR_DEPTH, 0x303030ff, 1.0, 0)

    s_cubeVertices_Decl = createShared(bgfx.VertexDecl)
    s_cubeVertices_Decl.Begin()
    s_cubeVertices_Decl.Add(bgfx.Attrib_Position, 3, bgfx.AttribType_Float)
    s_cubeVertices_Decl.Add(bgfx.Attrib_Color0, 4, bgfx.AttribType_Uint8, true)
    s_cubeVertices_Decl.End()

    var vertexdata = [
        PosColorVertex(x: -1.0'f32, y:  1.0'f32, z:  1.0'f32, abgr: 0xff000000'u32 ),
        PosColorVertex(x:  1.0'f32, y:  1.0'f32, z:  1.0'f32, abgr: 0xff0000ff'u32 ),
        PosColorVertex(x: -1.0'f32, y: -1.0'f32, z:  1.0'f32, abgr: 0xff00ff00'u32 ),
        PosColorVertex(x:  1.0'f32, y: -1.0'f32, z:  1.0'f32, abgr: 0xff00ffff'u32 ),
        PosColorVertex(x: -1.0'f32, y:  1.0'f32, z: -1.0'f32, abgr: 0xffff0000'u32 ),
        PosColorVertex(x:  1.0'f32, y:  1.0'f32, z: -1.0'f32, abgr: 0xffff00ff'u32 ),
        PosColorVertex(x: -1.0'f32, y: -1.0'f32, z: -1.0'f32, abgr: 0xffffff00'u32 ),
        PosColorVertex(x:  1.0'f32, y: -1.0'f32, z: -1.0'f32, abgr: 0xffffffff'u32 )
    ]
    var vertexmem: ptr bgfx.Memory = bgfx.Copy(addr(vertexdata[0]), cast[uint32_t](sizeof(PosColorVertex) * 8))

    var indexdata = [
        0'u16, 1'u16, 2'u16, ## 0
        1'u16, 3'u16, 2'u16,
        4'u16, 6'u16, 5'u16, ## 2
        5'u16, 6'u16, 7'u16,
        0'u16, 2'u16, 4'u16, ## 4
        4'u16, 2'u16, 6'u16,
        1'u16, 5'u16, 3'u16, ## 6
        5'u16, 7'u16, 3'u16,
        0'u16, 4'u16, 1'u16, ## 8
        4'u16, 5'u16, 1'u16,
        2'u16, 3'u16, 6'u16, ## 10
        6'u16, 3'u16, 7'u16]
    var indexmem: ptr bgfx.Memory = bgfx.Copy(addr(indexdata[0]), cast[uint32_t](sizeof(uint16) * 36))

    self.m_vbh = bgfx.CreateVertexBuffer(vertexmem, s_cubeVertices_Decl, BGFX_BUFFER_NONE)

    self.m_ibh = bgfx.CreateIndexBuffer(indexmem)

    self.m_program = LoadProgram("vs_cubes", "fs_cubes")

proc CleanUp(self: ExampleCubes) =
    bgfx.DestroyProgram(self.m_program)
    bgfx.DestroyVertexBuffer(self.m_vbh)
    bgfx.DestroyIndexBuffer(self.m_ibh)
    bgfx.Shutdown()

proc Update(self: ExampleCubes) =
    # Set view 0 default viewport
    bgfx.SetViewRect(0, 0, 0, cast[uint16](self.m_width), cast[uint16](self.m_height))

    var now = GetTime()
    var last {.global.} = GetTime()
    let frameTime: float32 = now - last
    let time = GetTime()
    last = now
    var toMs = 1000.0'f32

    # Use debug font to print information about this example.
    bgfx.DebugTextClear()
    bgfx.DebugTextPrintf(0, 1, 0x4f, "nim-bgfx/examples/01-Cubes")
    bgfx.DebugTextPrintf(0, 2, 0x6f, "Description: Rendering simple static mesh.")
    bgfx.DebugTextPrintf(0, 3, 0x0f, "Frame: %7.3f[ms] FPS: %7.3f", cast[float32](frameTime*toMs), cast[float32](1.0'f32 / (frameTime)));

    var at: Vec3  = [0.0'f32, 0.0'f32,   0.0'f32]
    var eye: Vec3 = [0.0'f32, 0.0'f32, -35.0'f32]

    var hmd = bgfx.GetHmd()
    if not hmd.isNil and (0'u8 != (hmd.flags and BGFX_HMD_RENDERING)):
        var view: Mat4
        fpumath.mtxQuatTranslationHMD(view, hmd.eye[0].rotation, eye)
        bgfx.SetViewTransform(0, unsafeAddr(view[0]), unsafeAddr(hmd.eye[0].projection[0]), BGFX_VIEW_STEREO, unsafeAddr(hmd.eye[1].projection[0]))

        bgfx.SetViewRect(0, 0, 0, hmd.width, hmd.height)
    else:
        var view: Mat4
        fpumath.mtxLookAt(view, eye, at)
        var proj: Mat4
        fpumath.mtxProj(proj, 60.0'f32, cast[float32](self.m_window_width)/cast[float32](self.m_window_height), 0.1'f32, 100.0'f32)
        bgfx.SetViewTransform(0, unsafeAddr(view[0]), unsafeAddr(proj[0]))

        bgfx.SetViewRect(0, 0, 0, cast[uint16](self.m_window_width), cast[uint16](self.m_window_height))

    bgfx.Touch(0)

    for yy in 0..11:
        for xx in 0..11:
            var fyy: float32 = yy.toFloat()
            var fxx: float32 = xx.toFloat()
            var mtx: Mat4
            fpumath.mtxRotateXY(mtx, time + fxx * 0.21'f32, time + fyy * 0.37'f32)
            mtx[12] = -15.0'f32 + fxx * 3.0'f32
            mtx[13] = -15.0'f32 + fyy * 3.0'f32
            mtx[14] = 0.0'f32

            bgfx.SetTransform(unsafeAddr(mtx[0]))

            bgfx.SetVertexBuffer(self.m_vbh)
            bgfx.SetIndexBuffer(self.m_ibh)

            bgfx.SetState(BGFX_STATE_DEFAULT)

            bgfx.Submit(0, self.m_program)

    bgfx.Frame()

StartExample[ExampleCubes]()
