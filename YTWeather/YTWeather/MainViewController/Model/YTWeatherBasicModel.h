//
//  YTWeatherBasicModel.h
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UpdateModel;

@interface YTWeatherBasicModel : NSObject

@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *cnty;
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, strong) NSNumber *lat;
@property (nonatomic, strong) NSNumber *lon;
@property (nonatomic, copy) NSString *prov;
@property (nonatomic, strong) UpdateModel *update;

@end

@interface UpdateModel : NSObject

@property (nonatomic, strong) NSNumber *lot;
@property (nonatomic, strong) NSNumber *utc;

@end
