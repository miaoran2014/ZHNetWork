//
//  WQKeyChain.h
//  KeyChainDemo
//
//  Created by 李红 on 13-9-26.
//  Copyright (c) 2013年 hongli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WQKeyChain : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;

@end
