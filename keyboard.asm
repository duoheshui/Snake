; ���� ��,��,��,�Ҽ�ɨ����
UP		equ		48h
DOWN	equ		50h
LEFT	equ		4bh
RIGHT	equ		4dh	

; ENTER ��(�˳���Ϸ)
_ENTER		equ		1ch




; ��ȡ����, ������
;===========================================
; prototype		: word kbhit()
; input			: none
; output		: 
;===========================================
kbhit:
	mov al, 0h
	mov ah, 01h	
	int 16h		
	jz .end			; ���û������16h�жϻ�����zf
	
	mov ax, 0h		; �Ӽ��̻�������ȡһ������
	int 16h
	
	cmp ah, UP				; ��
	mov byte [snake_direction], UP		; �ı���ͷ����
	jmp .end
	
	cmp ah, DOWN			; ��
	mov byte [snake_direction], DOWN	; �ı���ͷ����
	jmp .end
	
	cmp ah, LEFT			; ��
	mov byte [snake_direction], LEFT	; �ı���ͷ����
	jmp .end
	
	cmp ah, RIGHT			; ��
	mov byte [snake_direction], RIGHT	; �ı���ͷ����
	jmp .end
	
	;cmp ah, _ENTER			; Enter ���˳���Ϸ
	;jne .end
	;mov byte [quit_flag], 1
.end:
	ret
