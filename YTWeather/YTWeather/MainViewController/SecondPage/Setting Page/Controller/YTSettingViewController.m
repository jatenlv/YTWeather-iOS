//
//  YTSettingViewController.m
//  YTWeather
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTSettingViewController.h"

#import "YTSettingNormalTableViewCell.h"

@interface YTSettingViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
YTSettingNormalTableViewCellDelegate
>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewConstraint;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation YTSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.topViewConstraint.constant = Device_Is_iPhoneX ? 64 : 224;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[YTSettingNormalTableViewCell yt_defaultNibInMainBoundle] forCellReuseIdentifier:[YTSettingNormalTableViewCell className]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YTSettingNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[YTSettingNormalTableViewCell className]];
    cell.switchLeftText = @"°C";
    cell.switchLeftText = @"°F";
    cell.delegate = self;
    return cell;
}

- (void)switchTempWithText:(NSString *)text
{
    
}

@end
