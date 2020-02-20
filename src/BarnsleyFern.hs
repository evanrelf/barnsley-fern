{-# LANGUAGE NumericUnderscores #-}


module BarnsleyFern (main) where


import Diagrams.Backend.Rasterific.CmdLine (B, mainWith)
import Diagrams.Prelude
import Relude.Unsafe ((!!))
import System.Random (RandomGen, getStdGen, randomR)


f1 :: (Double, Double) -> (Double, Double)
f1 (_x, y) = (x', y') where
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


choose :: Int -> ((Double, Double) -> (Double, Double))
choose roll = f where
  fs = replicate 1 f1
    <> replicate 85 f2
    <> replicate 7 f3
    <> replicate 7 f4
  f = fs !! (roll - 1)


points :: RandomGen g => g -> Int -> [(Double, Double)]
points initialRng n = take n (unfoldr build ((0, 0), initialRng)) where
  build (prevPoint, prevRng) =
    let
      (roll, rng') = randomR (1, 100) prevRng
      p = choose roll prevPoint
    in
      Just (p, (p, rng'))


fern :: Diagram B -> [(Double, Double)] -> Diagram B
fern shape ps = position (fmap (\p -> (p2 p, shape)) ps)


main :: IO ()
main = do
  rng <- getStdGen
  let shape = circle 0.01 # fillColor green # lineWidth none
  mainWith (fern shape (points rng 50000))
