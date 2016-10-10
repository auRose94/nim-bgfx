# Copyright 2016 Cory Noll Crimmins - Golden
# License: BSD-2
# Port of bgfx helloworld example 00 to nim and nim-bgfx

import bgfx
import glfw3 as glfw
import ../platform
import parseopt2
import strutils
import locks
import os
include logo

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

proc CleanUp(self: ptr ExampleHelloWorld) {.thread.} =
    bgfx.Shutdown()

proc Update(self: ptr ExampleHelloWorld) {.thread.} =
    # Set view 0 default viewport
    bgfx.SetViewRect(0, 0, 0, cast[uint16](self.m_width), cast[uint16](self.m_height))

    # This dummy draw call is here to make sure that view 0 is cleared
    # if no other draw calls are submitted to view 0.
    bgfx.Touch(0)

    # Use debug font to print information about this example.
    bgfx.DebugTextClear()
    bgfx.DebugTextImage(max(cast[uint16](self.m_width) / 2'u16 / 8'u16, 20'u16) - 20'u16,
                      max(cast[uint16](self.m_height) / 2'u16 / 16'u16, 6'u16) - 6'u16,
                      40,
                      12,
                      s_logo.addr,
                      160
                      )
    bgfx.DebugTextPrintf(0, 1, 0x4f, "nim-bgfx/examples/00-HelloWorld")
    bgfx.DebugTextPrintf(0, 2, 0x6f, "Description: Initialization and debug text.")

    bgfx.Frame()

StartExample[ExampleHelloWorld]()
