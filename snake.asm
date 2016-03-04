; Snake 相关函数





; 根据x, y坐标获取该点的内存地址; addr = y*80*2+x*2
;=================================================
; prototype		: word get_addr(word xy)
; input			: x, y 坐标, 保存在ax中, ah是y值, al是x值
; output		: 该坐标的内存地址, 保存在ax中
;=================================================
get_addr:
	mov [.x_coord], al	; 计算乘法会频繁使用ax, 先将xy坐标保存起来
	mov [.y_coord], ah
	mov al, 80*2
	xor ah, ah
	mul byte [.y_coord]
	mov [.y_addr], ax		; .y_addr = 80*2 * y
	
	mov al, [.x_coord]		; 重新获取x坐标
	shl al, 1				; x坐标*2, 80*25模式每个字符占两个字节
	xor ah, ah
	add ax, [.y_addr]
	ret

	.y_addr dw 0	; y坐标*屏幕宽的值
	.x_coord db 0	; x坐标
	.y_coord db 0	; y坐标
	
	

	
; 在屏幕上显示蛇	
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
	cmp ax, 0				; 是否已到蛇尾？
	je .snake_end
	call get_addr
	mov di, ax
	mov byte [es:di], NODE_SHAPE
	add bx, 2				; 下一个节点
	jmp .show_node
.snake_end:
	ret
	
	
	
	
	
; 根据蛇头当前的方向, 移动一步
;=================================================
; prototype		: void move()
;=================================================
move:
	push bx
	push ax

	mov bx, node
	mov ax, [bx]
	mov [.prev_node_pos], ax				; 保存蛇头位置
	
	cmp byte [snake_direction], UP
	je .move_up
	cmp byte [snake_direction], DOWN
	je .move_down
	cmp byte [snake_direction], LEFT
	je .move_left
	cmp byte [snake_direction], RIGHT
	je .move_right
	
.move_head_complete:
	mov [bx], ax						; 更新蛇头
	mov cx, [snake_size]
	
.move_snake_body:						; 更新蛇身
	add bx, 2
	mov ax, [bx]
	mov [.curr_node_pos], ax			; 先备份前当节点位置
	mov ax, [.prev_node_pos]			; 再将上一个节点位置设置为当前节点
	mov [bx], ax
	
	mov ax, [.curr_node_pos]			; 将当前节点位置设置为上一节点位置
	mov [.prev_node_pos], ax
	loop .move_snake_body
	
	pop ax
	pop bx
	ret
	
.move_up:
	dec ah						; y方向减1
	jmp .move_head_complete

.move_down:
	inc ah						; y方向加1
	jmp .move_head_complete
	
.move_left:
	dec al						; x方向减1
	jmp .move_head_complete

.move_right:
	inc al						; x方向加1
	jmp .move_head_complete
	
	.prev_node_pos dw 0
	.curr_node_pos dw 0