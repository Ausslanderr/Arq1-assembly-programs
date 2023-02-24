.data
msg1: .asciiz "Indique um n�mero: "
msg2: .asciiz "Indique sua pot�ncia: "
msg3: .asciiz "O resultado �: "
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
	# Realiza a multiplica��o do primeiro valor de entrada pelo pr�prio, at� atingir o limite estipulado pelo segundo valor de entrada.
	beq $t0, $a1, sair    
        mul $v0,$v0,$a0         
        addi $t0,$t0,1           
        j   loop
        
sair:   
	# Retorna ao �ltimo bloco visitado.
	jr  $ra

InserirDados:
	
	# Imprime a msg de n�mero 1 e recebe o primeiro valor de entrada, sendo armazenado em $t0.
	li $v0,4
	la $a0,msg1
	syscall
	li $v0, 5
   	syscall
   	move $t0, $v0
   	
   	# Imprime a msg de n�mero 2 e recebe o segundo valor de entrada, sendo armazenado em $t1.
   	li $v0,4
	la $a0,msg2
	syscall
   	li $v0, 5
    	syscall
    	move $t1, $v0
    	
    	# Retorna para o main.
	j sair

Resposta:
	
	# Imprime a msg de n�mero 3 e realiza a movimenta��o dos argumentos para iniciar a fun��o.
   	li $v0,4
	la $a0,msg3
	syscall
     	move $a0, $t0
     	move $a1, $t1 
     	
     	# � retornado o resultado da pot�ncia pela fun��o "P". Assim, o programa imprime o resultado e � encerrado.  	
    	jal P   
   	move $a0, $v0     
    	li  $v0, 1              
   	syscall              
	li  $v0, 10     
	syscall
