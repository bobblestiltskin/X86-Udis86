#!/usr/bin/perl -w
use strict;
use X86::Udis86;
use X86::Udis86::Operand qw(:all);

use Data::Dumper;
use Devel::Peek;

#(@ARGV == 1) or die "Need some bytes, $!";
#open BYTES, $ARGV[0] or die "Can't open ",$ARGV[0], ", $!";

my $bytes = "\x8d\x4c\x24\x04\x83\xe4\xf0\xff\x71\xfc\x55\x89\xe5\x51";
#my $bytes = "\x8d\x4c\x24\x04";

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
  print "pc is ",$ud_obj->pc,"\n";
#  $ud_obj->pfx_info;

  my $max = $ud_obj->insn_len < 3 ? $ud_obj->insn_len : 3;
#  my $operand = X86::Udis86::Operand->new;
#print "OPERAND is ",Data::Dumper->Dump([$operand]);
  for (my $i=0; $i<$max; $i++) {
    my $operand = $ud_obj->insn_opr($i);
    if (defined $operand) {
      $operand->info($i) unless ($operand->type_as_string eq "UD_NONE");
    }
  }    
}
#close BYTES;
