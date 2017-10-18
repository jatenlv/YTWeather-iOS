//
//  YTWeatherSuggestionModel.h
//  YTWeather
//
//  Created by admin on 2017/10/18.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Comf;
@class Cw;
@class Drsg;
@class Flu;
@class Sport;
@class Trav;
@class Uv;

@interface YTWeatherSuggestionModel : NSObject

@property (nonatomic, strong) Comf *comf;
@property (nonatomic, strong) Cw *cw;
@property (nonatomic, strong) Drsg *drsg;
@property (nonatomic, strong) Flu *flu;
@property (nonatomic, strong) Sport *sport;
@property (nonatomic, strong) Trav *trav;
@property (nonatomic, strong) Uv *uv;

@end

@interface Comf

@property (nonatomic, copy) NSString *brf;
@property (nonatomic, copy) NSString *txt;

@end

@interface Cw

@property (nonatomic, copy) NSString *brf;
@property (nonatomic, copy) NSString *txt;

@end

@interface Drsg

@property (nonatomic, copy) NSString *brf;
@property (nonatomic, copy) NSString *txt;

@end

@interface Flu

@property (nonatomic, copy) NSString *brf;
@property (nonatomic, copy) NSString *txt;

@end

@interface Sport

@property (nonatomic, copy) NSString *brf;
@property (nonatomic, copy) NSString *txt;

@end

@interface Trav

@property (nonatomic, copy) NSString *brf;
@property (nonatomic, copy) NSString *txt;

@end

@interface Uv

@property (nonatomic, copy) NSString *brf;
@property (nonatomic, copy) NSString *txt;

@end
