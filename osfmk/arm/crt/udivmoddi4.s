/*
 * Copyright (c) 2008 - 2009, Apple Inc. All rights reserved.<BR>
 *
 * This program and the accompanying materials
 * are licensed and made available under the terms and conditions of the BSD License
 * which accompanies this distribution.  The full text of the license may be found at
 * http://opensource.org/licenses/bsd-license.php
 *
 * THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
 * WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
 */

#include <arm/asm_help.h>

.extern ___umodsi3
.extern ___udivsi3

EnterARM(__udivmoddi4)
  stmfd  sp!, {r4, r5, r6, r7, lr}
  add  r7, sp, #12
  stmfd  sp!, {r10, r11}
  sub  sp, sp, #20
  stmia  sp, {r2-r3}
  ldr  r6, [sp, #48]
  orrs  r2, r2, r3
  mov  r10, r0
  mov  r11, r1
  beq  l2
  subs  ip, r1, #0
  bne  l4
  cmp  r3, #0
  bne  l6
  cmp  r6, #0
  beq  l8
  mov  r1, r2
  bl  ___umodsi3
  mov  r1, #0
  stmia  r6, {r0-r1}
l8:
  ldr  r1, [sp, #0]
  mov  r0, r10
  b  l45
l6:
  cmp  r6, #0
  movne  r1, #0
  stmiane  r6, {r0-r1}
  b  l2
l4:
  ldr  r1, [sp, #0]
  cmp  r1, #0
  bne  l12
  ldr  r2, [sp, #4]
  cmp  r2, #0
  bne  l14
  cmp  r6, #0
  beq  l16
  mov  r1, r2
  mov  r0, r11
  bl  ___umodsi3
  mov  r1, #0
  stmia  r6, {r0-r1}
l16:
  ldr  r1, [sp, #4]
  mov  r0, r11
l45:
  bl  ___udivsi3
l46:
  mov  r10, r0
  mov  r11, #0
  b  l10
l14:
  subs  r1, r0, #0
  bne  l18
  cmp  r6, #0
  beq  l16
  ldr  r1, [sp, #4]
  mov  r0, r11
  bl  ___umodsi3
  mov  r4, r10
  mov  r5, r0
  stmia  r6, {r4-r5}
  b  l16
l18:
  sub  r3, r2, #1
  tst  r2, r3
  bne  l22
  cmp  r6, #0
  movne  r4, r0
  andne  r5, ip, r3
  stmiane  r6, {r4-r5}
l24:
  rsb  r3, r2, #0
  and  r3, r2, r3
  clz  r3, r3
  rsb  r3, r3, #31
  mov  r0, ip, lsr r3
  b  l46
l22:
  clz  r2, r2
  clz  r3, ip
  rsb  r3, r3, r2
  cmp  r3, #30
  bhi  l48
  rsb  r2, r3, #31
  add  lr, r3, #1
  mov  r3, r1, asl r2
  str  r3, [sp, #12]
  mov  r3, r1, lsr lr
  ldr  r0, [sp, #0]
  mov  r5, ip, lsr lr
  orr  r4, r3, ip, asl r2
  str  r0, [sp, #8]
  b  l29
l12:
  ldr  r3, [sp, #4]
  cmp  r3, #0
  bne  l30
  sub  r3, r1, #1
  tst  r1, r3
  bne  l32
  cmp  r6, #0
  andne  r3, r3, r0
  movne  r2, r3
  movne  r3, #0
  stmiane  r6, {r2-r3}
l34:
  cmp  r1, #1
  beq  l10
  rsb  r3, r1, #0
  and  r3, r1, r3
  clz  r3, r3
  rsb  r0, r3, #31
  mov  r1, ip, lsr r0
  rsb  r3, r0, #32
  mov  r0, r10, lsr r0
  orr  ip, r0, ip, asl r3
  str  r1, [sp, #12]
  str  ip, [sp, #8]
  ldrd  r10, r11, [sp, #8]
  b  l10
l32:
  clz  r2, r1
  clz  r3, ip
  rsb  r3, r3, r2
  rsb  r4, r3, #31
  mov  r2, r0, asl r4
  mvn  r1, r3
  and  r2, r2, r1, asr #31
  add  lr, r3, #33
  str  r2, [sp, #8]
  add  r2, r3, #1
  mov  r3, r3, asr #31
  and  r0, r3, r0, asl r1
  mov  r3, r10, lsr r2
  orr  r3, r3, ip, asl r4
  and  r3, r3, r1, asr #31
  orr  r0, r0, r3
  mov  r3, ip, lsr lr
  str  r0, [sp, #12]
  mov  r0, r10, lsr lr
  and  r5, r3, r2, asr #31
  rsb  r3, lr, #31
  mov  r3, r3, asr #31
  orr  r0, r0, ip, asl r1
  and  r3, r3, ip, lsr r2
  and  r0, r0, r2, asr #31
  orr  r4, r3, r0
  b  l29
l30:
  clz  r2, r3
  clz  r3, ip
  rsb  r3, r3, r2
  cmp  r3, #31
  bls  l37
l48:
  cmp  r6, #0
  stmiane  r6, {r10-r11}
  b  l2
l37:
  rsb  r1, r3, #31
  mov  r0, r0, asl r1
  add  lr, r3, #1
  mov  r2, #0
  str  r0, [sp, #12]
  mov  r0, r10, lsr lr
  str  r2, [sp, #8]
  sub  r2, r3, #31
  and  r0, r0, r2, asr #31
  mov  r3, ip, lsr lr
  orr  r4, r0, ip, asl r1
  and  r5, r3, r2, asr #31
l29:
  mov  ip, #0
  mov  r10, ip
  b  l40
l41:
  ldr  r1, [sp, #12]
  ldr  r2, [sp, #8]
  mov  r3, r4, lsr #31
  orr  r5, r3, r5, asl #1
  mov  r3, r1, lsr #31
  orr  r4, r3, r4, asl #1
  mov  r3, r2, lsr #31
  orr  r0, r3, r1, asl #1
  orr  r1, ip, r2, asl #1
  ldmia  sp, {r2-r3}
  str  r0, [sp, #12]
  subs  r2, r2, r4
  sbc  r3, r3, r5
  str  r1, [sp, #8]
  subs  r0, r2, #1
  sbc  r1, r3, #0
  mov  r2, r1, asr #31
  ldmia  sp, {r0-r1}
  mov  r3, r2
  and  ip, r2, #1
  and  r3, r3, r1
  and  r2, r2, r0
  subs  r4, r4, r2
  sbc  r5, r5, r3
  add  r10, r10, #1
l40:
  cmp  r10, lr
  bne  l41
  ldrd  r0, r1, [sp, #8]
  adds  r0, r0, r0
  adc  r1, r1, r1
  cmp  r6, #0
  orr  r10, r0, ip
  mov  r11, r1
  stmiane  r6, {r4-r5}
  b  l10
l2:
  mov  r10, #0
  mov  r11, #0
l10:
  mov  r0, r10
  mov  r1, r11
  sub  sp, r7, #20
  ldmfd  sp!, {r10, r11}
  ldmfd  sp!, {r4, r5, r6, r7, pc}
