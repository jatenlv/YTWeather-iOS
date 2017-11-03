//
//  YTHourWeatherScrollView.m
//  YTWeather
//
//  Created by admin on 2017/10/24.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTHourWeatherScrollView.h"

#define maxTmp  18
#define minTmp  1
#define perTmpDistance 1.5

@interface YTHourWeatherScrollView () <CAAnimationDelegate>

@property (nonatomic,strong) NSMutableArray *tmpArr;
@property (nonatomic,strong) NSMutableArray *labelArr;

@end

@implementation YTHourWeatherScrollView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}
#pragma mark -- setup
- (void)setup
{
    //坐标
    [self drawCoordinate];
    [self drawLine];
    [self addLabel];
    self.contentSize = CGSizeMake(20 + self.tmpArr.count * 50, 0);
}
- (void)drawRect:(CGRect)rect
{
   
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(20,70)];
//    [path addLineToPoint:CGPointMake(20, 0)];
//    [path moveToPoint:CGPointMake(20, 70)];
//    [path addLineToPoint:CGPointMake(self.tmpArr.count*30 + 20, 70)];
//
//    [[UIColor redColor] setStroke];
//    [path stroke];

}
- (void)drawCoordinate
{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(20,0)];
    [path addLineToPoint:CGPointMake(20, 70)];
    [path addLineToPoint:CGPointMake(self.tmpArr.count*50 + 20, 70)];
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:layer];
    
}
- (void)drawLine
{
    CGFloat midTmp = maxTmp - minTmp;
    _labelArr = [NSMutableArray array];
    CAShapeLayer * csl = [CAShapeLayer layer];
    csl.strokeColor = [UIColor redColor].CGColor;
    csl.lineCap = @"round";
    csl.lineJoin = @"round";
    csl.lineWidth = 1;
    UIBezierPath * path = [UIBezierPath bezierPath];

    path.lineWidth = 5;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    for(int i = 0;i < self.tmpArr.count;i++ )
    {
        CGPoint drawPpint = CGPointMake(i*50 + 20, 70 - perTmpDistance*(midTmp+ [self.tmpArr[i] floatValue]));
        if(i == 0)
        {
            [path moveToPoint:drawPpint];
        }else{
            
            [path addLineToPoint:drawPpint];
        }
    }
    csl.path = path.CGPath;
    [self.layer addSublayer:csl];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 3;
    pathAnimation.repeatCount = 1;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    // 设置动画代理，动画结束时添加一个标签，显示折线终点的信息
    pathAnimation.delegate = self;
    [csl addAnimation:pathAnimation forKey:@"strokeEnd"];
    
}
- (void)addLabel
{
    CGFloat midTmp = maxTmp - minTmp;
    for(int i = 0;i < self.tmpArr.count;i++ )
    {
        CGPoint drawPpint = CGPointMake(i*50 + 20, 70 - perTmpDistance*(midTmp+ [self.tmpArr[i] floatValue]));
        UILabel * label = [[UILabel alloc]init];
        label.center = CGPointMake(drawPpint.x, drawPpint.y-10);
        label.text = [self.tmpArr[i] stringValue];
        label.textColor = [UIColor greenColor];
        label.font = [UIFont systemFontOfSize:10];
        [label sizeToFit];
        [self addSubview:label];
    }
}
- (NSMutableArray *)tmpArr
{
    if(!_tmpArr){
        _tmpArr = [NSMutableArray array];
        [_tmpArr addObjectsFromArray:@[@18,@14,@13,@12,@14,@17,@1,@9,@8]];

    }
    return _tmpArr;
}
- (NSValue *)valueMakeFrom:(CGFloat)x y:(CGFloat)y
{
    return [NSValue valueWithCGPoint:CGPointMake(x, y)];
}
- (CGPoint)CGPointFromValue:(NSValue *)value
{
    return  [value CGPointValue];
}


@end
