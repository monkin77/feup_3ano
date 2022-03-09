import TP4

-- 5.4
data Set a = Set (Arv a)
    deriving Show

empty :: Set a 
empty = Set Vazia

insert :: Ord a => a -> Set a -> Set a
insert val (Set a) = Set (inserir val a)

member :: Ord a => a -> Set a -> Bool 
member val (Set a) = procurar val a

-- 5.5
union :: Ord a => Set a -> Set a -> Set a
union (Set a1) (Set a2) = Set( foldr (\x y -> inserir x y) a1 arvList )
    where arvList = arvToList a2

intersect :: Ord a => Set a -> Set a -> Set a
intersect (Set a1) (Set a2) = Set( foldr (\x y -> if (procurar x a1) then inserir x y else y) Vazia arvList )
    where arvList = arvToList a2

difference :: Ord a => Set a -> Set a -> Set a
difference (Set a1) (Set a2) = Set( foldr (\x y -> remover x y) a1 arvList )
    where arvList = arvToList a2