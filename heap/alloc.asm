; args:
; - size        : eax
;
; rets:
; - ptr or -1   : eax
;
; clob:
; - all
alloc_page:
  ; mmap syscall
  mov ecx, eax
  mov eax, 192
  xor ebx, ebx
  mov edx, 0x01 | 0x02
  mov esi, 0x20 | 0x02
  xor edi, edi
  xor ebp, ebp
  int 0x80
  ret
