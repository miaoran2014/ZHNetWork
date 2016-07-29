//
//  WQKeyChain.m
//  KeyChainDemo
//
//  Created by 李红 on 13-9-26.
//  Copyright (c) 2013年 hongli. All rights reserved.
//

#import "WQKeyChain.h"

@implementation WQKeyChain
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            ( id)kSecClassGenericPassword,( id)kSecClass,
            service, ( id)kSecAttrService,
            service, ( id)kSecAttrAccount,
            ( id)kSecAttrAccessibleAfterFirstUnlock,( id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete(( CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:( id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd(( CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:( id)kSecReturnData];
    [keychainQuery setObject:( id)kSecMatchLimitOne forKey:( id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching(( CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge  NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    return ret;
}

+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete(( CFDictionaryRef)keychainQuery);
}  
@end
