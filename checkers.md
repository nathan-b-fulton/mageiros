# Checkers: A fully worked example in Mageiros
## Checkers represented abstractly in a category theoretic framework

Consider the game of checkers. We're going to represent it as a collection of categories in the mathematical sense.

### Pieces
First, we'll describe possible states of individual squares on the board in terms of the properties of pieces.

Pieces have an immutable property, _color_, with possible values _red_ and _black_. By "immutable", I mean that a 
piece cannot transition from red to black. So we can model this as a discrete category **Chcl** with two objects.

Pieces also have _rank_, which can have the values _man_ or _king_. A piece can transition from man to king, so this 
is a preordered category, and in fact much stricter, a totally ordered category **Chrk**.

Now we can describe a product category **Chpc** induced by the first two categories. This is a skeletal category 
showing that (red, man) transitions to (red, king), and similarly for black pieces.

### Board state
We need one more thing to represent all the possible states of a square on the board: the absence of a piece. So the 
category we actually use for square state values is **Chsq**, which also has a 

