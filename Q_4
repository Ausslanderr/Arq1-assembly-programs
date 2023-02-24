.data

	pedido: .asciiz "Digite um número: "
	resultado: .asciiz "Resultado do produto dos números pares: "
	
.text
	
	jal LerInteiro
	move $s0, $v0	#move o valor fornecido para registrador s0
	li $s2,1	#acumulador do produto
	li $s3,2 
	jal loop
	
	li $v0, 10	# encerra o programa
	syscall

	LerInteiro:
	
		li $v0,4	#imprime string
		la $a0, pedido
		syscall
	
		li $v0,5	#le inteiro
		syscall
	
		jr $ra
		
	loop:
		bgt $s3,$s0,imprime	#testa se a soma já passou do número fornecido
		
		mul $s2,$s3,$s2	#faz o produto dos numeros pares e salva
		addi $s3,$s3,2	#soma + 2 para continuar a multiplicaçao
		
		j loop
		
	imprime:
		
		li $v0,4	#imprime string
		la $a0,resultado
		syscall
		
		li $v0,1	#imprime o resultado
		move $a0,$s2	
		syscall
		
		jr $ra
		
	
	
