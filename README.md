# nim-bgfx
BGFX wrapper for the nim programming language.

## Notes:
  1. This needs to be beta tested.
  2. This package is missing some convenience methods and objects that might be found in other libs.
  3. All types and functions are availible but are mapped to match the C equivalents and may work. 
  4. Constants and preproccesor functions from C have been ported but should work as excpected (see **bgfx/constaints.nim**)
  5. Should work on all platforms provided that the **.dll**, **.so**, or **.dylib** is availible with your program
  6. Because the bgfx library was programmed with specific integer types in mind **(i.e. uint8/16/32/64_t)**;
  ..* You have to be incredibley specific because of nims type system (42'u16, 100'i32)
  ..* You should take care that the bit flags do what you want
  ..* Convenience functions and objects are being made to mitigate this issue concisely.
  7. There might be a incompatibility with nims garbage collection system.
  ..* Try not to pass references to bgfx (Untested and avoided until a later date)
  ..* Pointers should be okay but the functions that use them may not have been fully tested to check to see if they work as expected.
  8. This package does not include nim examples(yet), because of that you might have to consult the bgfx documentation and C bgfx examples.
  ..* I'm going to have my project (that uses nim-bgfx) available on github for reference... soon.
  9. This package has the same license as bgfx... for your information.
  10. You are free to send improvements but you should;
  ..* Make sure it matches how things operate on the C++ or C of the library.
  ..* Make sure that the code is readable.
  ..* Note that there is no need to include documentation. (Unless it is necessary)
  ..* Make sure it works on the latest stable version of nim.
