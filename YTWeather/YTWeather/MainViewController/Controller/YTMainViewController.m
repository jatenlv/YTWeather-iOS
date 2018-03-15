//
//  YTMainViewController.m
//  YTWeather
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "YTMainViewController.h"

#import "YTMainView.h"
#import "YTLeftSlideView.h"

#import "YTSearchViewController.h"
#import "YTSettingViewController.h"

#import "YTMainRequestNetworkTool.h"

#import "YTCitySearchModel.h"

#define kSlideWidthScale 0.7

@interface YTMainViewController ()
<
YTMainViewDelegate,
YTLeftSlideViewDelegate,
UIGestureRecognizerDelegate,
UITableViewDelegate,
CLLocationManagerDelegate,
UIViewControllerTransitioningDelegate
>

@property (nonatomic, strong) YTLeftSlideView *leftSlideView; // 左侧可滑动视图
@property (nonatomic, assign) BOOL isPanGestureMove;

@property (nonatomic, strong) UIView *backAlphaView;          // scrollView和leftSlideView两层之间的遮罩

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSUInteger curIndex;            // 当前的MainView索引
@property (nonatomic, strong) UITapGestureRecognizer *tap;    // 单击手势

@property (nonatomic, strong) NSMutableArray <YTMainView *> *mainViewArray;
@property (nonatomic, strong) NSMutableArray *cityNameArray;
@property (nonatomic, assign) CGFloat viewOrginX;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSString *currentCity;          // 当前城市

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
    
    [self setupBackAlphaView];   // 添加底层遮罩页面
    [self setupLeftSlideView];   // 添加左侧滑动页面
    [self setupScrollView];      // 添加ScrollView
    [self readCityNameArray];    // 取出其他城市缓存
    [self loadOldViewAndData];   // 加载城市数组中的城市页面和数据
    [self addSlideGesture];      // 添加滑动弹出设置页面手势
    [self setupLocationManager]; // 加载定位功能，定位当前城市

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchCityNameDidSelect:) name:YTNotificationSearchCityNameDidSelect object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAllMainView) name:YTNotificationApplicationDidBecomeActive object:nil];
}

#pragma mark - Private Method

- (void)setupBackAlphaView
{
    self.backAlphaView = [[UIView alloc] initWithFrame:ScreenBounds];
    self.backAlphaView.backgroundColor = [UIColor colorWithHexString:@"#151515"];
    [self.view addSubview:self.backAlphaView];
}

- (void)setupLeftSlideView
{
    self.leftSlideView = [[YTLeftSlideView alloc]initWithFrame:ScreenBounds];
    self.leftSlideView.delegate = self;
    [self.view addSubview:self.leftSlideView];
    [self.view sendSubviewToBack:self.leftSlideView];
}

- (void)setupScrollView
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:ScreenBounds];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
}

- (void)setupLocationManager
{
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager requestAlwaysAuthorization];
        self.currentCity = [[NSString alloc] init];
        [self.locationManager startUpdatingLocation];
    }
}

- (void)readCityNameArray
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.cityNameArray = [[defaults objectForKey:YTCityNameArrayDefaults] mutableCopy];
    if (self.cityNameArray.count == 0) {
        if (!self.cityNameArray) {
            self.cityNameArray = [NSMutableArray array];
        }
        [self.cityNameArray addObject:@"上海"];
    }
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
    self.leftSlideView.kCityNameArray = [self.cityNameArray mutableCopy];
}

- (void)reloadScrollViewSize
{
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.cityNameArray.count * ScreenWidth, 0);
}

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
    [YTMainRequestNetworkTool requestWeatherAndAirWithCityName:cityName viewController:self andFinish:^(YTWeatherNormalModel *weatherModel, YTWeatherAirModel *airModel, NSError *error) {
        if (!error) {
            if ([mainView.cityNameForView isEqualToString:cityName]) {
                [mainView setWeatherAndAirModel:weatherModel airModel:airModel];
            }
        }
    }];
    
    if (newView) {
        [self.scrollView setContentOffset:mainView.frame.origin animated:NO];
    }
}

#pragma mark - 添加左侧侧滑手势

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
    YTMainView *curMainV = self.mainViewArray[_curIndex];
    curMainV.tableView.scrollEnabled = !_isShowSlide;
}

- (void)changeFrame:(UIPanGestureRecognizer *)pan
{
    //相对偏移量
    CGFloat translatePointX = [pan translationInView:self.scrollView].x;
    if(self.scrollView.mj_x + translatePointX < 0) {
        translatePointX = 0;
    }
    if(pan.state == UIGestureRecognizerStateChanged) {
        [self slideViewMoveWithDistance:translatePointX];
    } else if(pan.state == UIGestureRecognizerStateEnded) {
        if(self.scrollView.mj_x < kSlideWidthScale * ScreenWidth) {
            [self slideViewMoveWithDistance:-self.scrollView.mj_x];
            self.isShowSlide = NO;
        } else {
            [self slideViewMoveWithDistance: (kSlideWidthScale * ScreenWidth-self.scrollView.mj_x)];
        }
    }
    [pan setTranslation:CGPointZero inView:self.scrollView];
}

