module Domain.AuthSpec where

import ClassyPrelude
import Test.Hspec
import Domain.Auth

authSpec :: IO ()
authSpec = hspec $ do

  describe "Domain.Auth" $ do

    it "mkEmail" $ do
      mkEmail "test" `shouldBe` Left ["Not a valid email"]
      mkEmail "test@example.com" `shouldBe` Right (Email "test@example.com")

    it "mkPassword" $ do
      mkPassword "ABC" `shouldBe` Left ["Length should be between 5 and 50", "Should contain number", "Should contain lowercase letter"]
      mkPassword "1234ABCef" `shouldBe` Right (Password "1234ABCef")
