package X86::Udis86;

use 5.008000;
use strict;
use warnings;
use Carp;

require Exporter;
use AutoLoader;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use X86::Udis86 ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @mnemonics = qw(
  3dnow
  aaa
  aad
  aam
  aas
  adc
  add
  addpd
  addps
  addsd
  addss
  addsubpd
  addsubps
  and
  andpd
  andps
  andnpd
  andnps
  arpl
  movsxd
  bound
  bsf
  bsr
  bswap
  bt
  btc
  btr
  bts
  call
  cbw
  cwde
  cdqe
  clc
  cld
  clflush
  clgi
  cli
  clts
  cmc
  cmovo
  cmovno
  cmovb
  cmovae
  cmovz
  cmovnz
  cmovbe
  cmova
  cmovs
  cmovns
  cmovp
  cmovnp
  cmovl
  cmovge
  cmovle
  cmovg
  cmp
  cmppd
  cmpps
  cmpsb
  cmpsw
  cmpsd
  cmpsq
  cmpss
  cmpxchg
  cmpxchg8b
  comisd
  comiss
  cpuid
  cvtdq2pd
  cvtdq2ps
  cvtpd2dq
  cvtpd2pi
  cvtpd2ps
  cvtpi2ps
  cvtpi2pd
  cvtps2dq
  cvtps2pi
  cvtps2pd
  cvtsd2si
  cvtsd2ss
  cvtsi2ss
  cvtss2si
  cvtss2sd
  cvttpd2pi
  cvttpd2dq
  cvttps2dq
  cvttps2pi
  cvttsd2si
  cvtsi2sd
  cvttss2si
  cwd
  cdq
  cqo
  daa
  das
  dec
  div
  divpd
  divps
  divsd
  divss
  emms
  enter
  f2xm1
  fabs
  fadd
  faddp
  fbld
  fbstp
  fchs
  fclex
  fcmovb
  fcmove
  fcmovbe
  fcmovu
  fcmovnb
  fcmovne
  fcmovnbe
  fcmovnu
  fucomi
  fcom
  fcom2
  fcomp3
  fcomi
  fucomip
  fcomip
  fcomp
  fcomp5
  fcompp
  fcos
  fdecstp
  fdiv
  fdivp
  fdivr
  fdivrp
  femms
  ffree
  ffreep
  ficom
  ficomp
  fild
  fncstp
  fninit
  fiadd
  fidivr
  fidiv
  fisub
  fisubr
  fist
  fistp
  fisttp
  fld
  fld1
  fldl2t
  fldl2e
  fldlpi
  fldlg2
  fldln2
  fldz
  fldcw
  fldenv
  fmul
  fmulp
  fimul
  fnop
  fpatan
  fprem
  fprem1
  fptan
  frndint
  frstor
  fnsave
  fscale
  fsin
  fsincos
  fsqrt
  fstp
  fstp1
  fstp8
  fstp9
  fst
  fnstcw
  fnstenv
  fnstsw
  fsub
  fsubp
  fsubr
  fsubrp
  ftst
  fucom
  fucomp
  fucompp
  fxam
  fxch
  fxch4
  fxch7
  fxrstor
  fxsave
  fpxtract
  fyl2x
  fyl2xp1
  haddpd
  haddps
  hlt
  hsubpd
  hsubps
  idiv
  in
  imul
  inc
  insb
  insw
  insd
  int1
  int3
  int
  into
  invd
  invlpg
  invlpga
  iretw
  iretd
  iretq
  jo
  jno
  jb
  jae
  jz
  jnz
  jbe
  ja
  js
  jns
  jp
  jnp
  jl
  jge
  jle
  jg
  jcxz
  jecxz
  jrcxz
  jmp
  lahf
  lar
  lddqu
  ldmxcsr
  lds
  lea
  les
  lfs
  lgs
  lidt
  lss
  leave
  lfence
  lgdt
  lldt
  lmsw
  lock
  lodsb
  lodsw
  lodsd
  lodsq
  loopnz
  loope
  loop
  lsl
  ltr
  maskmovq
  maxpd
  maxps
  maxsd
  maxss
  mfence
  minpd
  minps
  minsd
  minss
  monitor
  mov
  movapd
  movaps
  movd
  movddup
  movdqa
  movdqu
  movdq2q
  movhpd
  movhps
  movlhps
  movlpd
  movlps
  movhlps
  movmskpd
  movmskps
  movntdq
  movnti
  movntpd
  movntps
  movntq
  movq
  movqa
  movq2dq
  movsb
  movsw
  movsd
  movsq
  movsldup
  movshdup
  movss
  movsx
  movupd
  movups
  movzx
  mul
  mulpd
  mulps
  mulsd
  mulss
  mwait
  neg
  nop
  not
  or
  orpd
  orps
  out
  outsb
  outsw
  outsd
  outsq
  packsswb
  packssdw
  packuswb
  paddb
  paddw
  paddq
  paddsb
  paddsw
  paddusb
  paddusw
  pand
  pandn
  pause
  pavgb
  pavgw
  pcmpeqb
  pcmpeqw
  pcmpeqd
  pcmpgtb
  pcmpgtw
  pcmpgtd
  pextrw
  pinsrw
  pmaddwd
  pmaxsw
  pmaxub
  pminsw
  pminub
  pmovmskb
  pmulhuw
  pmulhw
  pmullw
  pmuludq
  pop
  popa
  popad
  popfw
  popfd
  popfq
  por
  prefetch
  prefetchnta
  prefetcht0
  prefetcht1
  prefetcht2
  psadbw
  pshufd
  pshufhw
  pshuflw
  pshufw
  pslldq
  psllw
  pslld
  psllq
  psraw
  psrad
  psrlw
  psrld
  psrlq
  psrldq
  psubb
  psubw
  psubd
  psubq
  psubsb
  psubsw
  psubusb
  psubusw
  punpckhbw
  punpckhwd
  punpckhdq
  punpckhqdq
  punpcklbw
  punpcklwd
  punpckldq
  punpcklqdq
  pi2fw
  pi2fd
  pf2iw
  pf2id
  pfnacc
  pfpnacc
  pfcmpge
  pfmin
  pfrcp
  pfrsqrt
  pfsub
  pfadd
  pfcmpgt
  pfmax
  pfrcpit1
  pfrspit1
  pfsubr
  pfacc
  pfcmpeq
  pfmul
  pfrcpit2
  pmulhrw
  pswapd
  pavgusb
  push
  pusha
  pushad
  pushfw
  pushfd
  pushfq
  pxor
  rcl
  rcr
  rol
  ror
  rcpps
  rcpss
  rdmsr
  rdpmc
  rdtsc
  rdtscp
  repne
  rep
  ret
  retf
  rsm
  rsqrtps
  rsqrtss
  sahf
  sal
  salc
  sar
  shl
  shr
  sbb
  scasb
  scasw
  scasd
  scasq
  seto
  setno
  setb
  setnb
  setz
  setnz
  setbe
  seta
  sets
  setns
  setp
  setnp
  setl
  setge
  setle
  setg
  sfence
  sgdt
  shld
  shrd
  shufpd
  shufps
  sidt
  sldt
  smsw
  sqrtps
  sqrtpd
  sqrtsd
  sqrtss
  stc
  std
  stgi
  sti
  skinit
  stmxcsr
  stosb
  stosw
  stosd
  stosq
  str
  sub
  subpd
  subps
  subsd
  subss
  swapgs
  syscall
  sysenter
  sysexit
  sysret
  test
  ucomisd
  ucomiss
  ud2
  unpckhpd
  unpckhps
  unpcklps
  unpcklpd
  verr
  verw
  vmcall
  vmclear
  vmxon
  vmptrld
  vmptrst
  vmresume
  vmxoff
  vmrun
  vmmcall
  vmload
  vmsave
  wait
  wbinvd
  wrmsr
  xadd
  xchg
  xlatb
  xor
  xorpd
  xorps
  db
  invalid
  d3vil
  na
  grp_reg
  grp_rm
  grp_vendor
  grp_x87
  grp_mode
  grp_osize
  grp_asize
  grp_mod
  none
);

