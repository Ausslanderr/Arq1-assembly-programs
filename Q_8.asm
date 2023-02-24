.data
	msg: .asciiz "Digite um inteiro positivo: "
	msgTrue: .asciiz "O numero digitado é triangular"
	msgFalse: .asciiz "O numero digitado não é triangular"
.text
	jal imprimirSaudacao
	jal lerInteiro
	jal triangular
	
	add $t1, $zero, 1	# auxiliar
	
	beq $v0, $zero, False
	beq $v0, $t1, True
	
False:
	li $v0, 4		# comando para imprimir uma string ou char
	la $a0, msgFalse	# carrega em $a0 a string msgFalse
	syscall			# impressão
	
	li $v0, 10		# encerra o programa
	syscall
	
True:
	li $v0, 4
	la $a0, msgTrue		# carrega em $a0 a string msgTrue
	syscall
	
	li $v0, 10
	syscall
	
imprimirSaudacao:
	li $v0, 4
	la $a0, msg		# carrega em $a0 a string msg
	syscall
	jr $ra			# retorna ao chamador
	
lerInteiro:
	li $v0, 5		# comando para a leitura de um inteiro
	syscall			# leitura
	move $a0, $v0		# move o inteiro digitado para $a0
	
triangular:
	add $s0, $zero, $zero	# num1
	addi $s1, $zero, 1	# num2
	addi $s2, $zero, 2	# num3
	
	loop:
		multu $s0, $s1	# num1 * num2
		mflo $t0
		multu $t0, $s2	# (num1 * num2) * num3
		mflo $t0	# supondo que o numero está em 32 bits
		
		bgt $t0, $a0, exit1	# se mult > n, ir para exit1
		
		beq $t0, $a0, exit2	# se mult == n, ir para exit2
		
		addi $s0, $s0, 1	# num1++
		addi $s1, $s1, 1	# num2++
		addi $s2, $s2, 1	# num3++
		
		j loop
		
	exit1:
		add $v0, $zero, $zero
		jr $ra
		
	exit2:
		addi $v0, $zero, 1
		jr $ra
