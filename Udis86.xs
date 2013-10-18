#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <src/udis86.h>

#include "const-c.inc"

typedef ud_t *X86__Udis86;
typedef ud_operand_t *X86__Udis86__Operand;

static ud_t my_ud_obj;

ud_t* _new()
{
	ud_init(&my_ud_obj);

	return(&my_ud_obj);
}

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
	ud_set_mode(self, mode);

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
        if (strncmp(vendor, intel, strlen(intel)) == 0)
		ud_set_vendor(self, UD_VENDOR_INTEL);
        if (strncmp(vendor, amd, strlen(amd)) == 0)
		ud_set_vendor(self, UD_VENDOR_AMD);

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

const char* 
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

const char* 
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

const char*
mnemonic(self)
        X86::Udis86 self
        CODE:
        RETVAL = ud_lookup_mnemonic(ud_insn_mnemonic(self));

        OUTPUT:
        RETVAL

#ud_obj->pfx_rex

int
pfx_rex(self)
        X86::Udis86 self
        CODE:
        RETVAL = self->pfx_rex;

        OUTPUT:
        RETVAL

#ud_obj->pfx_seg

int
pfx_seg(self)
        X86::Udis86 self
        CODE:
        RETVAL = self->pfx_seg;

        OUTPUT:
        RETVAL

#ud_obj->pfx_opr

int
pfx_opr(self)
        X86::Udis86 self
        CODE:
        RETVAL = self->pfx_opr;

        OUTPUT:
        RETVAL

#ud_obj->pfx_adr

int
pfx_adr(self)
        X86::Udis86 self
        CODE:
        RETVAL = self->pfx_adr;

        OUTPUT:
        RETVAL

#ud_obj->pfx_lock

int
pfx_lock(self)
        X86::Udis86 self
        CODE:
        RETVAL = self->pfx_lock;

        OUTPUT:
        RETVAL

#ud_obj->pfx_rep

int
pfx_rep(self)
        X86::Udis86 self
        CODE:
        RETVAL = self->pfx_rep;

        OUTPUT:
        RETVAL

#ud_obj->pfx_repe

int
pfx_repe(self)
        X86::Udis86 self
        CODE:
        RETVAL = self->pfx_repe;

        OUTPUT:
        RETVAL

#ud_obj->pfx_repne

int
pfx_repne(self)
        X86::Udis86 self
        CODE:
        RETVAL = self->pfx_repne;

        OUTPUT:
        RETVAL

#uint64_t ud_obj->pc

uint64_t
pc(self)
        X86::Udis86 self
        CODE:
        RETVAL = self->pc;

        OUTPUT:
        RETVAL

X86::Udis86::Operand *
_operands(self)
	X86::Udis86 self
	PREINIT:
	int i;
	const char *class = "X86::Udis86::Operand";
	IV op_iv;
	SV *op_sv;
	SV *op_rv;
	SV *op_blessed;
	HV * hash;
        PPCODE:
# We return a list of 3 objects of appropriate class
	EXTEND(SP, 3);
	for (i=0; i<3; i++) {
		hash = newHV();

		hv_store(hash, "type", 4, newSViv(self->operand[i].type), 0);
		hv_store(hash, "size", 4, newSViv(self->operand[i].size), 0);
		hv_store(hash, "base", 4, newSViv(self->operand[i].base), 0);
		hv_store(hash, "index", 5, newSViv(self->operand[i].index), 0);
		hv_store(hash, "scale", 5, newSViv(self->operand[i].scale), 0);
		hv_store(hash, "offset", 6, newSViv(self->operand[i].offset), 0);
		hv_store(hash, "lval_sbyte", 10, newSViv(self->operand[i].lval.sbyte), 0);
		hv_store(hash, "lval_ubyte", 10, newSViv(self->operand[i].lval.ubyte), 0);
		hv_store(hash, "lval_sword", 10, newSViv(self->operand[i].lval.sword), 0);
		hv_store(hash, "lval_uword", 10, newSViv(self->operand[i].lval.uword), 0);
		hv_store(hash, "lval_sdword", 11, newSViv(self->operand[i].lval.sdword), 0);
		hv_store(hash, "lval_udword", 11, newSViv(self->operand[i].lval.udword), 0);
		hv_store(hash, "lval_sqword", 11, newSViv(self->operand[i].lval.sqword), 0);
		hv_store(hash, "lval_uqword", 11, newSViv(self->operand[i].lval.uqword), 0);
		hv_store(hash, "lval_ptr_seg", 12, newSViv(self->operand[i].lval.ptr.seg), 0);
		hv_store(hash, "lval_ptr_off", 12, newSViv(self->operand[i].lval.ptr.off), 0);

 		op_iv = PTR2IV(hash);
 		op_sv = newSViv(op_iv);
 		op_rv = newRV_inc(op_sv);
 		op_blessed = sv_bless(op_rv, gv_stashpv(class, 1));
 		PUSHs(sv_2mortal(op_blessed));
	}

