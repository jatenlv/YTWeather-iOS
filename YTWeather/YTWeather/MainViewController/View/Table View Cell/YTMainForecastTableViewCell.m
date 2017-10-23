//
//  YTMainForecastTableViewCell.m
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainForecastTableViewCell.h"

@interface YTMainForecastTableViewCell()
@property (weak, nonatomic) IBOutlet UICollectionView *scrollViewForNext12Hours;
@property (weak, nonatomic) IBOutlet UITableView *threeDaysForTheWeather;

@end
@implementation YTMainForecastTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    
}
- (void)setupAllViews
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
