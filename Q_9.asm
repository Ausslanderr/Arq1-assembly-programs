.data

	pedido: .asciiz "Digite um número natural: "
	resultado: .asciiz "Resultado da conversão para binário: "

.text
	jal lerInteiro
	move $t0,$v0 	#t0 recebe o valor digitado pelo usuario 
	addi $s2,$s2,1	#faz parte do condicional para saber se o valor de t0 é menor que 1
	addi $s3,$s3,2	#faz parte da divisao t0/2 para descobrir o resto da divisao
	addi $s4,$s4,0	#contador
	jal loopMem
	
	li $v0,4	#imprime string
	la $a0,resultado
	syscall
	
	jal imprime
	
	li $v0, 10	# encerra o programa
	syscall
	
	lerInteiro:
	
		li $v0,4	
		la $a0,pedido	#imprime o pedido ao usuario
		syscall
	
		li $v0,5	#recebe o valor digitado pelo usuario
		syscall
		
		jr $ra		# retorna ao chamador
	
	loopMem:
	
		blt $t0,$s2,voltaMain #verifica se o valor de t0 é menor que 1
		
		div $t0,$s3	#divide o valor do usuario por 2 para descobrir o resto
		mfhi $t1	#traz da memória o valor do resto para salvar em t1
		
		sll $t2,$s4,2	#4*contador
		add $t2,$t2,$gp	#t2 tem o endereço de gp*s4
		
		sw $t1, 0($t2)	#armazena o valor do resto 
		
		addi $s4,$s4,1	#incrementa o contador(tamanho)
		
		mflo $t3	#traz da memória o valor inteiro da divisão antes feita 
		move $t0,$t3	#move o valor inteiro para o registrador t0
		
		j loopMem
		
	voltaMain:
		
		jr $ra
		
	imprime:
		
		blt $s4,0,saida	#verifica se s4 é menor que 0
		
		sll $t2,$s4,2	#4*contador
		add $t2,$t2,$gp	#t2 tem o endereço de gp*s4
		
		lw $t4, 0($t2)	#carrega o valor do resto armazenado
		
		subi $s4,$s4,1	#decrementa o contador(tamanho)
		
		move $a0,$t4	#move o valor do resto para a0
		
		li $v0,1
		syscall
		
		j imprime
			
	saida:
	
		jr $ra
