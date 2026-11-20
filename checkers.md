# Worked examples I: Checkers and Chess

## Checkers represented abstractly in a category theoretic framework

Consider the game of checkers. We're going to represent it as a collection of categories in the mathematical sense.

### Local State

First, we'll describe the possible configurations of pieces or squares.

These local, stateful units have three properties, each of which have two states.
- _color_
  - _dark_
  - _light_
- _rank_
  - _man_
  - _king_
- _presence_
  - _active_
  - _inactive_

So we can model this as the discrete categories __Chcl__, __Chrk__, and __Chpr__, each with two objects, one for 
each state. Now we can describe a product category __Chst__ induced by the first three categories.

### Local transitions

__Chst__ leaves out a lot of important structure; as a discrete category, it cannot capture the transitions 
available to pieces and squares during a game of checkers. We will introduce some functors to correct this. 
These kinds of structure do not commute, because transitions between piece states cannot be directly translated 
into transitions in local board state (informally: pieces have to move to change, so they never change within a 
single square). So these cannot be endofunctors, we have to introduce new categories so that we don't induce 
invalid compositions. A notation convention: Appending '*' will indicate that we are adding a "piece-wise" element 
or structure, and appending '@' will indicate a "square-wise" element or structure. 

- We add a "promotion" functor from __Chrk__ to __Chrk*__, reflecting that a piece can be promoted.
  - This creates a morphism in __Chrk*__ from _man*_ to _king*_...
  - ...inducing morphisms in __Chst*__ from every product with a _man*_ component to the ones that have a _king*_,
  but hold the other two factors constant.
- We add a "capture" functor from __Chpr__ to __Chpr*__, reflecting that a piece can be captured.
  - This creates a morphism in __Chpr*__ from _active*_ to _inactive*_...
  - ...inducing morphisms in __Chst*__ from every product with an _active*_ component to the ones that have an
  _inactive*_, but hold the other two factors constant.

For __Chst@__, we use a similar approach, but the structure introduced is quite different. If the state of a square 
changes, it goes from empty to full (via leap) or vice versa (via leap or capture). This means that the only morphisms 
in __Chst@__ are transitions in the __Chpr@__ induced component (_inactive@_ is empty, regardless of 
whether a capture was involved).

- We introduce an "occupation" functor from __Chpr__ to __Chrp@__.
  - This creates a morphism in __Chpr@__ from _active@_ to _inactive@_,
  - as well as one from from _inactive@_ to _active@_,
  - inducing morphisms in __Chst@__ to and from every product with an _active@_ component and the ones that have an
  _inactive@_ component, but hold the other two factors constant.
- The occupation functor also adds isomorphisms between all empty states; if the presence factor is _inactive@_, the
  other factors are irrelevant.
- The end result is that __Chst@__ is codiscrete.
  - By composition, a square can transition between any pair of states.
  - This is correct; in the middle of the board (and at this stage we do not know the square's position), squares can
    over the course of the game be occupied by any configuration of piece, and subsequently any other configuration of
    piece.
  - We'll have to represent board positions, as introduced below, to have a basis for more powerful restrictions
    capturing the full rules of any major checkers variant.

### Global state

#### Base Categories: Board Structure and Sequence of Turns

We need two base categories to index board state. The first one is relatively simple: a quiver category __Bsq__ with 
the 32 playable squares of the board as objects, and morphisms capturing adjacency. The default direction of adjacency 
will be "playing as dark", so "playing as light" is simply __Bsq<sup>op</sup>__.

For the second, indexing states over the course of a game, we just use (ℕ,≤), but we also introduce a functor from 
__Chcl__ to its codiscrete analogue __Tncl__, representing the transitions between turns. There is a functor $F$ from 
(ℕ,≤) to __Tncl__ that maps even numbers to _dark_, odd numbers to _light_, and ordering morphisms to the cycle that 
switches in the appropriate direction. We'll add more to this set of structures around turns, but first we need to do a 
bit more with board states.

#### Board State and Legal Move Sequences

Possible board states can be modeled as functors from __Bsq__ to __Chst__. This collection of board states needs to be 
further restricted to the ones that can be reached via sequences of legal moves in a game of checkers. We do this by 
taking the free category on a quiver of legal moves to generate the wide subcategory __Bst__. Each morphism in __Bst__ 
is a single legal move.

The standard starting board state for checkers is, both intuitively and formally, the unique initial object in __Bst__.
There are many terminal objects modeling different ways in which the game can be dictated by the rules to be over, and 
any object can technically be the end of the game if one player resigns.

#### Turns and games

We now introduce another functor category, __Chgms__, the category of legal games of checkers. The objects in this 
category are functors from (ℕ,≤) to __Bst__, each one of which models a game of checkers with only legal turns. 
Component-wise, the objects in (ℕ,≤) map to states of the board that obtain at the start of turns, and the morphisms 
map to legal turns, which might be one move or several moves (if jumps are involved). Composition in __Bst__ provides 
morphisms for multi-move turns.

There is a further functor $G$ from __Bst__ to __Tncl__ that sends state objects to the color(s) that may start a turn in 
that state, and moves to the turn transition that they induce. If a move does not end the turn, it is sent to the 
identity morphism for the current color. Any triangle of $F$, $G$, and any functor in __Chgms__ must commute, so that 
composite paths in __Bst__ can be shown to preserve turn order.
