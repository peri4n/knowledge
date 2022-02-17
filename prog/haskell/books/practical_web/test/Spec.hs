import ClassyPrelude
import Test.Hspec
import Domain.Validation
import Text.Regex.PCRE.Heavy

main :: IO ()
main = hspec $ do
  describe "Validations" $ do
    it "lengthBetween" $ do
      lengthBetween 1 5 "err" ("12345"::Text) `shouldBe` Nothing
      lengthBetween 1 5 "err" ("123456"::Text) `shouldBe` Just "err"
    it "regexMatches" $ do
      regexMatches [re|^hello|] "err" "hello world" `shouldBe` Nothing
      regexMatches [re|^hello|] "err" "failed world" `shouldBe` Just "err"
    it "validate" $ do
      let mustContainA = regexMatches [re|A|] "Must contain 'A'"
      let mustContainB = regexMatches [re|B|] "Must contain 'B'"
      validate id [mustContainA, mustContainB] "abc" `shouldBe` Left ["Must contain 'A'", "Must contain 'B'"]
      validate id [mustContainA, mustContainB] "ABc" `shouldBe` Right "ABc"

