% Taken and modified from https://gist.github.com/MuffinTheMan/7806903
% Get an element from a 2-dimensional list at (Row,Column)
% using 1-based indexing.
nth1_2d(Row, Column, List, Element) :-
    nth1(Row, List, SubList),
    nth1(Column, SubList, Element).

read_file(Filename, Symbol) :-
    see(Filename),          % Loads the input-file
    read(Symbol),           % Reads the first Prolog-term from the file
    seen.                   % Closes the io-stream'

% Top-level predicate
% alive(Row, Column, BoardFileName) :-
%     read_file(BoardFileName, Board).
%     % check_ive(Row, Column, Board).

% Checks whether the group of stones connected to
% the stone located at (Row, Column) is alive or dead.
% check_alive(Row, Column, Board) :-
%     \+ is_occupied(Row, Column, Board), !;
%     neighbour(Row, Column, Row_, Column_),
%     same_color(Row, Column, Row_, Column_, Board),
%     check_alive(Row_, Column_, Board).


same_color(Row, Col, Row_, Col_, Board) :-
    nth1_2d(Row, Col, Board, Piece),
    nth1_2d(Row_, Col_, Board, Piece_),
    Piece = Piece_.

% cell_alive(Row, Col, Board) :-
%     neighbours(Row, Col, Board, Cell),
%     Cell = e, !.

is_occupied(Row, Column, Board) :-
    nth1_2d(Row, Column, Board, Stone),
    (Stone = b; Stone = w).

% neighbour(Row, Col, Row1, Col1, B) :-
%     neighbour(Row, Col, Row_, Col_, B),
%     neighbour(Row_, Col_, Row1, Col1, B).
neighbour(Row, Col, Row1, Col1, Board) :-
    (Col = Col1,
    (Row1 is Row + 1; Row1 is Row - 1);
    Row = Row1,
    (Col1 is Col + 1; Col1 is Col - 1)),
    same_color(Row, Col, Row1, Col1, Board).

% Check if group is alive
check_alive(Row, Column, Board, Visited) :-
    \+ member((Row, Column), Visited),
    is_occupied(Row, Column, Board).

% neighbours(Row, Col, Row_, Col_, Board, Neighbour) :-
%     neighbour(Row, Col, Row1, Col1, Board),
%     nth1_2d(Row1, Col1, Board, Neighbour).
