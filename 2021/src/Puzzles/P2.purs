module Puzzles.P2 where

import Prelude

import Data.Array (foldl, (!!))
import Data.Int as Int
import Data.Maybe (Maybe(..), fromMaybe)
import Data.String (Pattern(..), split)

solve :: String -> String
solve = split (Pattern "\n")
  >>> foldl runDirections { x: 0, y: 0 }
  >>> (\{ x, y } -> x * y)
  >>> show
  where
  runDirections { x, y } step = fromMaybe { x, y } do
    let parts = split (Pattern " ") step
    cmd <- parts !! 0
    distance <- Int.fromString =<< parts !! 1
    case cmd of
      "forward" ->
        Just { x: x + distance, y }
      "up" ->
        Just { x, y: y - distance }
      "down" ->
        Just { x, y: y + distance }
      _ ->
        Nothing