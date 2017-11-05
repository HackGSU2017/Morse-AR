//
//  OpenCVWrapper.h
//  Morse AR
//
//  Created by Nate Thompson on 11/4/17.
//  Copyright © 2017 Nate Thompson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface OpenCVWrapper : NSObject
- (NSArray*)processImage:(UIImage*)image;
@end
NS_ASSUME_NONNULL_END

