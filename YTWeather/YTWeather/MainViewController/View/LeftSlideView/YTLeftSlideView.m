//
//  YTLeftSlideView.m
//  YTWeather
//
//  Created by admin on 2017/10/20.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTLeftSlideView.h"

#import "YTLeftSlideTableViewNormalCell.h"
#import "YTLeftSlideTableViewToolCell.h"
#import "YTLeftSlideTableViewNoticeCell.h"

#import "YTMainRequestNetworkTool.h"

@interface YTLeftSlideView()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewConstraint;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation YTLeftSlideView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view =  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        view.frame = self.bounds;
        [self addSubview:view];
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.topViewConstraint.constant = Device_Is_iPhoneX ? 100 : 80;
    
    [self.tableView registerNib:[YTLeftSlideTableViewNormalCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTLeftSlideTableViewNormalCell className]];
    [self.tableView registerNib:[YTLeftSlideTableViewToolCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTLeftSlideTableViewToolCell className]];
    [self.tableView registerNib:[YTLeftSlideTableViewNoticeCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTLeftSlideTableViewNoticeCell className]];
}

#pragma mark dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2 + self.kCityNameArray.count;
    } else if (section == 1) {
        return 4;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat section = indexPath.section;
    CGFloat row = indexPath.row;
    
    YTLeftSlideTableViewNormalCell * cell = [tableView dequeueReusableCellWithIdentifier:[YTLeftSlideTableViewNormalCell className]];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"#202020"];

    if (section == 0) {
        if (row == 0) {
            cell.titleText = @"分享";
            cell.iconImageView.image = [UIImage imageNamed:@"Sidebar-Product-Navigation-Icon-Share"];
        } else if (row == 1) {
            cell.titleText = @"编辑地点";
            cell.iconImageView.image = [UIImage imageNamed:@"Sidebar-Product-Navigation-Icon-Add-New-Location"];
        } else {
            NSString *cityName = [self.kCityNameArray objectAtIndex:row - 2];
            if ([cityName isEqualToString:GetYTCurrentCity]) {
                // 定位城市
                cell.titleText = [NSString stringWithFormat:@"%@（定位）", cityName];
                cell.iconImageView.image = [UIImage imageNamed:@"Sidebar-Tools-Icon-Rate-This-App"];
            } else {
                // 普通城市
                cell.titleText = cityName;
                cell.iconImageView.image = [UIImage imageNamed:@"Sidebar-Product-Navigation-Icon-Other-Location"];
            }
        }
    } else if (section == 1) {
        if (row == 0) {
            YTLeftSlideTableViewToolCell *cell = [tableView dequeueReusableCellWithIdentifier:[YTLeftSlideTableViewToolCell className]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else if (row == 1) {
            cell.titleText = @"设置";
            cell.iconImageView.image = [UIImage imageNamed:@"Dark-Sidebar-Tools-Icon-Settings"];
        } else if (row == 2) {
            cell.titleText = @"意见和建议";
            cell.iconImageView.image = [UIImage imageNamed:@"Dark-Sidebar-Tools-Icon-Send-Feedback"];
        } else {
            cell.titleText = @"给此应用程序打分";
            cell.iconImageView.image = [UIImage imageNamed:@"Dark-Sidebar-Tools-Icon-Rate-This-App"];
        }
    } else {
        YTLeftSlideTableViewNoticeCell * cell = [tableView dequeueReusableCellWithIdentifier:[YTLeftSlideTableViewNoticeCell className]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
        return 45.0f;
    } else if (indexPath.section == 2) {
        return 80.0f;
    }
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0 && indexPath.row == 0) { // 友盟分享
        [self.delegate clickShareButton];
    } else if (indexPath.section == 0 && indexPath.row >= 2) { // 切换城市
        [self.delegate showCityViewWithIndex:indexPath.row - 2];
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        [self.delegate clickSettingButton];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.kCityNameArray removeObjectAtIndex:indexPath.row - 2];
        [self.delegate deleteCityViewWithIndex:indexPath.row - 2];
        [tableView reloadData];
    }
}                       

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"移除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row >= 2) {
        if (self.kCityNameArray.count > 1) {
            return YES;
        }
    }
    return NO;
}

- (void)setKCityNameArray:(NSMutableArray *)kCityNameArray
{
    _kCityNameArray = kCityNameArray;
    [self.tableView reloadData];
}

- (IBAction)clickCloseButton:(UIButton *)sender
{
    [self.delegate clickSlideViewCloseButton];
}

@end

