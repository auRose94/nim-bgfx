# nim-bgfx
> [bgfx](https://github.com/bkaradzic/bgfx) graphics library binding and wrapper for the nim programming language.    [![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=96STXBG8HMW2E)

[bgfx](https://github.com/bkaradzic/bgfx) is a rendering library that has a variety of graphics backends supported and a bunch of other neat features.
  * Supported backends; Direct3D 9, Direct3D 11, Direct3D 12 (WIP), Metal (WIP), Vulkan(WIP) OpenGL 2.1, OpenGL 3.1+, OpenGL ES 2, OpenGL ES 3.1, WebGL 1.0, and WebGL 2.0
  * Other features include occlusion querying, compute shader programs, draw and compute bucket sorting, conversion to compressed formats, and more.

bgfx's original and primary maintainer is [Branimir Karadzic](https://github.com/bkaradzic).

nim-bgfx's is original and primary maintainer is [Cory Noll Crimmins - Golden](https://github.com/Halsys).

You may contact me([Cory](https://github.com/Halsys)), if you ever face a problem related to this library. However all problems relating to features and internal issues that are a part of bgfx should be taken up with bgfx's community and [Branimir](https://github.com/bkaradzic)

## Notes:
  1. This needs to be beta tested, but is known to work(examples included).
  2. This package has all of the C functions, macros, and types
  3. Compiles bgfx right out of the box (provided it is supported).
  4. Because the bgfx library was programmed with specific types in mind **(i.e. uint8/16/32/64_t and float)**. You have to be incredibly specific because of nims type system (**42'u16**, **100'i32**, **1.0'f32**)
  5. This package does include nim examples.
  6. This package has the same license as bgfx... for your information.
  7. You are free to send improvements but you should;
    * Make sure it matches how things operate on the C++ or C of the library.
    * Make sure that the code is readable.
    * Documentation is optional, but would be nice.
    * Make sure it works on the latest version of nim.
  8. Currently two window managing libraries work with this package; [nimrod-glfw](https://github.com/rafaelvasco/nimrod-glfw) and [sdl2_nim](https://github.com/Vladar4/sdl2_nim) (with varying results).
  9. Compiling bgfx so far works on Linux and OSX... maybe untested on other platforms.
  10. Building bgfx on Windows is untested.
  11. Building bgfx in Javascript is untested.
  12. Works on amd64, untested on other architechures.
