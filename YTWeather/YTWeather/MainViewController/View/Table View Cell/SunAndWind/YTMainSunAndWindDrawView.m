//
//  YTMainSunAndWindDrawView.m
//  YTWeather
//
//  Created by admin on 2017/10/24.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainSunAndWindDrawView.h"

@interface YTMainSunAndWindDrawView ()

@property (nonatomic, strong) UIBezierPath *path;

@end

@implementation YTMainSunAndWindDrawView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    self.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 40, rect.size.width - 40, self.frame.size.height * 2 - 40)];
    CGFloat dashPattern[] = {3,1}; // 3实线，1空白
    [self.path setLineDash:dashPattern count:1 phase:1];
    [[UIColor lightGrayColor] set];
    [self.path stroke];
}

- (void)setup
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    view.backgroundColor = [UIColor redColor];
    [self addSubview:view];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    // 设置动画的路径为心形路径
    animation.path = self.path.CGPath;
    // 动画时间间隔
    animation.duration = 5.0f;
    // 重复次数为最大值
    animation.repeatCount = 0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    // 将动画添加到动画视图上
    [view.layer addAnimation:animation forKey:nil];
    
}

@end
