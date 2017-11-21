//
//  YTMainEmptyTableViewCell.m
//  YTWeather
//
//  Created by admin on 2017/10/24.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainEmptyTableViewCell.h"

@implementation YTMainEmptyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
