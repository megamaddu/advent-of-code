module Puzzles.P1 where

import Prelude

import Data.Array (foldl, snoc)
import Data.Int as Int
import Data.Maybe (Maybe(..), fromJust)
import Data.String (Pattern(..), split)
import Data.Tuple (fst)
import Data.Tuple.Nested ((/\))
import Partial.Unsafe (unsafePartial)

solve :: String -> String
solve = split (Pattern "\n")
  >>> map (Int.fromString >>> unsafePartial fromJust)
  >>> sumByLastThree
  >>> depth
  >>> show
  where
  depth :: Array Int -> Int
  depth = fst <<< flip foldl (0 /\ top) \(total /\ lastDepth) nextDepth ->
    let
      nextTotal = if nextDepth > lastDepth then total + 1 else total
    in
      nextTotal /\ nextDepth

  sumByLastThree :: Array Int -> Array Int
  sumByLastThree = fst <<< flip foldl ([] /\ Nothing /\ Nothing) \step n ->
    case step of
      xs /\ Just n' /\ Just n'' ->
        let
          x = n + n' + n''
        in
          snoc xs x /\ Just n /\ Just n'
      xs /\ n' /\ _ ->
        xs /\ Just n /\ n'