# Makefib

Fibonacci with dynamic programming in GNU `make`.

```console
$ make 42
267914296
```

GNU `make` seems like a dynamic programming framework. So I had wanted to abuse
GNU `make` as an algorithmic problem solver just for fun.

This `Makefile` uses build targets (`x`, `xx`, `xxx`, `xxxx...`) to memoize
calculated Fibonacci numbers; `x` for `fib(0)`, `xx` for `fib(1)`, and `xxx`
for `fib(2)`.
