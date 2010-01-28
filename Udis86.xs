#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <src/udis86.h>

#include "const-c.inc"

typedef ud_t *X86__Udis86;

static ud_t my_ud_obj;

ud_t* _new()
{
	ud_init(&my_ud_obj);

	return(&my_ud_obj);
}

//MODULE = X86::Udis86		PACKAGE = X86::Udis86		PREFIX = ud_
MODULE = X86::Udis86		PACKAGE = X86::Udis86

INCLUDE: const-xs.inc

X86::Udis86
new(CLASS)
        char *CLASS
        CODE:
        RETVAL = _new();

        OUTPUT:
        RETVAL

void
set_input_file(self, file)
        X86::Udis86 self
        FILE *file
        CODE:
	ud_set_input_file(&my_ud_obj, file);

void
set_mode(self, mode)
        X86::Udis86 self
        int mode
        CODE:
	printf("BEFORE + mode is %d\n", my_ud_obj.dis_mode);
	ud_set_mode(self, mode);
	printf("AFTER + mode is %d\n", my_ud_obj.dis_mode);

void
set_syntax(self, syntax)
        X86::Udis86 self
        void *syntax
        CODE:
//	printf("BEFORE + syntax is %d\n", my_ud_obj.dis_syntax);
	ud_set_syntax(self, syntax);
//	printf("AFTER + syntax is %d\n", my_ud_obj.dis_syntax);
