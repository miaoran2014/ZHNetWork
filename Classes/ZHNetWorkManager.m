//
//  NetworkTools.m
//  ZongHeng
//
//  Created by 王充 on 15/7/14.
//  Copyright (c) 2015年 李贺. All rights reserved.
//

#import "ZHNetWorkManager.h"
#import "MD5.h"
#import "ZHDeviceTool.h"
#import "ZHNetWorkTool.h"
#import "NSString+Encoding.h"

#define API_SIG                                 @"082DE6CF1178736AF28EB8065CDBE5AC%@082DE6CF1178736AF28EB8065CDBE5AC"
#define API_KEY                                 @"27A28A4D4B24022E543E"


// 文件下载路径
#define DownloadDirectory @"这里放入文件保存的路径(沙盒,或者缓存中)"

@interface ZHNetWorkManager() <NSURLSessionDownloadDelegate,NSURLSessionDelegate,NSURLSessionTaskDelegate,NSURLSessionDataDelegate>
@property (nonatomic, strong) NSMutableArray *paths;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSData *resumeData;
@property (nonatomic, strong) NSURL *URLFilePath;
@end

@implementation ZHNetWorkManager
+ (instancetype)shareNetworkTools{
    
    static ZHNetWorkManager *tools;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[self alloc]initWithNetworkBaseURL:nil];//[NSURL URLWithString:API_BASE]];
    });
    return tools;
}

- (void)requestJSONmethodGET:(NSString *)urlString baseString:(NSString *)baseString params:(NSDictionary *)parameters extroInfo:(id)extroInfo completionJSON:(completionJSON)completionJSON{
    
     NSString *URLString = [NSString stringWithFormat:@"%@%@",baseString,urlString];
    
     NSError *serializationError = nil;
   
     NSDictionary *parametersM = [self publicSigMethod:@"GET" URLString:URLString parameters:parameters serializationError:serializationError];
    
    [[ZHNetWorkManager shareNetworkTools] GET:URLString parameters:parametersM progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        completionJSON(responseObject,extroInfo);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        NSLog(@"%sERROR error:%@" ,__FUNCTION__, error);
        completionJSON(error,extroInfo);
    }];
    
}
///  POST
///
///  @param URLString      传入网址
///  @param parameters     传入的参数字典
///  @param extroInfo      自定义参数 
///  @param completionJSON 回调
- (void)requestJSONmethodPOST:(NSString *)urlString baseString:(NSString *)baseString params:(NSMutableDictionary *)parameters extroInfo:(id)extroInfo completionJSON:(completionJSON)completionJSON{
    
    NSString *URLString = [NSString stringWithFormat:@"%@%@",baseString,urlString];
    
    NSError *serializationError = nil;
    
    NSDictionary *parametersM = [self publicSigMethod:@"POST" URLString:URLString parameters:parameters serializationError:serializationError];
    
    [[ZHNetWorkManager shareNetworkTools] POST:URLString parameters:parametersM progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          completionJSON(responseObject,extroInfo);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"ERROR error:%@" ,error);
        NSLog(@"----------%ld----%@",(long)((NSHTTPURLResponse *)task.response).statusCode,error.userInfo);
        
        ZHError *tmpError = [[ZHError alloc]initWithDomain:error.domain code:error.code userInfo:error.userInfo];
        tmpError.statusCode = (long)((NSHTTPURLResponse *)task.response).statusCode;
        
        completionJSON(tmpError,extroInfo);
    }];
}

///  POST
///
///  @param URLString      传入网址
///  @param parameters     传入的参数字典
///  @param extroInfo      自定义参数
///  @param completionJSON 回调
- (void)requestJSONmethodPOST:(NSString *)urlString baseString:(NSString *)baseString params:(NSMutableDictionary *)parameters extroInfo:(id)extroInfo success:(completionJSON)successJSON failure:(completionJSON)failureJSON {
    
    NSString *URLString = [NSString stringWithFormat:@"%@%@",baseString,urlString];
    
    NSError *serializationError = nil;
    
    NSDictionary *parametersM = [self publicSigMethod:@"POST" URLString:URLString parameters:parameters serializationError:serializationError];

    [[ZHNetWorkManager shareNetworkTools] POST:URLString parameters:parametersM progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        successJSON(responseObject,extroInfo);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        ZHError *tmpError = [[ZHError alloc]initWithDomain:error.domain code:error.code userInfo:error.userInfo];
        tmpError.statusCode = (long)((NSHTTPURLResponse *)task.response).statusCode;
        failureJSON(tmpError,extroInfo);
    }];
}

