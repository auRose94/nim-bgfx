# Copyright 2016 Cory Noll Crimmins - Golden
# License: BSD-2
# Port of bgfx helloworld example 00 to nim and nim-bgfx

import bgfx
import bgfxplatform
import glfw3 as glfw
import parseopt2
import strutils
import locks
import os
include logo

when defined(Windows):
    import glfw3native.Win32 as glfwn
elif defined(MacOSX):
    import glfw3native.Cocoa as glfwn
elif defined(Linux) or
    defined(FreeBSD) or
    defined(OpenBSD) or
    defined(NetBSD) or
    defined(Solaris) or
    defined(QNX):
    import glfw3native.X11 as glfwn

proc `/`(x, y: uint16): uint16 =
    x div y

type ExampleHelloWorld = ref object
    m_width*: uint32
    m_height*: uint32
    m_debug*: uint32
    m_reset*: uint32
    m_WindowIsClosing*: bool
    m_BGFXNeedsToReset*: bool
    m_Updated*: bool

proc LinkGLFW3WithBGFX*(window: Window) =
    var pd: ptr PlatformData = create(PlatformData)
    when defined(Windows):
        pd.nwh = glfwn.GetWin32Window(window)
        pd.ndt = nil
    elif defined(MacOSX):
        pd.nwh = glfwn.GetCocoaWindow(window)
        pd.ndt = nil
    elif defined(Linux) or
        defined(FreeBSD) or
        defined(OpenBSD) or
        defined(NetBSD) or
        defined(Solaris) or
        defined(QNX):
        pd.nwh = glfwn.GetX11Window(window)
        pd.ndt = glfwn.GetX11Display(window)
    else:
        {.fatal: "Exposure of glfw3native functions is required".}
    pd.backBuffer = nil
    pd.backBufferDS = nil
    pd.context = nil
    SetPlatformData(pd)

proc GLFWErrorCB(errorCode: cint; description: cstring) {.cdecl.} =
    debugEcho "[GLFW3] error: $1, $2".format(errorCode, description)



proc Init(self: ptr ExampleHelloWorld) {.thread.} =

    var m_renderer_type = bgfx.RendererType.RendererType_Count
    var m_pciID = 0'u16

    self.m_width = 1280
    self.m_height = 1280
    self.m_debug = BGFX_DEBUG_TEXT #or BGFX_DEBUG_STATS
    self.m_reset = 0'u32 #BGFX_RESET_VSYNC
    self.m_WindowIsClosing = false
    self.m_BGFXNeedsToReset = false

    #Seperate Thread
    bgfx.Init(m_renderer_type, m_pciID, 0, nil, nil)
    bgfx.Reset(self.m_width, self.m_height, self.m_reset)

    # Enable Debug Text
    bgfx.SetDebug(self.m_debug)

    # Set view 0 clear state
    bgfx.SetViewClear(0, BGFX_CLEAR_COLOR or BGFX_CLEAR_DEPTH, 0x303030ff, 1.0, 0)

proc Shutdown(self: ptr ExampleHelloWorld) {.thread.} =
    bgfx.Shutdown()

proc Update(self: ptr ExampleHelloWorld) {.thread.} =
    # Set view 0 default viewport
    bgfx.SetViewRect(0, 0, 0, cast[uint16](self.m_width), cast[uint16](self.m_height))

    # This dummy draw call is here to make sure that view 0 is cleared
    # if no other draw calls are submitted to view 0.
    bgfx.Touch(0)

    # Use debug font to print information about this example.
    bgfx.DbgTextClear()
    bgfx.DbgTextImage(max(cast[uint16](self.m_width) / 2'u16 / 8'u16, 20'u16) - 20'u16,
                      max(cast[uint16](self.m_height) / 2'u16 / 16'u16, 6'u16) - 6'u16,
                      40,
                      12,
                      s_logo.addr,
                      160
                      )
    bgfx.DbgTextPrintf(0, 1, 0x4f, "nim-bgfx/examples/00-HelloWorld")
    bgfx.DbgTextPrintf(0, 2, 0x6f, "Description: Initialization and debug text.")

    bgfx.Frame()

var app: ptr ExampleHelloWorld = createShared(ExampleHelloWorld)
var AppLock: Lock
app[] = ExampleHelloWorld()
initLock(AppLock)
assert(not app.isNil)

# Set up
discard glfw.SetErrorCallback(GLFWErrorCB)

if glfw.Init() != glfw.TRUE:
    echo "[GLFW3] Failed to initialize!"
    quit(QuitFailure)

glfw.WindowHint(glfw.CLIENT_API, glfw.NO_API)
var window: Window
window = glfw.CreateWindow(1280, 720, "HelloWorld", nil, nil)
if window == nil:
    echo "[GLFW3] Failed to create window!"
    quit(QuitFailure)
glfw.SetWindowUserPointer(window, app)

LinkGLFW3WithBGFX(window)

var appThread: Thread[ptr ExampleHelloWorld]

proc appProc(app: ptr ExampleHelloWorld) {.thread.} =
    # Launch
    app.Init()

    # Update
    while true:
        if tryAcquire(AppLock):
            if not app.m_Updated:
                if app.m_BGFXNeedsToReset:
                    bgfx.Reset(cast[uint16](app.m_width), cast[uint16](app.m_height), app.m_reset)
                    app.m_BGFXNeedsToReset = false
                app.Update()
                app.m_Updated = true
                if app.m_WindowIsClosing:
                    release(AppLock)
                    break
            release(AppLock)
    #We are done
    app.Shutdown()

createThread(appThread, appProc, app)

while appThread.running:
    bgfxplatform.RenderFrame()

    # Do events on main thread and let aux know about them
    glfw.PollEvents()
    acquire(AppLock)
    if app.m_Updated:
        var current_width, current_height: cint
        glfw.GetFramebufferSize(window, current_width.addr, current_height.addr)
        if cast[uint32](current_width) != app.m_width or cast[uint32](current_height) != app.m_height:
            echo "Window resize: ($1, $2)".format(current_width, current_height)
            app.m_width = cast[uint32](current_width)
            app.m_height = cast[uint32](current_height)
            app.m_BGFXNeedsToReset = true
        if glfw.WindowShouldClose(window) != 0:
            app.m_WindowIsClosing = true
        app.m_Updated = false
    release(AppLock)


glfw.DestroyWindow(window)
glfw.Terminate()
