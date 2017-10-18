//
//  UIView+YT.h
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YT)

/**
 * get the UINib instance use this class name as the nib file name.
 *
 *  @return
 */
+ (UINib *) yt_defaultNibInMainBoundle;

/**
 *  get this View instance with use this class name as the nib file name.
 *
 *  @return
 */
+ (instancetype) yt_viewWithNibFromMainBoundle;

@end
