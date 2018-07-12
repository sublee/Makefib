# =======
# Makefib
# =======
#
# Match to number for Fibonacci.
#
# $ make 42
# 267914296
#
MAKEFLAGS := --silent

.PHONY: clean

%: TARGETS = \
	$(foreach i,$(shell seq 0 $@), \
		$(shell printf "%$$(( $i + 1 ))s" | tr ' ' 'x') \
	)

%:
	# Dependencies are solved at here. Here calls "make x xx xxx xxxx" for
	# "xxxx".
	@$(MAKE) $(TARGETS)

	# And prints the content of "xxxx" for "xxxx". It will print fib of 3.
	@cat $(lastword $(TARGETS))

# xxx... files memoize the fib numbers. xxx... with length N keeps fib of N-1.
# So x keeps fib of 0, xx keeps fib of 1.
x:
	@echo 0 > x

xx:
	@echo 1 > xx

# xxx... with length N depends on xxx... with length N-1 and N-2.
%xx: %x %
	a=$$(cat $(word 1,$^)); \
	b=$$(cat $(word 2,$^)); \
	echo $$(( $$a + $$b )) > $@

# Flush all memoized fib numbers.
clean:
	rm -f x*
