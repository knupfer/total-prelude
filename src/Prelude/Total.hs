{-# LANGUAGE NoImplicitPrelude #-}

module Prelude.Total
       ( module X
       , module Prelude.Total
       ) where

import qualified Control.Exception as E
import System.IO.Unsafe

import qualified Prelude as P
import Prelude as X hiding
  ( (!!)
  , (/)
  , (^)
  , cycle
  , div
  , divMod
  , error
  , errorWithoutStackTrace
  , fail
  , foldl1
  , foldr1
  , head
  , init
  , last
  , maximum
  , minimum
  , mod
  , pred
  , quot
  , quotRem
  , read
  , readIO
  , recip
  , rem
  , succ
  , tail
  , toEnum
  , undefined
  )

{-# NOINLINE unsafeCatch #-}
unsafeCatch
  :: a
  -> Maybe a
unsafeCatch x
  = unsafePerformIO $ E.catch (E.evaluate $ Just $! x) f
    where f :: Monad m => E.ErrorCall -> m (Maybe a)
          f _ = return Nothing

(!!)
  :: [a]
  -> Int
  -> Maybe a
xs !! n
  | n >= length xs || n < 0 = Nothing
  | otherwise = Just $ xs P.!! n

(/)
  :: Fractional a
  => a
  -> a
  -> Maybe a
a / b = unsafeCatch (a P./ b)

(^)
  :: (Num a, Integral b)
  => a
  -> b
  -> Maybe a
x ^ y | y < 0 = Nothing
      | otherwise = Just $ x P.^ y

cycle
  :: [a]
  -> Maybe [a]
cycle xs
  | null xs = Nothing
  | otherwise = Just $ P.cycle xs

div
  :: Integral a
  => a
  -> a
  -> Maybe a
div x y
  | y == 0 = Nothing
  | otherwise = Just $ P.div x y

divMod
  :: Integral a
  => a
  -> a
  -> Maybe (a, a)
divMod x y
  | y == 0 = Nothing
  | otherwise = Just $ P.divMod x y

foldl1
  :: Foldable t
  => (a -> a -> a)
  -> t a
  -> Maybe a
foldl1 f xs
  | null xs = Nothing
  | otherwise = Just $ P.foldl1 f xs

foldr1
  :: Foldable t
  => (a -> a -> a)
  -> t a
  -> Maybe a
foldr1 f xs
  | null xs = Nothing
  | otherwise = Just $ P.foldr1 f xs

head
  :: [a]
  -> Maybe a
head []
  = Nothing
head (x:_)
  = Just x

init
  :: [a]
  -> Maybe [a]
init []
  = Nothing
init xs
  = Just $ P.init xs

last
  :: [a]
  -> Maybe a
last []
  = Nothing
last xs
  = Just $ P.last xs

maximum
  :: (Foldable t, Ord a)
  => t a
  -> Maybe a
maximum xs
  | null xs = Nothing
  | otherwise = Just $ P.maximum xs

minimum
  :: (Foldable t, Ord a)
  => t a
  -> Maybe a
minimum xs
  | null xs = Nothing
  | otherwise = Just $ P.minimum xs

mod
  :: Integral a
  => a
  -> a
  -> Maybe a
mod _ 0
  = Nothing
mod a b
  = Just $ P.mod a b

pred
  :: Enum a
  => a
  -> Maybe a
pred
  = unsafeCatch . P.pred

quot
  :: Integral a
  => a
  -> a
  -> Maybe a
quot _ 0 = Nothing
quot x y = Just $ P.quot x y

quotRem
  :: Integral a
  => a
  -> a
  -> Maybe (a,a)
quotRem _ 0 = Nothing
quotRem x y = Just $ P.quotRem x y

read
  :: Read a
  => String
  -> Maybe a
read
  = unsafeCatch . P.read

readIO
  :: Read a
  => String
  -> IO (Maybe a)
readIO s
  = E.catch (P.readIO s) f
  where f :: Monad m => E.ErrorCall -> m (Maybe a)
        f _ = return Nothing

recip
  :: Fractional a
  => a
  -> Maybe a
recip = unsafeCatch . P.recip

rem
  :: Integral a
  => a
  -> a
  -> Maybe a
rem _ 0
  = Nothing
rem a b
  = Just $ P.rem a b

succ
  :: Enum a
  => a
  -> Maybe a
succ
  = unsafeCatch . P.pred

tail
  :: [a]
  -> Maybe [a]
tail []
  = Nothing
tail xs
  = Just $ P.tail xs

toEnum
  :: Enum a
  => Int
  -> Maybe a
toEnum
  = unsafeCatch . P.toEnum
