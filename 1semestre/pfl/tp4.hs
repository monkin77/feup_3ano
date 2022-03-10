module TP4 where

import Data.List ()
import Data.Sequence (insertAt)
import Distribution.FieldGrammar ()
import TP1
import TP2
import TP2 (letraInt)
import Text.Read.Lex (Number)
import Text.XHtml.Transitional (area)

-- Int representação até MAX_INT | Integer tem um limit maior

-- Exercicios recomendados: 4.2, 4.5, 4.6, 4.3, 4.4
--                          4.7, 4.9, 4.10, 4.11, 4.12

-- 4.2
calcPi1 :: Int -> Double
calcPi1 a = sum (take a (zipWith (/) num denom))
  where
    num = cycle [4, -4]
    denom = [1, 3 ..]

calcPi2 :: Int -> Double
calcPi2 a = 3 + sum (take a (zipWith (/) num denom))
  where
    num = cycle [4, -4]
    denom = [x * (x + 1) * (x + 2) | x <- [2, 4 ..]]

-- 4.5

cifraChave :: String -> String -> String
cifraChave text keyword = map (\(letter, offset) -> desloca offset letter) (zip text (cycle offsets))
  where
    offsets = map letraInt keyword

-- 4.6
infinitePascal :: [[Integer]]
infinitePascal = [[binom n k | k <- [0 .. n]] | n <- [0 ..]]

infinitePascal2 :: [[Integer]]
infinitePascal2 = lista
  where
    lista = [[if (k == 0 || n == k) then 1 else ((lista !! (n - 1) !! (k - 1)) + (lista !! (n - 1) !! k)) | k <- [0 .. n]] | n <- [0 ..]]

-- 4.3
myInsertAt :: a -> Int -> [a] -> [a]
myInsertAt elem idx lista = take idx lista ++ [elem] ++ drop idx lista

intercalar :: a -> [a] -> [[a]]
intercalar elem lista = [myInsertAt elem idx lista | idx <- [0 .. length lista]]

-- 4.4
myConcat3D :: [[[a]]] -> [[a]]
myConcat3D a = foldr (\x y -> x ++ y) [] a

perms :: [a] -> [[a]]
perms lista
  | length lista == 1 = [lista]
  | otherwise = myConcat3D (map (\permsChild -> intercalar (head lista) permsChild) (childPerms))
  where
    childPerms = perms (tail lista)

permsLength :: [a] -> Int
permsLength lista = length (perms lista)

data Arv a = Vazia | No a (Arv a) (Arv a) deriving (Show)

procurar :: Ord a => a -> Arv a -> Bool
procurar x Vazia = False -- não ocorre
procurar x (No y esq dir)
  | x == y = True -- encontrou
  | x < y = procurar x esq -- procura à esquerda
  | x > y = procurar x dir -- procura à direita

arvToList :: Arv a -> [a]
arvToList Vazia = []
arvToList (No x esq dir) = arvToList esq ++ [x] ++ arvToList dir

-- Ex árvore: (No 1 ( No 2 (No 3 Vazia Vazia) (No 4 Vazia Vazia) ) ( No 3 Vazia (No 1 Vazia Vazia) ) )
-- 4.7
sumArv :: Num a => Arv a -> a
sumArv Vazia = 0
sumArv (No val esq dir) = val + (sumArv esq) + (sumArv dir)

-- 4.9
listar :: Ord a => Int -> Arv a -> [a]
listar height Vazia = []
listar 0 (No val esq dir) = [val]
listar height (No val esq dir) = nivel (height - 1) esq ++ nivel (height - 1) dir

myQuickSort :: Ord a => [a] -> [a]
myQuickSort [] = []
myQuickSort (x : xs) = myQuickSort menores ++ [x] ++ myQuickSort maiores
  where
    menores = [y | y <- xs, y <= x]
    maiores = [y | y <- xs, y > x]

nivel :: Ord a => Int -> Arv a -> [a]
nivel height arv = myQuickSort (listar height arv)

-- 4.10
mapArv :: (a -> b) -> Arv a -> Arv b
mapArv f Vazia = Vazia
mapArv f (No val esq dir) = No (f val) (mapArv f esq) (mapArv f dir)

-- 4.11
-- 4.11a
inserir :: Ord a => a -> Arv a -> Arv a
inserir x Vazia = No x Vazia Vazia
inserir x (No y esq dir)
  | x == y = No y esq dir -- já ocorre; não insere
  | x < y = No y (inserir x esq) dir -- insere à esquerda
  | x > y = No y esq (inserir x dir) -- insere à direita

construir :: Ord a => [a] -> Arv a
construir [] = Vazia
construir (x : xs) = inserir x (construir xs)

construir2 :: Ord a => [a] -> Arv a
construir2 [] = Vazia
construir2 xs = foldr inserir Vazia xs

-- Construir uma árvore equilibrada
-- pré-condição: a lista de valores deve estar
-- por ordem crescente
construir3 :: Ord a => [a] -> Arv a
construir3 [] = Vazia
construir3 xs = No x (construir3 xss) (construir3 xsss)
  where
    n = div (length xs) 2 -- ponto médio
    xss = take n xs -- partir a lista
    x : xsss = drop n xs

-- 4.12
mais_dir :: Arv a -> a
mais_dir (No x _ Vazia) = x
mais_dir (No _ _ dir) = mais_dir dir

remover' :: Ord a => a -> Arv a -> Arv a
remover' _ Vazia = Vazia
remover' a (No x esq Vazia)
  | a == x = esq
remover' a (No x Vazia dir)
  | a == x = dir
remover' a (No x esq dir)
  | a < x = No x (remover' a esq) dir
  | a > x = No x esq (remover' a dir)
  | a == x =
    let novoNo = mais_dir esq
     in No novoNo (remover' novoNo esq) dir
