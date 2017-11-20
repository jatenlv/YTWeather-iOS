//
//  YTMainCustomNavigationBar.m
//  YTWeather
//
//  Created by admin on 2017/10/20.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainCustomNavigationBar.h"

@interface YTMainCustomNavigationBar ()

@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, strong) dispatch_source_t timer;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *darkVisualEffectView;

@end

@implementation YTMainCustomNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view =  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        view.frame = self.bounds;
        view.width = ScreenWidth;
        [self addSubview:view];
        
        self.cityNameLabel.text = @"";
        self.timeLabel.text = @"";
        
        self.darkVisualEffectViewAlpha = 0;
//        self.darkVisualEffectView.backgroundColor = [UIColor blackColor];
        [self setupUpdateTimer];
    }
    return self;
}

- (void)setupUpdateTimer
{
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateCurrentTime];
        });
    });
    dispatch_resume(self.timer);
}

- (void)updateCurrentTime
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    
    NSInteger hour = [components hour];
    NSInteger min = [components minute];
    NSInteger sec = [components second];
    
    NSString *hourString;
    if (hour < 10) {
        hourString = [NSString stringWithFormat:@"0%ld",(long)hour];
    } else {
        hourString = [NSString stringWithFormat:@"%ld",(long)hour];
    }
    NSString *minString;
    if (min < 10) {
        minString = [NSString stringWithFormat:@"0%ld",(long)min];
    } else {
        minString = [NSString stringWithFormat:@"%ld",(long)min];
    }
    NSString *secString;
    if (sec < 10) {
        secString = [NSString stringWithFormat:@"0%ld",(long)sec];
    } else {
        secString = [NSString stringWithFormat:@"%ld",(long)sec];
    }
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@:%@:%@ CCT", hourString, minString, secString];
}

#pragma mark - Set Model

- (void)setCityNameText:(NSString *)cityNameText
{
    if (cityNameText.length) {
        self.cityNameLabel.text = [NSString stringWithFormat:@"%@", cityNameText];
    }
}

- (void)setDarkVisualEffectViewAlpha:(CGFloat)darkVisualEffectViewAlpha
{
    self.darkVisualEffectView.alpha = darkVisualEffectViewAlpha;
}

#pragma mark - Click Button

- (IBAction)clickLeftButton:(UIButton *)sender
{
    if (self.clickLeftBarButton) {
        self.clickLeftBarButton();
    }
}

- (IBAction)clickRightButton:(UIButton *)sender
{
    if (self.clickRightBarButton) {
        self.clickRightBarButton();
    }
}

@end
