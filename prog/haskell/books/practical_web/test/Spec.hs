import ClassyPrelude
import Test.Hspec
import Domain.ValidationSpec
import Adapter.InMemory.AuthSpec
import Domain.AuthSpec
import Text.Regex.PCRE.Heavy

main :: IO ()
main = do
  validationSpec
  authSpec
  inMemAdapterSpec
