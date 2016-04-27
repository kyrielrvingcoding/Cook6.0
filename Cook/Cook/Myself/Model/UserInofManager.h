//
//  UserInoManager.h
//  Cook
//
//  Created by lanou on 16/4/26.
//  Copyright © 2016年 class17. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInofManager : NSObject


//+ (UserInofManager *)defaultManager;

//  保存用户的Moble
+ (void)conserveUserMoble:(NSString *)userMoble;
//  获取用户的Moble
+ (NSString *)getUserMoble;

//保存用户的Password
+ (void)conservePassword:(NSString *)password;
//获取用户的Password
+ (NSString *)getPassword;

//保存用户的id
+ (void)conserveUserID:(NSString *)userID;
//获取用户的id
+ (NSString *)getUserID;

//保存用户的SessionID
+ (void)conserveSessionID:(NSString *)sessionID;
//获取用户的SessionID
+ (NSString *)getSessionID;
//取消用户的SessionID
+ (void)cancelSessionID;

@end
