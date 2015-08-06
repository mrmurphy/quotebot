module App.Main where

import Html exposing (div, Html, text, textarea, input, button, h3, h4)
import Html.Attributes exposing (class, type', value, autofocus, placeholder, href, style)
import Signal exposing (Address)
import StartApp
import List

import App.Common.Actions exposing (..)
import App.Lib.ViewHelpers exposing (pageHeader, grid, row, col, mrtextarea, mrtextinput)
import App.Lib.EventHelpers exposing (onEnterPressed, onChage)

-- # Main

main =
  StartApp.start { model = model, view = view, update = update }

-- # Model

emptyQuote : Quote
emptyQuote = {author = "", text = ""}

type alias Quote = {author: String, text: String}
type alias Quotes = List Quote
type alias Model  = {entry: Quote, quotes: Quotes}
model : Model
model = {entry = emptyQuote, quotes = []}

-- # Actions

update : Action -> Model -> Model
update action model =
  case action of
    AddQuote -> {model | quotes <- [model.entry] ++ model.quotes, entry <- emptyQuote}
    ClearEntry -> {model | entry <- emptyQuote}
    UpdateEntryText newText ->
      let currentEntry = model.entry
      in {model | entry <- {currentEntry | text <- newText}}
    UpdateEntryAuthor newAuthor ->
      let currentEntry = model.entry
      in {model | entry <- {currentEntry | author <- newAuthor}}
    NoOp -> model

-- # View

view : Address Action -> Model -> Html
view address model =
  div [class "app-wrapper"]
    [ pageHeader "Quotebot!"
    , quoteEntry address model.entry
    , grid
        [ row
            [ col 12 [h3 [style [("marginTop", "4rem"), ("marginBottom", "1rem")]] [text "Quotes from the past"]]
            , col 12 [div [style [("fontSize", "1.5em"), ("color", "#ccd3d5"), ("marginLeft", "4rem")]] [if List.isEmpty model.quotes then (text "No Quotes Yet!") else (text "")]]
            , div [] (List.map renderQuote model.quotes)
            ]
        ]
    ]

quoteEntry : Address Action -> Quote -> Html
quoteEntry address quote =
  grid
    [ row
        [ col 12 [h3 [] [text "Add a quote"]]
        , col 12 [mrtextarea "Quote" [style [("marginBottom", "1rem"), ("minHeight", "10em")], autofocus True, onChage address UpdateEntryText, value quote.text]]
        , col 12 [mrtextinput "Author" [onEnterPressed address AddQuote, onChage address UpdateEntryAuthor, value quote.author]]
        ]
    ]

renderQuote : Quote -> Html
renderQuote quote =
  col 12 [
    div [style [("padding", "0 4rem")]]
      [ div [class "quote-text"] [text quote.text]
      , div [class "quote-author"] [text "~ ", text quote.author]
      ]
    ]
