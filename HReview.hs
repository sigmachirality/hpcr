{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE KindSignatures #-}
import Control.Concurrent
import Control.Exception (bracket)
import Control.Monad.IO.Class
import Data.Aeson
import Database.SQLite.Simple
import GHC.Generics
import GHC.TypeLits
import Network.HTTP.Client (newManager, defaultManagerSettings)
import Network.Wai.Handler.Warp
import Servant
import Servant.Client

data Ratings = Ratings {
    rAmountLearned :: Decimal,
    rCommAbility :: Decimal,
    rCourseQuality :: Decimal,
    rDifficulty :: Decimal,
    rInstructorAccess :: Decimal,
    rInstructorQuality :: Decimal,
    rReadingsValue :: Decimal,
    rRecommendMajor :: Decimal,
    rRecommentNonMajor :: Decimal,
    rStimulateInterest :: Decimal,
    rWorkRequired :: Decimal
    }

data Instructor = Instructor {
    code :: String,
    name :: String,
    average_reviews :: Ratings,
    recent_reviews :: Ratings
    }

data Course = Course { 
    code :: String, 
    aliases :: [String], 
    name :: String, 
    description :: String,
    average_ratings :: Ratings,
    recent_ratings :: Ratings,
    num_sections :: Int,
    num_sections_recent :: Int,
    instructors :: [Instructor]
    }

data Department = Department {
    code :: String,
    name :: String,
    average_reviews :: Ratings,
    recent_reviews :: Ratings
    }

