#第二题：字符串查找比较

#利用系统功能调用从键盘输入一个字符串，然后输入单个字符，查找该字符串中是否有该字符（区分大小写）。具体要求如下：
#(1) 如果找到，则在屏幕上显示：
#Success! Location: X
#其中，X为该字符在字符串中第一次出现的位置

#(2) 如果没找到，则在屏幕上显示：
#Fail!

#(3) 输入一个字符串后，可以反复输入希望查询的字符，直到按“?”键结束程序

#(4) 每个输入字符独占一行，输出查找结果独占一行，位置编码从1开始。

#提示：为避免歧义，字符串内不包含"?"符号

#格式示例如下：

#abcdefgh

#a
#Success! Location: 1

#x
#Fail!



	.data
msg_init:	.asciiz  "Please enter a string: \r\n"
msg_init2:	.asciiz "\r\nPlease enter a chacacter: \r\n"  
msg_success:	.asciiz "\r\nSuccess! Location: "
msg_fail:	.asciiz "\r\nFail!\r\n"
msg_enter:	.asciiz "\r\n"
str:	.space 200

	
	.text 
	.globl main
main:	la $a0 msg_init
	li $v0,4#$a0 = address of null-terminated string to print
	syscall
	
	la $a0,str
	la $a1,200
	li $v0, 8#$a0 = address of input buffer; $a1 = maximum number of characters to read
	syscall
	
input_ch:
	la $a0 msg_init2
	li $v0,4
	syscall
	li $v0, 12#$v0 contains character read
	syscall
	beq $v0, 63, quit #?
	beq $v0, 0x0d, input_ch #ENTER 回车Return
	beq $v0, 0x0a, input_ch #ENTER 换行NewLine
	
	la $s1, str
	
loop0:	lb $s0 	,0($s1)
	sub $t1, $v0, $s0
	beq $t1, 0, success
	addi $t0, $t0, 1
	bge $t0, $a1, fail
	addi $s1 ,$s1, 1
	j loop0

fail:	
	la $a0,msg_fail
	li $v0, 4
        syscall
        li $t0 ,0
        j input_ch
			
success:
	la $a0,msg_success
        li $v0, 4 
        syscall
        addi $a0, $t0, 1
        li $v0, 1 #$a0 = integer to print
        syscall
        la $a0, msg_enter
        li $v0, 4
        syscall
        li $t0 ,0
        j input_ch

quit:
	li $v0, 10 
	syscall
	