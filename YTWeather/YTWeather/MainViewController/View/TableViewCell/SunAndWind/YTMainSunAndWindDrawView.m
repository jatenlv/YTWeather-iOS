//
//  YTMainSunAndWindDrawView.m
//  YTWeather
//
//  Created by admin on 2017/10/24.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainSunAndWindDrawView.h"

@interface YTMainSunAndWindDrawView ()
<
CAAnimationDelegate
>

@property (nonatomic, strong) UIView *view;

@property (nonatomic, assign) CGFloat angle;
@property (weak, nonatomic) IBOutlet UIImageView *leftWindMillImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightWindMillImageView;

@property (weak, nonatomic) IBOutlet UILabel *sunRiseTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunSetTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDirection;

@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;

@property (weak, nonatomic) IBOutlet UILabel *airStatusLabel;

@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) UIBezierPath *yellowPath;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (weak, nonatomic) IBOutlet UIImageView *sunImageView;

@property (nonatomic, assign) BOOL hadFinishedAnimation;
@property (nonatomic, assign) CGPoint endSunPoint;

@end

@implementation YTMainSunAndWindDrawView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.view =  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        self.view.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.view];
        
        self.angle = 0;
        [self startWindMillAnimation];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.view.frame = self.bounds;
    if (!self.hadFinishedAnimation) {
        [self setupTime];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height - 30) radius:self.width / 2 - 36 startAngle:M_PI endAngle:0 clockwise:YES];
    CGFloat dashPattern[] = {3, 1}; // 3实线，1空白
    [self.path setLineDash:dashPattern count:1 phase:1];
    [self.path setLineWidth:2.0f];
    [[UIColor lightGrayColor] set];
    [self.path stroke];
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

- (void)setupTime
{
    self.sunRiseTimeLabel.text = self.dailyModel.sr;
    self.sunSetTimeLabel.text  = self.dailyModel.ss;
    
    // 当前时间
    NSInteger hour = [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:[NSDate date]] hour];
    NSInteger min = [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:[NSDate date]] minute];

    // 日出日落时间
    NSInteger sunRiseHour = [[self.dailyModel.sr substringToIndex:2] integerValue];
    NSInteger sunRiseMin = [[self.dailyModel.sr substringWithRange:NSMakeRange(3, 2)] integerValue];
    NSInteger sunSetHour = [[self.dailyModel.ss substringToIndex:2] integerValue];
    NSInteger sunSetMin = [[self.dailyModel.ss substringWithRange:NSMakeRange(3, 2)] integerValue];
    
    if ((hour > sunRiseHour && min > sunRiseMin) && (hour < sunSetHour && min < sunSetMin)) {
        
        self.yellowPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height - 30) radius:self.width / 2 - 36 startAngle:M_PI endAngle:((hour - 6.0) / (sunSetHour - sunRiseHour) + 1) * M_PI clockwise:YES];
        
        self.sunImageView.center = self.sunRiseTimeLabel.center;
        CAKeyframeAnimation *sunAnimation = [CAKeyframeAnimation animation];
        sunAnimation.path = self.yellowPath.CGPath;
        sunAnimation.keyPath = @"position";
        sunAnimation.duration = 2.0f;
        sunAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        sunAnimation.removedOnCompletion = NO;
        sunAnimation.fillMode = kCAFillModeForwards;
        sunAnimation.delegate = self;
        [self.sunImageView.layer addAnimation:sunAnimation forKey:nil];

        self.shapeLayer = [CAShapeLayer layer];
        [self.shapeLayer setLineDashPattern:@[@1, @5]];
        self.shapeLayer.path = self.yellowPath.CGPath;
        self.shapeLayer.lineWidth = 3.f;
        self.shapeLayer.strokeColor = [UIColor yellowColor].CGColor;
        self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:self.shapeLayer];

        CABasicAnimation *lineAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        lineAnimation.duration = 2.0f;
        lineAnimation.fromValue = @(0);
        lineAnimation.toValue = @(1);
        lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        lineAnimation.removedOnCompletion = NO;
        lineAnimation.fillMode = kCAFillModeForwards;
        [self.shapeLayer addAnimation:lineAnimation forKey:nil];
        
        self.hadFinishedAnimation = YES;
    } else {
        self.sunImageView.hidden = YES;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        self.sunImageView.hidden = YES;
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
