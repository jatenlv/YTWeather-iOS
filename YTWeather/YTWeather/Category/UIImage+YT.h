//
//  UIImage+YT.h
//  YTWeather
//
//  Created by admin on 2017/11/15.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YT)

// 将图片转换为指定色调
- (UIImage *)imageWithColor:(UIColor *)color;

// 裁剪
+ (UIImage *)cutImage:(UIImage *)image size:(CGSize)size;

@end
