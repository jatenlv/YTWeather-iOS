//
//  YTMainRequestNetworkTool.m
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "YTMainRequestNetworkTool.h"

@implementation YTMainRequestNetworkTool

+ (void)requestWeatherAndAirWithCityName:(NSString *)cityName viewController:(UIViewController *)vc andFinish:(void (^)(YTWeatherNormalModel *weatherModel, YTWeatherAirModel *airModel, NSError *error))finish
{
    __block NSError *errorMessage;
    __block YTWeatherNormalModel *weatherModel;
    __block YTWeatherAirModel *airModel;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [YTMainRequestNetworkTool getRequestWithUrl:YT_Request_Main_Weather_API cityName:cityName viewController:vc andFinish:^(id  _Nullable responseObject, NSError *error) {
            if (!error) {
                weatherModel = [NSArray modelArrayWithClass:[YTWeatherNormalModel class] json:responseObject[@"HeWeather6"]][0];
            } else {
                errorMessage = error;
            }
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (!errorMessage) {
            [YTMainRequestNetworkTool getRequestWithUrl:YT_Request_Main_Air_API cityName:cityName viewController:vc andFinish:^(id  _Nullable responseObject, NSError *error) {
                if (!error) {
                    airModel = [NSArray modelArrayWithClass:[YTWeatherAirModel class] json:responseObject[@"HeWeather6"]][0];
                }
                dispatch_group_leave(group);
            }];
        }
    });
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        if (!errorMessage) {
            finish(weatherModel, airModel, nil);
        } else {
            finish(nil, nil, errorMessage);
        }
    });
}

+ (void)getRequestWithUrl:(NSString *)url cityName:(NSString *)cityName viewController:(UIViewController *)vc andFinish:(void (^)(id  _Nullable responseObject, NSError *error))finish
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:cityName forKey:@"location"];
    [param setObject:YT_Request_Main_API_KEY forKey:@"key"];
    
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finish(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"获取天气信息失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"重新获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self getRequestWithUrl:url cityName:cityName viewController:vc andFinish:finish];
        }];
        [alertController addAction:okAction];
        [vc presentViewController:alertController animated:YES completion:nil];
        finish(nil, error);
    }];
}

@end
