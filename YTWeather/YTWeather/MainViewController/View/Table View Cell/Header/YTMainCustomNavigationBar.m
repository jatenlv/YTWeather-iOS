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

@end

@implementation YTMainCustomNavigationBar

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        UIView *view =  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        view.frame = self.bounds;
        view.width = ScreenWidth;
        [self addSubview:view];
        
        [self setTimeText:@""];
    }
    return self;
}

 - (void)setCityNameText:(NSString *)cityNameText
{
    self.cityNameLabel.text = cityNameText;
}

- (void)setTimeText:(NSString *)timeText
{
    NSDateComponents *dd = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
    self.timeLabel.text = [NSString stringWithFormat:@"%ld:%ld CCT", (long)[dd hour], (long)[dd minute]];
}

- (IBAction)clickLeftButton:(UIButton *)sender
{
    if(self.clickLeftBarButton)
    {
        self.clickLeftBarButton();
    }
}

- (IBAction)clickRightButton:(UIButton *)sender
{
    if(self.clickRightBarButton)
    {
        self.clickRightBarButton();
    }
}
@end
