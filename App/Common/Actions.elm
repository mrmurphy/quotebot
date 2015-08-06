module App.Common.Actions where

type Action
  = AddQuote
  | ClearEntry
  | UpdateEntryText String
  | UpdateEntryAuthor String
  | NoOp
