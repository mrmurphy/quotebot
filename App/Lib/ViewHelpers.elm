module App.Lib.ViewHelpers where

import Html exposing (div, text, textarea, Html, nav, Attribute, a, input, h1)
import Html.Attributes exposing (class, href, style, type', name, for)

pageHeader : String -> Html
pageHeader content =
  nav [style [("textAlign", "center"), ("padding", "2em"), ("background", "#27ae60")]]
    [ h1 [style [("margin", "0"), ("color", "white")]] [text content]
    ]

grid : List Html -> Html
grid children =
  div [class "container"] children

row : List Html -> Html
row children =
  div [class "row"] children

col : Int -> List Html -> Html
col num children =
  div [class ("col-xs-" ++ toString num)] children

mrtextarea : String -> List Attribute -> Html
mrtextarea label attrs =
  div []
    [ Html.label [] [ text label ]
    , textarea ([class "form-control"] ++ attrs) []
    ]

mrtextinput : String -> List Attribute -> Html
mrtextinput label attrs =
  div []
    [ Html.label [] [ text label ]
    , input ([type' "text", class "form-control"] ++ attrs) []
    ]
