import Stack

-- 5.1
parent :: String -> Bool
parent word = parentAux word Stack.empty

parentAux :: String -> Stack Char -> Bool
parentAux [] stk = isEmpty stk
parentAux (x : xs) stk
  | (x == '(') || (x == '[') = parentAux xs (push x stk)
  | x == ')' = not (isEmpty stk) && (top stk == '(') && parentAux xs (pop stk)
  | x == ']' = not (isEmpty stk) && (top stk == '[') && parentAux xs (pop stk)
  | otherwise = parentAux xs stk

-- 5.2
calc :: Stack Float -> String -> Stack Float
calc stk letter
  | letter == "+" = push (b + a) newStk
  | letter == "-" = push (b - a) newStk
  | letter == "*" = push (b * a) newStk
  | letter == "/" = push (b / a) newStk
  | otherwise = push digit stk
  where
    a = top stk
    b = top (pop stk)
    newStk = pop (pop stk)
    digit = read letter

calcular :: String -> Float
calcular word = top (foldr (\x y -> calc y x) Stack.empty l1)
  where
    l1 = reverse (words word)

main :: IO ()
main = do
  putStr "Give me some operations\n"
  userInput <- getLine
  putStr (show (calcular userInput))
  putStr ("\n")

printInput :: IO ()
printInput = do
  x <- getLine
  putStrLn x
  putStrLn x
