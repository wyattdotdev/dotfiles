-include lib/borg/borg.mk

ifndef BORG_DIR

help helpall::
        $(info )
        $(info Bootstrapping)
        $(info -------------)
        $(info make bootstrap-borg  -- Make borg and make targets available)
        @printf "\n"

GITDIR := $(shell realpath --relative-to=. "$$(git rev-parse --git-dir)")
SRCDIR ?= $(shell git config -f .gitmodules submodule.borg.path)
URL    ?= $(shell git config -f .gitmodules submodule.borg.url)

bootstrap-borg:
        mkdir -p "$(GITDIR)/modules"
        git clone $(URL) $(SRCDIR) --separate-git-dir "$(GITDIR)/modules/borg"

endif
