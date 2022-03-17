module Main where

import ClassyPrelude
import Katip

main :: IO ()
main = runKatip

runKatip :: IO ()
runKatip = withKatip $ \le ->
  runKatipContextT le () mempty logSomething

withKatip :: (LogEnv -> IO a) -> IO a
withKatip app =
  bracket createLogEnv closeScribes app
  where
    permitEverything = const $ return True
    createLogEnv = do
      logEnv <- initLogEnv "Playground" "dev"
      stdoutScribe <- mkHandleScribe ColorIfTerminal stdout permitEverything V2
      registerScribe "stdout" stdoutScribe defaultScribeSettings logEnv

logSomething :: (KatipContext m) => m ()
logSomething = do
  $(logTM) InfoS "Log in no namespace"
  katipAddNamespace "ns1" $
    $(logTM) InfoS "Log in ns1"
  katipAddNamespace "ns2" $ do
    $(logTM) WarningS "Log in ns2"
    katipAddNamespace "ns3" $
      katipAddContext (sl "userId" $ asText "12") $ do
        $(logTM) InfoS "Log in ns2.ns3 with userId context"
        katipAddContext (sl "country" $ asText "Singapore") $
          $(logTM) InfoS "Log in ns2.ns3 with userId and country context"
