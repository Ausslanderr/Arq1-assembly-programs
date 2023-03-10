.data
	msg: .asciiz "Digite 3 números naturais (um por enter): "
	msgTrue: .asciiz "É um triângulo retângulo"
	msgFalse: .asciiz "Não é um triângulo retângulo"
.text
	jal imprimirSaudacao
	jal lerNaturais
	jal acharMaior
	beq $v0, $zero, False
	jal ehTrianguloRet
	
	beq $v0, $zero, False
	bne $v0, $zero, True
	
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
	
lerNaturais:
	li $v0, 5		# comando para a leitura de um inteiro
	syscall			# leitura
	move $a0, $v0		# move o inteiro digitado para $a0
	
	li $v0, 5
	syscall	
	move $a1, $v0		# move o inteiro digitado para $a1
	
	li $v0, 5
	syscall	
	move $a2, $v0		# move o inteiro digitado para $a2
	
	jr $ra
	
acharMaior:
	addi $v0, $zero, 1	# suponha que haja um maior

	bgt $a0, $a1, n1
	retorno1:
		bgt $a1, $a0, n2
	retorno2:
		bgt $a2, $a0, n3
	
	move $v0, $zero		# se nenhum dos 3 casos acima foi atendido, não é possivel definir um maior
	jr $ra
	
	n1:			# n1 > n2
		bgt $a0, $a2, n1_maior
		j retorno1
		
	n1_maior:		# n1 > n3, a0 ou o primeiro numero digitado é o maior
		jr $ra
		
	n2:			# n2 > n1
		bgt $a1, $a2, n2_maior
		j retorno2
	
	n2_maior:		# n2 > n3, a1 ou o segundo numero digitado é o maior
		move $t0, $a0	# salva $a0
		move $a0, $a1	# swap
		move $a1, $t0
		jr $ra
	
	n3:			# n3 > n1
		bgt $a2, $a1, n3_maior
		jr $ra
		
	n3_maior:		# n3 > n2, a2 ou o terceiro numero digitado é o maior
		move $t0, $a0
		move $a0, $a2
		move $a2, $t0
		jr $ra
		
ehTrianguloRet:
	multu $a1, $a1		# eleva-se os numeros menores ao quadrado
	mflo $t0		# supondo que a multiplicação resulte em um numero com < 32 bits
	multu $a2, $a2	
	mflo $t1
	add $t0, $t0, $t1
	
	multu $a0, $a0		# eleva-se a hipotenusa ao quadrado
	mflo $t1
	
	beq $t0, $t1, equal	# pitágoras é true?
	move $v0, $zero
	jr $ra
	
	equal:
		addi $v0, $zero, 1
		jr $ra
