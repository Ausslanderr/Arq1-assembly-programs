.data
msg1: .asciiz "Indique o n�mero que deseja verificar se � perfeito: "
msg2: .asciiz "\n� Perfeito.\n"
msg3: .asciiz "\nN�o � Perfeito.\n"
.text

main:
	
	jal InserirDados # Insere os dados iniciais.
	jal Perfeito # Retorna a soma de todos os inteiros positivos menores do que valor de entrada, dos quais resultam em divis�es inteiras com o valor inserido.
	
	# Compara se o n�mero de entrada � igual ao do retorno da fun��o, se for, ele � perfeito.
	beq $a0, $v0, NumPerfeito
	bne $a0, $v0, NaoPerfeito
	
.end main

InserirDados:
	
	# Imprime a msg de n�mero 1 e realiza a leitura de um inteiro, que por sua vez � movido para $a0.
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
	# Verifica se os registradores s�o iguais para sair do loop. Caso contr�rio, realiza-se a divis�o e guarda o resto.
	beq $t0, $t1, sair 
	div $a0, $t0
	mfhi $t2
	
	# Caso $t2 tenha valor 0 (divis�o inteira), a fun��o "soma" � chamada. Caso contr�rio, � adicionado +1 ao contador $t0 e retorna ao loop.
	beq $t2, $zero, soma                    
        addi $t0,$t0,1       
        j loop

soma:	
	# Adiciona o valor de $t0 no registrador $v0, j� que a divis�o resultou em um inteiro. Por fim, soma-se +1 ao contador $t0 e retorna ao loop.
	add $v0, $v0, $t0
	addi $t0,$t0,1
	j loop         
                        
sair:   
	# Retorna ao �ltimo bloco visitado.
	jr  $ra


NumPerfeito:
	
	# Imprime a msg de n�mero 2 e encerra o programa.
	li $v0,4
	la $a0,msg2
	syscall
	li  $v0, 10     
	syscall
	
NaoPerfeito:
	
	# Imprime a msg de n�mero 3 e encerra o programa.
	li $v0,4
	la $a0,msg3
	syscall	
	li  $v0, 10     
	syscall 
