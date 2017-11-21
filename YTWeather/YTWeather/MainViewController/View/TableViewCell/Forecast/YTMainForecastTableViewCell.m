//
//  YTMainForecastTableViewCell.m
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainForecastTableViewCell.h"

#import "YTHourlyForecastCollectionViewCell.h"
#import "YTDailyForecastTableViewCell.h"

#define kTableViewCellHeight 45
#define kCollectionViewCellSize CGSizeMake(collectionView.width / 8, 90)

@interface YTMainForecastTableViewCell()
<
UITableViewDataSource,
UITableViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>

@property (weak, nonatomic) IBOutlet UIView *backgroundContentView;
@property (weak, nonatomic) IBOutlet UICollectionView *hourlyForecastCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *dailyForecastTableView;

@end

@implementation YTMainForecastTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundContentView.backgroundColor = MainTableViewCellColor;
    self.backgroundContentView.layer.cornerRadius = MainTableViewCellRadius;

    [self setupCollectionAndTable];
}

- (void)setupCollectionAndTable
{
    self.hourlyForecastCollectionView.dataSource = self;
    self.hourlyForecastCollectionView.delegate = self;
    [self.hourlyForecastCollectionView registerNib:[YTHourlyForecastCollectionViewCell yt_defaultNibInMainBoundle] forCellWithReuseIdentifier:[YTHourlyForecastCollectionViewCell className]];
    
    self.dailyForecastTableView.delegate = self;
    self.dailyForecastTableView.dataSource = self;
    [self.dailyForecastTableView registerNib:[YTDailyForecastTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTDailyForecastTableViewCell className]];
}

#pragma mark -- TableView

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YTDailyForecastTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[YTDailyForecastTableViewCell className]];
    cell.forecastModel = self.dailyForecastModelList[indexPath.row + 1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kTableViewCellHeight;
}

#pragma mark -- CollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YTHourlyForecastCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[YTHourlyForecastCollectionViewCell className] forIndexPath:indexPath];
    cell.hourlyForecastModel = self.hourlyForecastModelList[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return kCollectionViewCellSize;
}

#pragma mark - Model

- (void)setHourlyForecastModelList:(NSArray<YTWeatherHourlyForecastModel *> *)hourlyForecastModelList
{
    _hourlyForecastModelList = hourlyForecastModelList;
    [self.hourlyForecastCollectionView reloadData];
}

- (void)setDailyForecastModelList:(NSArray<YTWeatherDailyForecastModel *> *)dailyForecastModelList
{
    _dailyForecastModelList = dailyForecastModelList;
    [self.dailyForecastTableView reloadData];
}

@end
