import ClassyPrelude
import Test.Hspec
import Domain.ValidationSpec
import Text.Regex.PCRE.Heavy
import Domain.AuthSpec

main :: IO ()
main = do
  validationSpec
  authSpec
