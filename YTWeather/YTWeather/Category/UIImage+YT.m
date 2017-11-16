//
//  UIImage+YT.m
//  YTWeather
//
//  Created by admin on 2017/11/15.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "UIImage+YT.h"

@implementation UIImage (YT)

- (UIImage *)imageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//裁剪图片
+ (UIImage *)cutImage:(UIImage *)image size:(CGSize)size
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < (size.width / size.height)) {
        
        newSize.width = image.size.width;
        newSize.height = image.size.width * size.height / size.width;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        
        newSize.height = image.size.height;
        newSize.width = image.size.height * size.width / size.height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    
    return [UIImage imageWithCGImage:imageRef];
}

@end
