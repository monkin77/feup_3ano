-- 2
imparDiv3 :: [Int] -> Bool 
imparDiv3 l = length [x | x <- l, (mod x 3 /= 0) || (mod x 2 /= 0)] == length l

imparDiv3_2 :: [Int] -> Bool 
imparDiv3_2 l = all (\elem -> (mod elem 3 /= 0) || (mod elem 2 /= 0)) l

-- 3
