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

sub DESTROY {
  print "Bye Cruel World!\n";
  warn "Bye Cruel World!\n";
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

#sub new {
#  my $proto = shift;
#  my $class = ref($proto) || $proto;
#  my $self = X86::Udis86::_new();
#  bless $self, $class;
#
#  $self;
#}

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
