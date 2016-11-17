export PATH=/usr/bin:/bin:/usr/local/bin
unexport GROFF_TMAC_PATH

TFLAGS=-p -t -mm -Wall -M./tmac
GROFF=groff

all: fhs.ps fhs.txt fhs.man

fhs.lj4: draft.mm
	$(GROFF) $(TFLAGS) -Tlj4 draft.mm > fhs.lj4

fhs.dvi: draft.mm
	$(GROFF) $(TFLAGS) -Tdvi draft.mm > fhs.dvi

fhs.txt: draft.mm
	$(GROFF) $(TFLAGS) -Tascii draft.mm | col -bx > fhs.txt

fhs.doc: draft.mm
	$(GROFF) $(TFLAGS) -Tlatin1 draft.mm > fhs.doc

fhs.man: draft.mm
	$(GROFF) $(TFLAGS) -man draft.mm > fhs.man

fhs.ps: draft.mm
	$(GROFF) $(TFLAGS) -Tps draft.mm > fhs.ps

fhs.pdf: draft.mm fhs.ps
	ps2pdf fhs.ps fhs.pdf

X75: draft.mm
	$(GROFF) $(TFLAGS) -TX75 draft.mm

X100: draft.mm
	$(GROFF) $(TFLAGS) -TX100 draft.mm

clean:
	rm -f fhs.dvi fhs.ps fhs.txt fhs.doc fhs.lj4
