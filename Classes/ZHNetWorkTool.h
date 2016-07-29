//
//  ZHNetWorkTool.h
//  WWWW
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHNetWorkTool : NSObject

/// 获取用户接入的网络
+ (NSString *)wcReachabilityStatus;
///  判断有误网络
+ (BOOL)isConnectionAvailable;


+ (NSString *)getParamUrlSring:(NSDictionary *)param;

@end
