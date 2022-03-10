{-
1
    a) [1,5,4,3]
    b) [5,6,9]
    c) 2
    d) [15,18,21,24,27,30]
    e) 4
    f) [1, 2, 3, 4, 6, 9]
    g) [1, 2, 3]
    h) [x1*x2 | (x1,x2) <- zip [0..10] (cycle [1,-1])]
    i) 8
    j) ([Char], [Float])
    k) (a, b) -> a
    l) (Ord, Eq) a => a -> a -> a -> Bool
    m) [a] -> a
 -}

-- 2
numEqual :: Int -> Int -> Int -> Int
numEqual n m p = res
  where
    res =
      if (n == m && n == p)
        then 3
        else
          if (n == m || n == p || m == p)
            then 2
            else 1

-- 3
areaQuad :: Float -> Float -> Float -> Float -> Float -> Float -> Float
areaQuad a b c d p q = (1 / 4) * sqrt (4 * p2 * q2 - (b2 + d2 - a2 - c2) ^ 2)
  where
    p2 = p ^ 2
    q2 = q ^ 2
    b2 = b ^ 2
    d2 = d ^ 2
    a2 = a ^ 2
    c2 = c ^ 2

-- 4
enquantoPar :: [Int] -> [Int]
enquantoPar [] = []
enquantoPar (x : xs)
  | mod x 2 == 0 = x : enquantoPar xs
  | otherwise = []

enquantoPar2 :: [Int] -> [Int]
enquantoPar2 l = takeWhile (\x -> mod x 2 == 0) l

-- 5
nat_zip :: [a] -> [(Int, a)]
nat_zip l = [tup | tup <- zip [1 ..] l]

-- 6
quadrados :: [Int] -> [Int]
quadrados [] = []
quadrados (x : xs) = x ^ 2 : quadrados xs

quadrados2 :: [Int] -> [Int]
quadrados2 l = [val ^ 2 | val <- l]

-- 7
crescente :: [Int] -> Bool
crescente [] = True
crescente [_] = True
crescente (x : y : z) = x <= y && crescente (y : z)

partes :: Int -> [[Int]]
partes 0 = [[]]
partes val = filter crescente (concat [map (\l -> currElem : l) (partes (val - currElem)) | currElem <- [1 .. val]])
