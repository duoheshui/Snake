;=============================================
; prototype		: set_text_mode()
; desc			: ������ʾ��ģʽ: 80*25 �ַ�ģʽ
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
; desc			: ����
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
	mov word [es:bx], 0720h		; �ո�
	add bx, 2
	loop .fill
	
	call show_food
	
	pop es
	pop cx
	pop bx
	pop ax
	ret
	
	
	
	
;=============================================
; prototype		: viud hide_cursor()
; desc			: ���ع��
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
; desc			: 80*25 �ı�ģʽ
;=============================================	
init_video_pointer:
	push ax
	mov ax, 0b800h
	mov es, ax	
	pop ax
	ret