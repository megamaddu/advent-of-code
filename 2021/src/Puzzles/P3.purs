module Puzzles.P3 where

import Prelude

import Data.Array (foldl, (!!))
import Data.Int as Int
import Data.Maybe (Maybe(..), fromMaybe)
import Data.String (Pattern(..), split)

solve :: String -> String
solve = split (Pattern "\n")
  >>> foldl runDirections { x: 0, y: 0, aim: 0 }
  >>> (\{ x, y } -> x * y)
  >>> show
  where
  runDirections pos@{ x, y, aim } step = fromMaybe pos do
    let parts = split (Pattern " ") step
    cmd <- parts !! 0
    distance <- Int.fromString =<< parts !! 1
    case cmd of
      "forward" ->
        Just { x: x + distance, y: y + (aim * distance), aim }
      "up" ->
        Just { x, y, aim: aim - distance }
      "down" ->
        Just { x, y, aim: aim + distance }
      _ ->
        Nothing