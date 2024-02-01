; args:
; - pointer  : eax
; - old size : ebx
; - new size : ecx
;
; rets:
; - new ptr  : eax
;
; clobs:
; all
realloc_page:

; edx = min(old, new)
  mov edx, ebx
  cmp ebx, ecx
  jb .l0
  mov edx, ecx
.l0:

  push ebx  ; old size
  push edx  ; min(old, new)
  push eax  ; old pointer

  mov eax, ecx
  call alloc_page

; check errors
  cmp eax, -1
  jne .l1
  ret
.l1:

  mov ecx, eax  ; ecx = new pointer

  pop eax       ; eax = old pointer
  pop edx       ; edx = copy count

  ; TODO: use MMX for copy
.loop:
  dec edx
  jz .l2
  mov bl, [eax + edx]
  mov [ecx + edx], bl
  jmp .loop
.l2:

  mov edx, ecx  ; edx = new pointer
  mov ebx, eax  ; ebx = old pointer
  pop ecx       ; ecx = old size
  call dealloc_page

  mov eax, edx  ; eax = new pointer

  ret
