//
//  ZHDeviceTool.m
//  WWWW
//
//  Created by mac on 16/7/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZHDeviceTool.h"
#import <UIKit/UIKit.h>
#import "UIDevice+Hardware.h"
#import "OpenUDID.h"
#import "WQUserDataManager.h"

@implementation ZHDeviceTool

+ (NSString *)wcVersion{
    return [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
}

+ (NSString *)wcVersionInterception{
    NSMutableString *strM = [NSMutableString stringWithFormat:@"%@",[self wcVersion]];
    [strM replaceOccurrencesOfString:@"."
                          withString:@""
                             options:NSLiteralSearch
                               range:NSMakeRange(0, strM.length)];
    return strM.copy;
}
+ (NSString *)wcPlatform{
    return [UIDevice currentDevice].platformString;
}
+ (NSString *)wcSystemVersion{
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString *)wcResolutionWidth{

    NSInteger screenW = [[UIScreen mainScreen] bounds].size.width*[UIScreen mainScreen].scale;
    return  [NSString stringWithFormat:@"%ld",(long)screenW];
}
+ (NSString *)wcResolutionHeigth{

    NSInteger screenH = [[UIScreen mainScreen] bounds].size.height*[UIScreen mainScreen].scale;
    return [NSString stringWithFormat:@"%ld",(long)screenH];
    
}

+(NSString *)wcGetDeviceID
{
    NSString *deviceID = [WQUserDataManager readDeviceId];
    if (deviceID.length<=0) {
        deviceID = [[NSUserDefaults standardUserDefaults] stringForKey:@"DeviceID"];
        if (deviceID.length<=0) {
            deviceID = [OpenUDID value];
            [[NSUserDefaults standardUserDefaults] setObject:deviceID forKey:@"DeviceID"];
        }
        [WQUserDataManager saveDeviceId:deviceID];
    }
    return deviceID;
}

+ (NSString *)wcGetTime {
	//NSTimeInterval *interval =
	NSDate *date1 = [[NSDate alloc]init];
	NSTimeInterval time = [date1 timeIntervalSince1970];
	NSString *strTime = [NSString stringWithFormat:@"%f",time];
	return strTime;
}


@end
