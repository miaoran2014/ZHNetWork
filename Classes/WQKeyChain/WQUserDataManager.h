//
//  WQUserDataManager.h
//  KeyChainDemo
//
//  Created by 李红 on 13-9-26.
//  Copyright (c) 2013年 hongli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WQUserDataManager : NSObject
/**
 *  @brief  设备标识符
 *
 *  @param  password    密码内容
 */
+(void)saveDeviceId:(NSString *)deviceId;

/**
 *  @brief  读取密码
 *
 *  @return 密码内容
 */
+(id)readDeviceId;

/**
 *  @brief  删除密码数据
 */
+(void)deleteDeviceId;

@end
