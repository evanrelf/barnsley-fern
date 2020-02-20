module BarnsleyFern (main) where


import Diagrams.Backend.SVG.CmdLine (B, mainWith)
import Diagrams.Prelude


f1 :: (Double, Double) -> (Double, Double)
f1 (x, y) = (x', y') where
  x' = 0
  y' = 0.16 * y


f2 :: (Double, Double) -> (Double, Double)
f2 (x, y) = (x', y') where
  x' = (0.85 * x) + (0.04 * y)
  y' = (-0.04 * x) + (0.85 * y) + 1.6


f3 :: (Double, Double) -> (Double, Double)
f3 (x, y) = (x', y') where
  x' = (0.2 * x) - (0.26 * y)
  y' = (0.23 * x) + (0.22 * y) + 1.6


f4 :: (Double, Double) -> (Double, Double)
f4 (x, y) = (x', y') where
  x' = (-0.15 * x) + (0.28 * y)
  y' = (0.26 * x) + (0.24 * y) + 0.44


fern :: Diagram B
fern = circle 1 # fc green


-- $> :main -o fern.svg -w 400
main :: IO ()
main = mainWith fern
