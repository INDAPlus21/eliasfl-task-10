# Prolog Go alive checker

Prolog is weird.

## To run

Run the following in `swipl` to check if group is alive:

```prolog
?- ['main.pl'].
true.

?- alive(4, 6, 'dead_example.txt').
false.

?- alive(4, 6, 'alive_example.txt').
true.
```
