//
//  YTCitySearchViewController.m
//  YTWeather
//
//  Created by admin on 2017/10/20.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTCitySearchViewController.h"
#import "YTCitySearchModel.h"

@interface YTCitySearchViewController ()<UISearchResultsUpdating,UISearchBarDelegate,UISearchControllerDelegate>

@property (nonatomic,strong) UISearchController *searchVC;

@property (nonatomic,strong) NSMutableArray *resultArray;

@property (nonatomic,strong) NSMutableArray *searchSource;
@property (nonatomic,strong) UITextField *tf;

@end

@implementation YTCitySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _resultArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTabview];
    [self setupSearchBar];
    
}

- (void)setupTabview
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
#pragma mark 初始化searchBar
- (void)setupSearchBar
{
    UISearchController * searchVC = [[UISearchController alloc]initWithSearchResultsController:nil];
    searchVC.searchBar.placeholder = @"请输入地点或编号";
    searchVC.searchResultsUpdater = self;
    searchVC.delegate = self;
    searchVC.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    //搜索结果不变灰
    searchVC.dimsBackgroundDuringPresentation = NO;
    //显示取消按钮
    searchVC.searchBar.showsCancelButton = YES;
    //设置取消文字
    for (id obj in [searchVC.searchBar subviews]) {
        if ([obj isKindOfClass:[UIView class]]) {
            for (id obj2 in [obj subviews]) {
                if ([obj2 isKindOfClass:[UIButton class]]) {
                    UIButton *btn = (UIButton *)obj2;
                    [btn setTitle:@"取消" forState:UIControlStateNormal];
                }
            }
        }
    }
    //设置searchBar代理,来接收取消按钮点击事件
    searchVC.searchBar.delegate = self;
    self.searchVC = searchVC;
    self.tableView.tableHeaderView = searchVC.searchBar;
    self.tableView.sectionHeaderHeight = 64;

}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString * result = searchController.searchBar.text;
    NSPredicate * predict = [NSPredicate predicateWithFormat:@"cityChineseName CONTAINS %@",result];
    
    self.resultArray = [[self.searchSource filteredArrayUsingPredicate:predict] copy];
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark tableView-dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    YTCitySearchModel * dataModel = self.resultArray[indexPath.row];
    cell.textLabel.text = dataModel.cityChineseName ? dataModel.cityChineseName:@"sb";
    return  cell;
}
#pragma mark lazy
- (NSMutableArray *)searchSource
{
    if(!_searchSource) {
        _searchSource = [NSMutableArray array];
        NSString * path = [[NSBundle mainBundle]pathForResource:@"cityCode" ofType:@"plist"];
        NSArray *data = [NSArray arrayWithContentsOfFile:path];
        _searchSource = [NSArray modelArrayWithClass:[YTCitySearchModel class] json:data ];
        
    }
    return _searchSource;
}
- (void)didPresentSearchController:(UISearchController *)searchController {
    
    
    
    
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
