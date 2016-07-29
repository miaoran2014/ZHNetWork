//
//  ZHDeviceTool.h
//  WWWW
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHDeviceTool : NSObject
/// 获取用户UUID
//-(NSString *)uuid;
/// 获取客户端版本号
+ (NSString *)wcVersion;
/// 获取用户手机机型(iPhone5还是6)
+ (NSString *)wcPlatform;
/// 获取用户当前的ios版本
+ (NSString *)wcSystemVersion;
/// 获取用户手机屏幕分辨率(宽)
+ (NSString *)wcResolutionWidth;
/// 获取用户手机屏幕分辨率(高)
+ (NSString *)wcResolutionHeigth;

///  获取设备id
+ (NSString *)wcGetDeviceID;


@end
