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

@interface Comf : NSObject

@property (nonatomic, copy) NSString *brf;
@property (nonatomic, copy) NSString *txt;

@end

@interface Cw : NSObject

@property (nonatomic, copy) NSString *brf;
@property (nonatomic, copy) NSString *txt;

@end

@interface Drsg : NSObject

@property (nonatomic, copy) NSString *brf;
@property (nonatomic, copy) NSString *txt;

@end

@interface Flu : NSObject

@property (nonatomic, copy) NSString *brf;
@property (nonatomic, copy) NSString *txt;

@end

@interface Sport : NSObject

@property (nonatomic, copy) NSString *brf;
@property (nonatomic, copy) NSString *txt;

@end

@interface Trav : NSObject

@property (nonatomic, copy) NSString *brf;
@property (nonatomic, copy) NSString *txt;

@end

@interface Uv : NSObject

@property (nonatomic, copy) NSString *brf;
@property (nonatomic, copy) NSString *txt;

@end
