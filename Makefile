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

.PHONY: clean test

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

# Test fib of 0-12.
test: assert = echo fib\( $(1) \) = $(2); [ "$$( $(MAKE) $(1) )" -eq $(2) ]

test:
	$(call assert,  0,   0)
	$(call assert,  1,   1)
	$(call assert,  2,   1)
	$(call assert,  3,   2)
	$(call assert,  4,   3)
	$(call assert,  5,   5)
	$(call assert,  6,   8)
	$(call assert,  7,  13)
	$(call assert,  8,  21)
	$(call assert,  9,  34)
	$(call assert, 10,  55)
	$(call assert, 11,  89)
	$(call assert, 12, 144)
