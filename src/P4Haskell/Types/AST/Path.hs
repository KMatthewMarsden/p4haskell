module P4Haskell.Types.AST.Path
    ( Path(..)
    , parsePath ) where

import           P4Haskell.Types.AST.DecompressJSON

import           Polysemy

import qualified Waargonaut.Decode                  as D

data Path = Path
  { absolute :: Bool
  , name     :: Text
  }
  deriving ( Show, Generic, Eq, Hashable )

parsePath :: DecompressC r => D.Decoder (Sem r) Path
parsePath = D.withCursor . tryParseVal $ \c -> do
  o        <- D.down c
  absolute <- D.fromKey "absolute" D.bool o
  name     <- D.fromKey "name" D.text o
  pure $ Path absolute name
