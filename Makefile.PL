use 5.008000;
use ExtUtils::MakeMaker;

# 
# test if udis86 is installed!
#

unless (have_udis86()) {
  print STDERR <<DEATH;
udis86 not found
Please install udis86 from http://sourceforge.net/projects/udis86
DEATH
exit 0; # 0 recommended by http://cpantest.grango.org (Notes for CPAN Authors)
}

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'X86::Udis86',
    VERSION_FROM      => 'lib/X86/Udis86.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/X86/Udis86.pm', # retrieve abstract from module
       AUTHOR         => 'Bob Wilkinson <bob@fourtheye.org>') : ()),
    LIBS              => ['-ludis86'], # e.g., '-lm'
    DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    INC               => '-I.', # e.g., '-I. -I/usr/include/other'
	# Un-comment this if you add C files to link with later:
    # OBJECT            => '$(O_FILES)', # link all the C files too
);
if  (eval {require ExtUtils::Constant; 1}) {
  # If you edit these definitions to change the constants used by this module,
  # you will need to use the generated const-c.inc and const-xs.inc
  # files to replace their "fallback" counterparts before distributing your
  # changes.
  my @names = (qw());
  ExtUtils::Constant::WriteConstants(
                                     NAME         => 'X86::Udis86',
                                     NAMES        => \@names,
                                     DEFAULT_TYPE => 'IV',
                                     C_FILE       => 'const-c.inc',
                                     XS_FILE      => 'const-xs.inc',
                                  );

}
else {
  use File::Copy;
  use File::Spec;
  foreach my $file ('const-c.inc', 'const-xs.inc') {
    my $fallback = File::Spec->catfile('fallback', $file);
    copy ($fallback, $file) or die "Can't copy $fallback to $file: $!";
  }
}

# below shamelessly stolen from XML::LibXMLs Makefile.PL

use Config;
#use Cwd;
#use Symbol;
use File::Spec;

use vars qw/$DEVNULL/;

BEGIN {
  $DEVNULL = eval { File::Spec->devnull };
  if ($@) { $DEVNULL = '/dev/null' }
}

sub rm_fr {
  my @files = @_;
  my @realfiles;
  foreach (@files) {
    push @realfiles, glob($_);
  }
  foreach my $file (@realfiles) {
    if (-d $file) {
      rm_fr("$file/*");
      rm_fr("$file/.exists");
      rmdir($file) || die "Couldn't remove $file: $!";
    } else {
      chmod(0777, $file);
      unlink($file);
    }
  }
}

sub xsystem {
  my $command = shift;
  if ($DEBUG) {
    print $command, "\n";
    if (system($command) != 0) {
      die "system call to '$command' failed";
    }
    return 1;
  }
  open(OLDOUT, ">&STDOUT");
  open(OLDERR, ">&STDERR");
  open(STDOUT, ">$DEVNULL");
  open(STDERR, ">$DEVNULL");
  my $retval = system($command);
  open(STDOUT, ">&OLDOUT");
  open(STDERR, ">&OLDERR");
  if ($retval == -1) {
    die "system call to '$command' failed";
  }
  return !($? >> 8);
}

sub have_udis86 {
  unless (mkdir(".testlink", 0777)) {
    rm_fr(".testlink");
    mkdir(".testlink", 0777) or die "Cannot create .testlink dir: $!";
  }
  chdir (".testlink");

  open(CFILE, ">mytest.c") or die "Can't open temporary file, $!";
  print CFILE <<EOF;
#include <stdio.h>
#include <udis86.h>
int main()
{
  ud_t ud_obj;
  ud_init(&ud_obj);
  return 0;
}
EOF
  close CFILE or die "Can't close temporary file, $!";

  my $retval = xsystem(join (" ", $Config{ccname}, $Config{ccflags}, "-o mytest mytest.c -ludis86"));
  chdir ("..");
  rm_fr(".testlink");
  return $retval;
}
