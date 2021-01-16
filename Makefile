#
#  Makefile
#
#  Copyright (c) 2020 by Daniel Kelley
#

PROG := uri-cache
GEM := gem

.PHONY: all test install gem lib clean

all:
	@echo "targets: gem install clean"

gem: $(PROG).gemspec
	$(GEM) build $<

install: gem
	$(GEM) install $(PROG)

clean:
	-rm -f *.gem
