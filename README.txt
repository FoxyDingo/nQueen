Created by Francisco Durão (https://github.com/FoxyDingo)

The n queens puzzle is the problem of placing n chess queens on an n×n chessboard so that no two queens threaten each other.
Thus, a solution requires that no two queens share the same row, column, or diagonal.

"procura.lisp" contains code created by the professors of the PPLN course in tecnico. This code implements several searching
algorithms such as depth-first search, breadth-first search, a* search etc.

"nqueen.cl" contains code created by me (Francisco Durão) which implements specific functions (heuristics, objective state etc)
for the nqueen problem that then use the search algorithms implemented in "procura.lisp" to find a solution.

The board is represented by the positions of the queens on each line of the board.
For ex board (0 NIL 3 NIL NIL) means the board is 5x5 and there is a queen on line 0, column 0
and another queen at line 2, column 3.

"resolve-problema" is the function to call to solve the nqueen problem. It takes two arguments: the initial state and the search
algorithm to use.
I recommend using a* search, for it is the fastest, but feel free to try others.

Example to solve the n-queen problem for a 9x9 empty board:
run clisp (or any other lisp implementation)
Then type:
(in-package :user)
(load "nqueen.fas")
(load "procura.fas")
(resolve-problema (make-list 9) 'a*)

You can also feed a board with some queens already placed (you can not feed an impossible board though):
run clisp (or any other lisp implementation)
Then type:
(in-package :user)
(load "nqueen.fas")
(load "procura.fas")
(resolve-problema '(NIL 0 NIL NIL NIL 3 NIL NIL) 'a*)

