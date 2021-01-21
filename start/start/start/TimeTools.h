//
//  TimeTools.h
//  LightMooc
//
//  Created by 魏大同 on 2017/12/20.
//  Copyright © 2017年 魏大同. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TimeTools : NSObject

+(NSString *)getCurrentTimes;
+(NSTimeInterval )getTimeIntervalSince1970;
+ (NSTimeInterval)getLocateTimeIntervalSince1970;
+(NSString *)getTimeStringWithTimeInterval:(NSTimeInterval )interval;
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)date;
+ (NSDate *)stringToDate:(NSString *)strdate formatStr:(NSString *)formatStr;
+ (NSString *)dateToString:(NSDate *)date;


@end
