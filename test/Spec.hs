{-# LANGUAGE TemplateHaskell #-}

import Test.Hspec

import Codec.Picture as JP
import qualified Data.ByteString
import Data.FileEmbed

import Vision.Image.JuicyPixels


rgba8Png :: Data.ByteString.ByteString
rgba8Png = $(embedFile "test/rgba8.png")


main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "RGBA conversion" $ do
    it "should not modify the image when converting from Juicy to Friday and back" $
        let result = decodeImage rgba8Png in case result of
            Right (ImageRGBA8 img) ->
                let fridayImg    = toFridayRGBA img
                    juicyImg     = toJuicyRGBA fridayImg
                    orig         = encodeDynamicPng $ ImageRGBA8 img
                    converted    = encodeDynamicPng $ ImageRGBA8 juicyImg
                in  orig `shouldBe` converted
            Left _ -> error "Image decoding error"
            _      -> error "Unexpected color space"