// 上传
-(void)uploadWithPOST:(NSString *)urlString baseString:(NSString *)baseString fieldName:(NSString *)fieldName dataList:(NSDictionary *)dataList parameters:(NSMutableDictionary *)parameters extroInfo:(id)extroInfo completionJSON:(completionJSON)completionJSON{
    
    NSString *URLString = [NSString stringWithFormat:@"%@%@",baseString,urlString];
    
    NSError *serializationError = nil;
    
    NSDictionary *parametersM = [self publicSigMethod:@"POST" URLString:URLString parameters:parameters serializationError:serializationError];
    
    [[ZHNetWorkManager shareNetworkTools] POST:URLString parameters:parametersM constructingBodyWithBlock:^(id<AFMultipartFormData> fileData) {
        
        [dataList enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [fileData appendPartWithFileData:obj name:fieldName fileName:key mimeType:@"application/octet-stream"];
        }];
        
    } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        completionJSON(responseObject,extroInfo);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completionJSON(error,extroInfo);
    }];
}


- (instancetype)initWithNetworkBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url])
    {
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain",@"text/javascript", nil];
        
        self.requestSerializer.timeoutInterval = 15;
        // 联网状态监听
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable:


                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"联网状态是WiFi");
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"联网状态是窝蜂");
                    break;
                default:
                    NSLog(@"联网状态不明");
                    break;
            }
        }];
        
    }
    return self;
}

NSString *myGenerateSig(NSString *queryString)
{
    return [[NSString stringWithFormat:API_SIG, queryString] md5];
}
#pragma mark - private method
// 公共上行sig
- (NSMutableDictionary *)publicSigMethod:(NSString *)method URLString:(NSString *)URLString parameters:(NSDictionary *)parameters serializationError:(NSError *)serializationError{
    
    NSMutableURLRequest *tmpRequest = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
    
    NSDictionary *tmpParametersM = [self publicUpwardConcatenation:parameters];
    
    NSMutableDictionary *parametersM = [NSMutableDictionary dictionaryWithDictionary:tmpParametersM];
    if ([tmpRequest isKindOfClass:[NSMutableURLRequest class]]) {
        
        NSString *paramUrl = [ZHNetWorkTool getParamUrlSring:parametersM];
        
        parametersM[@"sig"] = myGenerateSig(paramUrl);
    }
    
    NSArray *tmpParamKeyArray = parametersM.allKeys;
    
    for (int i = 0; i < tmpParamKeyArray.count; ++i)
    {
        NSString *tmpKeyString = [tmpParamKeyArray objectAtIndex:i];
        
        if ([[parametersM objectForKey:tmpKeyString] isKindOfClass:[NSString class]])
        {
            NSString *tmpValueString = [parametersM objectForKey:tmpKeyString];
            
            [parametersM setObject:[tmpValueString stringByURLEncodingStringParameter] forKey:tmpKeyString];
        }
    }
    
    return parametersM;
}
// 拼接公共上行参数参数
- (NSDictionary *)publicUpwardConcatenation:(NSDictionary *)parameters{
    
    NSMutableDictionary *publicUpwardDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [publicUpwardDict setObject:@"AppStore" forKey:@"channelType"];
    [publicUpwardDict setObject:@"0" forKey:@"channelId"];
    [publicUpwardDict setObject:[ZHDeviceTool wcGetDeviceID]forKey:@"installId"];
    [publicUpwardDict setObject:[ZHDeviceTool wcPlatform] forKey:@"modelName"];
    [publicUpwardDict setObject:@"Apple" forKey:@"brand"];
    [publicUpwardDict setObject:[ZHDeviceTool wcPlatform] forKey:@"model"];
    [publicUpwardDict setObject:@"ios" forKey:@"os"];
    [publicUpwardDict setObject:[ZHDeviceTool wcSystemVersion] forKey:@"osVersion"];
    [publicUpwardDict setObject:[ZHDeviceTool wcVersion] forKey:@"clientVersion"];
    [publicUpwardDict setObject:[ZHDeviceTool wcResolutionWidth] forKey:@"screenW"];
    [publicUpwardDict setObject:[ZHDeviceTool wcResolutionHeigth] forKey:@"screenH"];
    
    //    [publicUpwardDict setObject:[self setUserID] forKey:@"userId"];
    [publicUpwardDict setObject:@"ZHKXS" forKey:@"appId"];
    [publicUpwardDict setObject:API_KEY forKey:@"api_key"];
    return publicUpwardDict.copy;
}
//- (NSString *)setUserID{
//    UserInfo *userInfo = [ZHUserManager currentUser];
//    if (userInfo.userID) {
//        return [NSString stringWithFormat:@"%ld",(unsigned long)userInfo.userID];
//    }
//    return @"0";
//}

@end
