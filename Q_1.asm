.data
	frase: .asciiz "Digite um número inteiro positivo: "
	resultado: .asciiz "O somatório é: "
.text
	jal imprimirFrase
	jal lerInteiro
	jal somatorio
	jal imprimirInteiro
	
	li $v0, 10	# encerra o programa
	syscall
	
	imprimirFrase:
		li $v0, 4	# comando para imprimir uma string ou char
		la $a0, frase	# carrega em $a0 a string frase
		syscall		# impressão
		jr $ra		# retorna ao chamador
		
	lerInteiro:
		li $v0, 5	# comando para a leitura de um inteiro
		syscall		# leitura
		move $a0, $v0	# move o inteiro digitado para $a0
		jr $ra		# retorna ao chamador
		
	somatorio:
		move $a1, $zero	# contador até chegar em n
		move $v1, $zero # somatório
		loop:
			beq $a1, $a0, exit	# se $a1 = $a0, o somatório foi realizado, sai-se do loop
			
			addi $a1, $a1, 1	# incremento do contador
			add $v1, $v1, $a1	# $v1 (somatório) recebe ele + valor atual de $a1
			j loop	# retorno ao loop
	
		exit:
			jr $ra	# retorna ao chamador
		
	imprimirInteiro:
		li $v0, 4	# comando para imprimir uma string ou char
		la $a0, resultado	# carrega em $a0 a string frase
		syscall		# impressão
			
		li $v0, 1	# imprime um inteiro
		move $a0, $v1	# $a0 recebe o valor do somatório ($v1)
		syscall		# impressão
		jr $ra
