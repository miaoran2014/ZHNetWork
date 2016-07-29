//
//  ZHNetWorkTool.m
//  WWWW
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZHNetWorkTool.h"
#import <UIKit/UIKit.h>

@implementation ZHNetWorkTool
+ (NSString *)wcReachabilityStatus{
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    if (type == 0) {
        return @"无网络";
    }else if(type == 1){
        return @"2G";
    }else if(type == 2){
        return @"3G";
    }else if(type == 3){
        return @"4G";
    }else if(type == 5){
        return @"WiFi";
    }else {
        return @"网络状态不识别";
    }
}

+ (BOOL)isConnectionAvailable
{
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    if (type == 0) {
        return NO;
    }else if(type == 1){
        return YES;
    }else if(type == 2){
        return YES;
    }else if(type == 3){
        return YES;
    }else if(type == 5){
        return YES;
    }else if(type == 6){
        return YES;
    }else
    {
        return NO;
    }
    
}

+ (NSString *)getParamUrlSring:(NSDictionary *)param {
    NSMutableString *sign = [[NSMutableString alloc] init];
    NSArray *keys = [[param allKeys] sortedArrayWithOptions:NSSortStable usingComparator:^(id objOne , id objTwo)
                     {
                         return[objOne compare:objTwo];
                     }];
    for(int i = 0 ; i < keys.count ; i++){
        NSString *key = [keys objectAtIndex:i];
        if(i == 0){
            [sign appendFormat:@"%@=%@",key,[param valueForKey:key]];
        }else{
            [sign appendFormat:@"&%@=%@",key,[param valueForKey:key]];
        }
    }
    NSLog(@"sign is:%@",sign);
    return sign;
}
@end
