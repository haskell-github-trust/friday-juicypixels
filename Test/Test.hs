import Vision.Image
import Vision.Image.Storage.DevIL
import Codec.Picture as JP
import Codec.Picture.Types as JP

convertTest :: FilePath -> FilePath -> IO ()
convertTest fp fp2 =
 do x <- readImage fp
    case x of
        Right (ImageYCbCr8 y) -> save JPG fp2 (toFridayRGB (JP.convertImage y :: JP.Image PixelRGB8)) >> return ()

