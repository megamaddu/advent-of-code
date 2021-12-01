module Main where

import Prelude

import Data.FoldableWithIndex (traverseWithIndex_)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Node.Encoding (Encoding(..))
import Node.FS.Aff as FS
import Node.Path as Path
import Puzzles.P0 as P0
import Puzzles.P1 as P1

main :: Effect Unit
main = launchAff_ do
  puzzles # traverseWithIndex_ \puzzleIndex solve -> do
    input <- readPuzzleInput puzzleIndex
    let output = solve input
    writePuzzleOutput puzzleIndex output
  where
  puzzles =
    [ P0.solve
    , P1.solve
    ]

  readPuzzleInput idx =
    FS.readTextFile UTF8 $ Path.concat [ "puzzles", show idx, "input" ]

  writePuzzleOutput idx =
    FS.writeTextFile UTF8 $ Path.concat [ "puzzles", show idx, "output" ]