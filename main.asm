; 程序入口
; 16 位汇编-贪食蛇游戏
; 公司项目赶的紧, 有些bug还未修正, 项目结束后再做版本升级

; TODO 
; 1, 显示墙边界
; 2, 优化键盘响应, 当前键盘会感觉响应有些延迟, 
; 		这是因为读取键盘的过程在循环体内, 而循环体每0.5秒执行一次(delay 函数)
; 3, 优化随机数生成器, 使food看起来更随机一些
; 4, 添加背景音乐
; ........

; 运行环境: DosBox
; Author: zhangyi
; Assembler: Nasm
; Version: 0.1
; Date: 2016-03-04
; Email: danielzhang221@gmail.com
 

NODE_SHAPE	equ '*'

	org 0100h

	call set_text_mode
	call hide_cursor
	call init_video_pointer
	call init_food
main:
	call show_snake
	
	call delay
	call move
	call is_collide			; 每移动一步判断是否有碰撞
	jc quit_game
	
	call kbhit
	jc quit_game
			
	
	call clear_screen
	call show_food	
	jmp main
	
quit_game:					; 退出游戏
	call clear_screen		
	mov ah, 4ch				; 返回DOS
	int 21h

	
%include 'screen.asm'
%include 'keyboard.asm'
%include 'time.asm'
%include 'snake.asm'
%include 'food.asm'
%include 'collide.asm'		; 碰触计算



; 变量区
;================================================================	
; 蛇身各个点的坐标, 高8位是y, 低8位是x							|
; 如 0c0fh 表示 (x=0fh, y=0ch)									|
node dw 0c0fh, 0c0eh, 0c0dh, 0c0ch, 0c0bh, 0c0ah, 0c09h, 0	   ;|
snake_buffer times 80*25-8 dw 0								   ;|
															   ;|
; 蛇头方向, 初始向右										   ;|	
snake_direction db RIGHT									   ;|	
															   ;|
; 蛇身长, 初始7个节点											|
snake_size dw 7												   ;|

; 蛇头位置		
food_xy dw 0
food_pos dw 0
;================================================================