# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl X86-Udis86.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 3;
BEGIN { use_ok('X86::Udis86') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $ud_obj = X86::Udis86->new;
warn "\nREF is ", ref $ud_obj, "\n";
ok( $ud_obj, "Pointer set");

$ud_obj->set_input_file(*STDIN);
$ud_obj->set_mode(64);
$ud_obj->set_syntax(X86::Udis86::UD_SYN_INTEL);
#while($ud_obj->disassemble) {
#  print $ud_obj->insn_asm,"\n";
#}

ok( 1, "Finished OK");