- (void)slideViewMoveWithDistance:(CGFloat)offset
{
    [UIView animateWithDuration:0.35 animations:^{
        self.scrollView.mj_x += offset;
        self.backAlphaView.alpha =  1 - self.scrollView.mj_x / (kSlideWidthScale * ScreenWidth);
    } completion:^(BOOL finished) {
        [self getCurMainVConfigScrollEnabled];
    }];
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x;
    _curIndex = offset / ScreenWidth;
}

#pragma mark - CoreLocation Delegate

//定位失败则执行此代理方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied) {
        [self.view showHudWithText:@"定位访问被拒绝"];
    } else if ([error code] == kCLErrorLocationUnknown) {
        [self.view showHudWithText:@"无法获取位置信息"];
    }
}

//定位成功回调
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [self.locationManager stopUpdatingLocation];

    CLLocation *currentLocation = locations.lastObject;
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    
    //地理反编码 可以根据坐标(经纬度)确定位置信息(街道 门牌等)
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count >0) {
            CLPlacemark *placeMark = placemarks[0];
            if (!placeMark.locality || placeMark.locality.length == 0) {
                [self.view showHudWithText:@"无法定位当前城市"];
                return;
            }
            // 成功获取到所在城市之后
            if (!self.currentCity.length) {
                if ([[placeMark.locality substringWithRange:NSMakeRange(placeMark.locality.length - 1, 1)] isEqualToString:@"市"]) {
                    self.currentCity = [placeMark.locality substringToIndex:placeMark.locality.length - 1];
                } else {
                    self.currentCity = placeMark.locality;
                }
                // 存一下城市名的全局缓存
                [[NSUserDefaults standardUserDefaults] setObject:self.currentCity forKey:@"YTCurrentCity"];
                
                // 判断是否LeftSlideView列表中存在此城市 若存在直接刷新列表 更换名字和图标
                for (NSString *cityName in self.cityNameArray) {
                    if ([cityName isEqualToString:self.currentCity]) {
                        [self.leftSlideView.tableView reloadData];
                        return;
                    }
                }
                
                // 判断定位的名称是否合法
                NSArray <YTCitySearchModel *> *searchSource = [NSArray array];
                NSString *path = [[NSBundle mainBundle]pathForResource:@"cityCode" ofType:@"plist"];
                NSArray *data = [NSArray arrayWithContentsOfFile:path];
                searchSource = [NSArray modelArrayWithClass:[YTCitySearchModel class] json:data];
                NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"belongToCityChineseName CONTAINS %@", self.currentCity];
                NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"cityChineseName CONTAINS %@", self.currentCity];
                NSCompoundPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[predicate1, predicate2]];
                NSArray *resultArray = [[searchSource filteredArrayUsingPredicate:compoundPredicate] copy];
                if (!resultArray.count) {
                    [self.view showHudWithText:@"当前定位城市不支持"];
                    return;
                }
                
                // 添加城市
                [self.cityNameArray addObject:self.currentCity];
                [self saveCityNameArray:[_cityNameArray copy]]; // 存入缓存
                [self reloadScrollViewSize];
                [self createMainViewWithCityName:self.currentCity newView:YES];
                self.leftSlideView.kCityNameArray = [self.cityNameArray mutableCopy];
                self.curIndex = self.scrollView.contentOffset.x / ScreenWidth;
            }
        }else if (error == nil && placemarks.count){
            [self.view showHudWithText:[NSString stringWithFormat:@"loction error:%@",error]];
        }else if (error){
            [self.view showHudWithText:[NSString stringWithFormat:@"loction error:%@",error]];
        }
    }];
    
}

#pragma mark - YTMainView Delegate

- (void)refreshData:(id)tagerView
{
    YTMainView *mainView = (YTMainView *)tagerView;
    
    [YTMainRequestNetworkTool requestWeatherAndAirWithCityName:mainView.cityNameForView viewController:self andFinish:^(YTWeatherNormalModel *weatherModel, YTWeatherAirModel *airModel, NSError *error) {
        [mainView.tableView.mj_header endRefreshing];
        if (!error) {
            [mainView setWeatherAndAirModel:weatherModel airModel:airModel];
        }
    }];
}

- (void)clickLeftBarButton
{
    CGFloat maxOffset = kSlideWidthScale * self.scrollView.width;
    CGFloat offset = _isShowSlide ? -maxOffset : maxOffset;
    [self slideViewMoveWithDistance:offset];
    self.isShowSlide = !self.isShowSlide;
    if (self.isShowSlide) {
        [UIView animateWithDuration:0.43 animations:^{
            self.backAlphaView.alpha = 0;
        }];
    } else {
        [UIView animateWithDuration:0.6 animations:^{
            self.backAlphaView.alpha = 1;
        }];
    }
}

