.PHONY: preflight package release-check help

VERSION ?= $(shell git describe --tags --always --dirty)
ARCHIVE ?= template.tar.gz

preflight:
	npm run prettier:check
	npm run lint

package:
	git archive --format=tar.gz --output="$(ARCHIVE)" HEAD:template
	shasum -a 256 "$(ARCHIVE)" > "$(ARCHIVE).sha256"

release-check:
	@printf '%s\n' "$(VERSION)" | grep -Eq '^wasp-v[0-9]+\.[0-9]+(\.[0-9]+)?-template$$'
	$(MAKE) preflight
	$(MAKE) package

help:
	@printf '%s\n' \
		'make preflight' \
		'make package' \
		'make release-check VERSION=wasp-v0.18-template'
