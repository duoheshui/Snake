; 键盘 上,下,左,右键扫描码
UP		equ		48h
DOWN	equ		50h
LEFT	equ		4bh
RIGHT	equ		4dh	

; ENTER 键(退出游戏)
_ENTER		equ		1ch




; 读取键盘, 非阻塞
; 如果输入为 上，下，左，右键，改变蛇头方向
; 如果输入为Enter键，设置cf
; 其他键清除cf 并返回
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
	jz .end			; 如果没有输入16h中断会设置zf
	
	mov ax, 0h		; 从键盘缓冲区获取一个输入
	int 16h
	
	cmp ah, UP				; 上
	je .up
	
	cmp ah, DOWN			; 下
	je .down
	
	cmp ah, LEFT			; 左
	je .left
	
	cmp ah, RIGHT			; 右
	je .right
	
	cmp ah, _ENTER			; Enter 键退出游戏
	je .enter
	
	clc						; 上，下，左，右，Enter以外的其他键
	jmp .end
	
	
.up:
	mov byte [snake_direction], UP		; 改变蛇头方向
	jmp .end
.down:
	mov byte [snake_direction], DOWN	; 改变蛇头方向
	jmp .end
.left:
	mov byte [snake_direction], LEFT	; 改变蛇头方向
	jmp .end
.right:
	mov byte [snake_direction], RIGHT	; 改变蛇头方向
	jmp .end
.enter:
	stc
	
.end:
	ret
