{-
1.
    a)  [[1,2,3], [4], [5]]
    b)  5
    c)  [8,6,4,2,0]
    d)  9
    e)  [(1, 1), (2,1), (3,1), (4,1), (2,2), (3,2), (4,2)]
    f)  [2, 4, 8, 16, 32]
    g)  [2^n - 1 | n <- [1..10]] ou

    teste :: Int -> [Int]
    teste a = l
    where
        l = 1 : [2 * (l !! idx) + 1 | idx <- [0 .. 8]]

    h)  15
    i)  ([Bool], [Char])
    j)  x -> y -> (x,y)
    k)  Eq a => [a] -> [a] -> [a]
    l)  Eq a => [a] -> Bool
 -}

-- 2
distancia :: (Float, Float) -> (Float, Float) -> Float
distancia (x1, y1) (x2, y2) = sqrt (d1 + d2)
  where
    d1 = (x2 - x1) ^ 2
    d2 = (y2 - y1) ^ 2

colineares :: (Float, Float) -> (Float, Float) -> (Float, Float) -> Bool
colineares (x1, y1) (x2, y2) (x3, y3) = declive1 == declive2
  where
    declive1 = (y2 - y1) / (x2 - x1)
    declive2 = (y3 - y2) / (x3 - x2)

-- 3
niguais :: Int -> a -> [a]
niguais 0 _ = []
niguais num elem = elem : niguais (num -1) elem

niguais2 :: Int -> a -> [a]
niguais2 num elem = [elem | times <- [1 .. num]]

-- 4
merge :: Ord a => [a] -> [a] -> [a]
merge x [] = x
merge [] y = y
merge (x : xs) (y : ys) = if x <= y then x : merge xs (y : ys) else y : merge (x : xs) ys

-- 5
length_zip :: [a] -> [(a, Int)]
length_zip l = [(elem, length) | (elem, length) <- zip l [length l, length l -1 ..]]

-- 6
decompor :: Int -> [Int] -> [[Int]]
decompor val coins = decomporCalc val coins (coins !! (length coins - 1))

decomporCalc :: Int -> [Int] -> Int -> [[Int]]
decomporCalc 0 _ _ = [[]]
decomporCalc val coins lastCoin
  | val < 0 = []
  | otherwise = concat [map (\decomp -> coin : decomp) (decomporCalc (val - coin) coins coin) | coin <- coins, coin <= lastCoin]

