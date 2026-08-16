DESTDIR ?=

LIBDIR  := $(DESTDIR)/usr/lib/kissrd
BINDIR  := $(DESTDIR)/usr/bin
CONFDIR := $(DESTDIR)/etc

.PHONY: \
	all \
	install \
	uninstall \
	install-gentoo-openrc \
	install-gentoo-systemd \
	uninstall-gentoo-openrc \
	uninstall-gentoo-systemd \
	check

all:

install:
	install -Dm755 kissrd $(LIBDIR)/kissrd
	install -Dm755 initramfs/init $(LIBDIR)/initramfs/init
	install -Dm644 config/kissrd.conf $(CONFDIR)/kissrd.conf
	install -d $(BINDIR)
	ln -sf ../lib/kissrd/kissrd $(BINDIR)/kissrd

uninstall:
	rm -rf $(LIBDIR) $(BINDIR)/kissrd

install-gentoo-openrc: install
	install -Dm755 distro/gentoo/openrc/60-kissrd.install $(DESTDIR)/usr/lib/kernel/postinst.d/60-kissrd.install

install-gentoo-systemd: install
	install -Dm755 distro/gentoo/systemd/60-kissrd.install $(DESTDIR)/usr/lib/kernel/install.d/60-kissrd.install

uninstall-gentoo-openrc: uninstall
	rm -f $(DESTDIR)/usr/lib/kernel/postinst.d/60-kissrd.install

uninstall-gentoo-systemd: uninstall
	rm -f $(DESTDIR)/usr/lib/kernel/install.d/60-kissrd.install

check:
	shellcheck -x kissrd
	shellcheck -x initramfs/init
