SCRIPT = ghclone
SRCDIR = src

PREFIX  = /usr/local
DESTDIR =
INSTDIR = $(DESTDIR)$(PREFIX)
INSTBIN = $(INSTDIR)/bin


all:
	@echo did nothing. try targets: install, or uninstall.
.PHONY: all


test:
	test/run_tests.sh
.PHONY: test


install:
	test -d $(INSTDIR) || mkdir -p $(INSTDIR)
	test -d $(INSTBIN) || mkdir -p $(INSTBIN)

	install -m 0755 $(SRCDIR)/$(SCRIPT) $(INSTBIN)
.PHONY: install


uninstall:
	$(RM) $(INSTBIN)/$(SCRIPT)
.PHONY: uninstall
