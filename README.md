# nim-bgfx
> [bgfx](https://github.com/bkaradzic/bgfx) graphics library binding and wrapper for the nim programming language.

[bgfx](https://github.com/bkaradzic/bgfx) is a rendering library that has a variety of graphics backends supported and a bunch of other neat features.
  * Supported backends; Direct3D 9, Direct3D 11, Direct3D 12 (WIP), Metal (WIP), OpenGL 2.1, OpenGL 3.1+, OpenGL ES 2, OpenGL ES 3.1, WebGL 1.0, and WebGL 2.0
  * Other features include occlusion querying, compute shader programs, draw and compute bucket sorting, conversion to compressed formats, and more.

bgfx's original and primary maintainer is [Branimir Karadzic](https://github.com/bkaradzic).

nim-bgfx's is original and primary maintainer is [Cory Noll Crimmins - Golden](https://github.com/Halsys).

You may contact me([Cory](https://github.com/Halsys)), if you ever face a problem related to this library. However all problems relating to features and internal issues that are a part of bgfx should be taken up with bgfx's community and [Branimir](https://github.com/bkaradzic)

## Notes:
  1. This needs to be beta tested, but is known to work(examples included).
  2. This package is missing some convenience methods and objects that might be found in other libs.
  3. All types and functions are available but are mapped to match the C and C++ equivalents and should work.
  4. Constants and preprocessor functions from C have been ported but should work as expected (see **bgfx/constants.nim**)
  5. Should work on all platforms provided that the **.dll**, **.so**, or **.dylib** is available with your program
  6. Because the bgfx library was programmed with specific types in mind **(i.e. uint8/16/32/64_t and float)**;
    * You have to be incredibly specific because of nims type system (**42'u16**, **100'i32**, **1.0'f32**)
    * The C++ style methods and functions help with this.
  7. There might be a incompatibility with nims garbage collection system.
  8. This package does include nim examples.
  9. This package has the same license as bgfx... for your information.
  10. You are free to send improvements but you should;
    * Make sure it matches how things operate on the C++ or C of the library.
    * Make sure that the code is readable.
    * Note that there is no need to include documentation. (Unless necessary)
    * Make sure it works on the latest stable version of nim.
  11. Only [nimrod-glfw](https://github.com/Halsys/nimrod-glfw) is known to hook up correctly with this because it is the only one supplying platform functions.
