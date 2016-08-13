# nim-bgfx
> [bgfx](https://github.com/bkaradzic/bgfx) graphics library binding and wrapper for the nim programming language.

[bgfx](https://github.com/bkaradzic/bgfx) is a graphics library that has a variety of backends and features.

bgfx's original and primary maintainer is [Branimir Karadzic](https://github.com/bkaradzic).

nim-bgfx's is original and primary maintainer is [Cory Noll Crimmins - Golden](https://github.com/Halsys).

You may contact me([Cory](https://github.com/Halsys)), if you ever face a problem related to this library. However all problems relating to features and internal issues that are a part of bgfx should be taken up with bgfx's community and [Branimir](https://github.com/bkaradzic)

## Notes:
  1. This needs to be beta tested, but is known to work.
  2. This package is missing some convenience methods and objects that might be found in other libs.
  3. All types and functions are availible but are mapped to match the C and CPP equivalents and may work. 
    * The only exception is [dbgTextPrintf](https://github.com/bkaradzic/bgfx/blob/master/include/bgfx/bgfx.h#L1109), I don't know how to wrap this so I made [dbgTextPrintfNim](https://github.com/Halsys/nim-bgfx/blob/master/bgfx/bgfx.nim#L327) as a replacement.
  4. Constants and preproccesor functions from C have been ported but should work as excpected (see **bgfx/constants.nim**)
  5. Should work on all platforms provided that the **.dll**, **.so**, or **.dylib** is availible with your program
  6. Because the bgfx library was programmed with specific integer types in mind **(i.e. uint8/16/32/64_t)**;
    * You have to be incredibley specific because of nims type system (**42'u16**, **100'i32**)
    * You should take care that the bit flags do what you want
    * Convenience functions and objects are being made to mitigate this issue concisely.
    * The CPP-esque methods and functions help with this.
  7. There might be a incompatibility with nims garbage collection system.
  8. This package does not include nim examples(yet), because of that you might have to consult the bgfx documentation and bgfx examples.
    * I'm going to have my project (that uses nim-bgfx) available on github for reference... soon.
  9. This package has the same license as bgfx... for your information.
  10. You are free to send improvements but you should;
    * Make sure it matches how things operate on the C++ or C of the library.
    * Make sure that the code is readable.
    * Note that there is no need to include documentation. (Unless it is necessary)
    * Make sure it works on the latest stable version of nim.
  11. Only [nimrod-glfw](https://github.com/Halsys/nimrod-glfw) is known to hook up correctly with this because it is the only one supplying platform functions.
