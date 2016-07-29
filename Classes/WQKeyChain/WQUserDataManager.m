//
//  WQUserDataManager.m
//  KeyChainDemo
//
//  Created by 李红 on 13-9-26.
//  Copyright (c) 2013年 hongli. All rights reserved.
//

#import "WQUserDataManager.h"
#import "WQKeyChain.h"

@implementation WQUserDataManager

static NSString * const KEY_IN_KEYCHAIN = @"com.wuqian.app.allinfo";
static NSString * const KEY_DEVICE_ID = @"com.wuqian.app.deviceId";

+(void)saveDeviceId:(NSString *)deviceId
{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:deviceId forKey:KEY_DEVICE_ID];
    [WQKeyChain save:KEY_IN_KEYCHAIN data:usernamepasswordKVPairs];
    
}

+(id)readDeviceId
{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[WQKeyChain load:KEY_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:KEY_DEVICE_ID];
}

+(void)deleteDeviceId
{
    [WQKeyChain delete:KEY_IN_KEYCHAIN];
}

@end
