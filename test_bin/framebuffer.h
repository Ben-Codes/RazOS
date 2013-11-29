#ifndef FRAMEBUFFER_H_INCLUDED
#define FRAMEBUFFER_H_INCLUDED

extern unsigned int InitialiseFrameBuffer(unsigned int width,unsigned int height,unsigned int bitDepth);
extern void WritePixel(unsigned int x, unsigned int y, unsigned short value);


#endif
