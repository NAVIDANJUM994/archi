.data
    array:.space 32    
    msg:.asciiz "Enter any 8 Elements of your array"
	space: .asciiz"\n"
	msg2: .asciiz "Your array before sorting"
	msg3: .asciiz "Your array After sorting"

.text
.globl main 
main:    
    li $v0,4
           la $a0,msg    # print message to get input from user
           syscall
	
	li $v0,4
           la $a0,space # print space
           syscall
	
	
	li $t0,0            #$t0=i=0 as counter variable
	  
    jal fun             # function coll
	
    li $v0,10           # exit cod
          syscall

fun:                    # this function will get input and store in myarray    
    
    beq $t0,32,PrintMyArray
	
	li $v0,5       
         syscall
	sw $v0,array($t0)   #i use ($t0) for both as counter and array index
    add $t0,$t0,4
    b fun
######################### PRINT ARRAY BEFORE SORTING #######################################
PrintMyArray:

     la $t0,array       #load adderes of arr
 
 li $v0,4
 la $a0,msg2            # print message as "Your array before sorting"
 syscall
 
 li $v0,4
    la $a0,space        # print space
    syscall

li $t1,0                # i=0
for:
   bge $t1,8 SHELLSORT
   
   lw $t2,($t0)
   
   li $v0,1
   move $a0,$t2
   syscall
   
   li $v0,4
           la $a0,space # print space
           syscall
   
   add $t0,$t0,4        #address=address+4
   add $t1,$t1,1        #i++
   
   
   b for

#################################### SORTING ALGORITHM STARTS FROM HERE #######################
SHELLSORT:

li $t3, 0 #t3=i
li $t4, 0 #$t4=j
li $t5, 0 #$t5=k
li $t6, 0 #$t6=temp
li $t7, 8 #num

div $t3,$t7,2                  # i = num / 2;

FOR1:                          # for (i = num / 2; i > 0; i = i / 2)
    beq $t3,0 PRINTMYARRAY 
	
	move $t4,$t3               #j = i;
	
	FOR12:                     #for (j = i; j < num; j++)
	     bgt $t4,$t7 jumptoloop1
		 
		 sub $t5,$t4,$t3
		 FOR123:               #for(k = j - i; k >= 0; k = k - i)
		      bge $t5,0 jumpto
			  add $t4,$t4,1    #j++)
		      b FOR12
		 jumpto:
		       # IF CONDITION STARTS
			                   #if (arr[k+i] >= arr[k])
			  la $t0, array    # load initial address of array in t0
			  
		
              move $a1,$t0     # save initial address in a1
			  
			
			  mul $a2,$t5,4    # k mul by 4 to get k(th) element
			  add $t0,$t0,$a2  # k+first address of array
			  lw,$t1,($t0)     # load first word of array in t0 = arr[k]
			  add $t2,$t5, $t3 
			  mul $t2,$t2,4
			  add $a1,$a1,$t2  # k+i
			  lw  $a0, ($a1)   # element at arr[k+i]
			  
			  bge $a0,$t1 jumtoloop123  #if (arr[k+i] >= arr[k])
			  move $t6,$t1     #tmp = arr[k];
			  sw $a0,($t0)     #arr[k] = arr[k+i];
              sw $t6,($a1)     #arr[k+i] = tmp;
			  
			  
			  jumtoloop123:
			  sub  $t5,$t5,$t3 #k = k - i)
			  b FOR123
			  
			  jumptoloop1:
			   
			  div $t3,$t3,2    # i = i / 2
			  b FOR1
			  
			  
####################################### SORTING ENDS ##########################################		  
################################### print sorted array #########################################			
PRINTMYARRAY:
la $t0,array                   #load adderes of arr
 
li $v0,4
    la $a0,msg3                # print message 
    syscall

li $v0,4
     la $a0,space              # print space
     syscall

li $t1,0     # i=0
for5:
   bge $t1,8 Exit22
   
   lw $t2,($t0)
   
   li $v0,1
   move $a0,$t2
   syscall
   
   li $v0,4
           la $a0,space    # print space
           syscall
   
   li $v0,4
           
   
   add $t0,$t0,4           #address=address+4
   add $t1,$t1,1           #i++
   
   
   b for5



Exit22:
li $v0,10
syscall	 
		 
		 
#################################### END ################################################################	
	
	