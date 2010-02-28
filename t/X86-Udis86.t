# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl X86-Udis86.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 3;
BEGIN { use_ok('X86::Udis86') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

#my $bytes = chr(0x65) . chr(0x67) . chr(0x89) . chr(0x87) . chr(0x76) . chr(0x65) . chr(0x54) . chr(0x56) . chr(0x78) . chr(0x89) . chr(0x09) . chr(0x00) . chr(0x87);
#warn "length BYTES is ", length $bytes,"\n";
#warn "BYTES are $bytes\n";
my $ud_obj = X86::Udis86->new;
warn "\nREF is ", ref $ud_obj, "\n";
ok( $ud_obj, "Pointer set");

open BYTES, "/home/bob/src/disassemblers/X86-Udis86/bytes" or die "Can't open bytes, $!";
$ud_obj->set_input_file(*BYTES);
#$ud_obj->set_input_buffer($bytes, length(bytes));
$ud_obj->set_mode(32);
$ud_obj->set_syntax("intel");
$ud_obj->set_vendor("intel");

while(my $count = $ud_obj->disassemble) {
#  warn "COUNT is ",$count;
#  warn "LEN is ", $ud_obj->insn_len,"\n";
#  warn "HEX is ", sprintf("%x", hex($ud_obj->insn_hex)),"\n";
  warn "ASM is ", $ud_obj->insn_asm,"\n";
}

close BYTES;
ok( 1, "Finished OK");

#65 67 89 87 76 65 54 56 78 89 09 00 87
__DATA__
65
67
89
87
76
65
54
56
78
89
09
00
87

