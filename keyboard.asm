; ���� ��,��,��,�Ҽ�ɨ����
UP		equ		48h
DOWN	equ		50h
LEFT	equ		4bh
RIGHT	equ		4dh	

; ENTER ��(�˳���Ϸ)
_ENTER		equ		1ch




; ��ȡ����, ������
; �������Ϊ �ϣ��£����Ҽ����ı���ͷ����
; �������ΪEnter��������cf
; ���������cf ������
;===========================================
; prototype		: word kbhit()
; input			: none
; output		: cf
;===========================================
kbhit:
	mov al, 0h
	mov ah, 01h	
	int 16h
	
	clc	
	jz .end			; ���û������16h�жϻ�����zf
	
	mov ax, 0h		; �Ӽ��̻�������ȡһ������
	int 16h
	
	cmp ah, UP				; ��
	je .up
	
	cmp ah, DOWN			; ��
	je .down
	
	cmp ah, LEFT			; ��
	je .left
	
	cmp ah, RIGHT			; ��
	je .right
	
	cmp ah, _ENTER			; Enter ���˳���Ϸ
	je .enter
	
	clc						; �ϣ��£����ң�Enter�����������
	jmp .end
	
	
.up:
	mov byte [snake_direction], UP		; �ı���ͷ����
	jmp .end
.down:
	mov byte [snake_direction], DOWN	; �ı���ͷ����
	jmp .end
.left:
	mov byte [snake_direction], LEFT	; �ı���ͷ����
	jmp .end
.right:
	mov byte [snake_direction], RIGHT	; �ı���ͷ����
	jmp .end
.enter:
	stc
	
.end:
	ret
