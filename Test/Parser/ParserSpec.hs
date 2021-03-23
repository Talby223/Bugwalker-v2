{-# LANGUAGE OverloadedStrings #-}
module Test.Parser.ParserSpec where
--
import IHP.Prelude
import Control.Applicative
import Data.Attoparsec.Text
import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import Test.Hspec
import Test.Hspec.Attoparsec
import Web.Controller.Prelude
import Generated.Types
--
import Application.Parser.Parser
--

-- {{{ ## ParserBuildString Tests 
-- | Testing the spellDump build string parser 

testParserBuildString = do
    describe "parsing WoW build string from a SpellDump example line" $ do
        it "correctly parses 9.0.5.37988 build string" $ do
            ("SimulationCraft 905-01 for World of Warcraft \
            \9.0.5.37988 Live (hotfix 2021-03-19/37988)\n" :: T.Text) ~> parserBuildString `shouldParse` "9.0.5.37988"
        it "correctly parses 9.0.5.37311 build string without hotfix" $ do
            ("SimulationCraft 905-01 for World of Warcraft \
            \9.0.5.37311\n" :: T.Text) ~> parserBuildString `shouldParse` "9.0.5.37311"
        it "correctly parses 9.1.0.2122 build string without hotfix" $ do
            ("SimulationCraft 910-02 for World of Warcraft \
            \9.1.0.2122\n" :: T.Text) ~> parserBuildString `shouldParse` "9.1.0.2122"
-- }}}

-- {{{ ## ParserSpell tests

testParserSpell = do
    describe "parsing single spells from a SpellDump example" $ do
        let testDir = "Test/TestData/Parser/"
        it "parses the 'OneSpell.txt' file correctly" $ do
            c <- TIO.readFile $ testDir ++ "OneSpell.txt"
            parserSpell `shouldSucceedOn` (c :: T.Text)
        it "parses the 'TwoSpells.txt' file correctly" $ do
            c <- TIO.readFile $ testDir ++ "TwoSpells.txt"
            parserSpells `shouldSucceedOn` (c :: T.Text)
        it "parses the 'TwoSpells.txt' file correctly" $ do
            c <- TIO.readFile $ testDir ++ "TwoSpells.txt"
            let sp1 = newRecord @Spell |> set #spellName "Cone of Cold" |> set #gameId 120 |> set #spellDescription "Targets in a cone in front of you take $s1 Frost damage and have movement slowed by $212792m1% for $212792d." 
            let sp2 = newRecord @Spell |> set #spellName "Frost Nova" |> set #gameId 122 |> set #spellDescription "Blasts enemies within $A2 yds of you for $s2 Frost damage and freezes them in place for $d. Damage may interrupt the freeze effect." 
            (c :: T.Text) ~> parserSpells `shouldParse` [sp1,sp2]   
                  

-- }}}

testParserSpec = hspec $ do
    testParserBuildString
    testParserSpell