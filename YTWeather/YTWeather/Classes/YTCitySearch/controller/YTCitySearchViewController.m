//
//  YTCitySearchViewController.m
//  YTWeather
//
//  Created by admin on 2017/10/20.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTCitySearchViewController.h"

@interface YTCitySearchViewController ()<UISearchResultsUpdating>

@property (nonatomic,strong) UISearchController *searchVC;


@end

@implementation YTCitySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];

    [self setupSearchBar];
    
}

#pragma mark 初始化searchBar
- (void)setupSearchBar
{
    UISearchController * searchVC = [[UISearchController alloc]initWithSearchResultsController:nil];
    searchVC.searchBar.placeholder = @"请输入地点或编号";
    searchVC.searchResultsUpdater = self;
    self.searchVC = searchVC;
    self.tableView.tableHeaderView = searchVC.searchBar;
    NSLog(@"%@",searchVC.searchBar);
    self.tableView.sectionHeaderHeight = 64;
    NSLog(@"%@",self.tableView.tableHeaderView);
}



- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString * result = searchController.searchBar.text;
    
    
}



#pragma mark tableView-dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"123";
    return  cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
