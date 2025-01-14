-- | Wraps the functions of Javascript's `String` object.
-- | A String represents a sequence of characters.
-- | For details of the underlying implementation, see [String Reference at MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String).
module Data.String
  ( charAt
  , charCodeAt
  , fromCharArray
  , fromChar
  , toChar
  , contains
  , indexOf
  , indexOf'
  , lastIndexOf
  , lastIndexOf'
  , null
  , uncons
  , length
  , singleton
  , localeCompare
  , replace
  , count
  , take
  , takeWhile
  , drop
  , dropWhile
  , split
  , toCharArray
  , toLower
  , toUpper
  , trim
  , joinWith
  ) where

import Prelude
import Data.Char
import Data.Maybe (Maybe(..), isJust)
import Data.Monoid (Monoid)
import qualified Data.String.Unsafe as U

-- | Returns the character at the given index, if the index is within bounds.
charAt :: Int -> String -> Maybe Char
charAt = _charAt Just Nothing

foreign import _charAt :: (forall a. a -> Maybe a)
                       -> (forall a. Maybe a)
                       -> Int
                       -> String
                       -> Maybe Char

-- | Returns a string of length `1` containing the given character.
fromChar :: Char -> String
fromChar = toString

-- | Returns a string of length `1` containing the given character.
-- | Same as `fromChar`.
singleton :: Char -> String
singleton = fromChar

-- | Returns the numeric Unicode value of the character at the given index,
-- | if the index is within bounds.
charCodeAt :: Int -> String -> Maybe Int
charCodeAt = _charCodeAt Just Nothing

foreign import _charCodeAt :: (forall a. a -> Maybe a)
                           -> (forall a. Maybe a)
                           -> Int
                           -> String
                           -> Maybe Int

toChar :: String -> Maybe Char
toChar = _toChar Just Nothing

foreign import _toChar :: (forall a. a -> Maybe a)
                       -> (forall a. Maybe a)
                       -> String
                       -> Maybe Char

-- | Returns `true` if the given string is empty.
null :: String -> Boolean
null s = length s == zero

-- | Returns the first character and the rest of the string,
-- | if the string is not empty.
uncons :: String -> Maybe { head :: Char, tail :: String }
uncons "" = Nothing
uncons s  = Just { head: U.charAt zero s, tail: drop one s }

-- | Returns the longest prefix (possibly empty) of characters that satisfy
-- | the predicate:
takeWhile :: (Char -> Boolean) -> String -> String
takeWhile p s = take (count p s) s

-- | Returns the suffix remaining after `takeWhile`.
dropWhile :: (Char -> Boolean) -> String -> String
dropWhile p s = drop (count p s) s

-- | Converts an array of characters into a string.
foreign import fromCharArray :: Array Char -> String

-- | Checks whether the first string exists in the second string.
contains :: String -> String -> Boolean
contains x s = isJust (indexOf x s)

-- | Returns the index of the first occurrence of the first string in the
-- | second string. Returns `Nothing` if there is no match.
indexOf :: String -> String -> Maybe Int
indexOf = _indexOf Just Nothing

foreign import _indexOf :: (forall a. a -> Maybe a)
                        -> (forall a. Maybe a)
                        -> String
                        -> String
                        -> Maybe Int

-- | Returns the index of the first occurrence of the first string in the
-- | second string, starting at the given index. Returns `Nothing` if there is
-- | no match.
indexOf' :: String -> Int -> String -> Maybe Int
indexOf' = _indexOf' Just Nothing

foreign import _indexOf' :: (forall a. a -> Maybe a)
                         -> (forall a. Maybe a)
                         -> String
                         -> Int
                         -> String
                         -> Maybe Int

-- | Returns the index of the last occurrence of the first string in the
-- | second string. Returns `-1` if there is no match.
lastIndexOf :: String -> String -> Maybe Int
lastIndexOf = _lastIndexOf Just Nothing

foreign import _lastIndexOf :: (forall a. a -> Maybe a)
                            -> (forall a. Maybe a)
                            -> String
                            -> String
                            -> Maybe Int

-- | Returns the index of the last occurrence of the first string in the
-- | second string, starting at the given index. Returns `Nothing` if there is
-- | no match.
lastIndexOf' :: String -> Int -> String -> Maybe Int
lastIndexOf' = _lastIndexOf' Just Nothing

foreign import _lastIndexOf' :: (forall a. a -> Maybe a)
                             -> (forall a. Maybe a)
                             -> String
                             -> Int
                             -> String
                             -> Maybe Int

-- | Returns the number of characters the string is composed of.
foreign import length :: String -> Int

-- | Locale-aware sort order comparison.
localeCompare :: String -> String -> Ordering
localeCompare = _localeCompare LT EQ GT

foreign import _localeCompare :: Ordering
                              -> Ordering
                              -> Ordering
                              -> String
                              -> String
                              -> Ordering

-- | Replaces the first occurence of the first argument with the second argument.
foreign import replace :: String -> String -> String -> String

-- | Returns the first `n` characters of the string.
foreign import take :: Int -> String -> String

-- | Returns the string without the first `n` characters.
foreign import drop :: Int -> String -> String

-- | Returns the number of characters in the string for which the predicate holds.
foreign import count :: (Char -> Boolean) -> String -> Int

-- | Returns the substrings of the first string separated along occurences
-- | of the second string.
foreign import split :: String -> String -> Array String

-- | Converts the string into an array of characters.
foreign import toCharArray :: String -> Array Char

-- | Returns the argument converted to lowercase.
foreign import toLower :: String -> String

-- | Returns the argument converted to uppercase.
foreign import toUpper :: String -> String

-- | Removes whitespace from the beginning and end of a string, including
-- | [whitespace characters](http://www.ecma-international.org/ecma-262/5.1/#sec-7.2)
-- | and [line terminators](http://www.ecma-international.org/ecma-262/5.1/#sec-7.3).
foreign import trim :: String -> String

-- | Joins the strings in the array together, inserting the first argument
-- | as separator between them.
foreign import joinWith :: String -> Array String -> String
