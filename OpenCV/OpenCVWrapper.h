

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OpenCVCamDelegate.h"

@interface OpenCVWrapper : NSObject

- (void)setDelegate: (id<OpenCVCamDelegate>) delegate;
- (void)start;
- (void)stop;

@end
