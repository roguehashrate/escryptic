{-# LANGUAGE DeriveGeneric #-}

module Main where

import System.Directory (doesFileExist)
import qualified Data.ByteString.Lazy as BL
import Data.Aeson (ToJSON, FromJSON, encode, decode)
import GHC.Generics (Generic)
import Data.Maybe (fromMaybe)

data PasswordEntry = PasswordEntry
  { name :: String
  , password :: String
  , memo :: String
  } deriving (Show, Generic)

instance ToJSON PasswordEntry
instance FromJSON PasswordEntry

main :: IO ()
main = menuLoop

menuLoop :: IO ()
menuLoop = do
    putStrLn "\n------------------------\n        ESCRYPTIC\n------------------------\n"
    putStrLn "> 1.) New Password Entry"
    putStrLn "> 2.) View Passwords"
    putStrLn "> 3.) Password Generator"
    putStrLn "> 4.) Quit"
    putStr "\n>>> "

    userSelection <- getLine
    case userSelection of
        "1" -> do
            newPasswordEntry
            menuLoop

        "2" -> do
            viewPasswords
            menuLoop

        "3" -> do
            passwordGenerator
            menuLoop

        "4" -> putStrLn "Goodbye!"

        _ -> do
            putStrLn "Please enter a valid option (1, 2, 3, 4)"
            menuLoop

newPasswordEntry :: IO ()
newPasswordEntry = do
  putStrLn "\n--- New Password Entry ---"
  putStrLn "Enter a password:"
  userNewPass <- getLine
  putStrLn "What is this password for:"
  userNewPassName <- getLine
  putStrLn "Memo Field (optional):"
  userNewMemo <- getLine

  let entry = PasswordEntry userNewPassName userNewPass userNewMemo

  fileExists <- doesFileExist "escryptic-pass.json"
  entries <- if fileExists
             then do
               contents <- BL.readFile "escryptic-pass.json"
               return $ fromMaybe [] (decode contents)
             else return []

  let newEntries = entries ++ [entry]
  BL.writeFile "escryptic-pass.json" (encode newEntries)

  putStrLn $ "Saved password for " ++ userNewPassName

viewPasswords :: IO ()
viewPasswords = do
    putStrLn "\n--- View Passwords ---"
    fileExists <- doesFileExist "escryptic-pass.json"
    if not fileExists
      then putStrLn "(No passwords stored yet)"
      else do
        contents <- BL.readFile "escryptic-pass.json"
        let entries = fromMaybe [] (decode contents :: Maybe [PasswordEntry])
        mapM_ printEntry entries
  where
    printEntry :: PasswordEntry -> IO ()
    printEntry (PasswordEntry n p m) = do
      putStrLn $ "Name: " ++ n
      putStrLn $ "Password: " ++ p
      putStrLn $ "Memo: " ++ m
      putStrLn "----------------------"

passwordGenerator :: IO ()
passwordGenerator = do
    putStrLn "\n--- Password Generator ---"
    putStrLn "(Not implemented yet)"
