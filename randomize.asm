

; 生成一个0~65535的随机数
;===================================================
; prototype		: word random()
; input			: none
; output		: 随机数, 保存在ax中
;===================================================
random:
	push cx
	push dx
	
	mov ah, 0h
	int 1ah						; 获取系统嘀嗒数, 保存在cx,dx中
	
	mov cl, 3
	rol dx, cl					; 将随机种子循环右移4次
	xor dx, [.last_rnd_num]		; 与上次生成的随机数异或
	mov [.last_rnd_num], dx		; 保存本次随机数
	mov ax, dx
	
	pop dx
	pop cx
	ret

	.last_rnd_num dw 12345
	
	
; 生成一个0~max_value的随机数
;===================================================
; prototype		: byte random_r(byte max_value)
; input			: 最大值(不包含), 保存在 cl 中
; output		: 0~max_value的随机数, 保存在al中
;===================================================
random_r:
	push dx
	
	xor dx, dx
	xor ch, ch
	call random
	div cx
	mov al, dl
	
	pop dx
	ret


	
; 生成一个随机的x坐标	
;===================================================
; prototype		: byte random_x()
; input			: none
; output		: 随机x值,保存在al中
;===================================================	
random_x:
	push cx
	mov cl, 80
	call random_r
	pop cx
	ret

; 生成一个随机的y坐标	
;===================================================
; prototype		: byte random_y()
; input			: none
; output		: 随机y值, 保存在al中
;===================================================	
random_y:
	push cx
	mov cl, 25
	call random_r
	pop cx
	ret









