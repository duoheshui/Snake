
; 是否碰触到food, 墙壁, 蛇身
;=======================================
; prototype		: void is_collide()
; input			: none
; output		: 如果碰墙或蛇向, CF置1
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
	
	
;	add bx, 3*2				; 从第4(下标为3)个节点开始计算, 【蛇头不可能碰到0,1,2号节点】
;	mov cx, [snake_size]
;	sub cx, 3				; 总长减去3个节点
	
;.next_node:	
;	cmp bx, [node]			; 蛇身与蛇头比较
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
	
	call delay				; 'Game Over' 在屏幕上停留1秒
	call delay
	
	stc
	jmp .end
	.game_over_msg	db 'Game Over'
	
	
	
; 吃	
.eat_food:
	clc
	jmp .end
		