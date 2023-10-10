### registers

* r - 64 bit
* e - 32 bit
* nothing - 16 bit
* ah:al - 8 bit

* rax
* rbx
* rcx
* rdx
* rsi
* rdi
* rsp
* rbp
* r8-r15 (not available on x32)

### instructions

* mov target (reg), source (reg, imm)
* add target (reg), source (reg, imm)
* sub target (reg), source (reg, imm)
* inc reg
* dec reg
* mul - unsigned multiply
    * only one arg
    * wDX:wAX = wAX*argument
* imul - signed multiply
    * two or three arguments
    * imul target, source - target \*= source
    * imul target, a, b - target = a*b
* div/idiv - multiply
    * single arg
    * wDX:wAX - reminder:quotient
    * in 8 bit mode AH:AL - reminder:quotient
    * result that does not fit into the register causes runtime errors
        * div - zero wAX, wDX (xor rax, rax)
        * idiv - extend sign (cbw/cwd/cdq/cqo)
    * overflow -> floating point exception (despite using integers)

