//
//  YTMainForecastTableViewCell.m
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainForecastTableViewCell.h"

#import "YTHourWeatherCollectionCell.h"
#import "YTDailyForecastTableViewCell.h"

#define kTableViewCellHeight 45

@interface YTMainForecastTableViewCell()
<
UITableViewDataSource,
UITableViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>

@property (weak, nonatomic) IBOutlet UIView *backgroundContentView;
@property (weak, nonatomic) IBOutlet UICollectionView *scrollViewForNext12Hours;
@property (weak, nonatomic) IBOutlet UITableView *threeDaysForTheWeather;

@end

@implementation YTMainForecastTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundContentView.backgroundColor = MainTableViewCellColor;
    self.backgroundContentView.layer.cornerRadius = MainTableViewCellRadius;

    [self setupAllViews];
}

- (void)setupAllViews
{
    [self.scrollViewForNext12Hours registerNib:[YTHourWeatherCollectionCell yt_defaultNibInMainBoundle] forCellWithReuseIdentifier:[YTHourWeatherCollectionCell className]];
    [self.threeDaysForTheWeather registerNib:[YTDailyForecastTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTDailyForecastTableViewCell className]];
    self.scrollViewForNext12Hours.dataSource = self;
    self.scrollViewForNext12Hours.delegate = self;
    self.threeDaysForTheWeather.dataSource = self;
    self.threeDaysForTheWeather.delegate = self;
}

#pragma mark -- TableView

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YTDailyForecastTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[YTDailyForecastTableViewCell className]];
    cell.forecastModel = self.forecastModelList[indexPath.row + 1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kTableViewCellHeight;
}

#pragma mark -- CollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
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

- (void)setForecastModelList:(NSArray<YTWeatherDailyForecastModel *> *)forecastModelList
{
    _forecastModelList = forecastModelList;
    [self.threeDaysForTheWeather reloadData];
}

@end
