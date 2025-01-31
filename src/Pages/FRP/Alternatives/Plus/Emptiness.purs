module Pages.FRP.Alternatives.Plus.Emptiness where

import Prelude

import Components.Code (psCode)
import Contracts (Subsection, subsection)
import Deku.Attribute ((!:=))
import Deku.Control (text_)
import Deku.DOM as D

emptiness :: Subsection
emptiness = subsection
  { title: "Emptiness"
  , matter: pure
      [ D.p_
          [ text_ "The empty event is none other than:"
          ]
      , psCode "makeLemmingEvent \\_ _ -> pure (pure unit)"
      , D.p_
          [ text_
              "It just ignores its inputs entirey and returns a no-op unsubscribe."
          ]
      ]
  }
