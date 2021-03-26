#!/usr/bin/env run-script
module Application.Script.ParseInsertSpells where

import           Application.Parser.Parser
import           Application.Script.Prelude
import           Data.Attoparsec.Text
import qualified Data.ByteString.Lazy       as BL
import           Data.Either
import qualified Data.Map                   as M
import qualified Data.Text                  as T
import           IHP.Prelude
import           Network.HTTP.Simple
import           Web.Controller.Prelude

-- | Helper function that updates the SpellMap specId fields with the correct specId
f :: [Int] -> M.Map Int (Id Spec) -> M.Map Int Spell -> M.Map Int Spell
f [] _ m     = m
f (x:xs) p m = f xs p $ M.adjust (\s -> s |> set #specIds (show $ p M.! fromRight 0 (parseOnly decimal (get #specIds s)))) x m

-- | Helper function that given a tuplelist of (specGameId, specId) populates the SpellMap
-- with the correct specIds from the db, concatenating multiple values together
g :: [(Int, Int)] -> M.Map Int (Id Spec) -> M.Map Int Spell -> M.Map Int Spell
g [] _ m          = m
g ((x,y):xs) sm m = g xs sm $ M.adjust (\s -> s |> set #specIds (get #specIds s ++ "," ++ show (sm M.! y))) x m

-- | The actual run script
run :: Script
run = do
    putStrLn "Running ParseInsertSpells script.. "
    putStrLn "Fetching spec IDs..."
    specs <- query @Spec |> fetch
    let specGameIds = map (get #gameId) specs
    let specIds = map (get #id) specs
    let specMap = M.fromList $ zip specGameIds specIds
    putStrLn "Parsing spells.."
    spClassOptionsCsv <- BL.readFile "Test/TestData/Parser/spellclassoptions.csv"
    case parseSpellIdsToMap spClassOptionsCsv M.empty of
      Left err -> putStrLn $ "Failed to parse SpellClassOptions. Aborting. " ++ show err
      Right sp -> do
          putStrLn "Parsed spellClassOptions. Upating class/spec UUIDs..."
          let m = f (M.keys sp) specMap sp
          putStrLn "Done. Parsing spell names.."
          spNamesCsv <- BL.readFile "Test/TestData/Parser/spellname.csv"
          case parseSpellNamesToMap spNamesCsv m of
            Left err -> putStrLn $ "Failed to parse SpellNames. Aborting. " ++ show err
            Right m' -> do
                putStrLn "Parsed spellNames. Parsing spell descriptions.."
                spDescCsv <- BL.readFile "Test/TestData/Parser/spell.csv"
                case parseSpellDescToMap spDescCsv m' of
                  Left err -> putStrLn $ "Failed to parse SpellDescs. Aborting. " ++ show err
                  Right m' -> do
                      putStrLn "Done. Parsing spell specs..."
                      spSpellSpecsCsv <- BL.readFile "Test/TestData/Parser/specializationspells.csv"
                      case parseSpellSpecsToMap spSpellSpecsCsv of
                        Left err -> putStrLn $ "Failed to parse spellSpecs. Aborting - ERR: " ++ show err
                        Right ss -> do
                            let fss = filter (\(p,q) -> p `elem` M.keys m' && q `elem` M.keys specMap) ss
                            let pog = g fss specMap m'
                            deleteAll @Spell
                            ins <- createMany $ M.elems pog
                            putStrLn "Done"

