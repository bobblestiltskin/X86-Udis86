# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl X86-Udis86.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 27;
BEGIN { use_ok('X86::Udis86') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $bytes = "\x8d\x4c\x24\x04\x83\xe4\xf0\xff\x71\xfc\x55\x89\xe5\x51";
#warn "length BYTES is ", length $bytes,"\n";
#warn "BYTES are $bytes\n";
my $ud_obj = X86::Udis86->new;
ok( $ud_obj, "Pointer set");
ok( ref $ud_obj eq "X86::Udis86", "Class is correct");

#open BYTES, "/home/bob/src/disassemblers/X86-Udis86/bytes" or die "Can't open bytes, $!";
#$ud_obj->set_input_file(*BYTES);
$ud_obj->set_input_buffer($bytes, length($bytes));
$ud_obj->set_mode(32);
$ud_obj->set_syntax("intel");
$ud_obj->set_vendor("intel");

my (@offset, @hex, @asm, @mnemonic);
while($ud_obj->disassemble) {
  my $offset = sprintf("%016x", $ud_obj->insn_off);
  push @offset, $offset;
  my $hex = sprintf("%-16x", hex($ud_obj->insn_hex));
  push @hex, $hex;
  my $asm = $ud_obj->insn_asm;
  push @asm, $asm;
  push @mnemonic, $ud_obj->lookup_mnemonic;
#  warn join(" ",$offset, $hex, $asm, $mnemonic, "\n");
}

#close BYTES;

ok($offset[0] eq '0000000000000000', "0 offset good");
ok($hex[0] eq "8d4c2404        ", "0 hex good");
ok($asm[0] eq "lea ecx, [esp+0x4]", "0 asm good");
ok($mnemonic[0] eq "lea", "0 mnemonic good");
ok($offset[1] eq '0000000000000004', "1 offset good");
ok($hex[1] eq "83e4f0          ", "1 hex good");
ok($asm[1] eq "and esp, 0xfffffff0", "1 asm good");
ok($mnemonic[1] eq "and", "1 mnemonic good");
ok($offset[2] eq '0000000000000007', "2 offset good");
ok($hex[2] eq "ff71fc          ", "2 hex good");
ok($asm[2] eq "push dword [ecx-0x4]", "2 asm good");
ok($mnemonic[2] eq "push", "2 mnemonic good");
ok($offset[3] eq '000000000000000a', "3 offset good");
ok($hex[3] eq "55              ", "3 hex good");
ok($asm[3] eq "push ebp", "3 asm good");
ok($mnemonic[3] eq "push", "3 mnemonic good");
ok($offset[4] eq '000000000000000b', "4 offset good");
ok($hex[4] eq "89e5            ", "4 hex good");
ok($asm[4] eq "mov ebp, esp", "4 asm good");
ok($mnemonic[4] eq "mov", "4 mnemonic good");
ok($offset[5] eq '000000000000000d', "5 offset good");
ok($hex[5] eq "51              ", "5 hex good");
ok($asm[5] eq "push ecx", "5 asm good");
ok($mnemonic[5] eq "push", "5 mnemonic good");
