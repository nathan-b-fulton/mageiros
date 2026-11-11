# Worked examples I: Checkers and Chess
## Checkers represented abstractly in a category theoretic framework

Consider the game of checkers. We're going to represent it as a collection of categories in the mathematical sense.

### Pieces
First, we'll describe the possible configurations of pieces.

Pieces have an immutable property, _color_, with possible values _dark_ and _light_. By "immutable", I mean that a 
piece cannot transition from dark to light. So we can model this as a discrete category **Chcl** with two objects.

Pieces also have _rank_, which can have the values _man_ or _king_. So this category also has two objects, but because 
a piece can transition from man to king, this is a preordered category, and in fact much stricter, a totally ordered 
category **Chrk**.

Now we can describe a product category **Chpc** induced by the first two categories. This is a skeletal category 
showing that (dark, man) transitions to (dark, king), and similarly for light pieces.

### Square state
We need one more thing to represent all the possible states of a square on the board: the absence of a piece. So the 
category we actually use for square state values is **Chsq**. There is an inclusion functor from **Chpc** to **Chsq**, 
and the latter simply adds one additional object representing the empty square.

The inclusion functor is free and forgetful, because a square cannot transition directly from one state in **Chpc** to 
another; if the state of a square changes, it goes from empty to full (via leap) or vice versa (via leap or capture). 
This means that the only morphisms in **Chsq** are to and from the empty square. All other states can either go to empty 
or result from it, so the empty square is both initial and terminal. Thus **Chsq** is a pointed category.

### Board state

#### Base Categories: Board Structure and Time

We need two base categories to index board state. The first one is relatively simple: a discrete category **Bsq** with 
the 32 playable squares of the board. The second is a total order understood as a category **Turn**, with turns as objects 
and transitions between turns as morphisms.

#### First Level of Indexing: Functors From **Bsq** to **Chsq**

Possible board states can be modeled as functors from **Bsq** to **Chsq**. This collection of board states supplies the 
objects in the functor category **Chst**. Not all functors generate valid board states, but we'll identify the invalid 
ones by noting that the morphisms in **Chst** (which are natural transformations) only connect valid board states. So 
once you define constraints on valid moves, isolated elements of the category represent invalid board states; we 
understand them more as board states that cannot be reached than as internally incoherent.

**Chst** is not a thin category because the graph it induces is not acyclic. Once any piece is promoted to king, its 
ability to move both forward and back creates potential cycles of game play. These cycles are limited in practice by 
repetition rules, but rather than try and capture them in **Chst**, we'll wait for **Chgms** below.

The standard starting board state for checkers is, both intuitively and formally, the unique initial object in **Chst**.
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
