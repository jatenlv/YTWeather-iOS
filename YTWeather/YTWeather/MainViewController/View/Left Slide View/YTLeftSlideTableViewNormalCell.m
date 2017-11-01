
//
//  YTLeftSlideTableViewNormalCell.m
//  YTWeather
//
//  Created by admin on 2017/11/1.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTLeftSlideTableViewNormalCell.h"

@interface YTLeftSlideTableViewNormalCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation YTLeftSlideTableViewNormalCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.iconImageView.backgroundColor = [UIColor redColor];
}

- (void)setTitleText:(NSString *)titleText
{
    self.titleLabel.text = titleText;
}

@end
