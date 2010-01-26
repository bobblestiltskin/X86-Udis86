#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <src/udis86.h>

#include "const-c.inc"

MODULE = X86::Udis86		PACKAGE = X86::Udis86		

INCLUDE: const-xs.inc
