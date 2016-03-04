
; 是否碰触到food, 墙壁, 蛇身
;=======================================
; prototype		: void is_collide()
; input			: none
; output		: 如果碰墙或蛇身, CF置1
;=======================================
is_collide:
	push ax
	push bx
	push cx
	push es
	push si
	push di
	
	mov bx, [node]
	cmp bx, [food_xy]		; 蛇头坐标和food坐标一至
	je .eat_food
	
	cmp bl, 0
	je .collide			; 左墙
	cmp bl, 79
	je .collide			; 右墙
	
	cmp bh, 0
	je .collide			; 上墙
	cmp bh, 24
	je .collide			; 下墙
	
	
	; 判断是否碰到自己
	mov bx, node
	add bx, 3*2				; 从第4(下标为3)个节点开始计算, 【蛇头不可能碰到0,1,2号节点】
	mov cx, [snake_size]
	sub cx, 3				; 总长减去3个节点
	
	mov dx, [node]			; 蛇头
.next_node:	
	cmp [bx], dx				; 蛇身与蛇头比较
	je .collide
	add bx, 2
	loop .next_node

.end:
	clc
.return:
	pop di
	pop si
	pop es
	pop cx
	pop bx
	pop ax	
	ret

		
		

; 撞到自己身体,墙壁
.collide:
	mov ax, 0b800h
	mov es, ax
	mov si, .game_over_msg
	mov di, 12*160+33*2		; 显示在屏幕正中间, 第12行, 33列
	mov cx, 9
.loop:
	movsb					; movsb 会使si+1, di+1
	inc di
	loop .loop
	
	call delay				; 'Game Over' 在屏幕上停留一会
	call delay
	call delay
	call delay
	
	stc
	jmp .return
	.game_over_msg	db 'Game Over'
	
	
	
; 吃 - 在蛇尾添加一个节点
.eat_food:
	mov bx, [snake_size]
	shl bx, 1				; 蛇尾下标
	mov ax, [bx -2]			; 获取蛇尾
	call move
	mov [bx], ax			; 把最蛇尾复制到下一个
	
	mov bx, [snake_size]
	inc bx
	mov [snake_size], bx	; 蛇长+1
	
	call init_food			; 更新food
	
	clc
	jmp .end
		