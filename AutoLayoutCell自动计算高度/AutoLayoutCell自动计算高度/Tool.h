//
//  Tool.h
//  Epipe
//
//  Created by ZXW on 2017/8/25.
//  Copyright © 2017年 Epipe-iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Tool : NSObject

/**
 * json格式字符串转字典或者数组
 */
+ (id)jsonStringtoArrayOrDictionary:(NSString *)jsonString;

/**
 * 把字典和数组转换成json字符串
 */
+ (NSString *)arrayOrDictionaryToJsonString:(id)object;

#pragma mark-->判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile;

#pragma mark-->判断网址格式是否正确
+ (BOOL)valiUrlStr:(NSString *)urlStr;

#pragma mark -->获取当前的控制器
+(UIViewController *)getCurrentVC;


/**
 * 每条消息右侧带有接收到该消息的时间：
 ν	2天以内，时间展示为“ 时：分”，“昨天 时：分”；
 ν	超过2天在一周内，时间格式“星期几”；
 ν	超过一周，则格式为“年/月/日”
 ν	举例：18:30；昨天 22:05；星期三；2017/8/27；
 */
#pragma mark -->处理消息中心时间的显示
+(NSString*)handleMessageTimeStr:(NSString*)time isDetail:(BOOL)flag;
+(NSString*)handleMessageTimeDate:(NSDate*)tagrtDate isDetail:(BOOL)flag;
//获取当前时间
//format: @"yyyy-MM-dd HH:mm:ss"、@"yyyy年MM月dd日 HH时mm分ss秒"
+ (NSString *)currentDateWithFormat:(NSString *)format;

//获取当前周几
+ (NSString*)weekDayStr:(NSDate*)date;

//获取当前时间的字符串
+(NSString *)getCuttentTimeStr;

//给url加上随机的参数 保证每次请求的参数不一样 解决缓存问题
+(NSString *)urlAddRandomParameter:(NSString*)urlStr;


@end
