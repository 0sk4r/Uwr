{-# LANGUAGE Safe #-}
positives :: [a] -> [(a,String)]
positives lst = [ (x,"test") | x <- lst ]