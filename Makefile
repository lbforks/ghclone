PREFIX=/usr/local
DESTDIR=

INSTDIR=$(DESTDIR)$(PREFIX)
INSTBIN=$(INSTDIR)/bin

SRCDIR=src
SCRIPT=ghclone


all:
	@echo did nothing. try targets: install, or uninstall.
.PHONY: all


test:
	bats test
.PHONY: test


install:
	test -d $(INSTDIR) || mkdir -p $(INSTDIR)
	test -d $(INSTBIN) || mkdir -p $(INSTBIN)

	install -m 0755 $(SRCDIR)/$(SCRIPT) $(INSTBIN)
.PHONY: install


uninstall:
	$(RM) $(INSTBIN)/$(SCRIPT)
.PHONY: uninstall
