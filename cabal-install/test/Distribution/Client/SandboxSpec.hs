module Distribution.Client.SandboxSpec (main, spec) where

import Test.Hspec

import Distribution.Client.Sandbox

import Control.Applicative
import System.FilePath (getSearchPath)

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "withSandboxBinDirOnSearchPath" $ do
    it "temporarily adds $SANDBOX_DIR/bin to $PATH" $ do
      withSandboxBinDirOnSearchPath "foo" $ do
        r <- getSearchPath
        r `shouldSatisfy` elem "foo/bin"

    it "restores the original PATH after executing the action" $ do
      r <- getSearchPath
      withSandboxBinDirOnSearchPath "foo" (pure ())
      getSearchPath `shouldReturn` r
