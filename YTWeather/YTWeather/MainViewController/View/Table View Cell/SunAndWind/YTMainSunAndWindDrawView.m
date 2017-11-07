//
//  YTMainSunAndWindDrawView.m
//  YTWeather
//
//  Created by admin on 2017/10/24.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainSunAndWindDrawView.h"

#define kLineColor [UIColor colorWithRed:252.f/255.f green:205.f/255.f blue:60.f/255.f alpha:1]

@interface YTMainSunAndWindDrawView ()

@property (nonatomic, strong) UIBezierPath *path;

@property (nonatomic, assign) CGFloat angle;
@property (weak, nonatomic) IBOutlet UIImageView *leftWindMillImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightWindMillImageView;

@property (weak, nonatomic) IBOutlet UILabel *sunRiseTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunSetTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDirection;

@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;

@property (weak, nonatomic) IBOutlet UILabel *airStatusLabel;

@property (weak, nonatomic) IBOutlet UIImageView *sunImageView;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@end

@implementation YTMainSunAndWindDrawView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        UIView *view =  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        view.frame = self.bounds;
        view.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:view];
        
        self.angle = 0;
        [self startWindMillAnimation];
    }
    return self;
}

- (void)startWindMillAnimation
{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(self.angle * (M_PI /180.0f));
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.leftWindMillImageView.transform = endAngle;
        self.rightWindMillImageView.transform = endAngle;
    } completion:^(BOOL finished) {
        self.angle += 1;
        [self startWindMillAnimation];
    }];
}

- (void)drawRect:(CGRect)rect
{
    self.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height - 30) radius:self.width / 2 - 36 startAngle:M_PI endAngle:0 clockwise:YES];
    CGFloat dashPattern[] = {3, 1}; // 3实线，1空白
    [self.path setLineDash:dashPattern count:1 phase:1];
    [[UIColor lightGrayColor] set];
    [self.path stroke];
    
    [self setupTime];
}

- (void)setupTime
{
    [self setNeedsDisplay];
    
    self.sunRiseTimeLabel.text = @"06:00";
    self.sunSetTimeLabel.text  = @"18:00";
    
    NSInteger hour = [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:[NSDate date]] hour];
    
    if (hour > 6 && hour < 18) {
        
        UIBezierPath *newPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height - 30) radius:self.width / 2 - 36 startAngle:M_PI endAngle:1.8 * M_PI clockwise:YES];
        
        CAKeyframeAnimation *sunAnimation = [CAKeyframeAnimation animation];
        sunAnimation.path = newPath.CGPath;
        sunAnimation.keyPath = @"position";
        sunAnimation.duration = 5.0f;
        sunAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        sunAnimation.removedOnCompletion = NO;
        sunAnimation.fillMode = kCAFillModeForwards;
        [self.sunImageView.layer addAnimation:sunAnimation forKey:nil];
        
        
        self.shapeLayer = [CAShapeLayer layer];
        self.shapeLayer.path = newPath.CGPath;
        self.shapeLayer.lineWidth = 1.f;
        self.shapeLayer.strokeColor = kLineColor.CGColor;
        self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:self.shapeLayer];

        CABasicAnimation *lineAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        lineAnimation.duration = 5.f;
        lineAnimation.fromValue = @(0);
        lineAnimation.toValue = @(1);
        lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        lineAnimation.removedOnCompletion = NO;
        lineAnimation.fillMode = kCAFillModeForwards;
        [self.shapeLayer addAnimation:lineAnimation forKey:nil];
    }
}

- (void)setNowModel:(YTWeatherNowModel *)nowModel
{
    _nowModel = nowModel;
    self.windSpeedLabel.text = nowModel.wind_spd;
    self.windDirection.text  = nowModel.wind_dir;
    self.pressureLabel.text  = nowModel.pres;
}

- (void)setAirModel:(YTWeatherAirModel *)airModel
{
    _airModel = airModel;
    self.airStatusLabel.text = airModel.air_now_city.qlty;
}

@end
