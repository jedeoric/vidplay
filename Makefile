AS=xa
CC=cl65
CO=co65

CFLAGS=-ttelestrat

PROGRAM=vidplay

LDFILES=src/$(PROGRAM)_cc65.s
SOURCE=src/vidplay.c
ASFLAGS=-R -v -cc 
HOMEDIR=/home/travis/bin/

SOURCE=$(PROGRAM)


vidplay.o:  src/$(PROGRAM).asm
	$(AS)  $(ASFLAGS) src/$(PROGRAM).asm -o src/$(PROGRAM).o
	$(CO) src/$(PROGRAM).o -o src/$(PROGRAM)_cc65.s
	$(CC) $(CFLAGS) -o $(PROGRAM) $(LDFILES) src/vidplay.c

test:
	mkdir -p build/usr/bin/
	mkdir -p build/usr/share/man
	mkdir -p build/usr/share/ipkg  
	cp $(PROGRAM) build/usr/bin/
	cp src/man/$(PROGRAM).hlp build/usr/share/man
	cp src/ipkg/$(PROGRAM).csv build/usr/share/ipkg
	cd build && tar -c * > ../$(PROGRAM).tar && cd ..
	filepack  $(PROGRAM).tar $(PROGRAM).pkg
	gzip $(PROGRAM).tar
	mv $(PROGRAM).tar.gz $(PROGRAM).tgz
	php buildTestAndRelease/publish/publish2repo.php $(PROGRAM).pkg ${hash} 6502 pkg beta
	php buildTestAndRelease/publish/publish2repo.php $(PROGRAM).tgz ${hash} 6502 tgz beta
	echo nothing




