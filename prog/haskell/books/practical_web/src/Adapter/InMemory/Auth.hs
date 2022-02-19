module Adapter.InMemory.Auth where

import ClassyPrelude
import Control.Monad.Except
import Data.Has
import Domain.Auth
import qualified Domain.Auth as D
import Text.StringRandom

data State = State
  { stateAuths :: [(D.UserId, D.Auth)],
    stateUnverifiedEmails :: Map D.VerificationCode D.Email,
    stateVerifiedEmails :: Set D.Email,
    stateUserIdCounter :: Int,
    stateNotifications :: Map D.Email D.VerificationCode,
    stateSessions :: Map D.SessionId D.UserId
  }
  deriving (Show, Eq)

initialState :: State
initialState =
  State
    { stateAuths = [],
      stateUnverifiedEmails = mempty,
      stateVerifiedEmails = mempty,
      stateUserIdCounter = 0,
      stateNotifications = mempty,
      stateSessions = mempty
    }

type InMemory r m = (Has (TVar State) r, MonadReader r m, MonadIO m)

addAuth :: InMemory r m => Auth -> m (Either RegistrationError VerificationCode)
addAuth auth = do
  tvar <- asks getter

  -- gen verification code
  vCode <- liftIO $ stringRandomIO "[A-Za-z0-9]{16}"
  atomically . runExceptT $ do
    state <- lift $ readTVar tvar

    -- check whether the given email is duplicate
    let auths = stateAuths state
        email = D.authEmail auth
        isDuplicate = any ((email ==) . (D.authEmail . snd)) auths
    when isDuplicate $ throwError D.RegistrationErrorEmailTaken

    -- update the state
    let newUserId = stateUserIdCounter state + 1
        newAuths = (newUserId, auth) : auths
        unverifieds = stateUnverifiedEmails state
        newUnverifieds = insertMap vCode email unverifieds
        newState = state { stateAuths = newAuths
          , stateUserIdCounter = newUserId
          , stateUnverifiedEmails = newUnverifieds }
    lift $ writeTVar tvar newState
    return vCode

setEmailAsVerified :: InMemory r m => VerificationCode -> m (Either EmailVerificationError ())
setEmailAsVerified vCode = do
  tvar <- asks getter
  atomically . runExceptT $ do
    state <- lift $ readTVar tvar
    let unverifieds = stateUnverifiedEmails state
        verifieds = stateVerifiedEmails state
        mayEmail = lookup vCode unverifieds
    case mayEmail of
      Nothing -> throwError D.EmailVerificationErrorInvalidCode
      Just email -> do
        let newUnverifieds = deleteMap vCode unverifieds
            newVerifieds = insertSet email verifieds
            newState =
              state
                { stateUnverifiedEmails = newUnverifieds,
                  stateVerifiedEmails = newVerifieds
                }
        lift $ writeTVar tvar newState

findUserByAuth :: InMemory r m => Auth -> m (Maybe (UserId, Bool))
findUserByAuth auth = do
  tvar <- asks getter
  state <- liftIO $ readTVarIO tvar
  let mayUserId = map fst . find ((auth ==) . snd) $ stateAuths state
  case mayUserId of
    Nothing -> return Nothing
    Just uId -> do
      let verifieds = stateVerifiedEmails state
          email = D.authEmail auth
          isVerified = email `elem` verifieds
      return $ Just (uId, isVerified)

findEmailFromUserId :: InMemory r m => UserId -> m (Maybe Email)
findEmailFromUserId uId = do
  tvar <- asks getter
  state <- liftIO $ readTVarIO tvar
  let mayAuth = map snd . find ((uId ==) . fst) $ stateAuths state
  return $ D.authEmail <$> mayAuth

notifyEmailVerification :: InMemory r m => Email -> VerificationCode -> m ()
notifyEmailVerification email vCode = do
  tvar <- asks getter
  atomically $ do
    state <- readTVar tvar
    let notifications = stateNotifications state
        newNotifications = insertMap email vCode notifications
        newState = state {stateNotifications = newNotifications}
    writeTVar tvar newState

getNotificationsForEmail :: InMemory r m => D.Email -> m (Maybe D.VerificationCode)
getNotificationsForEmail email = do
  tvar <- asks getter
  state <- readTVarIO tvar
  return $ lookup email (stateNotifications state)

newSession :: InMemory r m => UserId -> m SessionId
newSession uId = do
  tvar <- asks getter
  sId <- liftIO $ (tshow uId <>) <$> stringRandomIO "[A-Za-z0-9]{16}"
  atomically $ do
    state <- readTVar tvar
    let sessions = stateSessions state
        newSessions = insertMap sId uId sessions
        newState = state {stateSessions = newSessions}
    writeTVar tvar newState
    return sId

findUserBySessionId :: InMemory r m => SessionId -> m (Maybe UserId)
findUserBySessionId sId = do
  tvar <- asks getter
  liftIO $ lookup sId . stateSessions <$> readTVarIO tvar
