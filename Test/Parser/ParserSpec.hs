{-# LANGUAGE OverloadedStrings #-}
module Test.Parser.ParserSpec where
--
import IHP.Prelude
import Control.Applicative
import Data.Attoparsec.Text
import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import Test.Hspec
import Web.Controller.Prelude
import Generated.Types
import qualified Data.Map as M
import qualified Data.ByteString.Lazy as BL
--
import Application.Parser.Parser
--

-- {{{ ## ParserSpell tests

testParserSpell = do
    describe "parsing single spells from a SpellDump example" $ do
        let testDir = "Test/TestData/Parser/"
        it "parses the spellIds from 'spellclassoptions.csv' into a map" $ do
            c <- BL.readFile $ testDir ++ "spellclassoptions.csv"
            let m = parseSpellIdsToMap c M.empty
            case m of
              Left err -> True `shouldBe` False 
              Right m -> length m `shouldBe` 16371
        it "parses the spellNames from 'spellname.csv' into a map and checks a name" $ do
            c <- BL.readFile $ testDir ++ "spellclassoptions.csv"
            n <- BL.readFile $ testDir ++ "spellname.csv"
            let m = parseSpellIdsToMap c M.empty
            case m of
              Left err -> do
                  putStrLn $ "Error: " ++ show err
                  True `shouldBe` False 
              Right m -> do
                  length m `shouldBe` 16371
                  let names = parseSpellNamesToMap n m
                  case names of
                    Left err -> putStrLn $ "Error: " ++ show err
                    Right nm -> do
                        length nm `shouldBe` 16371
                        let bs = nm M.! 53
                        get #spellName bs `shouldBe` "Backstab"
        it "parses the spellDescs from 'spell.csv' into a map and checks a description" $ do
            c <- BL.readFile $ testDir ++ "spellclassoptions.csv"
            n <- BL.readFile $ testDir ++ "spell.csv"
            let m = parseSpellIdsToMap c M.empty
            case m of
              Left err -> do
                  putStrLn $ "Error: " ++ show err
                  True `shouldBe` False 
              Right m -> do
                  length m `shouldBe` 16371
                  let names = parseSpellDescToMap n m
                  case names of
                    Left err -> putStrLn $ "Error: " ++ show err
                    Right nm -> do
                        length nm `shouldBe` 16371
                        let bs = nm M.! 17
                        get #spellDescription bs `shouldBe` "Shields an ally for $d, absorbing $<shield> damage.  You cannot shield the target again for $6788d."
        it "parses the specialisations from 'chrspecialization.csv' into a map" $ do
            c <- BL.readFile $ testDir ++ "chrspecialization.csv"
            let m = parseChrSpecsToMap c M.empty
            case m of
              Left err -> True `shouldBe` False 
              Right m -> do
                  length m `shouldBe` 54
                  let shadow = m M.! 258
                  chrSpecName shadow `shouldBe` "Shadow"
                  

-- }}}

testParserSpec = hspec testParserSpell
