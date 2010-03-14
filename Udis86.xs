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

MODULE = X86::Udis86		PACKAGE = X86::Udis86::Operand

INCLUDE: const-xs.inc

X86::Udis86::Operand
new(CLASS)
        char *CLASS
        CODE:
        ud_operand_t *ptr = (ud_operand_t *) safemalloc(sizeof(ud_operand_t));
        if (ptr == NULL) {
          fprintf(stderr, "No memory for alloc()\n");
          exit(1);
        }
	RETVAL = ptr;

        OUTPUT:
        RETVAL

#ud_type_t ud_obj->operand[n].type

unsigned int
type(self)
	X86::Udis86::Operand self
        CODE:
        RETVAL = self->type;

        OUTPUT:
        RETVAL

#ud_obj->operand[n].size

uint8_t
size(self)
	X86::Udis86::Operand self
        CODE:
        RETVAL = self->size;

        OUTPUT:
        RETVAL

#ud_obj->operand[n].base

#ud_type_t
unsigned int
base(self)
	X86::Udis86::Operand self
        CODE:
        RETVAL = self->base;

        OUTPUT:
        RETVAL

#ud_obj->operand[n].index

#ud_type_t
unsigned int
index(self)
	X86::Udis86::Operand self
        CODE:
        RETVAL = self->index;

        OUTPUT:
        RETVAL

#ud_obj->operand[n].scale

uint8_t
scale(self)
	X86::Udis86::Operand self
        CODE:
        RETVAL = self->scale;

        OUTPUT:
        RETVAL

#ud_obj->operand[n].offset

uint8_t
offset(self)
	X86::Udis86::Operand self
        CODE:
        RETVAL = self->offset;

        OUTPUT:
        RETVAL

#ud_obj->operand[n].lval

#ud_obj->operand[n].lval.sbyte

int8_t
sbyte(self)
	X86::Udis86::Operand self
        CODE:
        RETVAL = self->lval.sbyte;

        OUTPUT:
        RETVAL


#ud_obj->operand[n].lval.ubyte

uint8_t
ubyte(self)
	X86::Udis86::Operand self
        CODE:
        RETVAL = self->lval.ubyte;

        OUTPUT:
        RETVAL

#ud_obj->operand[n].lval.sword

int16_t
sword(self)
	X86::Udis86::Operand self
        CODE:
        RETVAL = self->lval.sword;

        OUTPUT:
        RETVAL

#ud_obj->operand[n].lval.uword

uint16_t
uword(self)
	X86::Udis86::Operand self
        CODE:
        RETVAL = self->lval.uword;

        OUTPUT:
        RETVAL

#ud_obj->operand[n].lval.sdword

int32_t
sdword(self)
	X86::Udis86::Operand self
        CODE:
        RETVAL = self->lval.sdword;

        OUTPUT:
        RETVAL

#ud_obj->operand[n].lval.udword

uint32_t
udword(self)
	X86::Udis86::Operand self
        CODE:
        RETVAL = self->lval.udword;

        OUTPUT:
        RETVAL

#ud_obj->operand[n].lval.sqword

int64_t
sqword(self)
	X86::Udis86::Operand self
        CODE:
        RETVAL = self->lval.sqword;

        OUTPUT:
        RETVAL

#ud_obj->operand[n].lval.uqword

uint64_t
uqword(self)
	X86::Udis86::Operand self
        CODE:
        RETVAL = self->lval.uqword;

        OUTPUT:
        RETVAL

#ud_obj->operand[n].lval.ptr.seg 

uint16_t
ptr_seg(self)
	X86::Udis86::Operand self
        CODE:
        RETVAL = self->lval.ptr.seg;

        OUTPUT:
        RETVAL

#ud_obj->operand[n].lval.ptr.off

uint32_t
ptr_off(self)
	X86::Udis86::Operand self
        CODE:
        RETVAL = self->lval.ptr.off;

        OUTPUT:
        RETVAL

#//MODULE = X86::Udis86		PACKAGE = X86::Udis86		PREFIX = ud_
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
#	fprintf(stderr, "BEFORE + mode is %d\n", my_ud_obj.dis_mode);
	ud_set_mode(self, mode);
#	fprintf(stderr, "AFTER + mode is %d\n", my_ud_obj.dis_mode);

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
#	fprintf(stderr, "BEFORE + vendor is %d\n", my_ud_obj.vendor);
        if (strncmp(vendor, intel, strlen(intel)) == 0)
		ud_set_vendor(self, UD_VENDOR_INTEL);
        if (strncmp(vendor, amd, strlen(amd)) == 0)
		ud_set_vendor(self, UD_VENDOR_AMD);
#	fprintf(stderr, "AFTER + mode is %d\n", my_ud_obj.vendor);

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

unsigned int
mnemonic(self)
        X86::Udis86 self
        CODE:
        RETVAL = self->mnemonic;

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

#ud_operand_t ud_obj->operand[n]
void
_operands(self)
	X86::Udis86 self
	PREINIT:
	int i;
	ud_operand_t *op;
	const char *class = "X86::Udis86::Operand";
	IV op_iv;
	SV *op_sv;
	SV *op_rv;
	SV *op_blessed;
        PPCODE:
# We return a list of 3 objects of appropriate class
	EXTEND(SP, 3);
	for (i=0; i<3; i++) {
		op = &(self->operand[i]);
printf("op is %p\n", op);
		op_iv = PTR2IV(op);
printf("op_iv is %x\n", op_iv);
		op_sv = (SV *) op_iv;
printf("op_sv is %x\n", op_sv);
		op_rv = newRV_inc(op_sv);
printf("op_rv is %x\n", op_rv);
		op_blessed = sv_bless(op_rv, gv_stashpv(class, 1));
		PUSHs(sv_2mortal(op_blessed));
	}
