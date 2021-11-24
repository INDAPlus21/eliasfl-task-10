% Taken and modified from https://gist.github.com/MuffinTheMan/7806903
% Get an element from a 2-dimensional list at (Row,Column)
% using 1-based indexing.
nth1_2d(Row, Column, List, Element) :-
    nth1(Row, List, SubList),
    nth1(Column, SubList, Element).

read_file(Filename, Symbol) :-
    see(Filename),     % Loads the input-file
    read(Symbol),            % Reads the first Prolog-term from the file
    seen.                   % Closes the io-stream'


% Top-level predicate
alive(Row, Column, BoardFileName):-
    see(BoardFileName),     % Loads the input-file
    read(Board),            % Reads the first Prolog-term from the file
    seen,                   % Closes the io-stream
    check_alive(Row, Column, Board).

% Checks whether the group of stones connected to
% the stone located at (Row, Column) is alive or dead.
check_alive(Row, Column, Board):-
    nth1_2d(Row, Column, Board, Stone),
    (Stone = b; Stone = w).

neighbour(Row, Col, Row1, Col1) :-
    Col = Col1,
    (Row1 is Row + 1; Row1 is Row - 1);
    Row = Row1,
    (Col1 is Col + 1; Col1 is Col - 1).

neighbours(Board, Row, Col, Neighbour) :-
    neighbour(Row, Col, Row1, Col1),
    nth1_2d(Row1, Col1, Board, Neighbour).