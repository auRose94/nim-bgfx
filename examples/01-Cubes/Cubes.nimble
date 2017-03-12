# Package
version     = "0.1.0"
author      = "Cory Noll Crimmins - Golden"
description = "Cubes example for nim-bgfx"
license     = "BSD"
bin         = @["Cubes"]
backend     = "c"

# Dependencies
requires "bgfx >= 0.1.0"
requires "nim >= 0.14.2"
requires "glfw >= 3.2.0"
requires "sdl2_nim >= 0.9.6"
