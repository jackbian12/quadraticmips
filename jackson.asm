.data
beginning:  .asciiz "You are about to solve for quadratic equation "
firstInput: .asciiz "\nEnter value for a = "
secondInput: .asciiz "\nEnter value for b = "
thirdInput:  .asciiz "Enter value for c = "
complexroot: .asciiz "The equation you gave has a complex root. Please try again"
result:      .asciiz "The values for x = "
andd:        .asciiz " & "
two: .float 2.0
four: .float 4.0
zero: .float 0.0

.text
lwc1 $f10,zero
lwc1 $f2,two
lwc1 $f4,four

li $v0,4
la $a0,beginning
syscall

main:    # the main label

li $v0,4 # string to request first input
la $a0,firstInput
syscall

li $v0,6#to receive first input
syscall
mov.s $f6,$f0 

li $v0,4   #string to request second input from user
la $a0,secondInput
syscall

li $v0,6 #for user to input value
syscall
mov.s $f8,$f0


li $v0,4    #string to request third input from user 
la $a0,thirdInput
syscall

li $v0,6  #for user to input value
syscall
mov.s $f12,$f0


neg.s $f8,$f8 # negative of b (-b)
mul.s $f14,$f8,$f8 # power of b (b^2)
mul.s $f12,$f12,$f6 # ac
mul.s $f4,$f4,$f12 #4ac
mul.s $f2,$f2,$f6 #2a
sub.s $f14,$f14,$f4 # b2-4ac
mfc1 $t1,$f14 
bltz $t1,complexRoot
sqrt.s $f14,$f14 # sqrt of b2- 4ac
sub.s $f4,$f8,$f14 #-b - sqrt(b2-4ac)
add.s $f6,$f8,$f14 #-b + sqrt(b2-4ac)
div.s $f4,$f4,$f2
div.s $f6,$f6,$f2


li $v0,4
la $a0,result
syscall

li $v0,2
add.s $f12,$f10,$f6
syscall

li $v0,4
la $a0,andd
syscall

li $v0,2
add.s $f12,$f10,$f4
syscall

li $v0,10
syscall
complexRoot:
li $v0,4
la $a0,complexroot
syscall

j main