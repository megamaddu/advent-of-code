module Main where

import Prelude

import Data.Foldable (traverse_)
import Data.Tuple.Nested ((/\))
import Effect (Effect)
import Effect.Aff (launchAff_)
import Node.Encoding (Encoding(..))
import Node.FS.Aff as FS
import Node.Path as Path
import Puzzles.P0 as P0
import Puzzles.P1 as P1
import Puzzles.P2 as P2
import Puzzles.P3 as P3

main :: Effect Unit
main = launchAff_ do
  puzzles # traverse_ \(puzzleIndex /\ solve) -> do
    input <- readPuzzleInput puzzleIndex
    let output = solve input
    writePuzzleOutput puzzleIndex output
  where
  puzzles =
    [ 0 /\ P0.solve
    , 1 /\ P1.solve
    , 2 /\ P2.solve
    , 3 /\ P3.solve
    ]

  readPuzzleInput idx =
    FS.readTextFile UTF8 $ Path.concat [ "puzzles", show idx, "input" ]

  writePuzzleOutput idx =
    FS.writeTextFile UTF8 $ Path.concat [ "puzzles", show idx, "output" ]