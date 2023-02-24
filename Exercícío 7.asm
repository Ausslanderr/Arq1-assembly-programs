.data
msg1: .asciiz "Indique um número: "
msg2: .asciiz "Indique sua potência: "
msg3: .asciiz "O resultado é: "
.text

main:
    	
    	jal InserirDados # Insere os dados iniciais.
    	jal Resposta # Entrega a resposta do problema.
    	
	        
.end main

P:  	
	# Atribui valores iniciais para os registradores.
        add  $t0,$zero,$zero   
        addi $v0,$zero,1          
        
loop:   
	# Realiza a multiplicação do primeiro valor de entrada pelo próprio, até atingir o limite estipulado pelo segundo valor de entrada.
	beq $t0, $a1, sair    
        mul $v0,$v0,$a0         
        addi $t0,$t0,1           
        j   loop
        
sair:   
	# Retorna ao último bloco visitado.
	jr  $ra

InserirDados:
	
	# Imprime a msg de número 1 e recebe o primeiro valor de entrada, sendo armazenado em $t0.
	li $v0,4
	la $a0,msg1
	syscall
	li $v0, 5
   	syscall
   	move $t0, $v0
   	
   	# Imprime a msg de número 2 e recebe o segundo valor de entrada, sendo armazenado em $t1.
   	li $v0,4
	la $a0,msg2
	syscall
   	li $v0, 5
    	syscall
    	move $t1, $v0
    	
    	# Retorna para o main.
	j sair

Resposta:
	
	# Imprime a msg de número 3 e realiza a movimentação dos argumentos para iniciar a função.
   	li $v0,4
	la $a0,msg3
	syscall
     	move $a0, $t0
     	move $a1, $t1 
     	
     	# É retornado o resultado da potência pela função "P". Assim, o programa imprime o resultado e é encerrado.  	
    	jal P   
   	move $a0, $v0     
    	li  $v0, 1              
   	syscall              
	li  $v0, 10     
	syscall
