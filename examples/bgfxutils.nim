# Copyright 2016 Cory Noll Crimmins - Golden
# License: BSD-2
# Port for bgfx utilities

import bgfx

proc LoadMemory*(path: string): ptr bgfx.Memory =
    var file: File
    if open(file, path):
        var size = getFileSize(file)
        var mem = bgfx.Alloc(cast[uint32](size+1))
        assert size == readBuffer(file, mem.data, size)
        close(file)
        let memoryEnd: ptr uint8 = cast[ptr uint8](cast[int](mem.data) + cast[int](size))
        memoryEnd[] = cast[uint8]('\0')
        return mem
    return nil

proc LoadShader*(name: string): bgfx.ShaderHandle =
    var path = "./"
    case bgfx.GetRendererType()
    of bgfx.RendererType_Direct3D11, bgfx.RendererType_Direct3D12:
        path &= "shaders/dx11/"
    of bgfx.RendererType_OpenGL:
        path &= "shaders/glsl/"
    of bgfx.RendererType_OpenGLES:
        path &= "shaders/gles/"
    of bgfx.RendererType_Metal:
        path &= "shaders/metal/"
    of bgfx.RendererType_Gnm:
        path &= "shaders/gnm/"
    of bgfx.RendererType_Vulkan:
        path &= "shaders/vk/" # I'm guessing
    of bgfx.RendererType_Direct3D9:
        path &= "shaders/dx9/"
    of RendererType_Noop, RendererType_Count:
        raise newException(SystemError, "Invalid bgfx renderer type")
    path &= name & ".bin"
    return bgfx.CreateShader(LoadMemory(path))

proc LoadProgram*(vertName: string, fragName: string): bgfx.ProgramHandle =
    return bgfx.CreateProgram(LoadShader(vertName), LoadShader(fragName), true)

proc LoadProgram*(compName: string): bgfx.ProgramHandle =
    return bgfx.CreateProgram(LoadShader(compName), true)
