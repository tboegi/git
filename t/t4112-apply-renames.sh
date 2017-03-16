#!/bin/sh
#
# Copyright (c) 2005 Junio C Hamano
#

test_description='git apply should not get confused with rename/copy.

'

. ./test-lib.sh

# setup

mkdir -p klibc/arch/x86_64/include/klibc

cat >klibc/arch/x86_64/include/klibc/archsetjmp.h <<\EOF
/*
 * arch/x86_64/include/klibc/archsetjmp.h
 */

#ifndef _KLIBC_ARCHSETJMP_H
#define _KLIBC_ARCHSETJMP_H

struct __jmp_buf {
  size_t __rbx;
  size_t __rsp;
  size_t __rbp;
  size_t __r12;
  size_t __r13;
  size_t __r14;
  size_t __r15;
  size_t __rip;
};

typedef struct __jmp_buf jmp_buf[1];

#endif /* _SETJMP_H */
EOF
cat >klibc/README <<\EOF
This is a simple readme file.
EOF

cat >patch <<\EOF
diff --git a/klibc/arch/x86_64/include/klibc/archsetjmp.h b/include/arch/cris/klibc/archsetjmp.h
similarity index 76%
copy from klibc/arch/x86_64/include/klibc/archsetjmp.h
copy to include/arch/cris/klibc/archsetjmp.h
--- a/klibc/arch/x86_64/include/klibc/archsetjmp.h
+++ b/include/arch/cris/klibc/archsetjmp.h
@@ -1,21 +1,24 @@
 /*
- * arch/x86_64/include/klibc/archsetjmp.h
+ * arch/cris/include/klibc/archsetjmp.h
  */

 #ifndef _KLIBC_ARCHSETJMP_H
 #define _KLIBC_ARCHSETJMP_H

 struct __jmp_buf {
-  size_t __rbx;
-  size_t __rsp;
-  size_t __rbp;
-  size_t __r12;
-  size_t __r13;
-  size_t __r14;
-  size_t __r15;
-  size_t __rip;
+  size_t __r0;
+  size_t __r1;
+  size_t __r2;
+  size_t __r3;
+  size_t __r4;
+  size_t __r5;
+  size_t __r6;
+  size_t __r7;
+  size_t __r8;
+  size_t __sp;
+  size_t __srp;
 };

 typedef struct __jmp_buf jmp_buf[1];

-#endif /* _SETJMP_H */
+#endif /* _KLIBC_ARCHSETJMP_H */
diff --git a/klibc/arch/x86_64/include/klibc/archsetjmp.h b/include/arch/m32r/klibc/archsetjmp.h
similarity index 66%
rename from klibc/arch/x86_64/include/klibc/archsetjmp.h
rename to include/arch/m32r/klibc/archsetjmp.h
--- a/klibc/arch/x86_64/include/klibc/archsetjmp.h
+++ b/include/arch/m32r/klibc/archsetjmp.h
@@ -1,21 +1,21 @@
 /*
- * arch/x86_64/include/klibc/archsetjmp.h
+ * arch/m32r/include/klibc/archsetjmp.h
  */

 #ifndef _KLIBC_ARCHSETJMP_H
 #define _KLIBC_ARCHSETJMP_H

 struct __jmp_buf {
-  size_t __rbx;
-  size_t __rsp;
-  size_t __rbp;
+  size_t __r8;
+  size_t __r9;
+  size_t __r10;
+  size_t __r11;
   size_t __r12;
   size_t __r13;
   size_t __r14;
   size_t __r15;
-  size_t __rip;
 };

 typedef struct __jmp_buf jmp_buf[1];

-#endif /* _SETJMP_H */
+#endif /* _KLIBC_ARCHSETJMP_H */
diff --git a/klibc/README b/klibc/README
--- a/klibc/README
+++ b/klibc/README
@@ -1,1 +1,4 @@
 This is a simple readme file.
+And we add a few
+lines at the
+end of it.
diff --git a/klibc/README b/klibc/arch/README
copy from klibc/README
copy to klibc/arch/README
--- a/klibc/README
+++ b/klibc/arch/README
@@ -1,1 +1,3 @@
 This is a simple readme file.
+And we copy it to one level down, and
+add a few lines at the end of it.
EOF

find klibc -type f -print | xargs git update-index --add --

test_expect_success 'check rename/copy patch' 'git apply --check patch'

test_expect_success 'apply rename/copy patch' 'git apply --index patch'

test_done
