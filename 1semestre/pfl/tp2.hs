module TP2 where

import Data.Char
import Distribution.FieldGrammar ()
import TP1
import Text.Read.Lex (Number)
import Text.XHtml.Transitional (area)

-- 2.1
somaQuadrados :: Int
somaQuadrados = sum [x ^ 2 | x <- [1 .. 100]]

-- 2.2
-- a
aprox :: Int -> Double
aprox a = sum [(-1) ^ n / fromIntegral (2 * n + 1) | n <- [0 .. a]] * 4

-- b
aproxB :: Int -> Double
aproxB a = sqrt (sum [(-1) ^ n / fromIntegral ((n + 1) ^ 2) | n <- [0 .. a]] * 12)

-- 2.4
divprop :: Integer -> [Integer]
divprop a = [x | x <- [1 .. a], mod a x == 0]

-- 2.6
pitagoricos :: Integer -> [(Integer, Integer, Integer)]
pitagoricos a = [(x, y, z) | x <- [1 .. a], y <- [1 .. a], z <- [1 .. a], x ^ 2 + y ^ 2 == z ^ 2]

--2.7
primo :: Integer -> Bool
primo a
  | a == 1 = True
  | otherwise = divprop a == [1, a]

-- 2.8
pascal :: Integer -> [[Integer]]
pascal a = [[binom n k | k <- [0 .. n]] | n <- [0 .. a]]

-- 2.9
-- Converte letras em inteiros 0..25 e vice-versa
letraInt :: Char -> Int
letraInt c = ord c - ord 'A'

intLetra :: Int -> Char
intLetra n = chr (n + ord 'A')

maiúscula :: Char -> Bool
maiúscula x = x >= 'A' && x <= 'Z'

-- Efectuar um deslocamento de k posições
desloca :: Int -> Char -> Char
desloca k x
  | maiúscula x = intLetra ((letraInt x + k) `mod` 26)
  | otherwise = x

-- Repetir o deslocamento para toda a cadeia de caracteres.
cifrar :: Int -> String -> String
cifrar k xs = [desloca k x | x <- xs]

-- 2.10
myand :: [Bool] -> Bool
myand [] = True
myand a = head a && myand (tail a)

myor :: [Bool] -> Bool
myor [] = False
myor a = head a || myor (tail a)

myconcat :: [[a]] -> [a]
myconcat [] = []
myconcat a = head a ++ myconcat (tail a)

myreplicate :: Int -> a -> [a]
myreplicate 0 a = []
myreplicate n a = a : myreplicate (n - 1) a

(!!!) :: [a] -> Int -> a
(!!!) a 0 = head a
(!!!) a n = (!!!) (tail a) (n - 1)

myelem :: Eq a => a -> [a] -> Bool
myelem val [] = False
myelem val a = val == head a || myelem val (tail a)

-- 2.14
deleteDuplicates :: Eq a => a -> [a] -> [a]
deleteDuplicates val list = [x | x <- list, x /= val]

nub :: Eq a => [a] -> [a]
nub [] = []
nub a = head a : nub (deleteDuplicates (head a) a)

-- 2.15
intersperse :: a -> [a] -> [a]
intersperse a [x] = [x]
intersperse val list =
  let elem = head list
   in [elem, val] ++ intersperse val (tail list)

-- 2.16
algarismosRev :: Int -> [Int]
algarismosRev 0 = []
algarismosRev a = mod a 10 : algarismosRev (div a 10)

algarismos :: Int -> [Int]
algarismos a = reverse (algarismosRev a)

-- 2.17 (Instead of implementing toBits -> implemented conversion to another base)
-- base 10 Number -> new base
convertBaseRev :: Int -> Int -> [Int]
convertBaseRev 0 n = []
convertBaseRev a n = mod a n : convertBaseRev (div a n) n

convertBase :: Int -> Int -> [Int]
convertBase a n = reverse (convertBaseRev a n)

-- 2.20
myinsert :: Ord a => a -> [a] -> [a]
myinsert val [] = []
myinsert val list
  | val <= head list = val : list
  | otherwise = head list : myinsert val (tail list)

myisort :: Ord a => [a] -> [a]
myisort [x] = [x]
myisort (x : xs) = myinsert x (myisort xs)

-- 2.23
{- Exercício 2.23
   Somar e multiplicar polinómios representados
  como listas de coeficientes.

  Exemplo
   1+2X-X² ~ [1, 2, -1]
-}

-- somar polinómios; versão usando listas em compreensão
addPoly' :: [Int] -> [Int] -> [Int]
addPoly' ps qs
  | n <= m -- qs é maior ou igual que ps
    =
    [p + q | (p, q) <- zip (ps ++ replicate (m - n) 0) qs]
  | otherwise -- ps é maior que qs
    =
    [p + q | (p, q) <- zip ps (qs ++ replicate (n - m) 0)]
  where
    n = length ps
    m = length qs

-- somar polinómios: versão usando recursão
addPoly :: [Int] -> [Int] -> [Int]
addPoly (p : ps) (q : qs) = (p + q) : addPoly ps qs
addPoly [] qs = qs
addPoly ps [] = ps

{-
 Multiplicar polinómios
 Ideia do algoritmo recursivo:
 Se
  P = a0 + X*P'
  Q = b0 + X*Q'
 então
  P*Q = a0*b0 + a0*X*Q' + b0*X*P' + X²*P*Q
      = a0*b0 + X*(a0*Q' + b0*P' + X*P*Q)
 -}
multPoly :: [Int] -> [Int] -> [Int]
multPoly [] qs = []
multPoly ps [] = []
multPoly (a0 : ps) (b0 : qs) = (a0 * b0) : restantes
  where
    restantes = addPoly (addPoly resto1 resto2) resto3
    resto1 = [a0 * q | q <- qs]
    resto2 = [b0 * p | p <- ps]
    resto3 = 0 : multPoly ps qs