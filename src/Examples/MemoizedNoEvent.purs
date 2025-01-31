module Examples.MemoizedNoEvent where

import Prelude

import Control.Alt (alt)
import Data.Array (replicate)
import Data.Foldable (traverse_)
import Data.Int (floor, pow)
import Data.Tuple.Nested ((/\))
import Deku.Attribute (cb, (!:=))
import Deku.Attributes (klass_)
import Deku.Control (text)
import Deku.DOM as D
import Deku.Do as Deku
import Deku.Hooks (useMemoized')
import Deku.Toplevel (runInBody)
import Effect (Effect)
import Web.Event.Event (target)
import Web.HTML.HTMLInputElement (fromEventTarget, valueAsNumber)

inputKls :: String
inputKls =
  """rounded-md
border-gray-300 shadow-sm
border-2 mr-2
border-solid
focus:border-indigo-500 focus:ring-indigo-500
sm:text-sm"""

main :: Effect Unit
main = runInBody Deku.do
  setNumber /\ number <- useMemoized'
    (alt (pure 0) <<< map (_ `pow` 2))
  D.div_
    [ D.div_
        [ D.input
            [ klass_ inputKls
            , D.Xtype !:= "number"
            , D.Min !:= "0"
            , D.Max !:= "100"
            , D.Value !:= "0"
            , D.OnChange !:= cb \evt ->
                traverse_ (valueAsNumber >=> floor >>> setNumber) $
                  (target >=> fromEventTarget) evt
            ]
            []
        ]
    , D.div_
        ( replicate 200 $ D.span_
            [ text (show >>> (_ <> " ") <$> number) ]
        )
    ]