CAT=cat
ECHO=echo
EMULATOR=openmsx
MACHINE=C-BIOS_MSX1_BR
OUTFILE=nohzdyve
PASMO=pasmo
PYTHON=python
RM=rm -f

.PHONY: default rom test run clean superclean

MODULES=display controller engine tests


define make_variables
	${PYTHON} ../tools/make_variables.py ${MODULES} > __variables.asm
endef


default:
	make rom

all:
	make bin
	make rom 
	
bin:
	${RM} -f ${OUTFILE}.bin
	$(call make_variables)
	${PASMO} -v --alocal --err __binary.asm ${OUTFILE}.bin

rom:
	${RM} -f ${OUTFILE}.rom
	$(call make_variables)
	${PASMO} -v --alocal --err __cartridge.asm ${OUTFILE}.rom
		
test:
	${RM} -f ${OUTFILE}.rom
	$(call make_variables)
	${PASMO} -d -v --alocal --err __cartridge.asm ${OUTFILE}-test.rom ${OUTFILE}.sys |\
		tee -p ${OUTFILE}.log 2> ${OUTFIL}.err

run:
	make rom
	${EMULATOR} -machine ${MACHINE} ${OUTFILE}.rom

run-test:
	${EMULATOR} -machine ${MACHINE} ${OUTFILE}-test.rom

clean:
	${RM} --force --verbose *.rom *.bin

superclean:
	${RM} --force --verbose __variables.asm *.bin *.err *.log *.rom *.sys


