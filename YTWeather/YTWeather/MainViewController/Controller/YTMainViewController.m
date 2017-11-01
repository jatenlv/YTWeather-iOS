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
#import "YTSearchViewController.h"

#define kSlideWidthScale 0.7

@interface YTMainViewController ()
<
YTMainViewDelegate,
YTLeftSlideViewDelegate,
UIGestureRecognizerDelegate,
UITableViewDelegate
>

@property (strong, nonatomic) UIScrollView *scrollView;
//当前的MainView索引
@property (nonatomic, assign) NSUInteger curIndex;
//单击手势
@property (nonatomic,strong) UITapGestureRecognizer *tap;



@property (nonatomic,strong) YTLeftSlideView *leftSlideView;
@property (nonatomic, assign) BOOL isPanGestureMove;

@property (nonatomic, strong) NSMutableArray <YTMainView *> *mainViewArray;
@property (nonatomic, strong) NSMutableArray *cityNameArray;
@property (nonatomic, assign) CGFloat viewOrginX;


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
    _curIndex = 0;
    // 添加左侧滑动页面
    [self setupLeftSlideView];
    // 添加ScrollView
    [self setupScrollView];
    // 添加滑动弹出设置页面手势
    [self addSlideGesture];
    // 取出城市缓存
    [self readCityNameArray];
    // 加载缓存中的城市页面和数据
    [self loadOldViewAndData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchCityNameDidSelect:) name:YTNotificationSearchCityNameDidSelect object:nil];
}

#pragma mark - Private Method

- (void)setupLeftSlideView
{
    self.leftSlideView = [[YTLeftSlideView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.leftSlideView.delegate = self;
    [self.view addSubview:self.leftSlideView];
    [self.view sendSubviewToBack:self.leftSlideView];
}

- (void)setupScrollView
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
}

- (void)loadOldViewAndData
{
    // 调整scrollView大小
    [self reloadScrollViewSize];
    self.mainViewArray = [NSMutableArray array];
    self.viewOrginX = 0;
    for (NSString *cityName in self.cityNameArray) {
        [self createMainViewWithCityName:cityName newView:NO];
    }
    self.leftSlideView.cityNameArray = self.cityNameArray;
}

- (void)reloadScrollViewSize
{
    self.scrollView.pagingEnabled = YES;
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

#pragma mark - Notification

- (void)searchCityNameDidSelect:(NSNotification *)notify
{
    NSString *newCityName = notify.object;
    [self.cityNameArray addObject:newCityName];
    // 存入城市缓存
    [self saveCityNameArray:[self.cityNameArray copy]];
    
    [self reloadScrollViewSize];
    [self createMainViewWithCityName:newCityName newView:YES];
    self.leftSlideView.cityNameArray = self.cityNameArray;
}

#pragma mark 添加左侧侧滑手势

- (void)addSlideGesture
{
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(changeFrame:)];
    pan.delegate = self;
    [self.scrollView addGestureRecognizer:pan];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLeftBarButton)];
    [tap requireGestureRecognizerToFail:pan];
    self.tap = tap;
    [self addObserver:self forKeyPath:@"isShowSlide" options:NSKeyValueObservingOptionNew context:nil];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    [self getCurMainVConfigScrollEnabled];
    return _isShowSlide;
}
- (void)getCurMainVConfigScrollEnabled
{
    YTMainView * curMainV =self.mainViewArray[_curIndex];
    curMainV.tableView.scrollEnabled = !_isShowSlide;
}

- (void)changeFrame:(UIPanGestureRecognizer *)pan
{
    //相对偏移量
    CGFloat  translatePointX = [pan translationInView:self.scrollView].x;
    if(self.scrollView.mj_x + translatePointX < 0)
    {
        translatePointX = 0;
    }
    if(pan.state == UIGestureRecognizerStateChanged)
    {
        [self slideViewMoveWithDistance:translatePointX];

    }else if(pan.state == UIGestureRecognizerStateEnded)
    {
        if(self.scrollView.mj_x < kSlideWidthScale * ScreenWidth)
        {
            [self slideViewMoveWithDistance:-self.scrollView.mj_x];
            self.isShowSlide = NO;
        }else {
            [self slideViewMoveWithDistance: (kSlideWidthScale * ScreenWidth-self.scrollView.mj_x)];
        }
    }
    [pan setTranslation:CGPointZero inView:self.scrollView];
}

- (void)slideViewMoveWithDistance:(CGFloat)offset
{
    [UIView animateWithDuration:0.35 animations:^{
        self.scrollView.mj_x += offset;
    }];
}

#pragma mark - Scroll View Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x;
    _curIndex = offset/ScreenWidth;
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
    self.isShowSlide = !self.isShowSlide;
}

- (void)clickRightBarButton
{
    YTSearchViewController *resultVC = [[YTSearchViewController alloc] init];
    [self presentViewController:resultVC animated:YES completion:nil];
}

- (void)mainTableViewDidScrollWithOffset:(CGFloat)offset
{
    [self.mainViewArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(_curIndex != idx)
        {
            YTMainView * mainV = (YTMainView *)obj;
            [mainV setContentOffset:offset animated:NO];
        }
    }];
}

#pragma mark - YTLeftSlideView Delegate

- (void)showCityViewWithIndex:(NSInteger)index
{
    [self clickLeftBarButton];
    [self.scrollView setContentOffset:self.mainViewArray[index].frame.origin animated:NO];
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
#pragma mark - lazy init

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

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    BOOL isAddTapGesture = [change[NSKeyValueChangeNewKey] boolValue];
    if(isAddTapGesture){
        [self.scrollView addGestureRecognizer:self.tap];
    }else{
        [self.scrollView removeGestureRecognizer:self.tap];
    }
}

@end
