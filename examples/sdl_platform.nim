# Copyright 2017 Cory Noll Crimmins - Golden
# License: BSD-2
# Helper functions for sdl2 platform related code

{.deadCodeElim: on.}

import sdl2/sdl, sdl2/sdl_syswm
import bgfx as bgfx
import bgfx_platform
import strutils

proc GetTime*(): float64 =
    return cast[float64](getPerformanceCounter()*1000) / cast[float64](getPerformanceFrequency())

proc LinkSDL2WithBGFX(window: Window) =
    var pd: ptr PlatformData = create(PlatformData)
    var info: SysWMinfo
    version(info.version)
    assert getWindowWMInfo(window, addr(info))
    echo "SDL2 version: $1.$2.$3 - Subsystem: $4".format(info.version.major.int, info.version.minor.int, info.version.patch.int, info.subsystem)
    case(info.subsystem):
        of SysWM_Windows:
            when defined(windows):
                pd.nwh = cast[pointer](info.info.win.window)
            pd.ndt = nil
        of SysWM_X11:
            when defined(linux):
                pd.nwh = cast[pointer](info.info.x11.window)
                pd.ndt = cast[pointer](info.info.x11.display)
        of SysWM_Cocoa:
            when defined(osx):
                pd.nwh = cast[pointer](info.info.cocoa.window)
            pd.ndt = nil
        else:
            echo "[SDL2] failed to get handle: $1".format(sdl.getError())
            raise newException(OSError, "No structure for subsystem type")

    pd.backBuffer = nil
    pd.backBufferDS = nil
    pd.context = nil
    SetPlatformData(pd)

proc StartExample*[Example]() =
    var app: Example = Example()

    if init(0) != 0:
        echo "[SDL2] Failed to initialize!"
        quit(QuitFailure)

    var window: Window
    window = createWindow("",
                WINDOWPOS_UNDEFINED, WINDOWPOS_UNDEFINED,
                1280, 720,
                WINDOW_SHOWN or WINDOW_RESIZABLE)
    if window == nil:
        echo "[SDL2] Failed to create window!"
        quit(QuitFailure)

    LinkSDL2WithBGFX(window)

    app.Start()

    var evt: sdl.Event

    while true:
        while sdl.pollEvent(evt.addr) == 1:
            if(evt.kind == sdl.Quit):
                break
            elif(evt.kind == sdl.WINDOWEVENT):
                var windowEvent = cast[WindowEventObj](evt.addr)
                var current_width, current_height: cint
                sdl.glGetDrawableSize(window, current_width.addr, current_height.addr)
                if cast[uint32](current_width) != app.m_width or cast[uint32](current_height) != app.m_height:
                    echo "Window resize: ($1, $2)".format(current_width, current_height)
                    app.m_width = cast[uint32](current_width)
                    app.m_height = cast[uint32](current_height)
                    app.m_window_width = cast[uint32](windowEvent.data1)
                    app.m_window_height = cast[uint32](windowEvent.data2)
                    bgfx.Reset(cast[uint16](app.m_window_width), cast[uint16](app.m_window_height), app.m_reset)
        app.Update()

    app.CleanUp()

    destroyWindow(window)
    sdl.quit()
