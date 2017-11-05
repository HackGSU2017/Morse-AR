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
    
    cv::GaussianBlur(jpegImage, jpegImage, cv::Size(5, 5), 5);
    double thresh = cv::threshold(jpegImage, jpegImage, 200, 250, CV_THRESH_BINARY);
    UIImage *uiimage = [self UIImageFromCVMat:jpegImage];

    cv::Mat cannyOutput;
    std::vector<std::vector<cv::Point> > contours;
    std::vector<Vec4i> hierarchy;
    
    cv::Canny(jpegImage, cannyOutput, thresh, thresh * 2);
    //NSMutableArray *threshArray = [[NSMutableArray alloc] init];
    cv::findContours(cannyOutput, contours, hierarchy, CV_RETR_TREE, CV_CHAIN_APPROX_NONE);
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    return array;
}

- (string)detect:(std::vector<cv::Point>)c {
    double peri = cv::arcLength(c, true);
    array<std::vector<cv::Point>, sizeof(c)> approxCurve;
    double epsilon = 0.04 * peri;
    //cv::approxPolyDP(c, approxCurve, epsilon, true);
    //cv::cornerHarris(c, approxCurve, int blockSize, int ksize, double k)
    
    if (sizeof(approxCurve) == 4) {
        return "dash";
    } else if (sizeof(approxCurve) > 15) {
        return "dot";
    }
    return "unidentified";
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

-(UIImage *)UIImageFromCVMat:(cv::Mat)cvMat
{
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize()*cvMat.total()];
    CGColorSpaceRef colorSpace;
    
    if (cvMat.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                 //width
                                        cvMat.rows,                                 //height
                                        8,                                          //bits per component
                                        8 * cvMat.elemSize(),                       //bits per pixel
                                        cvMat.step[0],                            //bytesPerRow
                                        colorSpace,                                 //colorspace
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,// bitmap info
                                        provider,                                   //CGDataProviderRef
                                        NULL,                                       //decode
                                        false,                                      //should interpolate
                                        kCGRenderingIntentDefault                   //intent
                                        );
    
    
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return finalImage;
}



@end


