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
	je .hit_up
	
	cmp ah, DOWN			; ��
	je .hit_down
	
	cmp ah, LEFT			; ��
	je .hit_left
	
	cmp ah, RIGHT			; ��
	je .hit_right
	
	cmp ah, _ENTER			; Enter ���˳���Ϸ
	jne .end
	mov byte [quit_flag], 1
.end:
	ret
	


	
; ���������¼�
.hit_up:
	mov byte [snake_direction], UP		; �ı���ͷ����
	jmp .end
	
; ���������¼�
.hit_down:
	mov byte [snake_direction], DOWN	; �ı���ͷ����
	jmp .end

; ���������¼�
.hit_left:
	mov byte [snake_direction], LEFT	; �ı���ͷ����
	jmp .end

; ���������¼�
.hit_right:
	mov byte [snake_direction], RIGHT	; �ı���ͷ����
	jmp .end