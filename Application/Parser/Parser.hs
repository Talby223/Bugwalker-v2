module Application.Parser.Parser
    ( parserBuildString
    , parserSpell
    , parserSpells
    ) where

import Control.Applicative
import IHP.Prelude
import qualified Data.Text as T
import Data.Char
import Web.Controller.Prelude
import Data.Attoparsec.Text
import Generated.Types
import Debug.Trace


-- | Attempts to parse the WoW Client build string from a line e.g.
-- the first line fo the Simc SpellDump txt file. Consumes the line
-- in the process.
parserBuildString :: Parser Text
parserBuildString = do
    Data.Attoparsec.Text.takeWhile (/= 'W')
    asciiCI "World of Warcraft "
    majVersion <- many digit <* char '.'
    medVersion <- many digit <* char '.'
    minVersion <- many digit <* char '.'
    bldVersion <- many digit
    takeTill isEndOfLine <* endOfLine
    return $ T.pack $ majVersion ++ "." ++ medVersion ++ "." ++ minVersion ++ "." ++ bldVersion

-- | Attempts to parse a Simc SpellData block into a bugwalker IHP Spell ADT
-- consuming the block in the process
parserSpell :: Parser Spell
parserSpell = do
    skipWhile (/= ':') <* char ':'
    spellName <- space *> takeTill (== '(') <* asciiCI "(id="
    let x = trace (T.unpack spellName) spellName
    gameId <- decimal <* char ')'
    takeTill isEndOfLine <* endOfLine
    manyTill anyChar (asciiCI "Description")
    skipWhile (/= ':') <* char ':'
    spellDesc <- space *> takeTill isEndOfLine <* endOfLine
    -- manyTill anyChar (endOfInput)
    let spell = newRecord @Spell |> set #spellName (T.init spellName) |> set #gameId gameId |> set #spellDescription spellDesc
    return spell

parserSpells :: Parser [Spell]
parserSpells = parserSpell `sepBy'` (asciiCI "Name")
