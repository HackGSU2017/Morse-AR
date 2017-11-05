//
//  OpenCVWrapper.mm
//  Morse AR
//
//  Created by Nate Thompson on 11/4/17.
//  Copyright © 2017 Nate Thompson. All rights reserved.
//

#import "OpenCVWrapper.h"
#import <iostream>
#import <opencv2/imgproc.hpp>
#import <opencv2/core.hpp>

using namespace std;
using namespace cv;

@implementation OpenCVWrapper
- (NSArray*)processImage:(UIImage*)image {
    cv::Mat jpegImage = [self cvMatFromUIImage:image];

    cv::pyrMeanShiftFiltering(jpegImage, jpegImage, 31, 91);
    float thresh = cv::threshold(jpegImage, jpegImage, 127, 255, CV_THRESH_BINARY);
    
    NSMutableArray *contours = [[NSMutableArray alloc] init];
    cv::findContours(jpegImage, jpegImage, CV_RETR_TREE, CV_CHAIN_APPROX_SIMPLE);

    return contours;
}

- (cv::Mat)cvMatFromUIImage:(UIImage*)image{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels (color channels + alpha)
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,     // Pointer to data
                                                    cols,           // Width of bitmap
                                                    rows,           // Height of bitmap
                                                    8,              // Bits per component
                                                    cvMat.step[0],  // Bytes per row
                                                    colorSpace,     // Color space
                                                    kCGImageAlphaNoneSkipLast
                                                    | kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    return cvMat;
}



@end




enum class MorseShape {dot, dash};
