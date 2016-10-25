//
//  ShareInfoManager.h
//  USApp2.0
//
//  Created by zhangshanshan on 16/8/8.
//  Copyright © 2016年  门皓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ShareListModel;
/**
 *  分享类型
 */
typedef NS_ENUM(NSUInteger, CustomShareType) {
    /**
     *  分享收藏
     */
    CustomShareTypeWithMineCollection = 1,
    /**
     * 活动分享
     */
    CustomShareTypeWithMerchantInfo,
   
};

@interface ShareInfoManager : NSObject
@property (nonatomic, strong) ShareListModel * shareModel;
@property (nonatomic, strong) UIViewController * shareVC;
//- (void)shareWithType:(CustomShareType)type  andViewController:(UIViewController *)viewController;

+(instancetype)shareInstance;
- (void)shareBtnDelegate;

@end
