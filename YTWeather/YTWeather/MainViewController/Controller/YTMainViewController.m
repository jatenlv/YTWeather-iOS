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
#import "YTLeftSlideView.h"
#define kSlideWidthScale 0.7

@interface YTMainViewController ()
<
YTMainViewDelegate,
UIGestureRecognizerDelegate
>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,strong) YTLeftSlideView *leftSlideView;

@property (nonatomic, assign) BOOL isShowSlide;

@property (nonatomic, strong) NSMutableArray <YTMainView *> *mainViewArray;
//@property (nonatomic, strong) NSMutableArray <YTWeatherModel *> *weatherModelArray;
@property (nonatomic, strong) NSMutableArray *cityNameArray;

@end

@implementation YTMainViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    [self addSlideGesture];
    [self saveCityNameArray:@[@"北京",@"西安",@"五常"]];
    [self readCityNameArray];
    [self loadOldViewAndData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchCityNameDidSelect:) name:YTNotificationSearchCityNameDidSelect object:nil];
}

- (void)loadOldViewAndData
{

    // 设置scrollView
    self.scrollView.size = CGSizeMake(self.cityNameArray.count * ScreenWidth, ScreenHeight);
    self.scrollView.contentSize = CGSizeMake(self.cityNameArray.count * ScreenWidth, 0);
    self.scrollView.pagingEnabled = YES;
    
    CGFloat viewOrginX = 0;
    for (NSString *cityName in self.cityNameArray) {
        // 加载view
        YTMainView *mainView = [[YTMainView alloc] initWithFrame:CGRectMake(viewOrginX, 0, ScreenWidth, ScreenHeight)];
        mainView.cityNameForView = cityName;
        mainView.delegate = self;
        [self.scrollView addSubview:mainView];
        [self.mainViewArray addObject:mainView];
        viewOrginX += ScreenWidth;
        
        // 加载model
        [self loadCacheDataWithCityName:cityName andFinish:^(YTWeatherModel *model, NSError *) {
            if ([mainView.cityNameForView isEqualToString:cityName]) {
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
//    [self.scrollView addGestureRecognizer:pan];
}
- (void)changeFrame:(UIPanGestureRecognizer *)pan
{
    //相对偏移量
    __block  CGFloat  translatePointX = [pan translationInView:self.view].x;
    CGFloat scrollX = CGRectGetMinX(self.view.frame);
    CGFloat scrollMax = CGRectGetMaxX(self.view.frame);
    if(scrollMax + translatePointX < self.view.width)
    {
        return;
    }
    
    if(pan.state == UIGestureRecognizerStateChanged)
    {
        [self slideViewMoveWithDistance:translatePointX];

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
    NSLog(@"123");
    [UIView animateWithDuration:0.35 animations:^{
        self.view.centerX += offset;
    }];
}
#pragma mark - YTMainView Delegate

- (void)loadData:(id)tagerView
{
    YTMainView *mainView = (YTMainView *)tagerView;
    
    [YTMainRequestNetworkTool requestWeatherWithCityName:mainView.cityNameForView andFinish:^(YTWeatherModel *model, NSError *error) {
        [mainView.tableView.mj_header endRefreshing];
        if (!error) {
            mainView.weatherModel = model;
            [mainView.tableView.mj_header endRefreshing];
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
    YTCitySearchViewController *resultVC = [[YTCitySearchViewController alloc] init];
    [self presentViewController:resultVC animated:YES completion:nil];
}

#pragma mark - save

- (void)saveCityNameArray:(NSArray *)cityNameArray
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:cityNameArray forKey:YTCityNameArrayDefaults];
    [defaults synchronize];
}

- (void)readCityNameArray
{
    self.cityNameArray = [NSMutableArray array];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.cityNameArray = [defaults objectForKey:YTCityNameArrayDefaults];
}

- (void)loadCacheDataWithCityName:(NSString *)name andFinish:(void (^)(YTWeatherModel *model, NSError *))finish
{
    [YTMainRequestNetworkTool requestWeatherWithCityName:name andFinish:^(YTWeatherModel *model, NSError *error) {
        if (!error) {
            finish(model, nil);
        }
    }];
}

- (void)searchCityNameDidSelect:(NSNotification *)notify
{
    NSString *str =  notify.object;
    NSLog(@"21441414%@",str);
}
- (YTLeftSlideView *)leftSlideView
{
    if(!_leftSlideView)
    {
        _leftSlideView = [[YTLeftSlideView alloc]initWithFrame:CGRectMake(-kSlideWidthScale * ScreenWidth, 0, kSlideWidthScale * ScreenWidth, ScreenHeight) style:(UITableViewStylePlain)];
    }
    return _leftSlideView;
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
