    .data
prompt1: .asciiz "Insira o valor de N: "
prompt2: .asciiz "Insira o valor de i: "
prompt3: .asciiz "Insira o valor de j: "
espaco: .asciiz " "
    .text
    jal leitura
    jal loop_func
    #print_func esta sendo chamada dentro de loop_func
    # que por sua vez chama print_func qnd necessário. Loop_func chama 'fim', termina o programa.
    leitura:
   		 li $v0, 4  # comando pra imprimir uma string ou char
   		 la $a0, prompt1 #printando o prompt
   		 syscall
    
   		 li $v0, 5  # comando pra ler um inteiro
    		 syscall
    		 move $s1, $v0 # move o valor de n pro registrador $s1
    
    		 li $v0, 4  # comando pra imprimir uma string ou char
    		 la $a0, prompt2
    		 syscall
    
   		 li $v0, 5  # comando pra ler um inteiro
    		 syscall
    		 move $s2, $v0 # move o valor de i pro registrador $s2
    
   		 li $v0, 4  # comando pra imprimir uma string ou char
    		 la $a0, prompt3
    		 syscall
    
   		 li $v0, 5  # comando pra ler um inteiro
   		 syscall
   		 move $s3, $v0 # move o valor de j pro registrador $s3
    
   		 li $t0, 0    # Inicializa o contador
   		 li $s0, 0    # initializa o numero atual (numero que � dividido por i ou j 
		 # e verificado se � ou n�o um divisor).
    		 
    loop_func:
   		 beq $t0, $s1, fim  # se o contador igual a n, sai do loop
    
   		 # verificar se o numero atual � multiplo de i ou j
   		 div $s0, $s2 # divide s0 por s2 e guarda o resto no registrador $hi
  		 mfhi $t1 # move de hi pra t1
  		 beq $t1, 0, print_func # se o resto for zero, se t1==0, pula pra print.
    
   		 # repete o msm processo, mas agora com j ao inv�s de i.
   		 div $s0, $s3
   		 mfhi $t1
   		 beq $t1, 0,  print_func
   		 addi $s0, $s0, 1 # incrementa o numero atual
    		 j loop_func #volta pro loop

    print_func:
 		 li $v0, 4 #espaço entre os caracteres
   		 la $a0, espaco
  		 syscall
   		 move $a0, $s0    #  move o numero atual pra $a0
   		 li $v0, 1        # system call pra printar inteiros
    		 syscall	     # printa o $a0
    
    		 addi $s0, $s0, 1 # incrementa o numero atual
   		 addi $t0, $t0, 1 # incrementa o contador
  		 j loop_func
  		
    fim:
  		 li $v0, 10
  		 syscall