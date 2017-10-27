//
//  YTNewFeatureViewController.m
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTNewFeatureViewController.h"
#import "YTMainViewController.h"
#import "YTCustomNavViewController.h"
static NSString *featureViewCellID = @"featureViewCellID";

@interface YTNewFeatureViewController ()

@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation YTNewFeatureViewController

- (instancetype)init {
    UICollectionViewFlowLayout  * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout = flowLayout;
    return  [super initWithCollectionViewLayout:flowLayout];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"这是新特性" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(forward2Main) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    btn.center = self.view.center;
    [self.view addSubview:btn];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:featureViewCellID];
    self.collectionView.pagingEnabled= YES;
    self.collectionView.bounces = NO;
    // Do any additional setup after loading the view from its nib.
}

#pragma mark 跳到主页VC 
- (void)forward2Main
{
    YTMainViewController * mainVC = [[YTMainViewController alloc]init];
    YTCustomNavViewController * navVc = [[YTCustomNavViewController alloc]initWithRootViewController:mainVC];
    [self.navigationController pushViewController:navVc animated:NO];
    [UIApplication sharedApplication].keyWindow.rootViewController = navVc;
}
#pragma mark dateSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:featureViewCellID forIndexPath:indexPath];
    if(cell == nil) {
        cell = [[UICollectionViewCell alloc]init];
    }
    cell.backgroundColor = [self randomColor];
    return cell;
}
- (UIColor *)randomColor
{
    NSUInteger r = arc4random_uniform(255) + 1;
    NSUInteger g = arc4random_uniform(255) + 1;
    NSUInteger b = arc4random_uniform(255) + 1;
    NSUInteger a = arc4random_uniform(255) + 1;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0];
    
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
