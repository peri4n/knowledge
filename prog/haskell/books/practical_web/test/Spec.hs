import ClassyPrelude
import Test.Hspec
import Domain.ValidationSpec
import Domain.AuthSpec
import Text.Regex.PCRE.Heavy

main :: IO ()
main = do
  validationSpec
  authSpec
