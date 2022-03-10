-- 4
maximo :: IO ()
maximo = maximo_aux 0

maximo_aux :: Int -> IO ()
maximo_aux m = do
  x <- getLine
  -- putStrLn (" : " ++ x)
  let n = read x
   in ( if n == 0
          then print m
          else maximo_aux (max n m)
      )