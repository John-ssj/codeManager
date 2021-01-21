//
//  TimeTools.m
//  LightMooc
//
//  Created by 魏大同 on 2017/12/20.
//  Copyright © 2017年 魏大同. All rights reserved.
//

#import "TimeTools.h"

@implementation TimeTools

+(NSString *)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd_HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    
    return currentTimeString;
    
}


+(NSTimeInterval )getTimeIntervalSince1970{
    
    NSTimeInterval time = [[NSDate date]timeIntervalSince1970];
    
    return time;
}

+ (NSTimeInterval)getLocateTimeIntervalSince1970
{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate:date];
    
    NSDate *localDate = [date dateByAddingTimeInterval:interval];
    
    return [localDate timeIntervalSince1970];
}


+(NSString *)getTimeStringWithTimeInterval:(NSTimeInterval)interval{
    
    int min,sec;
    
    min = interval/60;
    sec = (int)interval%60;
    
    NSString *currentTimeString = [NSString stringWithFormat:@"%02d:%02d",min,sec];
    
    return currentTimeString;
}



//将字符串转化为date
+ (NSDate *)stringToDate:(NSString *)strdate formatStr:(NSString *)formatStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatStr];
    NSDate *retdate = [dateFormatter dateFromString:strdate];
    return retdate;
}

//将date转化为字符串
+ (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

//将UTC时间转化为本地时间
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)date
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:date];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:date];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date];
    
    return destinationDateNow;
}


@end
