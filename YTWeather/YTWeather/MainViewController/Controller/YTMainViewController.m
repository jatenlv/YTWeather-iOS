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

#import "YTLeftSlideView.h"
#import "YTMainMaskView.h"

#import "YTSearchViewController.h"

#define kSlideWidthScale 0.7

@interface YTMainViewController ()
<
YTMainViewDelegate,
UIGestureRecognizerDelegate
>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,strong) YTLeftSlideView *leftSlideView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewLeading;

@property (nonatomic, assign) BOOL isShowSlide;
@property (nonatomic, assign) BOOL isMaskViewMove;

@property (nonatomic, strong) NSMutableArray <YTMainView *> *mainViewArray;
@property (nonatomic, strong) NSMutableArray *cityNameArray;
@property (nonatomic, assign) CGFloat viewOrginX;

@property (nonatomic,strong) YTMainMaskView *maskView;

@end

@implementation YTMainViewController

#pragma mark - Lift Cycle

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 添加滑动弹出设置页面手势
    [self addSlideGesture];
    // 取出城市缓存
    [self readCityNameArray];
    // 加载缓存中的城市页面和数据
    [self loadOldViewAndData];
    
    // 加载左侧滑动视图及遮罩视图
    [self setupLeftSlideView];
    [self setupMaskView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchCityNameDidSelect:) name:YTNotificationSearchCityNameDidSelect object:nil];
}

#pragma mark - Private Method

- (void)loadOldViewAndData
{
    // 调整scrollView大小
    [self reloadScrollViewSize];
    
    self.viewOrginX = 0;
    for (NSString *cityName in self.cityNameArray) {
        [self createMainViewWithCityName:cityName newView:NO];
    }
    self.leftSlideView.cityNameArray = self.cityNameArray;
}

- (void)reloadScrollViewSize
{
    self.scrollView.pagingEnabled = YES;
    self.scrollView.size = CGSizeMake(self.cityNameArray.count * ScreenWidth, ScreenHeight);
    self.scrollView.contentSize = CGSizeMake(self.cityNameArray.count * ScreenWidth, 0);
}

// 创建新页面及数据
- (void)createMainViewWithCityName:(NSString *)cityName newView:(BOOL)newView
{
    // 加载view
    YTMainView *mainView = [[YTMainView alloc] initWithFrame:CGRectMake(self.viewOrginX, 0, ScreenWidth, ScreenHeight)];
    mainView.cityNameForView = cityName;
    mainView.delegate = self;
    [self.scrollView addSubview:mainView];
    [self.mainViewArray addObject:mainView];
    self.viewOrginX += ScreenWidth;
    // 加载model
    [YTMainRequestNetworkTool requestWeatherWithCityName:cityName andFinish:^(YTWeatherModel *model, NSError *error) {
        if (!error) {
            if ([mainView.cityNameForView isEqualToString:cityName]) {
                mainView.weatherModel = model;
            }
        }
    }];
    
    if (newView) {
        [self.scrollView setContentOffset:mainView.frame.origin animated:NO];
    }
}

- (void)setupLeftSlideView
{
    self.leftSlideView = [[YTLeftSlideView alloc]initWithFrame:CGRectMake(0, 0, kSlideWidthScale * ScreenWidth, ScreenHeight)];
    [self.view addSubview:self.leftSlideView];
    [self.view sendSubviewToBack:self.leftSlideView];

}

- (void)setupMaskView
{
    CGFloat x = kSlideWidthScale * ScreenWidth;
    self.maskView = [[YTMainMaskView alloc]initWithFrame:CGRectMake(x, 0, ScreenWidth - x, ScreenHeight)];
    @weakify(self);
    self.maskView.touchBlock = ^{
        @strongify(self);
        [self clickLeftBarButton];
    };
    [self.view addSubview:self.maskView];
    self.maskView.hidden = !_isShowSlide;
}

#pragma mark - Notification

- (void)searchCityNameDidSelect:(NSNotification *)notify
{
    NSString *newCityName = notify.object;
    [self.cityNameArray addObject:newCityName];
    // 存入城市缓存
    [self saveCityNameArray:[self.cityNameArray copy]];
    
    [self reloadScrollViewSize];
    [self createMainViewWithCityName:newCityName newView:YES];
}

#pragma mark 添加左侧侧滑手势

- (void)addSlideGesture
{
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(changeFrame:)];
    pan.delegate = self;
    //[self.maskView addGestureRecognizer:pan];
}

- (void)changeFrame:(UIPanGestureRecognizer *)pan
{
    //相对偏移量
    CGFloat  translatePointX = [pan translationInView:self.scrollView].x;
    
    if(pan.state == UIGestureRecognizerStateChanged)
    {
        [self slideViewMoveWithDistance:translatePointX];

    }else if(pan.state == UIGestureRecognizerStateEnded)
    {
//        if(scrollX >= kSlideWidthScale/2 * self.scrollView.width )
//        {
//            translatePointX = kSlideWidthScale * self.scrollView.width - scrollX;
//
//            [self slideViewMoveWithDistance:translatePointX];
//            _isShowSlide = YES;
//        }
//        else {
//            translatePointX = -scrollX;
//            [self slideViewMoveWithDistance:translatePointX];
//            _isShowSlide = NO;
//        }
    }
    [pan setTranslation:CGPointZero inView:self.scrollView];
}

- (void)slideViewMoveWithDistance:(CGFloat)offset
{
    CGAffineTransform transform;
    transform = _isShowSlide ? CGAffineTransformIdentity : CGAffineTransformMakeTranslation(offset, 0);
    [UIView animateWithDuration:0.35 animations:^{
        self.scrollView.transform = transform;
    }];
    self.maskView.hidden = _isShowSlide;
}
#pragma mark - YTMainView Delegate

- (void)refreshData:(id)tagerView
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
    YTSearchViewController *resultVC = [[YTSearchViewController alloc] init];
    [self presentViewController:resultVC animated:YES completion:nil];
}

#pragma mark - 读取缓存操作

- (void)readCityNameArray
{
    self.cityNameArray = [[NSMutableArray alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.cityNameArray = [[defaults objectForKey:YTCityNameArrayDefaults] mutableCopy];
}

- (void)saveCityNameArray:(NSArray *)cityNameArray
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:cityNameArray forKey:YTCityNameArrayDefaults];
    [defaults synchronize];
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
