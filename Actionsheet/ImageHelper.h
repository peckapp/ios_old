//
//  ImageHelper.h
//  Wo.iPhone
//
//  Created by pdixit on 19/11/12.
//  Copyright (c) 2012 pdixit. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface ImageHelper : NSObject

+ (UIImage *)scaleAndRotateImage:(UIImage *)image  toResolution: (int) kMaxResolution;
+ (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize : (UIImage*) img;
@end