our @EXPORT = qw(
	
);

our $VERSION = '0.01';

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.

    my $constname;
    our $AUTOLOAD;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    croak "&X86::Udis86::constant not defined" if $constname eq 'constant';
    my ($error, $val) = constant($constname);
    if ($error) { croak $error; }
    {
	no strict 'refs';
	# Fixed between 5.005_53 and 5.005_61
#XXX	if ($] >= 5.00561) {
#XXX	    *$AUTOLOAD = sub () { $val };
#XXX	}
#XXX	else {
	    *$AUTOLOAD = sub { $val };
#XXX	}
    }
    goto &$AUTOLOAD;
}

require XSLoader;
XSLoader::load('X86::Udis86', $VERSION);

# Preloaded methods go here.

#sub new {
#  my $proto = shift;
#  my $class = ref($proto) || $proto;
#  my $self = X86::Udis86::_new();
#  bless $self, $class;
#
#  $self;
#}

sub operands {
  my $self = shift;
  return $self->_operands;
}

sub DESTROY {
#  print "Bye Cruel World!\n";
#  warn "Bye Cruel World!\n";
}

# Autoload methods go after =cut, and are processed by the autosplit program.

# struct ud
# {
#   int                   (*inp_hook) (struct ud*);
#   uint8_t               inp_curr;
#   uint8_t               inp_fill;
#   FILE*                 inp_file;
#   uint8_t               inp_ctr;
#   uint8_t*              inp_buff;
#   uint8_t*              inp_buff_end;
#   uint8_t               inp_end;
#   void                  (*translator)(struct ud*);
#   uint64_t              insn_offset;
#   char                  insn_hexcode[32];
#   char                  insn_buffer[64];
#   unsigned int          insn_fill;
#   uint8_t               dis_mode;
#   uint64_t              pc;
#   uint8_t               vendor;
#   struct map_entry*     mapen;
#   enum ud_mnemonic_code mnemonic;
#   struct ud_operand     operand[3];
#   uint8_t               error;
#   uint8_t               pfx_rex;
#   uint8_t               pfx_seg;
#   uint8_t               pfx_opr;
#   uint8_t               pfx_adr;
#   uint8_t               pfx_lock;
#   uint8_t               pfx_rep;
#   uint8_t               pfx_repe;
#   uint8_t               pfx_repne;
#   uint8_t               pfx_insn;
#   uint8_t               default64;
#   uint8_t               opr_mode;
#   uint8_t               adr_mode;
#   uint8_t               br_far;
#   uint8_t               br_near;
#   uint8_t               implicit_addr;
#   uint8_t               c1;
#   uint8_t               c2;
#   uint8_t               c3;
#   uint8_t               inp_cache[256];
#   uint8_t               inp_sess[64];
#   struct ud_itab_entry * itab_entry;
# };

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

X86::Udis86 - Perl extension for blah blah blah

=head1 SYNOPSIS

  use X86::Udis86;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for X86::Udis86, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Bob Wilkinson, E<lt>bob@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Bob Wilkinson

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
