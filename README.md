# elm-post-render
Code sample demonstrating post render hooks in elm.

This code creates inputs, and then sets focus on them as soon as they're rendered.  `Effects.Tick` allows us to defer the next update until elm's virtual dom is done rendering.

[DEMO: http://maxgurewitz.github.io/elm-post-render/](http://maxgurewitz.github.io/elm-post-render/)
