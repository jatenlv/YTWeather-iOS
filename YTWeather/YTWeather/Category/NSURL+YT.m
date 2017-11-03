//
//  NSURL+YT.m
//  YTWeather
//
//  Created by admin on 2017/11/3.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "NSURL+YT.h"

@implementation NSURL (YT)

+ (NSURL *)findImageUrl:(NSString *)string
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"weatherCode" ofType:@"plist"];
    NSArray *waetherArray = [NSArray arrayWithContentsOfFile:plistPath];
    for (NSDictionary *dic in waetherArray) {
        if ([dic[@"weatherCode"] isEqualToString:string]) {
            return [NSURL URLWithString:dic[@"weatherIconUrl"]];
        }
    }
    return nil;
}

@end
