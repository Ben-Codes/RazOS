#ifndef FRAMEBUFFER_H_INCLUDED
#define FRAMEBUFFER_H_INCLUDED

extern unsigned int InitialiseFrameBuffer(unsigned int width,unsigned int height,unsigned int bitDepth);
extern unsigned short * GetGPU_Pointer(unsigned int framebufferAddress);
//This just adds a flag of 0x40000000 to address which the gpu is looking for
extern unsigned int FlagAddress(unsigned int framebufferAddress);
#endif
