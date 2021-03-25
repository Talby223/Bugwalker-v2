#!/usr/bin/env run-script
module Application.Script.ParseInsertSpecs where

import           Application.Parser.Parser
import           Application.Script.Prelude
import qualified Data.Map                   as M
import           IHP.Prelude
import           Network.HTTP.Simple
import           Web.Controller.Prelude
import Data.Foldable (forM_)
import qualified Data.ByteString.Lazy as BL

run :: Script
run = do
    putStrLn "Running ParseInsertSpecs script..."
    --let baseUrl = "https://wow.tools/dbc/?dbc=chrspecialization&build=9.0.5.37988#page=1"
    --response <- httpLBS baseUrl
    --putStrLn $ "The status code was: " ++ show (getResponseHeaders response)
    --let url = "https://wow.tools/dbc/api/export/?name=chrspecialization&build=9.0.5.37988"
    --putStrLn $ "Fetching .csv from " ++ show url
    --response <- httpLBS url
    --putStrLn $ "The status code was: " ++ show (getResponseStatusCode response)
    -- let body = getResponseBody response
    body <- BL.readFile "Test/TestData/Parser/chrspecialization.csv"
    case parseChrSpecsToMap body M.empty of
      Left err -> putStrLn $ "Error while parsing specs to map. Aborted. Err: " ++ show err
      Right sm -> do
          putStrLn "Deleting all specs.."
          deleteAll @Spec
          putStrLn "Inserting new specs..."
          forM_ (M.toList sm) $ \(k,v) -> do
              if chrSpecClassId v > 0 && chrSpecName v /= "Initial" then do
                  s <- newRecord @Spec
                    |> set #gameId (chrSpecId v)
                    |> set #gameClassId (chrSpecClassId v)
                    |> set #specName (chrSpecName v)
                    |> set #specDescription (chrSpecDesc v)
                    |> createRecord
                  putStrLn "Inserted spec"
              else putStrLn "Skipping placeholder spec"
          -- add base specs
          putStrLn "Inserting base specs.."
          let warrior = newRecord @Spec |> set #gameId 1 |> set #gameClassId 1 |> set #specName "Warrior"
              paladin = newRecord @Spec |> set #gameId 2 |> set #gameClassId 2 |> set #specName "Paladin"
              hunter = newRecord @Spec |> set #gameId 3 |> set #gameClassId 3 |> set #specName "Hunter"
              rogue = newRecord @Spec |> set #gameId 4 |> set #gameClassId 4 |> set #specName "Rogue"
              priest = newRecord @Spec |> set #gameId 5 |> set #gameClassId 5 |> set #specName "Priest"
              dk = newRecord @Spec |> set #gameId 6 |> set #gameClassId 6 |> set #specName "Death Knight"
              shaman = newRecord @Spec |> set #gameId 7 |> set #gameClassId 7 |> set #specName "Shaman"
              mage = newRecord @Spec |> set #gameId 8 |> set #gameClassId 8 |> set #specName "Mage"
              warlock = newRecord @Spec |> set #gameId 9 |> set #gameClassId 9 |> set #specName "Warlock"
              monk = newRecord @Spec |> set #gameId 10 |> set #gameClassId 10 |> set #specName "Monk"
              druid = newRecord @Spec |> set #gameId 11 |> set #gameClassId 11 |> set #specName "Druid"
              dh = newRecord @Spec |> set #gameId 12 |> set #gameClassId 12 |> set #specName "Demon Hunter"
              gen = newRecord @Spec |> set #gameId 0 |> set #gameClassId 0 |> set #specName "General"
          createMany [gen, warrior, paladin, hunter, rogue, priest, dk, shaman, mage, warlock, monk, druid, dh] 
          putStrLn "Inserted base specs."
          putStrLn "Done."

