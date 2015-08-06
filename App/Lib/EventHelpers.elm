module App.Lib.EventHelpers where

import Signal exposing (Address)
import Html.Events exposing (onKeyUp, on, targetValue)
import Html exposing (Attribute)

import App.Common.Actions exposing (..)

onEnterPressed : Address Action -> Action -> Attribute
onEnterPressed address actionToSend =
  onKeyUp address (\kc -> if kc == 13 then actionToSend else NoOp)

onChage : Address Action -> (String -> Action) -> Attribute
onChage address actionToSend =
  on "input" targetValue (Signal.message address << actionToSend)
