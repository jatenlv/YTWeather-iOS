//
//  UIView+YT.m
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "UIView+YT.h"

@implementation UIView (YT)

+ (UINib *)yt_defaultNibInMainBoundle{
    
    UINib *nib = nil;
    @try {
        nib = [UINib nibWithNibName:NSStringFromClass(self) bundle:nil];
    } @catch (NSException *exception) {
        NSLog(@"do not find the nib file in main boundle with the expected file name:%@",[self className]);
        
    } @finally {
        return nib;
    }
}

+ (instancetype)yt_viewWithNibFromMainBoundle{
    UIView *view;
    @try {
        view = [[[NSBundle mainBundle] loadNibNamed:[self className] owner:nil options:nil] firstObject];
    } @catch (NSException *exception) {
        NSLog(@"do not find the nib file in main boundle with the expected file name:%@",[self className]);
    } @finally {
        return view;
    }
}

@end
