//
//  YTSearchViewController.m
//  YTWeather
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTSearchViewController.h"

#import "YTCitySearchModel.h"

@interface YTSearchViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UIView *customSearchView;
@property (weak, nonatomic) IBOutlet UITextField *customSearchInputField;
@property (weak, nonatomic) IBOutlet UIButton *customSearchInputFieldClearButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray <YTCitySearchModel *> *resultArray;
@property (nonatomic,strong) NSArray <YTCitySearchModel *> *searchSource;

@end

@implementation YTSearchViewController

- (void)viewDidLoad
{
    [self setupCustomSearch];
    [self cancelKeyboardTapGestureRecognizer];
    // tableView无数据的cell取消分割线
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 1000);
}

- (void)cancelKeyboardTapGestureRecognizer
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tapGestureRecognizer];
}

- (void)keyboardHide:(UITapGestureRecognizer *)tap
{
    [self.customSearchInputField resignFirstResponder];
}

- (void)setupCustomSearch
{
    // backgroundView
    self.customSearchView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.925];
    // field_placeholderLabel
    [self.customSearchInputField setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    // field_clearButton
    [self.customSearchInputFieldClearButton addTarget:self action:@selector(clickClearButton) forControlEvents:UIControlEventTouchUpInside];
    self.customSearchInputFieldClearButton.hidden = YES;
    // field
    self.customSearchInputField.tintColor = [UIColor whiteColor];
    [self.customSearchInputField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.customSearchInputField becomeFirstResponder];
}

- (void)clickClearButton
{
    [self.customSearchInputField becomeFirstResponder];
    self.customSearchInputField.text = nil;
    [self.tableView reloadData];
    self.customSearchInputFieldClearButton.hidden = YES;
}

- (IBAction)clickCancelButton:(UIButton *)sender
{
    [self.customSearchInputField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (![textField.text isEqualToString:@""]) {
        self.customSearchInputFieldClearButton.hidden = NO;
        
        NSPredicate * predict = [NSPredicate predicateWithFormat:@"cityChineseName CONTAINS %@", textField.text];
        self.resultArray = [[self.searchSource filteredArrayUsingPredicate:predict] copy];
        [self.tableView reloadData];
    } else {
        self.customSearchInputFieldClearButton.hidden = YES;
    }
}

#pragma mark tableView-dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor blackColor];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"#090909"];
    }
    
    YTCitySearchModel *dataModel = self.resultArray[indexPath.row];
    cell.textLabel.text = dataModel.cityChineseName ? dataModel.cityChineseName : @"UnknownCity";
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.customSearchInputField resignFirstResponder];
    NSString *selectCityName = self.resultArray[indexPath.row].cityChineseName;
    [[NSNotificationCenter defaultCenter] postNotificationName:YTNotificationSearchCityNameDidSelect
                                                        object:selectCityName];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Lazy Init

- (NSMutableArray<YTCitySearchModel *> *)resultArray
{
    if (!_resultArray) {
        _resultArray = [[NSMutableArray alloc] init];
    }
    return _resultArray;
}

- (NSArray<YTCitySearchModel *> *)searchSource
{
    if (!_searchSource) {
        _searchSource = [NSArray array];
        NSString * path = [[NSBundle mainBundle]pathForResource:@"cityCode" ofType:@"plist"];
        NSArray *data = [NSArray arrayWithContentsOfFile:path];
        _searchSource = [NSArray modelArrayWithClass:[YTCitySearchModel class] json:data];
    }
    return _searchSource;
}

@end
