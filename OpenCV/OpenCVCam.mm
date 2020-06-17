

#import "OpenCVCam.h"
#import "UIImage+OpenCV.h"

using namespace cv;

@implementation OpenCVCam

+ (id)sharedInstance {
    static OpenCVCam *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance initCam];
    });
    return instance;
}

- (id) init
{
    return self;
}

- (void) start
{
    [self.cam start];
}

- (void) stop
{
    [self.cam stop];
}

- (void) initCam
{
    self.cam = [[CvVideoCamera alloc] init];
    
    self.cam.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    self.cam.defaultAVCaptureSessionPreset = AVCaptureSessionPreset1280x720;
    self.cam.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.cam.defaultFPS = 30;
    self.cam.grayscaleMode = NO;
    self.cam.delegate = self;
}

- (void)processImage:(cv::Mat &)image
{
   
    // Do some OpenCV stuff with the image
//    Mat image_copy;
//    cvtColor(image, image_copy, COLOR_BGR2GRAY);
//    // invert image
//    bitwise_not(image_copy, image_copy);
//    //Convert BGR to BGRA (three channel to four channel)
//    Mat bgr;
//    cvtColor(image_copy, bgr, COLOR_GRAY2BGR);
//    cvtColor(bgr, image, COLOR_BGR2BGRA);

// Do some OpenCV stuff with the image
    Mat image_copy;

    // Convert to gray scale
    cvtColor(image, image_copy, COLOR_BGR2GRAY);
    // invert image
    bitwise_not(image_copy, image_copy);

    // Lets blur to eliminate noise; feel free to tune the filter size below
    GaussianBlur(image_copy, image_copy, cv::Size(15, 15), 0);

    // Do a canny. Max threshold value below eliminates most noisy edges and detects the quarter for me; more tuning might be needed
    Canny(image_copy, image_copy, 100, 150);

    // Now identify the circles; It works best if I have the quarter with just the floor
    // as the background without my feet.
    // Like Sae has been advocating, we can achieve this by identifying a box and asking
    // customers to place the quarter there and not have their feet overlap in that area.
    // These parameters need further tuning.
    std::vector<cv::Vec3f> circles;
    HoughCircles(image_copy, circles, HOUGH_GRADIENT, 1.5, 20, 50, 35, 25, 60);

    cvtColor(image_copy, image_copy, COLOR_GRAY2RGB);

    // I am displaying all the circles found in the code below. But we can do the following
    // in the actual app:
    //   1. We can repeat this function until we find exactly one circle
    //   2. If no circle is found or if we find multiple circles, after a few attempts,
    // we can ask the user to doublecheck and start again.
    for( size_t i = 0; i < circles.size(); i++ )
    {
        printf("Found %lu circles", circles.size());
        Vec3i c = circles[i];
        circle( image_copy, cv::Point(c[0], c[1]), c[2], Scalar(255,0,0), 3, CV_AA);
        circle( image_copy, cv::Point(c[0], c[1]), 2, Scalar(255,0,0), 3, CV_AA);
    }

    
    if (self.delegate != nil) {
        [self.delegate imageProcessed:[UIImage imageWithCVMat: image_copy]];
    }
}

@end
