module BarnsleyFern (main) where


import Diagrams.Backend.SVG.CmdLine (B, mainWith)
import Diagrams.Prelude


fern :: Diagram B
fern = circle 1 # fc green


-- $> :main -o fern.svg -w 400
main :: IO ()
main = mainWith fern
