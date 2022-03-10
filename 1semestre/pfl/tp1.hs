module TP1 where

import Distribution.FieldGrammar ()
import System.Directory.Internal.Prelude (Fractional)
import Text.Read.Lex (Number)
import Text.XHtml.Transitional (area)

main = print "Hello World!"

-- 1.1
testaTriangulo :: Float -> Float -> Float -> Bool
testaTriangulo a b c = not (a >= b + c || b >= a + c || c >= a + b)

testaTriangulo1 :: Float -> Float -> Float -> Bool
testaTriangulo1 a b c = if (a >= b + c || b >= a + c || c >= a + b) then False else True

testaTriangulo2 :: Float -> Float -> Float -> Bool
testaTriangulo2 a b c
  | a >= b + c || b >= a + c || c >= a + b = False
  | otherwise = True

-- 1.2
areaTriangulo :: Float -> Float -> Float -> Float
areaTriangulo a b c = sqrt (s * (s - a) * (s - b) * (s - c))
  where
    s = (a + b + c) / 2

-- 1.3
metades :: [a] -> ([a], [a])
metades a = (take (div (length a) 2) a, drop (div (length a) 2) a)

metades2 :: [a] -> ([a], [a])
metades2 a = (take (length a `div` 2) a, drop (length a `div` 2) a)

metades3 :: [a] -> ([a], [a])
metades3 a = splitAt (div (length a) 2) a

-- 1.4
myLast :: [a] -> [a]
myLast list = drop (length list - 1) list

myLast2 :: [a] -> a
myLast2 list = head (reverse list)

myInit :: [a] -> [a]
myInit list = take (length list - 1) list

myInit2 :: [a] -> [a]
myInit2 list = reverse (drop 1 (reverse list))

-- 1.5
factorial :: Integer -> Integer
factorial a = product [1 .. a]

--a
binom :: Integer -> Integer -> Integer
binom n k = div (factorial n) (factorial k * factorial (n - k))

binom2 :: Integer -> Integer -> Integer
binom2 n k =
  if k < n - k
    then div (product [n - k + 1 .. n]) (factorial k)
    else div (product [k + 1 .. n]) (factorial n - k)

-- 1.6
raizes :: Float -> Float -> Float -> Maybe (Float, Float)
raizes a b c =
  let delta = b * b - 4 * a * c
      discreetBinomial = sqrt delta
      doubleA = 2 * a
   in if delta > 0
        then Just ((- b + discreetBinomial) / doubleA, (- b - discreetBinomial) / doubleA)
        else Nothing

-- 1.7
-- a: lista char [char] -> String
-- b: tuple (Char, Char, Char)
-- c: lista [(Bool, Char)]
-- d: tuple ([Bool], [char])
-- e: lista [[a] -> [a]]
-- f: lista [Bool -> Bool]

-- 1.8
-- a: [a] -> a
-- b: (a, b) -> (b, a)
-- c: a -> b -> (a, b)
-- d: Num a => a -> a
-- e: Fractional a => a -> a
-- f: char -> bool
-- g: Ord a => a -> a -> a -> bool
-- h: Eq a => [a] -> Bool
-- i: (a -> a) -> a -> a

-- 1.9
classifica :: Int -> String
classifica a =
  if a <= 9
    then "reprovado"
    else
      if a <= 12
        then "suficiente"
        else
          if a <= 15
            then "bom"
            else
              if a <= 18
                then "muito bom"
                else
                  if a <= 20
                    then "muito bom com distincao"
                    else "Inválido"

classifica2 :: Int -> String
classifica2 a
  | a <= 9 = "reprovado"
  | a <= 12 = "suficiente"
  | a <= 15 = "bom"
  | a <= 18 = "muito bom"
  | a <= 20 = "muito bom com distincao"
  | otherwise = "Inválido"

-- 1.10

classificaImc :: Float -> Float -> String
classificaImc a b
  | imc < 18.5 = "baixo peso"
  | imc < 25 = "peso normal"
  | imc < 30 = "excesso de peso"
  | otherwise = "obesidade"
  where
    imc = a / (b * b)

-- 1.13
safeTail1 :: [a] -> [a]
safeTail1 a = if null a then [] else tail a

safeTail2 :: [a] -> [a]
safeTail2 a
  | null a = []
  | otherwise = tail a

safeTail3 :: [a] -> [a]
safeTail3 a = case a of
  [] -> []
  _ -> tail a

-- 1.14
curta :: [a] -> Bool
curta a = length a < 3

curta2 :: [a] -> Bool
curta2 a = null (drop 3 a)

-- 1.15
-- Tipo mais geral é Ord
mediana :: Ord a => a -> a -> a -> a
mediana a b c
  | (a >= b && a <= c) || (a <= b && a >= c) = a
  | (b >= a && b <= c) || (b <= a && b >= c) = b
  | otherwise = c

-- Tipo mais geral é Ord
mediana2 :: Num a => Ord a => a -> a -> a -> a
mediana2 a b c = (a + b + c) - (max (max a b) (max a c)) - (min (min a b) (min a c))

-- 1.16
converteAteDezanove :: Int -> String
converteAteDezanove a = case a of
  0 -> "zero "
  1 -> "um "
  2 -> "dois "
  3 -> "tres "
  4 -> "quatro "
  5 -> "cinco "
  6 -> "seis "
  7 -> "sete "
  8 -> "oito "
  9 -> "nove "
  10 -> "dez "
  11 -> "onze "
  12 -> "doze "
  13 -> "treze "
  14 -> "catorze "
  15 -> "quinze "
  16 -> "dezasseis "
  17 -> "dezassete "
  18 -> "dezoito "
  19 -> "dezanove "
  _ -> ""

converteDezenas :: Int -> String
converteDezenas a
  | a == 20 = "vinte e "
  | a == 30 = "trinta e "
  | a == 40 = "quarenta e "
  | a == 50 = "cinquenta e "
  | a == 60 = "sessenta e "
  | a == 70 = "setenta e "
  | a == 80 = "oitenta e "
  | a == 90 = "noventa e "
  | otherwise = ""

converteCentenas :: Int -> String
converteCentenas a = case a of
  100 -> "cento e "
  200 -> "duzentos e "
  300 -> "trezentos e "
  400 -> "quatrocentos e "
  500 -> "quinhentos e "
  600 -> "seiscentos e "
  700 -> "setecentos e "
  800 -> "oitocentos e "
  900 -> "novecentos e "
  _ -> ""

converteAteMil :: Int -> String
converteAteMil a =
  if a < 20
    then converteAteDezanove a
    else
      if a < 100
        then converteDezenas (a - mod a 10) ++ converteAteDezanove (mod a 10)
        else
          if a < 1000
            then converteCentenas (a - mod a 100) ++ converteDezenas (mod a 100 - mod a 10) ++ converteAteDezanove (mod a 10)
            else ""

converte :: Int -> String
converte a
  | a < 20 = converteAteDezanove a
  | a < 100 = converteDezenas (a - mod a 10) ++ converteAteDezanove (mod a 10)
  | a < 1000 = converteCentenas (a - mod a 100) ++ converteDezenas (mod a 100 - mod a 10) ++ converteAteDezanove (mod a 10)
  | a < 1000000 = converteAteMil (div (a - mod a 1000) 1000) ++ "mil " ++ converteAteMil (mod a 1000)
  | otherwise = "number is too big. Choose a number < 1000000"