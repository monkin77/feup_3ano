{-
1
    a) 3
    b) [[1,2], [3]]
    c) [11, 12, 13, 14, 15]
    d) 240
    e) []
    f) False
    g) [(1,1), (4,4), (9, 7), (16, 10), (25, 13), (36, 16)]
    h) [tup | tup <- zip [1,3..] [10,8..]]
    i) [1,2,3,4,5]
    j) Int -> Int
    k) [(Int -> Int) -> [Int] -> [Int], (Int -> Bool) -> [Int] -> [Int]]
    l) data Arv a = F a | N (Arv a) (Arv a)
    m) (x -> Bool) -> [x] -> [x]
 -}

-- 2
notaF :: [Float] -> [Float] -> Float
notaF notas pesos = sum (zipWith (\x y -> x * y) notas pesos)

rfc :: [[Float]] -> Int
rfc l = length (filter (\li -> any (\num -> num < 8) li) l)

-- 3
type Vert = Int

type Graph = [(Vert, Vert)]

-- Checks if a tuple exists in the graph
findTuple :: Graph -> (Vert, Vert) -> Bool
findTuple [] _ = False
findTuple ((gx, gy) : g) (x, y) = if (gx == x) && (gy == y) then True else findTuple g (x, y)

-- Returns the second elemnt of the tuples where exists (v1,v2) and (v2,v3) given a certain v2. Returns v3
findSimilarTuples :: Graph -> Vert -> [Vert]
findSimilarTuples g mutualVal = map (\elem -> snd elem) (filter (\(x, y) -> x == mutualVal) g)

transitiva :: Graph -> Bool
transitiva g = all (\(x, y) -> all (\y2 -> findTuple g (x, y2)) (findSimilarTuples g y)) g

-- 4
iterate2 :: (a -> a) -> a -> [a]
iterate2 f base = l
  where
    l = base : [f (l !! idx) | idx <- [0 ..]]

-- 5
deleteNth :: Int -> [a] -> [a]
deleteNth idx l = deleteNthAux idx idx l

deleteNthAux :: Int -> Int -> [a] -> [a]
deleteNthAux _ _ [] = []
deleteNthAux initIdx 1 (x : xs) = deleteNthAux initIdx initIdx xs
deleteNthAux initIdx currIdx (x : xs) = x : deleteNthAux initIdx (currIdx -1) xs

deleteNth2 :: Int -> [a] -> [a]
deleteNth2 idx l = [elem | (elem, lIdx) <- zip l [1 ..], mod lIdx idx /= 0]

-- 6
data Arv a = Folha | No a (Arv a) (Arv a)
  deriving (Show)

soma :: Num a => Arv a -> a
soma Folha = 0
soma (No a esq dir) = soma esq + a + soma dir

somaArv :: Num a => Arv a -> Arv a -> Arv a
somaArv Folha Folha = Folha
somaArv (No a esq dir) Folha = No a esq dir
somaArv Folha (No a esq dir) = No a esq dir
somaArv (No a1 esq1 dir1) (No a2 esq2 dir2) = No (a1 + a2) (somaArv esq1 esq2) (somaArv dir1 dir2)

-- 7
