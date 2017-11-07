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

@property (nonatomic, assign) CGFloat angle;
@property (weak, nonatomic) IBOutlet UIImageView *leftWindMillImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightWindMillImageView;

@property (weak, nonatomic) IBOutlet UILabel *sunRiseTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunSetTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDirection;

@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;

@property (weak, nonatomic) IBOutlet UILabel *airStatusLabel;

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
        [self startAnimation];
        [self setupTime];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    self.path = [[UIBezierPath alloc] init];
    [self.path addArcWithCenter:CGPointMake(self.width / 2, self.height - 30)
                    radius:self.width / 2 - 35
                startAngle:M_PI
                  endAngle:0
                 clockwise:YES];
    CGFloat dashPattern[] = {3, 1}; // 3实线，1空白
    [self.path setLineDash:dashPattern count:1 phase:1];
    [[UIColor lightGrayColor] set];
    [self.path stroke];
}


- (void)startAnimation
{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(self.angle * (M_PI /180.0f));
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.leftWindMillImageView.transform = endAngle;
        self.rightWindMillImageView.transform = endAngle;
    } completion:^(BOOL finished) {
        self.angle += 1;
        [self startAnimation];
    }];
}

- (void)setupTime
{
    self.sunRiseTimeLabel.text = @"06:14";
    self.sunSetTimeLabel.text  = @"17:01";
}

- (void)setTodayModel:(YTWeatherDailyForecastModel *)todayModel
{
    _todayModel = todayModel;
//    self.sunRiseTimeLabel.text = todayModel.sr;
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
