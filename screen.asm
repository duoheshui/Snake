;=============================================
; prototype		: set_text_mode()
; desc			: 设置显示器模式: 80*25 字符模式
;=============================================
set_text_mode:
	push ax
	mov ah, 0h
	mov al, 03h
	int 10h
	pop ax
	ret





;=============================================
; prototype		: void clear_screen()
; desc			: 清屏
;=============================================
clear_screen:
	push ax
	push bx
	push cx
	push es

	mov ax, 0b800h
	mov es, ax
	xor bx, bx
	mov cx, 80*25
	
.fill:	
	mov word [es:bx], 0720h		; 空格
	add bx, 2
	loop .fill
	
	pop es
	pop cx
	pop bx
	pop ax
	ret
	
	
	
	
;=============================================
; prototype		: viud hide_cursor()
; desc			: 隐藏光标
;=============================================	
hide_cursor:
	push ax
	push cx
	
	mov ah, 01h
	mov cx, 2607h
	int 10h
	pop cx
	pop ax
	ret
	
;=============================================
; prototype		: void init_video_pointer()
; desc			: 80*25 文本模式
;=============================================	
init_video_pointer:
	push ax
	mov ax, 0b800h
	mov es, ax	
	pop ax
	ret