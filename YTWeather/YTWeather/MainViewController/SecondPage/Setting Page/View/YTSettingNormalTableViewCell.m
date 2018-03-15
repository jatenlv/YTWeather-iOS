//
//  YTSettingNormalTableViewCell.m
//  YTWeather
//
//  Created by admin on 2018/3/13.
//  Copyright © 2018年 Jaten. All rights reserved.
//

#import "YTSettingNormalTableViewCell.h"

#import "YTSwitchView.h"

@interface YTSettingNormalTableViewCell ()
<
YTSwitchViewDelegate
>

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet YTSwitchView *switchView;

@end

@implementation YTSettingNormalTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupCustomSwitchControl];
}

- (void)setupCustomSwitchControl
{
    self.switchView.leftText = self.switchLeftText;
    self.switchView.rightText = self.switchRightText;
    self.switchView.delegate = self;
}

- (void)chooseSwitchWithText:(NSString *)text
{
    [self.delegate switchTempWithText:text];
}

@end
