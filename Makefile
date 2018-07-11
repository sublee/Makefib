SHELL := /bin/bash

# Match to number for Fibonacci.
#
# $ make -s 42
# 267914296
#
.PHONY:
%:
	$(eval target = $(shell printf "%$@s" | tr ' ' 'x')x)
	@$(MAKE) $(target)
	@cat $(target)

# xxx... files memoize the fib numbers. xxx... with length N keeps fib of N-1.
# So x keeps fib of 0, xx keeps fib of 1.
x:
	@echo 0 > x
xx:
	@echo 1 > xx

# $(xxx) is xxx xxxx xxxxx xxxxxx ...
xxx = $(shell for i in {3..97}; do printf "%$${i}s" | tr ' ' 'x'; echo; done)

# xxx... with length N depends on xxx... with length N-1 and N-2.
$(xxx): %xx: %x %
	@x=$@; \
	\
	a=$${x:0:-1}; \
	b=$${x:0:-2}; \
	\
	fib_a=$$(cat $$a); \
	fib_b=$$(cat $$b); \
	\
	echo $$(( $$fib_a + $$fib_b )) > $@

# Flush all memoized fib numbers.
clean:
	rm -f x*
