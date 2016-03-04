

; ����һ��0~65535�������
;===================================================
; prototype		: word random()
; input			: none
; output		: �����, ������ax��
;===================================================
random:
	push cx
	push dx
	
	mov ah, 0h
	int 1ah						; ��ȡϵͳ�����, ������cx,dx��
	
	mov cl, 3
	rol dx, cl					; ���������ѭ������4��
	xor dx, [.last_rnd_num]		; ���ϴ����ɵ���������
	mov [.last_rnd_num], dx		; ���汾�������
	mov ax, dx
	
	pop dx
	pop cx
	ret

	.last_rnd_num dw 12345
	
	
; ����һ��0~max_value�������
;===================================================
; prototype		: byte random_r(byte max_value)
; input			: ���ֵ(������), ������ cl ��
; output		: 0~max_value�������, ������al��
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


	
; ����һ�������x����	
;===================================================
; prototype		: byte random_x()
; input			: none
; output		: ���xֵ,������al��
;===================================================	
random_x:
	push cx
	mov cl, 80
	call random_r
	pop cx
	ret

; ����һ�������y����	
;===================================================
; prototype		: byte random_y()
; input			: none
; output		: ���yֵ, ������al��
;===================================================	
random_y:
	push cx
	mov cl, 25
	call random_r
	pop cx
	ret









