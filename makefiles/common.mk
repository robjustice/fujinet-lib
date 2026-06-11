# Derive VERSION_STRING from git state:
# - clean checkout exactly on a tag -> tag name without leading "v" (e.g. 2.1.2)
# - otherwise -> short commit hash, with "-dirty" suffix if the tree is dirty
GIT_EXACT_TAG := $(shell git describe --exact-match --tags HEAD 2>/dev/null)
GIT_SHORT_HASH := $(shell git rev-parse --short HEAD 2>/dev/null || echo unknown)
GIT_DIRTY := $(shell test -n "$$(git status --porcelain 2>/dev/null)" && echo dirty)

ifneq ($(GIT_DIRTY),)
VERSION_STRING := $(GIT_SHORT_HASH)-dirty
else ifneq ($(GIT_EXACT_TAG),)
VERSION_STRING := $(patsubst v%,%,$(GIT_EXACT_TAG))
else
VERSION_STRING := $(GIT_SHORT_HASH)
endif
