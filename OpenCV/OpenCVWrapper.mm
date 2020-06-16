

#import "OpenCVWrapper.h"
#import "UIImage+OpenCV.h"
#import "OpenCVCam.h"

@implementation OpenCVWrapper

- (void)setDelegate: (id<OpenCVCamDelegate>) delegate
{
    OpenCVCam* cvCam = [OpenCVCam sharedInstance];
    cvCam.delegate = delegate;
}

- (void) start
{
    OpenCVCam* cvCam = [OpenCVCam sharedInstance];
    [cvCam start];
}

- (void) stop
{
    OpenCVCam* cvCam = [OpenCVCam sharedInstance];
    [cvCam stop];
}

@end

