

#ifndef OpenCVCamDelegate_h
#define OpenCVCamDelegate_h

@protocol OpenCVCamDelegate <NSObject>
- (void) imageProcessed: (UIImage*) image;
@end

#endif /* OpenCVCamDelegate_h */
