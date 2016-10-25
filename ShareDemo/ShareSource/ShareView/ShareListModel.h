//
//  ShareListModel.h
//  EBusiness
//
//  Created by zhangshanshan on 16/5/19.
//  Copyright © 2016年 yeecolor. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <ShareSDK/ShareSDK.h>

@interface ShareListModel : NSObject

@property (nonatomic, copy)NSString * url;
@property (nonatomic, copy)NSString * content;
@property (nonatomic, copy)NSString * title;
@property (nonatomic, copy)NSString * shareImg;
@property (nonatomic, copy)NSString * defaultContent;
@property (nonatomic, copy)NSString * descriptions;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)ShareWithDict:(NSDictionary *)dict;
@end
