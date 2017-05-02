# Copyright 2017 Cory Noll Crimmins - Golden
# License: BSD-2
# Helper functions for sdl2 platform related code

{.deadCodeElim: on.}

when defined(macosx):
  type
    SysWMinfoCocoaObj = object
        window: pointer ## The Cocoa window

    SysWMinfoKindObj = object
        cocoa: SysWMinfoCocoaObj

import sdl2.sdl, sdl2.sdl_syswm
import bgfx.bgfx
import bgfx.platform
import strutils

proc GetTime*(): float64 =
    return (float64(getPerformanceCounter()) * 1000'f64) / float64(getPerformanceFrequency())

proc LinkSDL2WithBGFX(window: Window) =
    var pd: PlatformData = PlatformData()
    var info: SysWMinfo
    version(info.version)
    if(sdl_syswm.getWindowWMInfo(window, addr(info)) != true):
        raise newException(Exception, "Failed to get system info")
    echo "SDL2 version: $1.$2.$3 - Subsystem: $4".format(info.version.major.int, info.version.minor.int, info.version.patch.int, info.subsystem)
    pd.backBuffer = nil
    pd.backBufferDS = nil
    pd.context = nil
    pd.session = nil
    pd.ndt = nil
    case(info.subsystem):
        of SysWM_Windows:
            when defined(windows) and defined(SDL_VIDEO_DRIVER_WINDOWS):
                pd.nwh = cast[pointer](info.info.win.window)
        of SysWM_X11:
            when defined(linux) and defined(SDL_VIDEO_DRIVER_X11):
                pd.nwh = cast[pointer](info.info.x11.window)
                pd.ndt = cast[pointer](info.info.x11.display)
        of SysWM_Cocoa:
            when defined(macosx):
                pd.nwh = (cast[SysWMinfoKindObj](info.info)).cocoa.window
        else:
            raise newException(Exception, "No structure for subsystem type")
    if(pd.nwh == nil):
        raise newException(Exception, "Failed to get platform handle for window")
    platform.SetPlatformData(addr(pd))

proc StartExample*[Example]() =
    var app: Example = Example()

    if sdl.init(0) != 0:
        raise newException(Exception, "Failed to initialize SDL2")

    var window: Window
    window = sdl.createWindow("",
                WINDOWPOS_UNDEFINED, WINDOWPOS_UNDEFINED,
                1280, 720,
                WINDOW_SHOWN or WINDOW_RESIZABLE or WINDOW_ALLOW_HIGHDPI)
    if window == nil:
        raise newException(Exception, "Failed to create window")

    LinkSDL2WithBGFX(window)

    app.Start()

    var evt: sdl.Event

    var quit = false
    while not quit:
        while sdl.pollEvent(evt.addr) == 1:
            if(evt.kind == sdl.Quit):
                quit = true
            elif(evt.kind == sdl.WINDOWEVENT):
                case evt.window.event
                of WINDOWEVENT_SIZE_CHANGED:
                    var current_width, current_height: cint
                    sdl.glGetDrawableSize(window, current_width.addr, current_height.addr)
                    if cast[uint32](current_width) != app.m_width or cast[uint32](current_height) != app.m_height:
                        echo "Window resize: ($1, $2)".format(current_width, current_height)
                        app.m_width = cast[uint32](current_width)
                        app.m_height = cast[uint32](current_height)
                    app.m_window_width = cast[uint32](evt.window.data1)
                    app.m_window_height = cast[uint32](evt.window.data2)
                    bgfx.Reset(cast[uint16](app.m_window_width), cast[uint16](app.m_window_height), app.m_reset)
                of WINDOWEVENT_CLOSE:
                    quit = true
                else: discard
        app.Update()

    app.CleanUp()

    sdl.destroyWindow(window)
    sdl.quit()
