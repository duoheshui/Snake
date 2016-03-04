


; ‘›Õ£0.5√Î
;=================================================
; prototype		: void delay()
;=================================================	
delay:
	push cx
	push dx
	push ax
	
	mov cx, 07h
	mov dx, 0a120h
	mov ah, 86h
	int 15h
	
	pop ax
	pop dx
	pop cx
	ret