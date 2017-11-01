//
//  YTMainMaskView.m
//  YTWeather
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainMaskView.h"

@implementation YTMainMaskView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.touchBlock) {
        self.touchBlock();
    }
}

@end
