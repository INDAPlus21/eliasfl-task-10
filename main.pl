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
% Example query: `alive(4, 6, 'alive_example.txt').`
alive(Row, Column, BoardFileName) :-
    read_file(BoardFileName, Board),
    nth1_2d(Row, Column, Board, Stone),
    (Stone = b; Stone = w),
    check_alive(Row, Column, Board, []).

same_color(Row, Col, Row_, Col_, Board) :-
    nth1_2d(Row, Col, Board, Piece),
    nth1_2d(Row_, Col_, Board, Piece_),
    Piece = Piece_.

is_empty(Row, Column, Board) :-
    nth1_2d(Row, Column, Board, Stone),
    \+ (Stone = b; Stone = w).

% Assign Row_, Col_ to neighbours of Row, Col
neighbour(Row, Col, Row_, Col_) :-
    (Col = Col_,
    (Row_ is Row + 1; Row_ is Row - 1);
    Row = Row_,
    (Col_ is Col + 1; Col_ is Col - 1)).

% Neighbours with Color
neighbours(Row, Col, Row_, Col_, Board, Color) :-
    neighbour(Row, Col, Row_, Col_),
    nth1_2d(Row_, Col_, Board, Color).

% Checks whether the group of stones connected to
% the stone located at (Row, Column) is alive or dead.
check_alive(Row, Column, Board, Visited) :-
    \+ member([Row, Column], Visited),
    nth1_2d(Row, Column, Board, Stone),
    ((\+ (Stone = w; Stone = b));
    (neighbours(Row, Column, Row_, Col_, Board, Stone_), Stone_ = Stone,
    check_alive(Row_, Col_, Board, [[Row, Column]|Visited]))). % check alive for neighbour of same color
