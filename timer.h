#ifndef TIMER_H
#define TIMER_H
#endif

#include <time.h>

static struct timespec timer_endtime;

//FSM Time Management functions
void timespec_sub (struct timespec *res, struct timespec *a, struct timespec *b);
void timespec_add (struct timespec *res, struct timespec *a, struct timespec *b);
int timespec_less (struct timespec *a, struct timespec *b);
void delay_until (struct timespec* next_activation);

//Timer Functions
void timer_start (int s);
int timer_finished (void);
