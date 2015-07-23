{-# LANGUAGE ViewPatterns #-}
module Vision.Image.JuicyPixels where

import Vision.Image
import Vision.Image.Storage.DevIL
import Vision.Primitive
import Codec.Picture as JP
import Codec.Picture.Types as JP
import Data.Coerce
import Unsafe.Coerce

convertTest :: FilePath -> FilePath -> IO ()
convertTest fp fp2 =
 do x <- readImage fp
    case x of
        Right (ImageYCbCr8 y) -> save JPG fp2 (toFridayRGB (JP.convertImage y :: JP.Image PixelRGB8)) >> return ()
        _ -> error "foo"

toFridayGrey :: JP.Image Pixel8 -> Grey
toFridayGrey (JP.Image w h vec) = Manifest (Z :. h :. w) (coerce vec)

toJuicyGrey :: Grey -> JP.Image Pixel8
toJuicyGrey (compute -> Manifest (Z :. h :. w) vec) = JP.Image w h (coerce vec)

toFridayRGB :: JP.Image PixelRGB8 -> RGB
toFridayRGB (JP.Image w h vec) = Manifest (Z :. h :. w) (unsafeCoerce vec)

toJuicyRGB :: RGB -> JP.Image PixelRGB8
toJuicyRGB (compute -> Manifest (Z :. h :. w) vec) = JP.Image w h (unsafeCoerce vec)

toFridayRGBA :: JP.Image PixelRGBA8 -> RGB
toFridayRGBA (JP.Image w h vec) = Manifest (Z :. h :. w) (unsafeCoerce vec)

toJuicyRGBA :: RGBA -> JP.Image PixelRGBA8
toJuicyRGBA (compute -> Manifest (Z :. h :. w) vec) = JP.Image w h (unsafeCoerce vec)
