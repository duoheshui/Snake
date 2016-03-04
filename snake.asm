; Snake ��غ���





; ����x, y�����ȡ�õ���ڴ��ַ; addr = y*80*2+x*2
;=================================================
; prototype		: word get_addr(word xy)
; input			: x, y ����, ������ax��, ah��yֵ, al��xֵ
; output		: ��������ڴ��ַ, ������ax��
;=================================================
get_addr:
	mov [.x_coord], al	; ����˷���Ƶ��ʹ��ax, �Ƚ�xy���걣������
	mov [.y_coord], ah
	mov al, 80*2
	xor ah, ah
	mul byte [.y_coord]
	mov [.y_addr], ax		; .y_addr = 80*2 * y
	
	mov al, [.x_coord]		; ���»�ȡx����
	shl al, 1				; x����*2, 80*25ģʽÿ���ַ�ռ�����ֽ�
	xor ah, ah
	add ax, [.y_addr]
	ret

	.y_addr dw 0	; y����*��Ļ���ֵ
	.x_coord db 0	; x����
	.y_coord db 0	; y����
	
	

	
; ����Ļ����ʾ��	
;=================================================
; prototype		: void show_snake()
; input			: none
; output		: none
;=================================================	
show_snake:
	mov bx, node
	xor di, di
.show_node:	
	mov ax, [bx]
	cmp ax, 0				; �Ƿ��ѵ���β��
	je .snake_end
	call get_addr
	mov di, ax
	mov byte [es:di], NODE_SHAPE
	add bx, 2				; ��һ���ڵ�
	jmp .show_node
.snake_end:
	ret
	
	
	
	
	
; ������ͷ��ǰ�ķ���, �ƶ�һ��
;=================================================
; prototype		: void move()
;=================================================
move:
	push bx
	push ax

	mov bx, node
	mov ax, [bx]
	mov [.prev_node_pos], ax				; ������ͷλ��
	
	cmp byte [snake_direction], UP
	je .move_up
	cmp byte [snake_direction], DOWN
	je .move_down
	cmp byte [snake_direction], LEFT
	je .move_left
	cmp byte [snake_direction], RIGHT
	je .move_right
	
.move_head_complete:
	mov [bx], ax						; ������ͷ
	mov cx, [snake_size]
	
.move_snake_body:						; ��������
	add bx, 2
	mov ax, [bx]
	mov [.curr_node_pos], ax			; �ȱ���ǰ���ڵ�λ��
	mov ax, [.prev_node_pos]			; �ٽ���һ���ڵ�λ������Ϊ��ǰ�ڵ�
	mov [bx], ax
	
	mov ax, [.curr_node_pos]			; ����ǰ�ڵ�λ������Ϊ��һ�ڵ�λ��
	mov [.prev_node_pos], ax
	loop .move_snake_body
	
	pop ax
	pop bx
	ret
	
.move_up:
	dec ah						; y�����1
	jmp .move_head_complete

.move_down:
	inc ah						; y�����1
	jmp .move_head_complete
	
.move_left:
	dec al						; x�����1
	jmp .move_head_complete

.move_right:
	inc al						; x�����1
	jmp .move_head_complete
	
	.prev_node_pos dw 0
	.curr_node_pos dw 0