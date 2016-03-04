; 键盘 上,下,左,右键扫描码
UP		equ		48h
DOWN	equ		50h
LEFT	equ		4bh
RIGHT	equ		4dh	

; ENTER 键(退出游戏)
_ENTER		equ		1ch




; 读取键盘, 非阻塞
;===========================================
; prototype		: word kbhit()
; input			: none
; output		: 
;===========================================
kbhit:
	mov al, 0h
	mov ah, 01h	
	int 16h		
	jz .end			; 如果没有输入16h中断会设置zf
	
	mov ax, 0h		; 从键盘缓冲区获取一个输入
	int 16h
	
	cmp ah, UP				; 上
	je .hit_up
	
	cmp ah, DOWN			; 下
	je .hit_down
	
	cmp ah, LEFT			; 左
	je .hit_left
	
	cmp ah, RIGHT			; 右
	je .hit_right
	
	cmp ah, _ENTER			; Enter 键退出游戏
	jne .end
	mov byte [quit_flag], 1
.end:
	ret
	


	
; 键盘向上事件
.hit_up:
	mov byte [snake_direction], UP		; 改变蛇头方向
	jmp .end
	
; 键盘向下事件
.hit_down:
	mov byte [snake_direction], DOWN	; 改变蛇头方向
	jmp .end

; 键盘向左事件
.hit_left:
	mov byte [snake_direction], LEFT	; 改变蛇头方向
	jmp .end

; 键盘向右事件
.hit_right:
	mov byte [snake_direction], RIGHT	; 改变蛇头方向
	jmp .end