#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "TRVSEventSource.h"
#import "TRVSEventSourceDelegate.h"
#import "TRVSServerSentEvent.h"

FOUNDATION_EXPORT double TRVSEventSourceVersionNumber;
FOUNDATION_EXPORT const unsigned char TRVSEventSourceVersionString[];

