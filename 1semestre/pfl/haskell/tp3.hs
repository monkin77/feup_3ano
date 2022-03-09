import Data.List
import Distribution.FieldGrammar (List)
import TP1
import Text.Read.Lex (Number)
import Text.XHtml.Transitional (area)

-- 3.1
customComprehension :: [a] -> (a -> b) -> (a -> Bool) -> [b]
customComprehension a f p = map f (filter p a)

-- Fold Functions take:
-- Function with 2 arguments FOLD RIGHT: (next elem and the recursive step (Acumulador) )
--                           FOLD LEFT: (Acumulador and nextElem)
-- Base case value
-- List where this is applied to

-- 3.2
dec2int :: [Int] -> Int
dec2int a = foldl (\x y -> 10 * x + y) 0 a

-- [2,3,4] = 2 * 10 * 10 + 3*10 + 4 + 0

-- 3.4
isort2 :: Ord a => [a] -> [a]
isort2 a = foldr (\x y -> insert x y) [] a

-- 3.7
-- a)
(+++) :: [a] -> [a] -> [a]
(+++) a b =
  foldr
    (\x y -> x : y)
    b
    a

-- b)
myConcat :: [[a]] -> [a]
myConcat a = foldr (\x y -> x ++ y) [] a

-- c)
myReverseRight :: [a] -> [a]
myReverseRight a = foldr (\x y -> y ++ [x]) [] a

-- d)
myReverseLeft :: [a] -> [a]
myReverseLeft a = foldl (\x y -> y : x) [] a

-- e)
myElem :: Eq a => a -> [a] -> Bool
myElem a b = any (\x -> x == a) b

-- 3.8
palavras :: String -> [String]
palavras a
  | takeWhile (/= ' ') a == a = [a] -- ja nao tem espaços
  | otherwise = takeWhile (/= ' ') a : palavras (tail (dropWhile (/= ' ') a)) -- Separar até ao espaço e concatenar recursivamente

despalavras :: [String] -> String
despalavras a = foldr (\x y -> x ++ " " ++ y) [] a