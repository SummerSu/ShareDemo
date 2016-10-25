//
//  XSDKRegister.m
//  EBusiness
//
//  Created by xlx on 16/4/7.
//  Copyright © 2016年 yeecolor. All rights reserved.
//

#import "XSDKRegister.h"
#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"

#define RegisterAppKey @"167760b0596e5"
#define WXAppId @"wx162b31804e04a141"
#define WXAppSecret @"4791e3ede549087797a2cea44d9d01de"


@implementation XSDKRegister

+(void)XSDKRegisterShareSDK{
    [ShareSDK registerApp:RegisterAppKey];
    [ShareSDK connectWeChatWithAppId:WXAppId
                           appSecret:WXAppSecret
                           wechatCls:[WXApi class]];
}

@end
