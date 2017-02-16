# Package
version     = "0.1.0"
author      = "Cory Noll Crimmins - Golden"
description = "Hello world example for nim-bgfx"
license     = "BSD"
bin         = @["HelloWorld"]
backend     = "c"

# Dependencies
requires "bgfx >= 0.1.0"
requires "nim >= 0.14.2"
requires "glfw >= 3.2.0"
requires "sdl2_nim >= 0.96"
requires "x11 >= 1.0"
