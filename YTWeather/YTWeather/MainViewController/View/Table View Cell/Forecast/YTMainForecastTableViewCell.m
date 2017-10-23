//
//  YTMainForecastTableViewCell.m
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainForecastTableViewCell.h"
#import "YTHourWeatherCollectionCell.h"
#import "YTThreeDaysTableViewCell.h"
@interface YTMainForecastTableViewCell()<UITableViewDataSource,UITableViewDelegate, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *scrollViewForNext12Hours;
@property (weak, nonatomic) IBOutlet UITableView *threeDaysForTheWeather;

@end
@implementation YTMainForecastTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupAllViews];
    
    
}
- (void)setupAllViews
{
    
    [self.scrollViewForNext12Hours registerNib:[YTHourWeatherCollectionCell yt_defaultNibInMainBoundle] forCellWithReuseIdentifier:[YTHourWeatherCollectionCell className]];
    [self.threeDaysForTheWeather registerNib:[YTThreeDaysTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTThreeDaysTableViewCell className]];
    self.scrollViewForNext12Hours.dataSource = self;
    self.scrollViewForNext12Hours.delegate = self;
    self.threeDaysForTheWeather.dataSource = self;
    self.threeDaysForTheWeather.delegate = self;

}
#pragma mark -- dataSource && delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YTThreeDaysTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[YTThreeDaysTableViewCell className]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  59;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  12;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YTHourWeatherCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[YTHourWeatherCollectionCell className] forIndexPath:indexPath];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(ScreenWidth/6, 90);
}


@end
