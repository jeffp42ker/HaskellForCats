module TClasses where
-- : set expandtab ts=2 ruler number spell -- daw
-- Type Class Instances 
-- Instances 
-- Deriving 
-- Defining type classes 
-- Subclasses 

el2m :: Eq a => a -> [a] -> Bool
el2m _ [] = False 
el2m x (y:ys)   
  | x==y = True 
  | otherwise = el2m x ys 

-- Haskell doesn't have a built in equality test for everything. Functions don't have built in equality tests. 
-- but we can have a known answer test (KAT)

data RGB = RGB Int Int Int 
-- to test for equality between colors we have to create an instance of equality for our RGB type. 
instance Eq RGB where 
  (RGB r1 g1 b1) == (RGB r2 g2 b2) = 
    (r1 == r2) && (g1 == g2) && (b1 == b2) 
instance Show RGB where 
  show (RGB r g b) = 
    "RGB " ++ (show r) ++ "  " ++ (show g) ++ " " ++ (show b)  
colors = [RGB 255 0 0, RGB 0 255 0, RGB 0 0 255] 
green = RGB 0 255 0 
greenInColors = elem green colors 
-- *TClasses> elem green colors 
-- True
-- *TClasses> show (RGB 255 255 255) 
-- "RGB 255  255 255"

-- we've had to add an instance here because Maybe' a is defined with an Eq type no matter what a is; x == y have values of type a and will always be equal. 
-- => is the context of the typeclass instance   
-- for simple things this is straight forward but more complex examples will require knowing more about the "context instance".

data Maybe' a = Nothing' | Just' a  
instance (Eq a) => Eq (Maybe' a) where 
  Nothing' == Nothing' = True 
  Nothing' == (Just' _) = False 
  (Just' _) == Nothing' = False 
  (Just' x) == (Just' y) = x == y 

data Person = Person String Int Int 
instance Eq Person where 
  (Person name1 age1 height1) == (Person  name2 age2 height2) = 
    (name1 == name2) && (age1 == age2) && (height1 == height2) 
-- so that we don't have to do this for every Type constraint we can use the keyword deriving

-- data RGB' = RGB Int Int Int 
--  deriving Eq 

-- deriving adds on the obvious acceptable typeclasses like 
-- Eq where each component == component 
-- Ord where (<),(>),(<=),(>=) component to component
-- Show gives us show "component"
--                      "[Constructor-name] {argument-1} {argument-2}..." 
-- Read which gives the read function 
--    Deriving-parse output of default show 

-- Minimum complete definition
-- must be satisfied     

-- we create new type classes when to not have them would require excessive amounts of definitions, because we want polymorphic functionality on a function. 

-- Subclasses work as refinements on the Superclass. Eq just allows for comparison where as Ord which inherits from Eq allows other comparisons (<),(>),(<=),(>=) which would not be possible to do with out first checking if two elements were the same or not. 
{-
class Eq a => Ord a where
  compare :: a -> a -> Ordering
  (<) :: a -> a -> Bool
  (>=) :: a -> a -> Bool
  (>) :: a -> a -> Bool
  (<=) :: a -> a -> Bool
  max :: a -> a -> a
  min :: a -> a -> a
  	-- Defined in `GHC.Classes'
-} 
-- note that the Class definition class Eq a => Ord a where shows that Ord is a Subclass of Eq. 
-- compare :: a -> a -> Ordering
-- note that ordering is defined thus...  
-- data Ordering = LT | EQ | GT 	-- Defined in `GHC.Types'


{-
class (Num a, Ord a) => Real a where
  toRational :: a -> Rational
  	-- Defined in `GHC.Real'
-} 

 
