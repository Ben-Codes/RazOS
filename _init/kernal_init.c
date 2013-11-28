#include "framebuffer.h"
#include "mailbox.h"

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
//address,value
extern void PUT32 ( unsigned int, unsigned int );
extern void PUT16 ( unsigned int, unsigned short );
extern unsigned int GET32 ( unsigned int );


extern void TurnOnLight(void);
void setup_framebuffer(void);
//-------------------------------------------------------------
volatile unsigned int irq_counter;
//-------------------------------------------------------------

////////////////////////////////////////////
//This is where we setup our first proccess
int kernal_init(void)
{

	setup_framebuffer();
	

	while(1){
		
	}
	
	return 0;
}

void setup_framebuffer(void)
{
	InitialiseFrameBuffer(1024,768,16);
	
	unsigned int y = 0;
	unsigned int x = 0;
	
	while(y <= 768)
	{
		
		while(x <= 1024)
		{
			WritePixel(x,y,0x0000);
			x++;
		}

		y++;
		x = 0;
	}
	
	TurnOnLight();
	
};

//////
//Called via vector table on hardware
//interupt
void irq_event_handler ( void )
{
	irq_counter++;
}
