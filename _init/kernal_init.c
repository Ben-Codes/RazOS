
#define ARMBASE 0x8000
#define CS      0x20003000
#define CLO     0x20003004
#define C0      0x2000300C
#define C1      0x20003010
#define C2      0x20003014
#define C3      0x20003018

#define GPFSEL1 0x20200004
#define GPSET0  0x2020001C
#define GPCLR0	0x20200028

extern void PUT32 ( unsigned int, unsigned int );
extern unsigned int GET32 ( unsigned int );

//-------------------------------------------------------------
volatile unsigned int irq_counter;
//-------------------------------------------------------------

int kernal_init(void)
{
	unsigned int ra;
	unsigned int rb;

	
	ra=GET32(GPFSEL1);
	ra &=~ (7<<18);
	ra |= 1<<18;
	
	PUT32(GPFSEL1, ra);
	PUT32(GPSET0, ra);
	
	rb = 0;
	while(1){
		rb++;
	}
}

//////
//Called via vector table on hardware
//interupt
void irq_event_handler ( void )
{
	irq_counter++;
}
