//
//  UserInoManager.m
//  Cook
//
//  Created by lanou on 16/4/26.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "UserInofManager.h"

@implementation UserInofManager

//+ (instancetype)defaultManager {
//    static UserInofManager *manager = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        manager = [[UserInofManager alloc] init];
//    });
//    return manager;
//}

//  保存用户的Moble
+ (void)conserveUserMoble:(NSString *)userMoble {
    [[NSUserDefaults standardUserDefaults] setObject:userMoble forKey:@"userMoble"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//  获取用户的Moble
+ (NSString *)getUserMoble {
    NSString *moble = [[NSUserDefaults standardUserDefaults] objectForKey:@"userMoble"];
    if (!moble) {
        moble = @"";
    }
    return moble;
}

//保存用户的Password
+ (void)conservePassword:(NSString *)password {
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//获取用户的Password
+ (NSString *)getPassword {
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    if (!password) {
        password = @"";
    }
    return password;
}

//保存用户的id
+ (void)conserveUserID:(NSString *)userID {
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", userID] forKey:@"userID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//获取用户的id
+ (NSString *)getUserID {
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    if (!userID) {
        userID = @"";
    }
    return userID;
}

//保存用户的SessionID
+ (void)conserveSessionID:(NSString *)sessionID {
    [[NSUserDefaults standardUserDefaults] setObject:sessionID forKey:@"sessionID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//获取用户的SessionID
+ (NSString *)getSessionID {
    NSString *sessionID = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionID"];
    if (!sessionID) {
        sessionID = @"";
    }
    return sessionID;
}
//取消用户的SessionID
+ (void)cancelSessionID {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sessionID"];
}

@end
