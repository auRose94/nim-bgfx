# Copyright 2016 Cory Noll Crimmins - Golden
# License: BSD-2
# Helper functions for platform related code

{.deadCodeElim: on.}

import locks
import glfw3 as glfw
import bgfx, bgfxplatform
import strutils

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

proc GLFWErrorCB(errorCode: cint; description: cstring) {.cdecl.} =
    debugEcho "[GLFW3] error: $1, $2".format(errorCode, description)

proc LinkGLFW3WithBGFX(window: Window) =
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

var ExampleLock*: Lock

proc StartExample*[Example]() =
    var app: ptr Example = createShared(Example)
    app[] = Example()
    initLock(ExampleLock)
    assert(not app.isNil)

    # Set up
    discard glfw.SetErrorCallback(GLFWErrorCB)

    if glfw.Init() != glfw.TRUE:
        echo "[GLFW3] Failed to initialize!"
        quit(QuitFailure)

    glfw.WindowHint(glfw.CLIENT_API, glfw.NO_API)
    var window: Window
    window = glfw.CreateWindow(1280, 720, "Cubes", nil, nil)
    if window == nil:
        echo "[GLFW3] Failed to create window!"
        quit(QuitFailure)
    glfw.SetWindowUserPointer(window, app)

    LinkGLFW3WithBGFX(window)

    var appThread: Thread[ptr Example]

    proc appProc(app: ptr Example) {.thread.} =
        # Launch
        app.Init()

        # Update
        while true:
            {.locks: [ExampleLock].}:
                if not app.m_Updated:
                    if app.m_BGFXNeedsToReset:
                        bgfx.Reset(cast[uint16](app.m_width), cast[uint16](app.m_height), app.m_reset)
                        app.m_BGFXNeedsToReset = false
                    app.Update()
                    app.m_Updated = true
                    if app.m_WindowIsClosing:
                        break
        #We are done
        app.CleanUp()

    createThread(appThread, appProc, app)

    while appThread.running:
        bgfxplatform.RenderFrame()

        # Do events on main thread and let aux know about them
        glfw.PollEvents()
        {.locks: [ExampleLock].}:
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

    glfw.DestroyWindow(window)
    glfw.Terminate()
