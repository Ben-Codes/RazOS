#ifndef MAILBOX_H_INCLUDED
#define MAILBOX_H_INCLUDED

//Address bottom for bits must be 0
//ID cannot be bigger than 15
extern unsigned int MailboxWrite(unsigned int address,unsigned int mailBoxID);
extern unsigned int MailboxRead(unsigned int mailBoxID);

#endif
