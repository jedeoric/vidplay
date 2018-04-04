AS=xa
CC=cl65
CO=co65

CFLAGS=-ttelestrat

PROGRAM=vidplay
HOMEDIR=/home/travis/bin/
HOMEDIR_PROGRAM=/home/travis/build/oric-software/$(PROGRAM)
LDFILES=src/$(PROGRAM)_cc65.s
SOURCE=src/vidplay.c
ASFLAGS=-R -v -cc 


SOURCE=$(PROGRAM)


vidplay.o:  src/$(PROGRAM).asm
	$(AS)  $(ASFLAGS) src/$(PROGRAM).asm -o src/$(PROGRAM).o
	$(CO) src/$(PROGRAM).o -o src/$(PROGRAM)_cc65.s
	$(CC) $(CFLAGS) -o $(PROGRAM) $(LDFILES) src/vidplay.c



test:
	mkdir -p build/usr/bin/
	mkdir -p build/usr/share/man
	mkdir -p build/usr/share/ipkg
	mkdir -p build/usr/share/$(PROGRAM)
	mkdir -p build/usr/share/doc/$(PROGRAM)  
	cp $(PROGRAM) build/usr/bin/
	cp README.md build/usr/share/doc/$(PROGRAM) 
	cp src/man/$(PROGRAM).hlp build/usr/share/man
	cp src/ipkg/$(PROGRAM).csv build/usr/share/ipkg
	cp data/*.gz build/usr/share/$(PROGRAM)
	cd $(HOMEDIR) && cat $(HOMEDIR_PROGRAM)/src/man/$(PROGRAM).md | md2hlp.py > $(HOMEDIR_PROGRAM)/build/usr/share/man/$(PROGRAM).hlp  
	cd build && tar -c * > ../$(PROGRAM).tar && cd ..
	filepack  $(PROGRAM).tar $(PROGRAM).pkg
	gzip $(PROGRAM).tar
	mv $(PROGRAM).tar.gz $(PROGRAM).tgz
	php buildTestAndRelease/publish/publish2repo.php $(PROGRAM).pkg ${hash} 6502 pkg alpha
	php buildTestAndRelease/publish/publish2repo.php $(PROGRAM).tgz ${hash} 6502 tgz alpha
	echo nothing




