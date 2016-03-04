
; �Ƿ�������food, ǽ��, ����
;=======================================
; prototype		: void is_collide()
; input			: none
; output		: �����ǽ������, CF��1
;=======================================
is_collide:
	push ax
	push bx
	push cx
	push es
	push si
	push di
	
	mov bx, [node]
	cmp bx, [food_xy]		; ��ͷ�����food����һ��
	je .eat_food
	
	cmp bl, 0
	je .collide			; ��ǽ
	cmp bl, 79
	je .collide			; ��ǽ
	
	cmp bh, 0
	je .collide			; ��ǽ
	cmp bh, 24
	je .collide			; ��ǽ
	
	
;	add bx, 3*2				; �ӵ�4(�±�Ϊ3)���ڵ㿪ʼ����, ����ͷ����������0,1,2�Žڵ㡿
;	mov cx, [snake_size]
;	sub cx, 3				; �ܳ���ȥ3���ڵ�
	
;.next_node:	
;	cmp bx, [node]			; ��������ͷ�Ƚ�
;	je .collide
;	add bx, 2
	clc
.end:
	pop di
	pop si
	pop es
	pop cx
	pop bx
	pop ax
	ret

		
		

; ײ���Լ�����,ǽ��
.collide:
	mov ax, 0b800h
	mov es, ax
	mov si, .game_over_msg
	mov di, 12*160+33*2		; ��ʾ����Ļ���м�, ��12��, 33��
	mov cx, 9
.loop:
	movsb					; movsb ��ʹsi+1, di+1
	inc di
	loop .loop
	
	call delay				; 'Game Over' ����Ļ��ͣ��һ��
	call delay
	call delay
	call delay
	
	stc
	jmp .end
	.game_over_msg	db 'Game Over'
	
	
	
; ��
.eat_food:
	clc
	jmp .end
		