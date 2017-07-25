//
//  AppConfig.h
//  ZJKits
//
//  Created by jianz3 on 2017/7/25.
//  Copyright © 2017年 jianz3. All rights reserved.
//

#ifndef AppConfig_h
#define AppConfig_h


#endif /* AppConfig_h */

//通用颜色
#define kBlackColor         [UIColor blackColor]
#define kDarkGrayColor      [UIColor darkGrayColor]
#define kLightGrayColor     [UIColor lightGrayColor]
#define kWhiteColor         [UIColor whiteColor]
#define kGrayColor          [UIColor grayColor]
#define kRedColor           [UIColor redColor]
#define kGreenColor         [UIColor greenColor]
#define kBlueColor          [UIColor blueColor]
#define kCyanColor          [UIColor cyanColor]
#define kYellowColor        [UIColor yellowColor]
#define kMagentaColor       [UIColor magentaColor]
#define kOrangeColor        [UIColor orangeColor]
#define kPurpleColor        [UIColor purpleColor]
#define kClearColor         [UIColor clearColor]

// 手机系统版本
#define System_version [[UIDevice currentDevice] systemVersion]

// 当前屏幕宽
#define KmainScreenWidth   ([UIScreen mainScreen].bounds.size.width)

// 当前屏幕高
#define KmainScreenHeight  ([UIScreen mainScreen].bounds.size.height)

//自定义颜色
#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(1)];
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)];
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


//keyWindow实例化
#define kWindow [UIApplication sharedApplication].keyWindow

//重定义打印方法
#ifdef DEBUG
#define CLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define CLog(format, ...)
#endif

//获取图片资源
#define ZJGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

/**
 沙盒目录文件
 */
//获取temp
#define kPathTemp NSTemporaryDirectory()

//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
