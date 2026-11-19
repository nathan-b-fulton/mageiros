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
will be "playing as dark", so "playing as light" is simply **Bsq<sup>op</sup>**.

The second is a total order understood as a category __Turn__, with turns as objects and transitions between turns as 
morphisms. It will become apparently shortly that the turns are themselves monoids.

#### Board State and Legal Move Sequences

Possible board states can be modeled as functors from **Bsq** to **Chst**. This collection of board states needs to be 
further restricted to the ones that can be reached via sequences of legal moves in a game of checkers. We do this by 
taking the free category on a quiver of legal moves to generate the wide subcategory **Bst**. Each morphism in **Bst** 
is a single legal move.

The standard starting board state for checkers is, both intuitively and formally, the unique initial object in **Bst**.
There are many terminal objects modeling different ways in which the game can be dictated by the rules to be over, and 
any object can technically be the end of the game if one player resigns.

#### Second Level of Indexing: Functors from **Turn** to **Chst**

We now introduce another functor category, **Chgms**, the category of legal games of checkers. The objects in this 
category are functors from **Turn** to **Chst**, each one of which models a game of checkers with only legal moves. 
Component-wise, the objects in **Turn** map to the states of the board at the beginning of turns, and the morphisms map 
to legal moves from that board state, or another board state reached using a jump that enables a subsequent jump. In 
this latter case, the additional jumps are mapped from endofunctors in **Turn**, indicating that several moves happened 
within the same turn due to the chaining properties of jumps in Checkers.

There is a unique functor from **Turn** back to **Chcl**, showing whose turn it is. This tracks that turns strictly 
alternate, and as noted above, a move may be an endomorphism in **Turn** that does not "advance the turn", even if it 
does map to a change in board state in **Chst**.
