//
//  NSURL+YT.h
//  YTWeather
//
//  Created by admin on 2017/11/3.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (YT)

// plist文件中查找天气图片url
+ (NSURL *)findImageUrl:(NSString *)string;

@end
