{-# LANGUAGE OverloadedStrings #-}
module Application.Parser.Parser where

import           Control.Applicative
import qualified Data.ByteString.Lazy   as BL
import           Data.Csv
import qualified Data.Map               as M
import qualified Data.Text              as T
import qualified Data.Vector            as V
import           Generated.Types
import           IHP.Prelude
import           Web.Controller.Prelude (newRecord, (|>))

-- {{{ ## CSV data types
data CsvSpellId = CsvSpellId
    { id            :: Int,
      spellID       :: Int,
      spellClassSet :: Int
    }

instance FromNamedRecord CsvSpellId where
    parseNamedRecord r =
        CsvSpellId <$> r .: "ID" <*> r .: "SpellID" <*> r .: "SpellClassSet"

data CsvSpellName = CsvSpellName
    { spellNameId   :: Int,
      spellNameLang :: T.Text
    }

instance FromNamedRecord CsvSpellName where
    parseNamedRecord r =
        CsvSpellName <$> r .: "ID" <*> r .: "Name_lang"

data CsvSpellDesc = CsvSpellDesc
    { spellDescId   :: Int,
      spellDescLang :: T.Text
    }

instance FromNamedRecord CsvSpellDesc where
    parseNamedRecord r =
        CsvSpellDesc <$> r .: "ID" <*> r .: "Description_lang"

data CsvChrSpec = CsvChrSpec
    { chrSpecName :: T.Text,
      chrSpecId :: Int,
      chrSpecDesc :: T.Text,
      chrSpecClassId :: Int
    }

instance FromNamedRecord CsvChrSpec where
    parseNamedRecord r =
        CsvChrSpec <$> r .: "Name_lang" <*> r .: "ID" <*> r .: "Description_lang" <*> r .: "ClassID"

data CsvSpellSpec = CsvSpellSpec
    { spellSpecSpellId :: Int,
      spellSpecSpecId :: Int
    }
instance FromNamedRecord CsvSpellSpec where
    parseNamedRecord r =
        CsvSpellSpec <$> r .: "SpellID" <*> r .: "SpecID"

-- }}}

-- {{{ ## Utility functions

spellClassSetToClassId :: Int -> Int
spellClassSetToClassId 6 = 5
spellClassSetToClassId 3 = 8
spellClassSetToClassId 4 = 1
spellClassSetToClassId 9 = 3
spellClassSetToClassId 7 = 11
spellClassSetToClassId 8 = 4
spellClassSetToClassId 5 = 9
spellClassSetToClassId 10 = 2
spellClassSetToClassId 107 = 12
spellClassSetToClassId 15 = 6
spellClassSetToClassId 53 = 10
spellClassSetToClassId _ = 0

-- }}}

-- {{{ ## Parser helper functions

-- | Takes the contents of a csv file containing all the spell by their class options
-- e.g. from https://wow.tools/dbc/?dbc=spellclassoptions and a map to store them in
-- and returns the populated map or an error
parseSpellIdsToMap :: BL.ByteString -> M.Map Int Spell -> Either String (M.Map Int Spell)
parseSpellIdsToMap csvData m =
    case decodeByName csvData of
      Left err -> Left err
      Right (_, v) ->
          Right $ f v m
              where f x m'
                      | V.null x = m'
                      | otherwise = f (V.tail x) $
                          M.insert (spellID (V.head x)) (newRecord @Spell
                          |> set #gameId (spellID (V.head x))
                          |> set #specIds (show (spellClassSetToClassId $ spellClassSet (V.head x)))
                          |> set #buildId "c87b35d7-f107-4f57-90f8-c0c6035e3ff2") m'


-- | Takes the contents of a csv file containing all the spellIds and their names
-- e.g. from https://wow.tools/dbc/?dbc=spellnames and a map of existing spellId <-> Spell to store them in, returning the populated map or an error
parseSpellNamesToMap :: BL.ByteString -> M.Map Int Spell -> Either String (M.Map Int Spell)
parseSpellNamesToMap csvData m =
    case decodeByName csvData of
      Left err -> Left err
      Right (_, v) ->
          Right $ f v m
              where f x m'
                      | V.null x = m'
                      | otherwise = f (V.tail x) $ M.adjust (\s ->
                          s |> set #spellName (spellNameLang (V.head x))) (spellNameId (V.head x)) m'

-- | Takes the contents of a csv file containing all the spellIds and their descriptions
-- e.g. from https://wow.tools/dbc/?dbc=spell and a map of existing spellId <-> Spell to store them in, returning the populated map or an error
parseSpellDescToMap :: BL.ByteString -> M.Map Int Spell -> Either String (M.Map Int Spell)
parseSpellDescToMap csvData m = do
    case decodeByName csvData of
      Left err -> Left err
      Right (_, v) ->
          Right $ f v m
              where f x m'
                      | V.null x = m'
                      | otherwise = f (V.tail x) $ M.adjust (\s ->
                          s |> set #spellDescription (spellDescLang (V.head x))) (spellDescId (V.head x)) m'

-- | Takes the contents of a csv file containing all the character specialisations
-- e.g. from https://wow.tools/dbc/?dbc=chrspecialization and a map of Int <-> CsvChrSpec to store them in, returning the populated map or an error
parseChrSpecsToMap :: BL.ByteString -> M.Map Int CsvChrSpec -> Either String (M.Map Int CsvChrSpec)
parseChrSpecsToMap csvData m = do
    case decodeByName csvData of
      Left err -> Left err
      Right (_, v) ->
          Right $ f v m
              where f x m'
                      | V.null x = m'
                      | otherwise = f (V.tail x) $ M.insert (chrSpecId (V.head x)) (V.head x) m'


-- | Takes the contents of a csv file containing all the spells associated with a specialisations
-- e.g. from https://wow.tools/dbc/?dbc=specializationspells and returns a list of tuples of (spellId, specId) or an error
parseSpellSpecsToMap :: BL.ByteString -> Either String [(Int,Int)]
parseSpellSpecsToMap csvData = do
    case decodeByName csvData of
      Left err -> Left err
      Right (_, v) ->
          Right $ f v []
              where f x m'
                      | V.null x = m'
                      | otherwise = f (V.tail x) $
                          (spellSpecSpellId $ V.head x,spellSpecSpecId $ V.head x):m'
-- }}}
