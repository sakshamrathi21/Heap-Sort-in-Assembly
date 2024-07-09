;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; AUTHOR = SAKSHAM RATHI ;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Functions which we have to import externally:
extern init_v
extern pop_v
extern push_v
extern size_v
extern get_element_v
extern resize_v
extern delete_v

; For debugging purposes:
; section   .data
; message:  db        "Hello, World", 10 

; Here starts the code:
section .text
global init_h
global delete_h
global size_h
global insert_h
global get_max
global pop_max
global heapify
global heapsort


; Code for initializing the heap:
init_h:
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
        ; The struct of the heap has similar address pattern as that of vector. rdi of struct heap = rdi of struct vector
        call init_v             ; Initializing a vector struct at the same address

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


; Code for deleting the heap
delete_h:
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
        ;Deleting the vector struct at that address is sufficient
        call delete_v                   ; Calling to delete the vector

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


; Returns the size of the heap:
size_h:
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
        call size_v             ; The size of the vector is the same as the size of the heap.
        
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


; Inserting into the heap
insert_h:
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
        call size_h                     ; rax will now contain the current size of the heap.
        mov r8, rax                     ; storing the size in r8
        call push_v                     ; Pushing the element in the vector at the end
        mov rbx, [rdi+16]               ; Storing the pointer to the array in rbx.
       
; The following code is a while loop, so as to place the newly inserted element so as to satisfy heap properties:
while_loop:
        cmp r8, 0                       ; Comparing old size with 0
        je end_while                    ; If it waa empty, it will have one element now, so we are done
        mov r9, r8                      ; Storing the old size into r9.
        sub r9, 1                       ; r9 = old size --
        shr r9, 1                       ; r9 = (oldsize - 1)/2 (parent of the current index(i) = (i-1)/2)
        mov r10, r8                     ; Storing r8 into r10
        mov r11, r9                     ; Storing r9 into r11
        imul r10, 8                     ; Each element has 8 bytes
        imul r11, 8                     ; Each element has 8 bytes
        mov r12, [r10+rbx]              ; r12 contains the ith element
        cmp [r11+rbx], r12              ; r11 contsins the parent element, comparing with child
        jl swap_elements                ; If parent < child, we need to swap
        jmp end_while                   ; Else, we are done.

; Code for swapping parent and child
swap_elements:
        ; For debugging purposes:
        ; mov r15, rdi
        ; mov rax, 1
        ; mov rdi, 1
        ; mov r14, rsi
        ; mov rsi, message
        ; mov rdx, 13
        ; syscall
        ; mov rsi, r14
        ; mov rdi, r15
        mov r13, [r10+rbx]              ; Storing the child element into r13
        mov r14, [r11+rbx]              ; Storing the parent element into r14
        mov [r10+rbx], r14              ; Parent element stored at child address
        mov [r11+rbx], r13              ; Child element stored at parent address
        mov r8, r9                      ; Updating (i) for while loop (i = parent(i))
        jmp while_loop                  ; Jumping to while loop with the updated index.

; For exiting while loop
end_while:                              
        mov [rdi+16], rbx               ; We are updating rbx, so storing back to the pointer of the vector.
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


; Code for getting the max of the heap:
get_max:
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
        mov rsi, 0                              ; The max will be present at the 0th index of the heap
        call get_element_v                      ; Calling get_element_v with 0 as the argument
        mov rax, [rax]                          ; Returning the element at the address returned

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


; Popping the maximum element out of the heap.
pop_max:
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
        call size_h                             ; Calling size_h
        mov r9, rax                             ; rax contains the size of the heap, storing the size into the r9
        sub r9, 1                               ; r9 = size - 1
        imul r9, 8                              ; Each element of 8 bytes
        mov r8, 0                               ; Moving 0 to r8
        imul r8, 8                              ; Each element of 8 bytes
        mov rbx, [rdi+16]                       ; Storing the pointer to rbx
        mov r10, [r8+rbx]                       ; Element at 0th index to r10
        mov r11, [r9+rbx]                       ; Element at the last index to r11
        mov [r8+rbx], r11                       ; Storing the last element at the first position.
        mov [r9+rbx], r10                       ; Storing the first element (maximum) to the last position, in short we are swapping the first and last elements.
        mov [rdi+16], rbx                       ; Storing rbx back into the pointer after swapping
        call pop_v                              ; Removing the last (max) element
        mov r15, 0                              ; r15 = 0
        cmp [rdi+8], r15                        ; Comparing current size with 0
        je end_pop_max                          ; If size = 0, then returning
        mov rsi, 0                              ; Index(rsi) = 0
        call heapify                            ; Calling heapify on the 0th index
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
        call size_h                             ; Calling size_h
        imul rax, 8                             ; size_h = size_h*8
        add rbx, rax                            ; Last element(deleted) address into rax
        mov rax, rbx                            ; rax = rbx
        mov rax, [rax]                          ; For returning the last element.

; For ending this function:
end_pop_max:
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


