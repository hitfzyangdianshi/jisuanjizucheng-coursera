#�ڶ��⣺�ַ������ұȽ�

#����ϵͳ���ܵ��ôӼ�������һ���ַ�����Ȼ�����뵥���ַ������Ҹ��ַ������Ƿ��и��ַ������ִ�Сд��������Ҫ�����£�
#(1) ����ҵ���������Ļ����ʾ��
#Success! Location: X
#���У�XΪ���ַ����ַ����е�һ�γ��ֵ�λ��

#(2) ���û�ҵ���������Ļ����ʾ��
#Fail!

#(3) ����һ���ַ����󣬿��Է�������ϣ����ѯ���ַ���ֱ������?������������

#(4) ÿ�������ַ���ռһ�У�������ҽ����ռһ�У�λ�ñ����1��ʼ��

#��ʾ��Ϊ�������壬�ַ����ڲ�����"?"����

#��ʽʾ�����£�

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
	beq $v0, 0x0d, input_ch #ENTER �س�Return
	beq $v0, 0x0a, input_ch #ENTER ����NewLine
	
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
	