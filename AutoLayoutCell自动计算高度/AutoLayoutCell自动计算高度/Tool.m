//
//  Tool.m
//  Epipe
//
//  Created by ZXW on 2017/8/25.
//  Copyright © 2017年 Epipe-iOS. All rights reserved.
//

#import "Tool.h"
#import "NSDate+Add.h"

@implementation Tool
//json格式字符串转字典或者数组
+ (id)jsonStringtoArrayOrDictionary:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id object = [NSJSONSerialization JSONObjectWithData:jsonData
                                                options:NSJSONReadingMutableContainers
                                                  error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return object;
}

//把字典和数组转换成json字符串
+ (NSString *)arrayOrDictionaryToJsonString:(id)object{
    NSError *error = nil;
    NSData* jsonData =[NSJSONSerialization dataWithJSONObject:object
                                                      options:NSJSONWritingPrettyPrinted error:&error];
    NSString *strs=[[NSString alloc] initWithData:jsonData
                                         encoding:NSUTF8StringEncoding];
    return strs;
}

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        //[1][34578][0-9]{9}
        NSString *CT_NUM = @"^(13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9])[0-9]{8}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch = [pred evaluateWithObject:mobile];
        
        if (isMatch) {
            return YES;
        }else{
            return NO;
        }
    }
}
#pragma mark-->判断网址格式是否正确
+ (BOOL)valiUrlStr:(NSString *)urlStr{
    
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regulaStr];
    BOOL isMatch = [pred evaluateWithObject:urlStr];
    if (isMatch) {
        return YES;
    }else{
        return NO;
    }
}

+(UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        
//        NSLog(@"===%@",[window subviews]);
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    if (![result isKindOfClass:[UIViewController class]]) {
        return nil;
    }
    return result;
}


/**
 * 每条消息右侧带有接收到该消息的时间：
 ν	2天以内，时间展示为“ 时：分”，“昨天 时：分”；
 ν	超过2天在一周内，时间格式“星期几”；
 ν	超过一周，则格式为“年/月/日”
 ν	举例：18:30；昨天 22:05；星期三；2017/8/27；
 */
#pragma mark -->处理消息中心时间的显示
+(NSString*)handleMessageTimeStr:(NSString*)time  isDetail:(BOOL)flag{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *tagrtDate = [formatter dateFromString:time];
    
    return [self handleMessageTimeDate:tagrtDate isDetail:flag];
}

+(NSString*)handleMessageTimeDate:(NSDate*)tagrtDate  isDetail:(BOOL)flag{
    
    //时间间隔
    NSInteger intevalTime = [[NSDate date] timeIntervalSinceReferenceDate] - [tagrtDate timeIntervalSinceReferenceDate];
    CGFloat day = intevalTime / 60.0 / 60.0 / 24.0;
    //如果是同一天
    if ([[NSDate date] sameDayWithDate:tagrtDate]) {
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"HH:mm";
        NSString * time = [df stringFromDate:tagrtDate];
        return time;
    }
    //如果不是同一天(时间间隔小于等于1)
    if (day<=1) {
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"昨天 HH:mm";
        NSString * time = [df stringFromDate:tagrtDate];
        return time;
    }if (day<=7) {
        return [self weekDayStr:tagrtDate];
    }else{
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        if (flag) {
            df.dateFormat = @"yyyy-MM-dd HH:mm";
        }else{
            df.dateFormat = @"yyyy/MM/dd";
        }
        NSString * time = [df stringFromDate:tagrtDate];
        return time;
    }
    
    return @"";
    
}



+ (NSString*)weekDayStr:(NSDate*)date{
    
    NSString *weekStr=nil;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    comps = [calendar components:unitFlags fromDate:date];

    NSInteger week = [comps weekday];

    switch(week){
            
        case 1:
            weekStr=@"星期日";
            break;
        case 2:
            weekStr=@"星期一";
            break;
        case 3:
            weekStr=@"星期二";
            break;
        case 4:
            weekStr=@"星期三";
            break;
        case 5:
            weekStr=@"星期四";
            break;
        case 6:
           weekStr=@"星期五";
            break;
        case 7:
            weekStr=@"星期六";
            break;
        default:
            weekStr=@"";
            break;
    }
    return weekStr;
}


//获取当前时间
//format: @"yyyy-MM-dd HH:mm:ss"、@"yyyy年MM月dd日 HH时mm分ss秒"
+ (NSString *)currentDateWithFormat:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:[NSDate date]];
}

//获取当前时间的字符串
+(NSString *)getCuttentTimeStr{
    return  [self currentDateWithFormat:@"yyyyMMddHHmmss"];
}

//给url加上随机的参数 保证每次请求的参数不一样 解决缓存问题
+(NSString *)urlAddRandomParameter:(NSString*)urlStr{

    //原则:有参数(有?就有说明有参数)那就后面加&timeSpan=xxx
    //没有参数(没有?就有说明没有参数)那就后面加?timeSpan=xxx
    
    NSString *randomStr = [NSString stringWithFormat:@"timeSpan=%@",[self getCuttentTimeStr]];
    
    NSRange range = [urlStr rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        //没有?
        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"?%@",randomStr]];
    }else{
        //有?
        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"&%@",randomStr]];
    }
    
    return urlStr;
    
}

@end
