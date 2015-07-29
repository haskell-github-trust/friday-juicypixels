{-# LANGUAGE ViewPatterns #-}

module Vision.Image.JuicyPixels where

import Vision.Image
import Vision.Primitive
import Codec.Picture as JP
import Foreign.ForeignPtr
import Data.Vector.Storable as V

fcast :: Vector (PixelBaseComponent Pixel8) -> Vector GreyPixel
fcast v = unsafeFromForeignPtr (castForeignPtr fp) o l where (fp,o,l) = unsafeToForeignPtr v

jcast :: Vector GreyPixel -> Vector (PixelBaseComponent Pixel8)
jcast v = unsafeFromForeignPtr (castForeignPtr fp) o l where (fp,o,l) = unsafeToForeignPtr v

-- XXX friday is 4 bytes per elem (1/4 the elem) while JP is 1 byte per
-- elem for 4x the length!  We can make fcast total at
-- the cost of an O(n) copy.  Do so and document.
jcastRGBA :: Vector RGBAPixel -> Vector (PixelBaseComponent PixelRGBA8)
jcastRGBA v = unsafeFromForeignPtr (castForeignPtr fp) (4*o) (4*l) where (fp,o,l) = unsafeToForeignPtr v

fcastRGBA :: Vector (PixelBaseComponent PixelRGBA8) -> Vector RGBAPixel
fcastRGBA v
    | o `rem` 4 /= 0 = error "Can not cast a JuicyPixel image constructed via a vector with non zero offset (mod 4)."
    | otherwise = unsafeFromForeignPtr (castForeignPtr fp) (o`div`4) (l`div`4)
 where (fp,o,l) = unsafeToForeignPtr v

jcastRGB :: Vector RGBPixel -> Vector (PixelBaseComponent PixelRGB8)
jcastRGB v = unsafeFromForeignPtr (castForeignPtr fp) (3*o) (3*l) where (fp,o,l) = unsafeToForeignPtr v

fcastRGB :: Vector (PixelBaseComponent PixelRGB8) -> Vector RGBPixel
fcastRGB v
    | o `rem` 3 /= 0 = error "Can not cast a JuicyPixel image constructed via a vector with non zero offset (mod 3)."
    | otherwise = unsafeFromForeignPtr (castForeignPtr fp) (o`div`3) (l`div`3)
 where (fp,o,l) = unsafeToForeignPtr v

toFridayGrey :: JP.Image Pixel8 -> Grey
toFridayGrey (JP.Image w h vec) =
    Manifest (Z :. h :. w) (fcast vec)

toJuicyGrey :: Grey -> JP.Image Pixel8
toJuicyGrey (compute -> Manifest (Z :. h :. w) vec) =
    JP.Image w h (jcast vec)

toFridayRGB :: JP.Image PixelRGB8 -> RGB
toFridayRGB (JP.Image w h vec) =
    Manifest (Z :. h :. w) (fcastRGB vec)

toJuicyRGB :: RGB -> JP.Image PixelRGB8
toJuicyRGB (compute -> Manifest (Z :. h :. w) vec) =
    JP.Image w h (jcastRGB vec)

toFridayRGBA :: JP.Image PixelRGBA8 -> RGBA
toFridayRGBA (JP.Image w h vec) =
    Manifest (Z :. h :. w) (fcastRGBA vec)

toJuicyRGBA :: RGBA -> JP.Image PixelRGBA8
toJuicyRGBA (compute -> Manifest (Z :. h :. w) vec) =
    JP.Image w  h (jcastRGBA vec)
