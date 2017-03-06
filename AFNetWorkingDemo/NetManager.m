//
//  NetManager.m
//  AFNetWorkingDemo
//
//  Created by WJ on 17/2/23.
//  Copyright © 2017年 WJ. All rights reserved.
//

#import "NetManager.h"

#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

#define APIURL @"http://wx.meishijia.com/yichiTest/appManager/basic/post"     // 测试地址

@interface NetManager ()
@property (nonatomic, strong)AFHTTPSessionManager *manager;
@end

@implementation NetManager

+ (instancetype)share{

    static NetManager *netManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!netManager) {
            netManager = [[NetManager alloc] init];
        }
    });
    return netManager;
}

- (void)post{
    if (!self.manager) {
        self.manager = [AFHTTPSessionManager manager];
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];

    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:[USER_DEFAULT objectForKey:TENANCT_ID] forKey:@"tenancy_id"];
        [dic setObject:@"41" forKey:@"tenancy_id"];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:@"getType" forKey:@"oper"];
    [para setObject:@"move" forKey:@"type"];
    [para setObject:dic forKey:@"body"];

    [self.manager POST:APIURL parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功");
        
        // 已经是字典了
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"shibai");
    }];
}


- (void)postImage{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         
                                                         @"text/html",
                                                         
                                                         @"image/jpeg",
                                                         
                                                         @"image/png",
                                                         
                                                         @"application/octet-stream",
                                                         
                                                         @"text/json",
                                                         nil];
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://172.18.95.35:8080/yichi/fileupload/imageUpload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        UIImage *image = [UIImage imageNamed:@"1.png"];
        NSData *data = UIImagePNGRepresentation(image);
        
        //上传的参数(上传图片，以文件流的格式)
        
        [formData appendPartWithFileData:data
                                    name:@"file"
         
                                fileName:@"1.png"
                                mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"上传成功");
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"上传失败%@",error);
        
        
        
    }];
}


@end
