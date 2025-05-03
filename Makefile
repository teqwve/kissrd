DESTDIR ?=

LIBDIR  := $(DESTDIR)/usr/lib/kissrd
BINDIR  := $(DESTDIR)/usr/bin
CONFDIR := $(DESTDIR)/etc
HOOKDIR := $(DESTDIR)/etc/kernel/install.d

.PHONY: all install uninstall install-gentoo uninstall-gentoo check

all:

install:
	install -Dm755 kissrd $(LIBDIR)/kissrd
	install -Dm755 initramfs/init $(LIBDIR)/initramfs/init
	install -Dm644 config/kissrd.conf $(CONFDIR)/kissrd.conf
	install -d $(BINDIR)
	ln -sf ../lib/kissrd/kissrd $(BINDIR)/kissrd

uninstall:
	rm -rf $(LIBDIR) $(BINDIR)/kissrd

install-gentoo: install
	install -Dm755 distro/gentoo/60-kissrd.install $(HOOKDIR)/60-kissrd.install

uninstall-gentoo: uninstall
	rm -f $(HOOKDIR)/60-kissrd.install

check:
	shellcheck -x kissrd
	shellcheck -x initramfs/init
