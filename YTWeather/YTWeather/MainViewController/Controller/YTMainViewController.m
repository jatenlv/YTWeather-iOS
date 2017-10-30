//
//  YTMainViewController.m
//  YTWeather
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainViewController.h"

#import "YTMainView.h"

#import "YTWeatherModel.h"

#import "YTMainRequestNetworkTool.h"

#import "YTCitySearchViewController.h"

#define kSlideWidthScale 0.7

@interface YTMainViewController ()
<
YTMainViewDelegate,
UIGestureRecognizerDelegate
>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *leftSlideView;
@property (nonatomic, assign) BOOL isShowSlide;

@property (nonatomic, strong) NSMutableArray <YTMainView *> *mainViewArray;
@property (nonatomic, strong) NSMutableArray <YTWeatherModel *> *weatherModelArray;
@property (nonatomic, strong) NSMutableArray *cityArray;

@end

@implementation YTMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self addSlideGesture];
    [self readCityArray];
    [self loadOldViewAndData];
}

- (void)loadOldViewAndData
{
    CGFloat viewOrginX = 0;
    for (NSString *city in self.cityArray) {
        YTMainView *mainView = [[YTMainView alloc] initWithFrame:CGRectMake(viewOrginX, 0, ScreenWidth, ScreenHeight)];
        mainView.tagName = city;
        mainView.delegate = self;
        [self.scrollView addSubview:mainView];
        [self.mainViewArray addObject:mainView];
        viewOrginX += ScreenWidth;
        
        [self loadDataWithCityName:city andFinish:^(YTWeatherModel *model, NSError *) {
            if ([mainView.tagName isEqualToString:city]) {
                mainView.weatherModel = model;
                [mainView.tableView reloadData];
            }
        }];
    }
}

#pragma mark 添加左侧侧滑手势

- (void)addSlideGesture
{
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(changeFrame:)];
    pan.delegate = self;
    [self.scrollView addGestureRecognizer:pan];
}

- (void)changeFrame:(UIPanGestureRecognizer *)pan
{
    //相对偏移量
    __block  CGFloat  translatePointX = [pan translationInView:self.scrollView].x;
    CGFloat scrollX = self.scrollView.frame.origin.x;

    // 左滑滑动范围
    if(self.scrollView.frame.origin.x + translatePointX< 0)
    {
        translatePointX = -self.scrollView.frame.origin.x;
        //右滑滑动范围
    }else if(scrollX + translatePointX > kSlideWidthScale * self.scrollView.width) {
        
        translatePointX =  kSlideWidthScale * self.scrollView.width - self.scrollView.frame.origin.x;
    }
    self.scrollView.centerX += translatePointX;
    self.leftSlideView.centerX += translatePointX;
    if(pan.state == UIGestureRecognizerStateChanged)
    {
        NSLog(@"change");
    }else if(pan.state == UIGestureRecognizerStateEnded)
    {
        if(scrollX >= kSlideWidthScale/2 * self.scrollView.width )
        {
            translatePointX = kSlideWidthScale * self.scrollView.width - scrollX;

            [self slideViewMoveWithDistance:translatePointX];
            _isShowSlide = YES;
        }
        else {
            translatePointX = -scrollX;
            [self slideViewMoveWithDistance:translatePointX];
            _isShowSlide = NO;
        }
    }
   
    [pan setTranslation:CGPointZero inView:self.scrollView];
}

- (void)slideViewMoveWithDistance:(CGFloat)offset
{
    [UIView animateWithDuration:0.35 animations:^{
        self.scrollView.centerX += offset;
        self.leftSlideView.centerX += offset;
    }];
}
#pragma mark - YTMainView Delegate

- (void)loadData:(NSString *)tagName{
    for (YTMainView *view in self.mainViewArray) {
        if ([view.tagName isEqualToString: tagName]) {
            
            [YTMainRequestNetworkTool requestWeatherWithCityName:tagName andFinish:^(YTWeatherModel *model, NSError *error) {
                [view.tableView.mj_header endRefreshing];
                if (!error) {
                    view.weatherModel = model;
                    [view.tableView.mj_header endRefreshing];
                }
            }];
        }
    }
}

- (void)loadDataWithCityName:(NSString *)name andFinish:(void (^)(YTWeatherModel *model, NSError *))finish
{
    [YTMainRequestNetworkTool requestWeatherWithCityName:name andFinish:^(YTWeatherModel *model, NSError *error) {
        if (!error) {
            finish(model, nil);
        }
    }];
}

- (void)clickLeftBarButton
{
    CGFloat maxOffset = kSlideWidthScale * self.scrollView.width;
    CGFloat offset = _isShowSlide ? -maxOffset : maxOffset;
    [self slideViewMoveWithDistance:offset];
    _isShowSlide = !_isShowSlide;
}

- (void)clickRightBarButton
{
    YTCitySearchViewController * resultVC = [[YTCitySearchViewController alloc]init];
    [self presentViewController:resultVC   animated:YES completion:nil];
}

#pragma mark - save

- (void)saveCityArray:(NSArray *)cityArray
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:cityArray forKey:@"cityArray"];
    [defaults synchronize];
}

- (void)readCityArray
{
    self.cityArray = [NSMutableArray array];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.cityArray = [defaults objectForKey:@"cityArray"];
}

/*
 * 暂时不用 以后如果需要转换再用 txt -> plist
- (void)test
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"condition-code" ofType:@"txt"];
    NSString *str = [[NSString alloc] initWithContentsOfFile:plistPath encoding:NSUTF8StringEncoding error:nil];
    NSArray  *ary = [str componentsSeparatedByString:@"\n"];
    NSMutableArray *bigAry = [NSMutableArray array];
    for (int i=1; i<ary.count-1; i++) {
        NSArray *smallAry = [ary[i] componentsSeparatedByString:@"    "];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:smallAry[0] forKey:@"cityCode"];
        [dic setObject:smallAry[1] forKey:@"cityEnglishName"];
        [dic setObject:smallAry[2] forKey:@"cityChineseName"];
        [dic setObject:smallAry[3] forKey:@"countryCode"];
        [dic setObject:smallAry[4] forKey:@"countryEnglishName"];
        [dic setObject:smallAry[5] forKey:@"countryChineseName"];
        [dic setObject:smallAry[6] forKey:@"provinceEnglishName"];
        [dic setObject:smallAry[7] forKey:@"provinceChineseName"];
        [dic setObject:smallAry[8] forKey:@"belongToCityEnglishName"];
        [dic setObject:smallAry[9] forKey:@"belongToCityChineseName"];
        [dic setObject:smallAry[10] forKey:@"cityLng"];
        [dic setObject:smallAry[11] forKey:@"cityLat"];
        [bigAry addObject:dic];
    }
    
    NSArray  *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"cityCode.plist"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
        [bigAry writeToFile:fileName atomically:YES];
        NSLog(@"文件写入完成");
    }
}*/

@end
