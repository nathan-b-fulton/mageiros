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

- We introduce an "occupation" functor from __Chpr__ to __Chpr@__.
  - This creates a morphism in __Chpr@__ from _active@_ to _inactive@_,
  - as well as one from _inactive@_ to _active@_,
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

For the second, indexing states over the course of a game, we just use finite ordinals 
$`[n] = (0 \to 1 \to \dots \to n)`$, but we also introduce a functor from __Chcl__ to its codiscrete analogue __Tncl__, 
representing the transitions between turns. There is a functor $F$ from the finite ordinals to __Tncl__ that maps even 
numbers to _dark_, odd numbers to _light_, and ordering morphisms to the cycle that switches in the appropriate direction. 
We'll add more to this set of structures around turns, but first we need to do a bit more with board states.

#### Board State and Legal Move Sequences

Possible board states can be modeled as pairs $`(B, c)`$ where $B$ is a functor from __Bsq__ to __Chst@__, and 
$c \in \text{Ob}(\mathbf{Tncl})$ indicates whose turn the move falls within. This collection of board states needs to be 
further restricted to the ones that can be reached via sequences of legal moves in a game of checkers. We do this by 
taking the free category on a quiver whose vertices are board states and whose edges are legal moves: __Bst__. Each 
generating edge of __Bst__ is a single legal move, and morphisms are legal move sequences.

The standard starting board state for checkers, paired with _dark_ to acknowledge that dark goes first in standard 
American rules, is a root object in __Bst__, and there are many sink objects that model different ways in which the game 
can be dictated by the rules to be over. In fact any object can technically be the end of the game if one player resigns, 
though we only regard states with no valid moves out as formal sinks.

#### Turns and games

We now introduce another functor category, __Chgms__, the category of legal games of checkers. The objects in this 
category are functors from the finite ordinals to __Bst__, each one of which models a game of checkers with only legal 
turns. Component-wise, the finite ordinals map to states of the board that obtain at the start of turns, and the order 
morphisms map to legal turns, which might be one move or several moves (if jumps are involved). Composition in __Bst__ 
provides morphisms for multi-move turns.

There is a further functor $G$ from __Bst__ to __Tncl__ that sends state objects to the color that starts a turn in that 
state, and moves to the turn transition that they induce. If a move does not end the turn, it is sent to the identity 
morphism for the current color. Any triangle of $F$, $G$, and any functor in __Chgms__ must commute, so that composite 
paths in __Bst__ can be shown to preserve turn order. Put a bit more rigorously, __Chgms__ is a subcategory of the slice 
category $`\mathbf{Cat} / \mathbf{Tncl}`$, or a fiber of the post-composition functor 
$`G_*: [\mathbf{FinOrd}, \mathbf{Bst}] \to [\mathbf{FinOrd}, \mathbf{Tncl}]`$ over F.
