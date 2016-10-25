//
//  ShareListModel.m
//  EBusiness
//
//  Created by zhangshanshan on 16/5/19.
//  Copyright © 2016年 yeecolor. All rights reserved.
//

#import "ShareListModel.h"

@implementation ShareListModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)ShareWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
