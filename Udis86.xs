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
set_input_buffer(self, buffer, size);
        X86::Udis86 self
        unsigned char *buffer
        size_t size
        CODE:
	ud_set_input_buffer(self, buffer, size);

void
set_input_file(self, file)
        X86::Udis86 self
        FILE *file
        CODE:
	ud_set_input_file(self, file);

void
set_mode(self, mode)
        X86::Udis86 self
        int mode
        CODE:
	fprintf(stderr, "BEFORE + mode is %d\n", my_ud_obj.dis_mode);
	ud_set_mode(self, mode);
	fprintf(stderr, "AFTER + mode is %d\n", my_ud_obj.dis_mode);

void 
set_pc(self, pc)
        X86::Udis86 self
        unsigned int pc
	CODE:
	ud_set_pc(self, pc);

void
set_syntax(self, syntax)
        X86::Udis86 self
        char *syntax
	char *intel = "intel";
	char *att = "att";
        CODE:
        if (strncmp(syntax, intel, strlen(intel)) == 0)
		ud_set_syntax(self, UD_SYN_INTEL);
        if (strncmp(syntax, att, strlen(att)) == 0)
		ud_set_syntax(self, UD_SYN_ATT);

void
set_vendor(self, vendor)
        X86::Udis86 self
        char *vendor
	char *intel = "intel";
	char *amd = "amd";
        CODE:
	fprintf(stderr, "BEFORE + vendor is %d\n", my_ud_obj.vendor);
        if (strncmp(vendor, intel, strlen(intel)) == 0)
		ud_set_vendor(self, UD_VENDOR_INTEL);
        if (strncmp(vendor, amd, strlen(amd)) == 0)
		ud_set_vendor(self, UD_VENDOR_AMD);
	fprintf(stderr, "AFTER + mode is %d\n", my_ud_obj.vendor);

unsigned int 
disassemble(self)
        X86::Udis86 self
        CODE:
        RETVAL = ud_disassemble(self);

        OUTPUT:
        RETVAL

unsigned int 
insn_len(self)
        X86::Udis86 self
        CODE:
        RETVAL = ud_insn_len(self);

        OUTPUT:
        RETVAL

unsigned int 
insn_off(self)
        X86::Udis86 self
        CODE:
        RETVAL = ud_insn_off(self);

        OUTPUT:
        RETVAL

char* 
insn_hex(self)
        X86::Udis86 self
        CODE:
        RETVAL = ud_insn_hex(self);

        OUTPUT:
        RETVAL

unsigned long* 
insn_ptr(self)
        X86::Udis86 self
        CODE:
        RETVAL = (unsigned long *) ud_insn_ptr(self);

        OUTPUT:
        RETVAL

char* 
insn_asm(self)
        X86::Udis86 self
        CODE:
        RETVAL = ud_insn_asm(self);

        OUTPUT:
        RETVAL

void 
input_skip(self, n);
        X86::Udis86 self
	size_t n
        CODE:
	ud_input_skip(self, n);

#ud_mnemonic_code_t ud_obj->mnemonic
#
#ud_operand_t ud_obj->operand[n]
#
#ud_type_t ud_obj->operand[n].type
#
#ud_obj->operand[n].size
#
#ud_obj->operand[n].base
#ud_obj->operand[n].index
#ud_obj->operand[n].scale
#ud_obj->operand[n].offset
#ud_obj->operand[n].lval
#
#ud_obj->operand[n].lval.sbyte
#ud_obj->operand[n].lval.ubyte
#ud_obj->operand[n].lval.sword
#ud_obj->operand[n].lval.uword
#ud_obj->operand[n].lval.sdword
#ud_obj->operand[n].lval.udword
#ud_obj->operand[n].lval.sqword
#ud_obj->operand[n].lval.uqword
#ud_obj->operand[n].lval.ptr.seg 
#ud_obj->operand[n].lval.ptr.off
#
#ud_obj->pfx_rex
#ud_obj->pfx_seg
#ud_obj->pfx_opr
#ud_obj->pfx_adr
#ud_obj->pfx_lock
#ud_obj->pfx_rep
#ud_obj->pfx_repe
#ud_obj->pfx_repne
#
#uint64_t ud_obj->pc
