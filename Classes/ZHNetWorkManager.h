//
//  NetworkTools.h
//  ZongHeng
//
//  Created by 王充 on 15/7/14.
//  Copyright (c) 2015年 李贺. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"
#import "ZHError.h"


// 网络回调
typedef void (^completionJSON)(id responseObject,id extroInfo);
typedef void(^DownloadSuccess)(NSURLSessionDownloadTask *downloadTask,id responseObject,id extroInfo);
typedef void(^DownloadFailure)(NSURLSessionDownloadTask *downloadTask, NSError *error,id extroInfo);
typedef void(^progressBlock)(NSProgress *progress,id extroInfo);
@interface ZHNetWorkManager : AFHTTPSessionManager

+ (instancetype)shareNetworkTools;

///  GET
///
///  @param URLString      传入服务器地址
///  @param parameters     传入的参数字典
///  @param extroInfo      自定义参数
///  @param completionJSON 回调
- (void)requestJSONmethodGET:(NSString *)URLString
                  baseString:(NSString *)baseString
                      params:(NSMutableDictionary *)parameters
                   extroInfo:(id)extroInfo
              completionJSON: (completionJSON)completionJSON;

///  POST
///
///  @param URLString      传入服务器地址
///  @param parameters     传入的参数字典
///  @param extroInfo      自定义参数
///  @param completionJSON 回调
- (void)requestJSONmethodPOST:(NSString *)URLString
                   baseString:(NSString *)baseString
                       params: (NSMutableDictionary *)parameters
                    extroInfo:(id)extroInfo
               completionJSON:(completionJSON)completionJSON;


- (void)requestJSONmethodPOST:(NSString *)urlString
                   baseString:(NSString *)baseString
                       params:(NSMutableDictionary *)parameters
                    extroInfo:(id)extroInfo
                      success:(completionJSON)successJSON
                      failure:(completionJSON)failureJSON;


///  POST上传
///
///  @param URLString      传入上传服务器地址
///  @param fieldName      保存在服务器的文件名
///  @param dataList       把要上传的数据放入字典中,key是服务器字段名  value是要上传的数据(二进制)
///  @param parameters     传入的参数字典
///  @param extroInfo      自定义参数
///  @param completionJSON 回调
- (void)uploadWithPOST : (NSString *)URLString
             baseString:(NSString *)baseString
              fieldName:(NSString *)fieldName
              dataList : (NSDictionary *)dataList
            parameters : (NSMutableDictionary *)parameters
              extroInfo:(id)extroInfo
        completionJSON : (completionJSON)completionJSON;

@end
