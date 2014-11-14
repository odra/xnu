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

.extern ___udivsi3

EnterARM(__umodsi3)
  stmfd  sp!, {r4, r5, r7, lr}
  add  r7, sp, #8
  mov  r5, r0
  mov  r4, r1
  bl   ___udivsi3
  mul  r0, r4, r0
  rsb  r0, r0, r5
  ldmfd  sp!, {r4, r5, r7, pc}

