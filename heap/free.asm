; args:
; - address : ebx
; - size    : ecx
;
; rets:
;
; clob:
; - eax
dealloc_page:
  ; munmap syscall
  mov eax, 0x91
  int 0x80
  ret
