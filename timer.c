#include "timer.h"

//FSM Time Management functions
void timespec_sub (struct timespec *res, struct timespec *a, struct timespec *b)
{
	res->tv_sec = a->tv_sec - b->tv_sec;
	res->tv_nsec = a->tv_nsec - b->tv_nsec;
	if (res->tv_nsec < 0) {
		--res->tv_sec;
		res->tv_nsec += 1000000000;
	}
}

/* res = a + b */
void timespec_add (struct timespec *res, struct timespec *a, struct timespec *b)
{
	res->tv_sec = a->tv_sec + b->tv_sec;
	res->tv_nsec = a->tv_nsec + b->tv_nsec;
	if (res->tv_nsec > 1000000000) {
		++res->tv_sec;
		res->tv_nsec -= 1000000000;
	}
}

/* a < b */
int timespec_less (struct timespec *a, struct timespec *b)
{
  return (a->tv_sec < b->tv_sec) ||
    ((a->tv_sec == b->tv_sec) && (a->tv_nsec < b->tv_nsec));
}

/* wait until next_activation (absolute time) */
void delay_until (struct timespec* next_activation)
{
	struct timespec resto, now;
	clock_gettime(CLOCK_REALTIME, &now);
	timespec_sub(&resto, next_activation, &now);
	while (nanosleep(&resto,&resto)>0);
}


/*
static void timer_isr (union sigval arg) 
{ 
	timer = 1; 
}*/

void timer_start (int s) 
{ 
	struct timespec inc = { s, 0};
	clock_gettime(CLOCK_REALTIME, &timer_endtime);
	timespec_add (&timer_endtime, &timer_endtime, &inc);
}

int timer_finished (void) 
{
	struct timespec now;
	clock_gettime(CLOCK_REALTIME, &now);
	return timespec_less (&timer_endtime, &now); 
}