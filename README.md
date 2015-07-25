# friday-juicypixels

This library facilitates conversion between [friday](https://github.com/RaphaelJ/friday)
(an all-Haskell image manipulation library) and
[JuicyPixels](https://github.com/Twinside/Juicy.Pixels) (an all-Haskell encoder/decoder
library for many image formats). Combining these two libraries is useful for adding basic
image manipulation capabilities of many image formats to a Haskell application without
requiring any C libraries/headers to be installed.

**NOTE:** Expect this library's API to break, as it is still very young.


### Compared to `friday-devil`

The `friday-devil` package provides a storage backend to `friday` by calling the
[DevIL](https://github.com/DentonW/DevIL) library. It is much more mature, and probably
a lot faster (though benchmarks have yet to prove this).

This package is not in the spirit of `friday-devil` which is a more native bridge than
conversion .  As such, it should probabably be called something different like
`juicy-friday`.


### TODO

* Make it into a storage backend that automatically converts all formats and
  color spaces supported by `JuicyPixels` to the internal representations
  supported by `friday`.
* Add some benchmarks. Include `friday-devil` and ImageMagik.
* Add more specs.

Done:

* Conversion between JP and Friday for cheap using `coerce` and `unsafeCoerce`, yay!
* Basic test suite.


### License

Released under a 3-clause BSD license.

