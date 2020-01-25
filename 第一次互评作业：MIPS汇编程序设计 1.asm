#第一题：用系统功能调用实现简单输入输出
#利用系统功能调用从键盘输入，转换后在屏幕上显示，具体要求如下：
# (1) 如果输入的是字母（A~Z，区分大小写）或数字（0~9），则将其转换成对应的英文单词后在屏幕上显示，对应关系见下表
# (2) 若输入的不是字母或数字，则在屏幕上输出字符“*”，
# (3) 每输入一个字符，即时转换并在屏幕上显示，
# (4) 支持反复输入，直到按“?”键结束程序。
# A	Alpha	N	November	1	First	a	alpha	n	november
# B	Bravo	O	Oscar	2	Second	b	bravo	o	oscar
# C	China	P	Paper	3	Third	c	china	p	paper
# D	Delta	Q	Quebec	4	Fourth	d	delta	q	quebec
# E	Echo	R	Research	5	Fifth	e	echo	r	research
# F	Foxtrot	S	Sierra	6	Sixth	f	foxtrot	s	sierra
# G	Golf	T	Tango	7	Seventh	g	golf	t	tango
# H	Hotel	U	Uniform	8	Eighth	h	hotel	u	uniform
# I	India	V	Victor	9	Ninth	i	india	v	victor
# J	Juliet	W	Whisky	0	zero	j	juliet	w	whisky
# K	Kilo	X	X-ray			k	kilo	x	x-ray
# L	Lima	Y	Yankee			l	lima	y	yankee
# M	Mary	Z	Zulu			m	mary	z	zulu


	.data
U:	.asciiz 
	" Alpha\r\n", " Bravo\r\n", " China\r\n", " Delta\r\n", " Echo\r\n", " Foxtrot\r\n", " Golf\r\n", " Hotel\r\n", " India\r\n", " Juliet\r\n", " Kilo\r\n", " Lima\r\n", " Mary\r\n", " November\r\n", " Oscar\r\n", " Paper\r\n", " Quebec\r\n", " Research\r\n", " Sierra\r\n", " Tango\r\n", " Uniform\r\n", " Victor\r\n", " Whisky\r\n", " X-ray\r\n", " Yankee\r\n", " Zulu\r\n"
	.word  
U_:	0, 9, 18, 27, 36, 44, 55, 63, 72, 81, 91, 99, 107, 115, 127, 136, 145, 155, 167, 177, 186, 197, 207, 217, 226, 236
L:	.asciiz
  	" alpha\r\n", " bravo\r\n", " china\r\n", " delta\r\n", " echo\r\n", " foxtrot\r\n", " golf\r\n", " hotel\r\n", " india\r\n", " juliet\r\n", " november\r\n", " oscar\r\n", " paper\r\n", " quebec\r\n", " research\r\n", " sierra\r\n", " tango\r\n", " uniform\r\n", " victor\r\n", " whisky\r\n", " kilo\r\n", " lima\r\n", " mary\r\n", " x-ray\r\n", " yankee\r\n", " zulu\r\n"
L_:	.word
	0, 9, 18, 27, 36, 44, 55, 63, 72, 81, 91, 103, 112, 121, 131, 143, 153, 162, 173, 183, 193, 201, 209, 217, 226, 236
num:	.asciiz
	" zero\r\n"," First\r\n"," Second\r\n"," Third\r\n", " Fourth\r\n", " Fifth\r\n", " Sixth\r\n", " Seventh\r\n", " Eighth\r\n", " Ninth\r\n"
n_:	.word
	0, 8, 17, 27, 36, 46, 55, 64, 75, 85
otherch:	.asciiz
	" *\r\n"
#otherch_:	.word
#	0	
	.text
	.globl main
main:	li $v0, 12
	syscall
	beq $v0, 63, quit 
	
	sub $t0, $v0, 48 
	bltz $t0, other
	sub $t0, $v0, 57
	blez $t0, number
	
	sub $t0, $v0, 65
	bltz $t0, other  
	sub $t0, $v0, 90
	blez $t0, upper
	
	sub $t0, $v0, 97
	bltz $t0, other  
	sub $t0, $v0, 122
	blez $t0, lower
	
	j other

lower:
	sub $t0, $v0, 97
	sll $t0, $t0, 2 
	la $t1, L_
	add $t1, $t1, $t0
	lw $t1, ($t1)#
	la $a0, L
	add $a0, $a0, $t1
	li $v0, 4
	syscall
	j main
			
upper:
	sub $t0, $v0, 65
	sll $t0, $t0, 2 
	la $t1, U_
	add $t1, $t1, $t0
	lw $t1, ($t1)#
	la $a0, U
	add $a0, $a0, $t1
	li $v0, 4
	syscall
	j main	
	
number:
	sub $t0, $v0, 48 # -48
	sll $t0, $t0, 2 # 1 word -> 2 bytes
	la $t1, n_
	add $t1, $t1, $t0
	lw $t1, ($t1)#
	la $a0, num
	add $a0, $a0, $t1
	li $v0, 4
	syscall
	j main	
	
other:
	la $a0, otherch
	li $v0, 4
	syscall
	j main	
quit:
	li $v0, 10 
	syscall


	
#参考资料 https://www.cnblogs.com/thoupin/p/4018455.html
#	http://courses.missouristate.edu/kenvollmar/mars/help/syscallhelp.html
#	http://www.mrc.uidaho.edu/mrc/people/jff/digital/MIPSir.html

