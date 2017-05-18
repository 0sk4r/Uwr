{-# LANGUAGE Safe #-}

getVariable :: (Eq a) => a -> [(a,b)] -> Maybe b 
getVariable var zmienne = lookup var zmienne

inList :: Eq(a) => a -> [a] -> Bool
inList x xs = x `elem` xs
