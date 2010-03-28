#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <src/udis86.h>

#include "const-c.inc"

typedef ud_t *X86__Udis86;
typedef ud_operand_t *X86__Udis86__Operand;

static ud_t my_ud_obj;

static ud_operand_t my_ud_ops[3]; // We allocate space for 3 operands statically

ud_t* _new()
{
	ud_init(&my_ud_obj);

	return(&my_ud_obj);
}

MODULE = X86::Udis86		PACKAGE = X86::Udis86::Operand

INCLUDE: const-xs.inc

 #X86::Udis86::Operand
 #new(CLASS)
 #        char *CLASS
 #        CODE:
 #        ud_operand_t *ptr = (ud_operand_t *) safemalloc(sizeof(ud_operand_t));
 #printf("X86::Udis86::Operand new invoked\n");
 #        if (ptr == NULL) {
 #          fprintf(stderr, "No memory for alloc()\n");
 #          exit(1);
 #        }
 #	RETVAL = ptr;
 #
 #        OUTPUT:
 #        RETVAL

#ud_type_t ud_obj->operand[n].type

unsigned int
type(self)
	X86::Udis86::Operand self
        CODE:
 	if (self == NULL)
 	{
 		printf("X86::Udis86::Operand type invoked with NULL\n");
 	} else {
	        RETVAL = (*self).type;
printf("X86::Udis86::Operand got type %d OK!\n", RETVAL);
 	}

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
#X86::Udis86::Operand *
void
_operands(self)
	X86::Udis86 self
	PREINIT:
	int i;
 #	ud_operand_t *sptr;
	const char *class = "X86::Udis86::Operand";
	IV op_iv;
	SV *op_sv;
	SV *op_rv;
	SV *op_blessed;
	HV * hash;
        int type;
        int size;
        PPCODE:
# We return a list of 3 objects of appropriate class
	EXTEND(SP, 3);
	for (i=0; i<3; i++) {
 #		if (!self->operand[i].size)
 #			continue;

		hash = newHV();

 printf("op type is %d\n", self->operand[i].type);
		hv_store(hash, "type", 4, newSViv(self->operand[i].type), 0);
 printf("op size is %d\n", self->operand[i].size);
		hv_store(hash, "size", 4, newSViv(self->operand[i].size), 0);
 printf("op base is %d\n", self->operand[i].base);
		hv_store(hash, "base", 4, newSViv(self->operand[i].base), 0);
 printf("op index is %d\n", self->operand[i].index);
		hv_store(hash, "index", 5, newSViv(self->operand[i].index), 0);
 printf("op scale is %d\n", self->operand[i].scale);
		hv_store(hash, "scale", 5, newSViv(self->operand[i].scale), 0);
 printf("op offset is %d\n", self->operand[i].offset);
		hv_store(hash, "offset", 6, newSViv(self->operand[i].offset), 0);
 #		hv_store(hash, "lval", 4, newSViv(self->operand[i].lval), 0);
 printf("op sbyte is %d\n", self->operand[i].lval.sbyte);
		hv_store(hash, "lval_sbyte", 10, newSViv(self->operand[i].lval.sbyte), 0);
 printf("op ubyte is %d\n", self->operand[i].lval.ubyte);
		hv_store(hash, "lval_ubyte", 10, newSViv(self->operand[i].lval.ubyte), 0);
 printf("op sword is %d\n", self->operand[i].lval.sword);
		hv_store(hash, "lval_sword", 10, newSViv(self->operand[i].lval.sword), 0);
 printf("op uword is %d\n", self->operand[i].lval.uword);
		hv_store(hash, "lval_uword", 10, newSViv(self->operand[i].lval.uword), 0);
 printf("op sdword is %d\n", self->operand[i].lval.sdword);
		hv_store(hash, "lval_sdword", 11, newSViv(self->operand[i].lval.sdword), 0);
 printf("op udword is %d\n", self->operand[i].lval.udword);
		hv_store(hash, "lval_udword", 11, newSViv(self->operand[i].lval.udword), 0);
 printf("op sqword is %d\n", self->operand[i].lval.sqword);
		hv_store(hash, "lval_sqword", 11, newSViv(self->operand[i].lval.sqword), 0);
 printf("op uqword is %d\n", self->operand[i].lval.uqword);
		hv_store(hash, "lval_uqword", 11, newSViv(self->operand[i].lval.uqword), 0);
 printf("op seg is %d\n", self->operand[i].lval.ptr.seg);
		hv_store(hash, "lval_ptr_seg", 12, newSViv(self->operand[i].lval.ptr.seg), 0);
 printf("op off is %d\n", self->operand[i].lval.ptr.off);
		hv_store(hash, "lval_ptr_off", 12, newSViv(self->operand[i].lval.ptr.off), 0);

 		op_iv = PTR2IV(hash);
printf("op_iv is %p\n", op_iv);
 		op_sv = (SV *) op_iv;
printf("op_sv is %lx\n", op_sv);
 		op_rv = newRV_inc(op_sv);
printf("op_rv is %lx\n", op_rv);
 		op_blessed = sv_bless(op_rv, gv_stashpv(class, 1));
printf("op_blessed is %lx\n", op_blessed);
 		PUSHs(sv_2mortal(op_blessed));
 #		PUSHs(op_blessed);
	}