- (void)clickRightBarButton
{
    YTSearchViewController *resultVC = [[YTSearchViewController alloc] init];
    resultVC.transitioningDelegate = self;
    [self presentViewController:resultVC animated:YES completion:NULL];
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

- (void)clickShareButton
{
    [self clickLeftBarButton];
    [UMSocialUIManager removeAllCustomPlatformWithoutFilted];
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession), @(UMSocialPlatformType_WechatTimeLine), @(UMSocialPlatformType_QQ), @(UMSocialPlatformType_Sina)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        if (platformType == UMSocialPlatformType_QQ || platformType == UMSocialPlatformType_WechatSession || platformType == UMSocialPlatformType_Sina) {
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:@"油条天气" descr:@"分享给您" thumImage:[UIImage imageNamed:@"AppIcon"]];
            [shareObject setShareImage:[self screenShot]];
            messageObject.shareObject = shareObject;
            [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id result, NSError *error) {
                if (error) {
                    if (error.code == 2003 || error.code == 2007) {
                        [self.view showHudWithText:@"分享配置不正确"];
                    } else if (error.code == 2009) {
                        [self.view showHudWithText:@"分享被取消"];
                    } else {
                        [self.view showHudWithText:@"分享失败"];
                    }
                } else {
                    [self.view showHudWithText:@"分享成功"];
                }
            }];
        } else {
            [self.view showHudWithText:@"暂未开放此分享平台"];
        }
    }];
}

- (UIImage *)screenShot
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]){
        UIGraphicsBeginImageContextWithOptions(self.view.window.bounds.size, NO, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(self.view.window.bounds.size);
    }
    [self.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)clickSlideViewCloseButton
{
    [self clickLeftBarButton];
}


- (void)showCityViewWithIndex:(NSInteger)index
{
    [self clickLeftBarButton];
    [self.scrollView setContentOffset:self.mainViewArray[index].frame.origin animated:NO];
    self.curIndex = self.scrollView.contentOffset.x / ScreenWidth;
}

- (void)deleteCityViewWithIndex:(NSInteger)index
{
    [self.cityNameArray removeObjectAtIndex:index];
    [self saveCityNameArray:[self.cityNameArray copy]]; // 存入缓存
    
    [[self.mainViewArray objectAtIndex:index] removeFromSuperview];
    [self.mainViewArray removeObjectAtIndex:index];
    for (NSInteger i = index; i < self.mainViewArray.count; i++) {
        [[self.mainViewArray objectAtIndex:i] setFrame:CGRectMake([self.mainViewArray objectAtIndex:i].mj_x - ScreenWidth, 0, ScreenWidth, ScreenHeight)];
    }
    
    if (self.curIndex > index) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x - ScreenWidth, 0) animated:YES];
    }
    
    [self.scrollView layoutSubviews];
    [self reloadScrollViewSize];
    self.curIndex = self.scrollView.contentOffset.x / ScreenWidth;
}

- (void)clickSettingButton
{
    YTSettingViewController *settingVC = [[YTSettingViewController alloc] init];
    [self.navigationController presentViewController:settingVC animated:YES completion:nil];
}

#pragma mark - Notification Action

- (void)searchCityNameDidSelect:(NSNotification *)notify
{
    NSString *newCityName = notify.object;
    
    for (NSString *cityName in self.cityNameArray) {
        if ([cityName isEqualToString:newCityName]) {
            NSInteger index = [self.cityNameArray indexOfObject:cityName];
            [self.scrollView setContentOffset:CGPointMake(index * ScreenWidth, 0)];
            return;
        }
    }
    
    [self.cityNameArray addObject:newCityName];
    [self saveCityNameArray:[_cityNameArray copy]]; // 存入缓存
    
    [self reloadScrollViewSize];
    [self createMainViewWithCityName:newCityName newView:YES];
    self.leftSlideView.kCityNameArray = [self.cityNameArray mutableCopy];
    self.curIndex = self.scrollView.contentOffset.x / ScreenWidth;
}


- (void)refreshAllMainView
{
    for (YTMainView *view in self.mainViewArray) {
        [view.tableView.mj_header beginRefreshing];
    }
}

#pragma mark - 存缓存操作

- (void)saveCityNameArray:(NSArray *)cityNameArray
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:cityNameArray forKey:YTCityNameArrayDefaults];
    [defaults synchronize];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    BOOL isAddTapGesture = [change[NSKeyValueChangeNewKey] boolValue];
    if (isAddTapGesture) {
        [self.scrollView addGestureRecognizer:self.tap];
    } else {
        [self.scrollView removeGestureRecognizer:self.tap];
    }
}

@end
