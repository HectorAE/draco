# Automated zipping and installation
# by Hector Escobedo

DESTDIR = /

all : scales.love

scales.love : src
	zip -r -q -9 scales.love src

install :
ifeq ($(findstring scales.love,$(wildcard *.love)),scales.love)
	install -Dm644 scales.love $(DESTDIR)/opt/scales.love

	install -Dm644 README.md $(DESTDIR)/usr/share/doc/scales/README.md
	install -Dm644 LICENSE $(DESTDIR)/usr/share/doc/scales/LICENSE

	install -Dm755 scales $(DESTDIR)/usr/bin/scales
	install -Dm755 scales.desktop $(DESTDIR)/usr/share/applications/scales.desktop
else
	@echo "Nothing to install yet. Try 'make all' first."
endif

clean:
	rm scales.love
