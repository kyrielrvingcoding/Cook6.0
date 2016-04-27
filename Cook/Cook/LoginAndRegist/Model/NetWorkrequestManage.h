//
//  NetWorkrequestManage.h
//  Leisure
//
//  Created by 左建军 on 16/3/29.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

//  定义枚举，用来标识请求的方式
typedef NS_ENUM(NSInteger, requestType) {
    GET,
    POST
};

typedef void (^RequestFinish)(NSData *data);
typedef void (^RequestError)(NSError *error);

@interface NetWorkrequestManage : NSObject


+(void)requestWithType:(requestType)type url:(NSString *)urlString parameters:(NSDictionary *)parDic finish:(RequestFinish)requestFinish error:(RequestError)requestError;

@end
