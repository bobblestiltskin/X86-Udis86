package X86::Udis86;

use 5.008000;
use strict;
use warnings;
use Carp;

use X86::Udis86::Operand ':all';

require Exporter;
use AutoLoader;

our @ISA = qw(Exporter);

our $VERSION = '0.03';

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

sub pfx_info {
  my $self = shift;

  print "pfx_rex is ",$self->pfx_rex,"\n";
  print "pfx_seg is ",$X86::Udis86::Operand::udis_types->[$self->pfx_seg],"\n";
  print "pfx_opr is ",$self->pfx_opr,"\n";
  print "pfx_adr is ",$self->pfx_adr,"\n";
  print "pfx_lock is ",$self->pfx_lock,"\n";
  print "pfx_rep is ",$self->pfx_rep,"\n";
  print "pfx_repe is ",$self->pfx_repe,"\n";
  print "pfx_repne is ",$self->pfx_repne,"\n";
}

sub DESTROY {
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

X86::Udis86 - Perl extension for the C disassembler Udis86.

=head1 SYNOPSIS

  use X86::Udis86;

=head1 DESCRIPTION

This module provides a Perl interface to the C disassembler Udis86.
See http://udis86.sourceforge.net/

The test program in t/X86-Udis86.t provides some indication of usage. 

The file udis86.pdf distributed with the C library documents the 
interface which has been followed in the Perl wrapper.

If you would like more extensive documentation, write to me and ask!

=head2 EXPORT

None by default. Exports @mnemonics on request.

=head1 AUTHOR

Bob Wilkinson, E<lt>bob@fourtheye.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009, 2013 by Bob Wilkinson

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
