module Main where

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

-- Placeholder for New Password Entry logic
newPasswordEntry :: IO ()
newPasswordEntry = do
    putStrLn "\n--- New Password Entry ---"
    putStrLn "Enter a password:"
    userNewPass <- getLine
    putStrLn "What is this password for?"
    userNewPassName <- getLine
    putStrLn $ "Saved password for " ++ userNewPassName
    -- TODO: File storage goes here

-- Placeholder for View Passwords
viewPasswords :: IO ()
viewPasswords = do
    putStrLn "\n--- View Passwords ---"
    putStrLn "(Not implemented yet)"

-- Placeholder for Password Generator
passwordGenerator :: IO ()
passwordGenerator = do
    putStrLn "\n--- Password Generator ---"
    putStrLn "(Not implemented yet)"
