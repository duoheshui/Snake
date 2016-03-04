
; 生成随机food
;=======================================
; prototype		: void init_food()
;=======================================
init_food:
	push ax
	call random_y
	mov [.food_y], al
	call random_x
	
	mov ah, [.food_y]
	
	mov [food_xy], ax	; 保存food x,y坐标
	call get_addr		; 获取food内存位置
	mov [food_pos], ax
	call show_food
	pop ax
	ret
	.food_y db 0
	
	


; 显示food
;=======================================
; prototype		: void show_food(word addr)
; input			: food 内存地址, 位于 [food_pos]
; output		; none
;=======================================
show_food:
	push ax
	push bx
	push es
	
	mov bx, [food_pos]
	cmp bx, 0
	je .end
	
	mov ax, 0b800h
	mov es, ax
	
	mov byte [es:bx], '#'
	inc bx
	mov byte [es:bx], 0000_1010b		; 绿色食物 :-)
	
	pop es
	pop bx
	pop ax
.end:	
	ret

	

	
%include 'randomize.asm'