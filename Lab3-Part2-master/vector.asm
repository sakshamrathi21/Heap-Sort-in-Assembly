;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; AUTHOR = SAKSHAM RATHI ;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Functions which we have to import externally:
extern realloc                  ; reallocates a chunk of memory
extern free                     ; to free a space of memory

; For debugging purposes:
; section   .data
; message:  db        "Hello, World", 10 

; Here starts the code:
section .text
; The following have been made global so that they can be accessed from outside.
global init_v
global delete_v
global resize_v
global get_element_v
global push_v
global pop_v
global size_v


; Initializing a vector:
init_v:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15

        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE

        mov rax, 0                      ; Initializing rax to 0
        mov [rdi], rax                  ; [rdi] contains the maximum size of the vector, we are initializing it to 0.
        mov [rdi+8], rax                ; [rdi+8] contains the current size of the vector, we are initializing it to 0.
        mov r8, rdi                     ; Storing rdi (function argument) to r8.
        mov rdi, 0                      ; Setting rdi to 0. This will be the first function argument to realloc (null ptr)
        mov rsi, 8                      ; Setting rsi to 8. Initially we want 8 bytes of space for first element. This will be the second function argument to realloc.
        call realloc                    ; Calling realloc with rdi and rsi as function parameters.
        mov rdi, r8                     ; Restoring the value of rdi.
        mov [rdi+16], rax               ; Storing the return value from realloc to [rdi+16] (pointer to the vector)
        mov rax, 1                      ; Setting rax to 1
        mov [rdi], rax                  ; The maximum size of the array is 1.

        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

; Deleting the vector after use
delete_v:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        
        mov rdi, [rdi+16]                       ; Pointer to the vector which has to be freed
        call free                               ; Calling free on rdi.

        ; The following commented code is for debugging purposes, It prints the message "Hello, World" on terminal.
        ; mov rdi, r10
        ; mov r8, rdi
        ; mov rax, 1
        ; mov rdi, 1
        ; mov r9, rsi
        ; mov rsi, message
        ; mov rdx, 13
        ; syscall
        ; mov rsi, r9
        ; mov rdi, r8

        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

; Unlike arrays, vectors can be expanded, so here is the resize function.
resize_v:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15

        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        ; The following line calls realloc function with rdi and rsi as function parameters. rdi contains the old pointer to the vector and rsi conatins the size which we want.
        ; If realloc finds space at the old pointer, it does not change it, else it returns the new pointer to rax.

        ; mov r15, rdi
        ; mov rax, 1
        ; mov rdi, 1
        ; mov r14, rsi
        ; mov rsi, message
        ; mov rdx, 13
        ; syscall
        ; mov rsi, r14
        ; mov rdi, r15

        call realloc

        

        
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

; To get the element of the vector at a particular index.
get_element_v:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        ; Two function parameters, rdi = address of the struct of vector and rsi for the index
        mov rax, [rdi+16]               ; The pointer to the vector
        mov rbx, rsi                    ; Index of the vector
        imul rbx, 8                     ; Each element takes 8 bytes 
        add rax, rbx                    ; Returning the address of the required element. It can be accessed by *get_element_v(&v, i).
        
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

; To push the element at the back of the vector.
push_v:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        
        mov r10, rsi                            ; rsi contains the element to be pushed. We are storing it in r10.
        mov r12, [rdi]                          ; Maixmum size in r12
        cmp r12, [rdi+8]                        ; Comparing current size with maximum size
        jg continue_push_v                     ; If maximum size >= current size, we can continue pushing, else resize.

        mov rsi, [rdi]                          ; Maximum size stored in rsi
        imul rsi, 2                             ; rsi = rsi*2
        add rsi, 1                              ; rsi++
        mov [rdi], rsi                          ; This is our new maximum size, we are storing it in [rdi]
        imul rsi, 8                             ; Each element takes 8 bytes
        mov r11, rdi                            ; Storing rdi for future
        mov rdi, [rdi+16]                       ; Old pointer passed as a function argument
        call resize_v                           ; Calling resize with rdi and rsi as parameters
        mov rdi, r11                            ; Restoring rdi
        mov [rdi+16], rax                       ; The pointer might have changed, so storing the new pointer


continue_push_v:
        

        mov rax, [rdi+16]                       ; Storing the pointer in rax
        mov rbx, [rdi+8]                        ; Storing the current size in rbx
        imul rbx, 8                             ; 8 bytes for each element
        add rax, rbx                            ; Getting to the last address
        mov [rax], r10                          ; Storing the value to be pushed at the start
        mov rcx, 1                              ; rcx = 1
        add [rdi+8], rcx                        ; Incrementing current size by 1

        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

; To pop an element from the back of the vector
pop_v:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        mov rbx, [rdi+8]                        ; rbx = current size
        mov rcx, rbx                            ; rcx = rbx
        cmp rbx, 0                              ; Comaprison of current size with 0
        je vector_empty                         ; If current size = 0, we do not have anything to pop, so returning
        add rbx, -1                             ; Decrementing rbx by 1 (current_size--;)
        imul rbx, 8                             ; Each element has 8 bytes
        mov rax, [rdi+16]                       ; Storing the pointer in rax
        add rax, rbx                            ; Getting addres of the last element
        mov rax, [rax]                          ; Getting the value of the element

        ; For debugging:
        ; mov r15, rdi
        ; mov rax, 1
        ; mov rdi, 1
        ; mov r14, rsi
        ; mov rsi, message
        ; mov rdx, 13
        ; syscall
        ; mov rsi, r14
        ; mov rdi, r15

        add rcx, -1                             ; rcx = new size
        mov [rdi+8], rcx                        ; Updating the new size of the array
        
; Code for returning back to the caller.
vector_empty:
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

; To return the current size of the vector
size_v:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
        mov rax, [rdi+8]                        ; [rdi+8] contains the current size of the vector, we are moving it to rax (return register).

        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

;The code ends here.