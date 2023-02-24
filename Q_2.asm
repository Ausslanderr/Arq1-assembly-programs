.data
	msg1: .asciiz "Digite o valor de n: "
	msg2: .asciiz "Digite um inteiro: "
	msg3: .asciiz "O resultado é: "
	espaco: .byte ' '
.text
	jal lerN
	move $s0, $a0	# salva o valor de n em $s0
	move $t0, $a0	# $t0 será decrementado até 0
	move $s1, $gp	# servirá para salvar na memória
	jal loopInteiros
	jal insertion
	jal imprimirInteiros
	
	li $v0, 10	# encerra o programa
	syscall
	
lerN:
	li $v0, 4	# comando para imprimir uma string ou char
	la $a0, msg1	# carrega em $a0 a string msg1
	syscall		# impressão
	
	li $v0, 5	# comando para a leitura de um inteiro
	syscall		# leitura
	move $a0, $v0	# move o inteiro digitado para $a0
	jr $ra		# retorna ao chamador
	
loopInteiros:
	sw $ra, 0($sp)	# salva o retono principal na pilha
	
	loop:
		beq $t0, $zero, exitLoop	# se n != 0, continua lendo inteiros
		
		jal lerInteiro
		addi $t0, $t0, -1	# n - 1
		
		sw $a0, 0($s1)		# salva o valor do inteiro digitado
		addi $s1, $s1, 4	# +4 para guardar em outra posição
		
		j loop
	
	exitLoop:
		lw $ra, 0($sp)	# restaura o retorno principal
		jr $ra
	
lerInteiro:
	li $v0, 4	
	la $a0, msg2	# carrega em $a0 a string mg2
	syscall

	li $v0, 5
	syscall
	move $a0, $v0
	jr $ra
	
insertion:
	move $s1, $gp		# restaura o valor de $s1
	addi $s2, $zero, 1	# variável i

	loop1:
		slt $t2, $s2, $s0	# se i é menor que n
		beq $t2, $zero, exit1
		
		sll $t0, $s2, 2		# 4i
		add $t0, $t0, $s1	# endereço de vet[i]
		lw $s4, 0($t0)		# $s4 (pivo) = vet[i]
	
		addi $s3, $s2, -1	# variavel j = i - 1
	
	loop2:
		sll $t1, $s3, 2		# 4j
		add $t1, $t1, $s1	# endereço de vet[j]
	
		slt $t2, $s3, $zero	# se j >= 0, $t2 = 0
		bne $t2, $zero, exit2
		
		lw $t2, 0($t1)		# $t2 = vet[j]
		ble $s4, $t2, exit2	# se pivo > vet[j], continua abaixo
	
		lw $t3, 0($t1)		# $t3 = vet[j]
		sw $t3, 4($t1)		# vet[j + 1] = vet[j]
		addi $s3, $s3, -1	# j--
		
		j loop2
		
	exit2:
		sw $s4, 4($t1)		# vet[j + 1] = pivo
		addi $s2, $s2, 1 	# i++
		j loop1
	
	exit1:
		jr $ra
		
imprimirInteiros:
	li $v0, 4
	la $a0, msg3
	syscall
	
	move $t0, $zero		# $t0 recebe 0, que irá incrementar até n
	
	loopEscrita:
		beq $t0, $s0, saida	# se $t0 == n, sai do programa
		
		li $v0, 1
		sll $t1, $t0, 2		# 4 * $t0
		add $t1, $t1, $gp	# endereço de vet[4 * $t0]
		lw $t2, 0($t1)		# vet[$t0]
		move $a0, $t2		# move o valor atual para ser impresso na tela
		syscall
		
		li $v0, 4
		la $a0, espaco
		syscall
		
		addi $t0, $t0, 1
		j loopEscrita
		
	saida:
		jr $ra
