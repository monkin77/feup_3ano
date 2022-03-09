-- 1
{-
    a) [[1,2], [], [3,4], [5]]
    b) [5]
    c) 2 -> left side of ':' is an element so the list is actually = [[], []]
    d) [16,20,24,28,32]
    e) [(3, 2), (4, 3), (5, 4), (5, 6), (6, 8), (7, 12)]
    f) [[2,8], [4,6], []]
    g) [(x, 6-x) | x <- [0..6]]
    h) 1*3 + 3*1 + 1*5 + 5*0 + 0*4 + 4 = 15
    i) [(char, String)]
    j) (Num a, Ord a) => a -> [a] -> Bool
    k) Eq a => [a] -> Bool
    l) Eq a => (a -> a) -> a -> Bool
 -}

-- 2
pitagoricos :: Int -> Int -> Int -> Bool
pitagoricos a b c
  | a <= 0 || b <= 0 || c <= 0 = False
  | (a >= b) && (a >= c) = a ^ 2 == b ^ 2 + c ^ 2
  | (b >= a) && (b >= c) = b ^ 2 == a ^ 2 + c ^ 2
  | otherwise = c ^ 2 == a ^ 2 + b ^ 2

hipotenusa :: Float -> Float -> Float
hipotenusa a b = sqrt (a ^ 2 + b ^ 2)

-- 3
diferentes :: Eq a => [a] -> [a]
diferentes [] = []
diferentes [_] = []
diferentes (l1 : l2 : l3) = if l1 == l2 then diferentes (l2 : l3) else l1 : diferentes (l2 : l3)

diferentes2 :: Eq a => [a] -> [a]
diferentes2 l = [x | (x, y) <- zip l (tail l), x /= y]

-- 4
my_zip3 :: [a] -> [b] -> [c] -> [(a, b, c)]
my_zip3 l1 l2 l3 = [(x, y, z) | (x, idx1) <- zip l1 [0 ..], (y, idx2) <- zip l2 [0 ..], (z, idx3) <- zip l3 [0 ..], idx1 == idx2 && idx2 == idx3]

my_zip3_2 :: [a] -> [b] -> [c] -> [(a, b, c)]
my_zip3_2 l1 l2 l3 = [(x, y, z) | (x, (y, z)) <- zip l1 (zip l2 l3)]

--5
partir :: Eq a => a -> [a] -> ([a], [a])
partir _ [] = ([], [])
partir num (x : xs)
  | num == x = ([], x : xs)
  | otherwise = (x : xs1, xs2)
  where
    (xs1, xs2) = partir num xs

-- 6
parts :: [a] -> [[[a]]]
parts [] = [[]]
parts (x : xs) = [[x] : ps | ps <- pss] ++ [(x : p) : ps | (p : ps) <- pss]
  where
    pss = parts xs

-- I prefer this one
parts2 :: [a] -> [[[a]]]
parts2 [] = [[]]
parts2 xs = [(take n xs) : ps | n <- [1 .. length xs], ps <- parts2 (drop n xs)]
