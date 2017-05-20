{-# LANGUAGE Safe #-}
mfnd :: a -> [(a,b)] -> Maybe b

mfnd var list =
	if var == fst(head(list))