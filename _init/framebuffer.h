#ifndef FRAMEBUFFER_H_INCLUDED
#define FRAMEBUFFER_H_INCLUDED

extern int * InitialiseFrameBuffer(unsigned int width,unsigned int height,unsigned int bitDepth);
extern int * GetGPU_Pointer(int *framebufferAddress);
#endif
