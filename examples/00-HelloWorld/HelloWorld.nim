# Copyright 2017 Cory Noll Crimmins - Golden
# License: BSD-2
# Port of bgfx helloworld example 00 to nim and nim-bgfx

import bgfx.bgfx
when defined(useSDL):
    import ../sdl_platform
elif defined(useGLFW) or not defined(useSDL):
    import ../glfw_platform
import parseopt2
import strutils
import locks
import os
include Logo

proc `/`(x, y: uint16): uint16 =
    x div y

type ExampleHelloWorld = ref object
    m_width*: uint32
    m_height*: uint32
    m_window_width*: uint32
    m_window_height*: uint32
    m_debug*: uint32
    m_reset*: uint32

proc Start(self: ExampleHelloWorld) =
    self.m_width = 1280
    self.m_height = 720
    self.m_window_width = 1280
    self.m_window_height = 720
    self.m_debug = BGFX_DEBUG_TEXT #or BGFX_DEBUG_STATS
    self.m_reset = BGFX_RESET_VSYNC

    #Seperate Thread
    #bgfxplatform.RenderFrame()
    bgfx.Init()
    bgfx.Reset(self.m_width, self.m_height, self.m_reset)

    # Enable Debug Text
    bgfx.SetDebug(self.m_debug)

    # Set view 0 clear state
    bgfx.SetViewClear(0, BGFX_CLEAR_COLOR or BGFX_CLEAR_DEPTH, 0x303030ff, 1.0, 0)

proc CleanUp(self: ExampleHelloWorld) =
    bgfx.Shutdown()

proc Update(self: ExampleHelloWorld) =
    # Set view 0 default viewport
    bgfx.SetViewRect(0, 0, 0, cast[uint16](self.m_width), cast[uint16](self.m_height))

    # This dummy draw call is here to make sure that view 0 is cleared
    # if no other draw calls are submitted to view 0.
    bgfx.Touch(0)

    # Use debug font to print information about this example.
    bgfx.DebugTextClear()
    bgfx.DebugTextImage(max(cast[uint16](self.m_window_width) / 2'u16 / 8'u16, 20'u16) - 20'u16,
                      max(cast[uint16](self.m_window_height) / 2'u16 / 16'u16, 6'u16) - 6'u16,
                      40,
                      12,
                      s_logo.addr,
                      160
                      )
    bgfx.DebugTextPrintf(0, 1, 0x4f, "nim-bgfx/examples/00-HelloWorld")
    bgfx.DebugTextPrintf(0, 2, 0x6f, "Description: Initialization and debug text.")

    bgfx.DebugTextPrintf(0, 4, 0x0f, "Color can be changed with ANSI \x1b[9;me\x1b[10;ms\x1b[11;mc\x1b[12;ma\x1b[13;mp\x1b[14;me\x1b[0m code too.")

    bgfx.Frame()

StartExample[ExampleHelloWorld]()