; The function which heapifies a particular index of the heap:
heapify:
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
        mov rbx, [rdi+16]                       ; rbx = pointer of the vector
        mov r8, rsi                             ; r8 = i, where i is the second function argument of heapify
        mov r9, rsi                             ; r9 = 1
        mov r10, rsi                            ; r10 = i
        imul r9, 2                              ; r9 = 2i
        add r9, 1                               ; r9 = 2i+1 (left(i))
        imul r10, 2                             ; r10 = 2i
        add r10, 2                              ; r10 = 2i+2 (right(i))
        call size_h                             ; Calling size_h
        add rax, -1                             ; rax = size, rax = size - 1
        cmp r9, rax                             ; Comparing left(i) with n-1
        jg end_while                            ; if left(i)>n-1, we are at the bottom level, so no need to heapify
        add rax, 1                              ; rax = n
        cmp r10, rax                            ; compare right(i), n
        je heapify_with_two_elements            ; if (right(i) == n), we need to comapare i and left(i)
        jmp index_with_largest_key              ; Else, we have to compare all the three elements

; If we need to comapare i and left(i):
heapify_with_two_elements:
        imul r9, 8                              ; Each element of 8 bytes
        imul r8, 8                              ; Each element of 8 bytes
        add r9, rbx                             ; Address of left(i)
        add r8, rbx                             ; Address of i
        mov r11, [r8]                           ; r11 = ith element
        cmp [r9], r11                           ; cmp heap[left(i)] and heap[i]
        jl end_heapify                          ; if heap[left(i)] < heap[i], we can end
        jmp r12_larger                          ; Else we need to swap

; If we need to compare three elements:
index_with_largest_key:
        imul r9, 8                              ; r9*=8
        imul r8, 8                              ; r8*=8
        imul r10, 8                             ; r10*=8
        add r9, rbx                             ; Adding the offset
        add r8, rbx                             ; Adding the offset
        add r10, rbx                            ; Adding the offset
        mov r11, [r8]                           ; r11 = heap[i]
        mov r12, [r9]                           ; r12 = heap[left(i)]
        mov r13, [r10]                          ; r13 = heap[right(i)]
        cmp r11, r12                            ; Compare ith and left(i) element
        jge compare_r13                         ; if heap[i] >= heap[left(i)], we jump
        jmp large_r12                           ; heap[left(i)] is greater, so we jump to compare it with r12

; To compare heap[i] and heap[right(i)]
compare_r13:
        cmp r11, r13                            ; compare heap[i] and heap[right(i)]
        jge end_heapify                         ; if heap[i] >= heap[right(i)], we do need to swap and we end
        jmp large_r12                           ; We compare r12 and r13

; To compare heap[left(i)] and heap[right(i)]
large_r12:
        cmp r12, r13                            ; compare heap[left(i)] and heap[right(i)]
        jg r12_larger                           ; if heap[left(i)] > heap[right(i)], left(i) is greatest of all
        mov r9, r10                             ; else, we move right(i) to r9
        jmp r12_larger                          ; We need to swap

; To swap:
r12_larger:
        sub r9, rbx                             ; Subtracting the offset
        sub r8, rbx                             ; Subtracting the offset
        mov r14, [rbx+r8]                       ; Storing heap[i] in r14
        mov r15, [rbx+r9]                       ; Storing the largest element in r15
        mov [rbx+r9], r14                       ; Storing the largest element in r14
        mov [rbx+r8], r15                       ; Storing heap[i] in r15, swapping done
        shr r9, 3                               ; r9 = r9/8
        mov rsi, r9                             ; Moving r9 to rsi
        call heapify                            ; Calling heapify again with the largest key index as the new argument (recursive)

; Code to end heapify function:
end_heapify:
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


; Code for building the heap out of an array:
buildHeap:
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
        call size_v                     ; size of the vector
        mov rcx, rax                    ; rcx = size(n)
        add rcx, -1                     ; rcx = n-1

; while loop to build the heap
while_build_heap:
        cmp rcx, 0                      ; compare rcx and 0

        ; mov r15, rdi
        ; mov rax, 1
        ; mov rdi, 1
        ; mov r14, rsi
        ; mov rsi, message
        ; mov rdx, 13
        ; syscall
        ; mov rsi, r14
        ; mov rdi, r15

        jl end_build_heap               ; if rcx < 0, we have done and we can exit
        mov rsi, rcx                    ; moving rcx to rsi
        call heapify                    ; Calling heapify on that index
        add rcx, -1                     ; Subtracting 1 from rcx
        jmp while_build_heap            ; Again jumping to the while loop

; Ending buildHeap function
end_build_heap:
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


; Code for sorting the vector using heap sort algorithm:
heapsort:
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
        call size_v                     ; rax = siz of the vector (n)
        mov r8, rax                     ; r8 = rax (n)
        mov r9, r8                      ; r9 = n
        call buildHeap                  ; Calling buildHeap on the vector. Now the vector will be arranged in form of a heap.

; Code to Arrange the elements in non-decreasing order: 
while_heap_sort:
        cmp r8, 0                       ; comparing current_index with 0
        je end_heap_sort                ; If = 0, we have completed
        call pop_max                    ; popping the maximum element out of the heap adn putting it to the last
        add r8, -1                      ; Decrementing index by 1
        jmp while_heap_sort             ; Again jumping to the while loop

; Code to end heap sort
end_heap_sort:
        mov [rdi+8], r9                 ; pop max decreases size, we need to restore it to original, the elements are sorted now.
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
;The code ends here.;
;Thank You for reading the code. 
; The code for this structure of heap and it's member functions has been taken from : "https://www.cse.iitb.ac.in/~akg/courses/2023-ds/"