#pragma once

#include <sys/time.h>
#include <time.h>

/* Obtain the system 's notion of the current Greenwich time.
 * TODO: manipulate current time zone.
 */
void rv_gettimeofday(struct timeval *tv);

/* Retrieve the value used by a clock which is specified by clock_id. */
void rv_clock_gettime(struct timespec *tp);
