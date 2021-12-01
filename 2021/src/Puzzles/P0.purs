module Puzzles.P0 where

import Prelude

import Data.Array (foldl)
import Data.Int as Int
import Data.Maybe (fromJust)
import Data.String (Pattern(..), split)
import Data.Tuple (fst)
import Data.Tuple.Nested ((/\))
import Partial.Unsafe (unsafePartial)

solve :: String -> String
solve = split (Pattern "\n")
  >>> map (Int.fromString >>> unsafePartial fromJust)
  >>> depth
  >>> show
  where
  depth :: Array Int -> Int
  depth = fst <<< flip foldl (0 /\ top) \(total /\ lastDepth) nextDepth ->
    let
      nextTotal = if nextDepth > lastDepth then total + 1 else total
    in
      nextTotal /\ nextDepth