# Copyright 2017 Cory Noll Crimmins - Golden
# License: BSD-2
# Helper functions for glfw platform related code

{.deadCodeElim: on.}

import glfw3 as glfw
import bgfx.bgfx, bgfx.platform
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

proc GetTime*(): float64 =
    return cast[float64](glfw.GetTime())

proc GLFWErrorCB(errorCode: cint; description: cstring) {.cdecl.} =
    debugEcho "[GLFW3] error: $1, $2".format(errorCode, description)

proc LinkGLFW3WithBGFX(window: Window) =
    var pd: PlatformData = PlatformData()
    when defined(Windows):
        pd.nwh = glfwn.GetWin32Window(window)
    elif defined(MacOSX):
        pd.nwh = glfwn.GetCocoaWindow(window)
    elif defined(Linux) or
        defined(FreeBSD) or
        defined(OpenBSD) or
        defined(NetBSD) or
        defined(Solaris) or
        defined(QNX):
        pd.nwh = cast[pointer](glfwn.GetX11Window(window))
        pd.ndt = glfwn.GetX11Display()
    else:
        {.fatal: "Exposure of glfw3native functions is required".}

    SetPlatformData(addr(pd))

proc StartExample*[Example]() =
    var app: Example = Example()

    # Set up
    discard glfw.SetErrorCallback(GLFWErrorCB)

    if glfw.Init() != glfw.TRUE:
        raise newException(Exception, "Failed to initialize GLFW3")

    glfw.WindowHint(glfw.CLIENT_API, glfw.NO_API)
    var window: Window
    window = glfw.CreateWindow(1280, 720, "", nil, nil)
    if window == nil:
        raise newException(Exception, "Failed to create window")
    glfw.SetWindowUserPointer(window, app.addr)

    LinkGLFW3WithBGFX(window)

    app.Start()

    var quit = false
    while not quit:
        glfw.PollEvents()
        var current_width, current_height: cint
        var current_window_width, current_window_height: cint
        glfw.GetFramebufferSize(window, current_width.addr, current_height.addr)
        glfw.GetWindowSize(window, current_window_width.addr, current_window_height.addr)
        if cast[uint32](current_width) != app.m_width or cast[uint32](current_height) != app.m_height:
            echo "Window resize: ($1, $2)".format(current_width, current_height)
            app.m_width = cast[uint32](current_width)
            app.m_height = cast[uint32](current_height)
            app.m_window_width = cast[uint32](current_window_width)
            app.m_window_height = cast[uint32](current_window_height)
            bgfx.Reset(cast[uint16](app.m_window_width), cast[uint16](app.m_window_height), app.m_reset)
        if glfw.WindowShouldClose(window) != 0:
            quit = true
        app.Update()

    app.CleanUp()

    glfw.DestroyWindow(window)
    glfw.Terminate()
