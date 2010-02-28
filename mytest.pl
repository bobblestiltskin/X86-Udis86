#!/usr/bin/perl -w
use strict;
use X86::Udis86;

(@ARGV == 1) or die "Need some bytes, $!";
open BYTES, $ARGV[0] or die "Can't open ",$ARGV[0], ", $!";

my $ud_obj = X86::Udis86->new;
$ud_obj->set_input_file(*BYTES);
$ud_obj->set_mode(32);
$ud_obj->set_syntax("intel");
while($ud_obj->disassemble) {
  print join(" ",sprintf("%016x", $ud_obj->insn_off),
       sprintf("%-16x", hex($ud_obj->insn_hex)),
       $ud_obj->insn_asm,"\n");

}
close BYTES;
