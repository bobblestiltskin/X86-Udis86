#!/usr/bin/perl -w
use strict;
use X86::Udis86;

use Data::Dumper;
use Devel::Peek;

#(@ARGV == 1) or die "Need some bytes, $!";
#open BYTES, $ARGV[0] or die "Can't open ",$ARGV[0], ", $!";

#my $bytes = "\x8d\x4c\x24\x04\x83\xe4\xf0\xff\x71\xfc\x55\x89\xe5\x51";
my $bytes = "\x8d\x4c\x24\x04";

my $ud_obj = X86::Udis86->new;
#$ud_obj->set_input_file(*BYTES);
$ud_obj->set_input_buffer($bytes, length($bytes));
$ud_obj->set_mode(32);
$ud_obj->set_syntax("intel");
while($ud_obj->disassemble) {
  print join(" ",sprintf("%016x", $ud_obj->insn_off),
       sprintf("%-16x", hex($ud_obj->insn_hex)),
       $ud_obj->insn_asm,"\n");
  print "insn_len is ",$ud_obj->insn_len,"\n";
  print "pfx_rex is ",$ud_obj->pfx_rex,"\n";
  print "pfx_seg is ",$ud_obj->pfx_seg,"\n";
  print "pfx_opr is ",$ud_obj->pfx_opr,"\n";
  print "pfx_adr is ",$ud_obj->pfx_adr,"\n";
  print "pfx_lock is ",$ud_obj->pfx_lock,"\n";
  print "pfx_rep is ",$ud_obj->pfx_rep,"\n";
  print "pfx_repe is ",$ud_obj->pfx_repe,"\n";
  print "pfx_repne is ",$ud_obj->pfx_repne,"\n";
  print "pc is ",$ud_obj->pc,"\n";
  my $operands = $ud_obj->operands;
print "HAVE ",scalar @$operands, " operands\n";
print "GOT OPS\n";

  my $max = $ud_obj->insn_len < 3 ? $ud_obj->insn_len : 3;
  for (my $i=0; $i<$max; $i++) {
    my $operand = $operands->[$i];
#print "REF OP is ",ref $operand,"\nOP is ",Data::Dumper->Dump([$operand]),"\nDump is ",Dump($operand),"\n";
    print "Op $i type is ",$operand->{type},"\n";
    print "Op $i size is ",$operand->{size},"\n";
    print "Op $i base is ",$operand->{base},"\n";
    print "Op $i index is ",$operand->{index},"\n";
    print "Op $i scale is ",$operand->{scale},"\n";
    print "Op $i offset is ",$operand->{offset},"\n";
  }    
}
#close BYTES;
