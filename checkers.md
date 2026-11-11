# Worked examples I: Checkers and Chess
## Checkers represented abstractly in a category theoretic framework

Consider the game of checkers. We're going to represent it as a collection of categories in the mathematical sense.

### Pieces
First, we'll describe the possible configurations of pieces.

Pieces have an immutable property, _color_, with possible values _red_ and _black_. By "immutable", I mean that a 
piece cannot transition from red to black. So we can model this as a discrete category **Chcl** with two objects.

Pieces also have _rank_, which can have the values _man_ or _king_. So this category also has two objects, but because 
a piece can transition from man to king, this is a preordered category, and in fact much stricter, a totally ordered 
category **Chrk**.

Now we can describe a product category **Chpc** induced by the first two categories. This is a skeletal category 
showing that (red, man) transitions to (red, king), and similarly for black pieces.

### Square state
We need one more thing to represent all the possible states of a square on the board: the absence of a piece. So the 
category we actually use for square state values is **Chsq**. There is an inclusion functor from **Chpc** to **Chsq**, 
and the latter simply adds one additional object representing the empty square.

The inclusion functor is free and forgetful, because a square cannot transition directly from one state in **Chpc** to 
another; if the state of a square changes, it goes from empty to full (via leap) or vice versa (via leap or capture). 
This means that the only morphisms in **Chsq** are to and from the empty square. All other states can either go to empty 
or result from it, so the empty square is both initial and terminal. **Chsq** is a pointed category.

### Board state

