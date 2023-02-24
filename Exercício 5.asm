.data
msg1: .asciiz "Indique o número que deseja verificar se é perfeito: "
msg2: .asciiz "\nÉ Perfeito.\n"
msg3: .asciiz "\nNão é Perfeito.\n"
.text

main:
	
	jal InserirDados # Insere os dados iniciais.
	jal Perfeito # Retorna a soma de todos os inteiros positivos menores do que valor de entrada, dos quais resultam em divisões inteiras com o valor inserido.
	
	# Compara se o número de entrada é igual ao do retorno da função, se for, ele é perfeito.
	beq $a0, $v0, NumPerfeito
	bne $a0, $v0, NaoPerfeito
	
.end main

InserirDados:
	
	# Imprime a msg de número 1 e realiza a leitura de um inteiro, que por sua vez é movido para $a0.
	li $v0,4 
	la $a0,msg1
	syscall
	li $v0, 5 
	syscall
	move $a0, $v0
    	
    	# Retorna ao main.
	j sair


Perfeito:

	# Atribui valores iniciais para os registradores.
	add  $v0, $zero, $zero
	add  $t0, $zero, 1
	sub  $t1, $a0, 1

loop:   
	# Verifica se os registradores são iguais para sair do loop. Caso contrário, realiza-se a divisão e guarda o resto.
	beq $t0, $t1, sair 
	div $a0, $t0
	mfhi $t2
	
	# Caso $t2 tenha valor 0 (divisão inteira), a função "soma" é chamada. Caso contrário, é adicionado +1 ao contador $t0 e retorna ao loop.
	beq $t2, $zero, soma                    
        addi $t0,$t0,1       
        j loop

soma:	
	# Adiciona o valor de $t0 no registrador $v0, já que a divisão resultou em um inteiro. Por fim, soma-se +1 ao contador $t0 e retorna ao loop.
	add $v0, $v0, $t0
	addi $t0,$t0,1
	j loop         
                        
sair:   
	# Retorna ao último bloco visitado.
	jr  $ra


NumPerfeito:
	
	# Imprime a msg de número 2 e encerra o programa.
	li $v0,4
	la $a0,msg2
	syscall
	li  $v0, 10     
	syscall
	
NaoPerfeito:
	
	# Imprime a msg de número 3 e encerra o programa.
	li $v0,4
	la $a0,msg3
	syscall	
	li  $v0, 10     
	syscall 
