//
//  UIView+YT.h
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YT)

+ (UINib *)yt_defaultNibInMainBoundle;

+ (instancetype)yt_viewWithNibFromMainBoundle;

// 提示框
- (void)showHudWithText:(NSString *)text delayTime:(NSTimeInterval)delayTime;

@end
