; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-apple-darwin | FileCheck %s

; Check that the legalizer doesn't crash when scalarizing FP conversion
; instructions' operands.  The operands are all illegal on AArch64,
; ensuring they are legalized.  The results are all legal.

define <1 x double> @test_sitofp(<1 x i1> %in) #0 {
; CHECK-LABEL: test_sitofp:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    sub sp, sp, #16 ; =16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    sbfx w8, w0, #0, #1
; CHECK-NEXT:    mov w9, #1127219200
; CHECK-NEXT:    eor w8, w8, #0x80000000
; CHECK-NEXT:    stp w8, w9, [sp, #8]
; CHECK-NEXT:    ldr d0, [sp, #8]
; CHECK-NEXT:    mov x8, #2147483648
; CHECK-NEXT:    movk x8, #17200, lsl #48
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    fsub d0, d0, d1
; CHECK-NEXT:    add sp, sp, #16 ; =16
; CHECK-NEXT:    ret
entry:
  %0 = call <1 x double> @llvm.experimental.constrained.sitofp.v1f64.v1i1(<1 x i1> %in, metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret <1 x double> %0
}

define <1 x double> @test_uitofp(<1 x i1> %in) #0 {
; CHECK-LABEL: test_uitofp:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    sub sp, sp, #16 ; =16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    and w8, w0, #0x1
; CHECK-NEXT:    mov w9, #1127219200
; CHECK-NEXT:    stp w8, w9, [sp, #8]
; CHECK-NEXT:    ldr d0, [sp, #8]
; CHECK-NEXT:    mov x8, #4841369599423283200
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    fsub d0, d0, d1
; CHECK-NEXT:    add sp, sp, #16 ; =16
; CHECK-NEXT:    ret
entry:
  %0 = call <1 x double> @llvm.experimental.constrained.uitofp.v1f64.v1i1(<1 x i1> %in, metadata !"round.dynamic", metadata !"fpexcept.strict") #0
  ret <1 x double> %0
}

attributes #0 = { strictfp }

declare <1 x double> @llvm.experimental.constrained.sitofp.v1f64.v1i1(<1 x i1>, metadata, metadata)
declare <1 x double> @llvm.experimental.constrained.uitofp.v1f64.v1i1(<1 x i1>, metadata, metadata)
