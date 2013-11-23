CFLAGS = -g

all:	stage2

scm_files = \
	sps-external.scm \
	sps-byte-vector.scm \
	sps-char-map.scm \
	sps-input.scm \
	sps-mem.scm \
	sps-mem-fsp.scm \
	sps-mem-sp.scm \
	sps-input-file.scm \
	sps-lexer-action.scm \
	sps-lexer-error.scm \
	sps-lexer.scm \
	sps-strings-sps.scm \
	sps-hash.scm \
	sps-hash-table.scm \
	sps-ast.scm \
	sps-symbol-table.scm \
	sps-to-c.scm \
	sps-main.scm

pre-scheme-compiler.scm: $(scm_files) scm-join
	@echo Creating $@
	@./scm-join $(scm_files) > $@

bootstrap.c:	pre-scheme-compiler.scm bootstrap-scm.scm
	@echo Converting pre-scheme-compiler.scm to $@
	@printf "(load \"bootstrap-scm.scm\")\n(quit)\n" | scm 

stage1:	bootstrap.c  sps_prelude.h
	gcc $(CFLAGS) -o stage1 bootstrap.c

stage2.c:	stage1 pre-scheme-compiler.scm sps_prelude.h
	./stage1 pre-scheme-compiler.scm stage2.c stage2_preamble.c

stage2:	stage2.c sps_prelude.h
	gcc $(CFLAGS) -o stage2 stage2.c

hello.c: stage2 hello.scm
	./stage2 hello.scm hello.c hello_preamble.c

hello:	hello.c sps_prelude.h
	gcc $(CFLAGS) -o hello hello.c

clean:
	rm -f pre-scheme-compiler.scm bootstrap.c bootstrap_preamble.c stage2.c stage2_preamble.c hello.c hello_preamble.c hello stage1 stage2
