//
//  ShareInfoManager.m
//  USApp2.0
//
//  Created by zhangshanshan on 16/8/8.
//  Copyright © 2016年  门皓. All rights reserved.
//

#import "ShareInfoManager.h"

#import "XMNShareScrollView.h"
#import "XMNShareView.h"
#import <ShareSDK/ShareSDK.h>
#import "XMNShareMenu.h"
#import "ShareListModel.h"

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ShareInfoManager ()<ISSViewDelegate>
{
    XMNShareView        * shareView;
}

@end

@implementation ShareInfoManager


static ShareInfoManager * _instance = nil;
+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance ;
}

//分享
- (void)shareBtnDelegate{
    NSArray *shareAry = @[
                          @{kXMNShareImage:@"more_weixin",
                            kXMNShareHighlightImage:@"more_weixin_highlighted",
                            kXMNShareTitle:@"微信好友"},
                          @{kXMNShareImage:@"more_circlefriends",
                            kXMNShareHighlightImage:@"more_circlefriends_highlighted",
                            kXMNShareTitle:@"朋友圈"},
                          ];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 36)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 21, headerView.frame.size.width-32, 15)];
    label.textColor = [UIColor colorWithRed:94/255.0 green:94/255.0 blue:94/255.0 alpha:1.0];;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"分享到";
    [headerView addSubview:label];
    
    shareView = [[XMNShareView alloc] init];
    //设置头部View 如果不设置则不显示头部
    shareView.headerView = headerView;
    
    __weak ShareInfoManager * wself = self;
    [shareView setSelectedBlock:^(NSUInteger tag, NSString *title) {
        if(tag == 0){
            [[ShareInfoManager shareInstance] shareAction:ShareTypeWeixiSession];
        }else if(tag == 1){
            [[ShareInfoManager shareInstance] shareAction:ShareTypeWeixiTimeline];
        }
    }];
    
    //计算高度 根据第一行显示的数量和总数,可以确定显示一行还是两行,最多显示2行
    [shareView setupShareViewWithItems:shareAry];
    
    [shareView showUseAnimated:YES];
}


-(void)shareAction:(ShareType )type{
    //构造分享内容
    
    id<ISSContent> publishContent = [ShareSDK content:_shareModel.content
                                       defaultContent:@"来自US"
                                                image:[ShareSDK pngImageWithImage:[UIImage imageNamed:_shareModel.shareImg]]
                                                title:_shareModel.title
                                                  url:_shareModel.url
                                          description:_shareModel.descriptions
                                            mediaType:SSPublishContentMediaTypeNews
                                     ];
    //    if(type == SSCShareTypeSinaWeibo){
    //        NSString * content = @"不妨试试「US」吧？即刻前往App Store下载US，获取新鲜、趣味并具有型格的生活方式。每位精英男性面对发达的电商平台而造成的选择困境都将迎刃而解。\n 网址(分享自 @US我们科技)";
    //        publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@%@",content,_shareModel.url]
    //                            defaultContent:@"来自US"
    //                                     image:[ShareSDK pngImageWithImage:_shareModel.shareImage]
    //                                     title:_shareModel.title
    //                                       url:_shareModel.url
    //                               description:_shareModel.descriptions
    //                                 mediaType:SSPublishContentMediaTypeNews
    //                          ];
    //
    //    }
    
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:self
                                               authManagerViewDelegate:self];
    [ShareSDK shareContent:publishContent type:type
               authOptions:authOptions
             statusBarTips:true
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        
                        
                        
                        if (state == SSResponseStateSuccess)
                        {
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分享成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                
                            }];
                            [alert addAction:action];
                            [self.shareVC presentViewController:alert animated:true completion:^{
                                
                            }];
                        }
                        else if (state == SSResponseStateFail)
                        {
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分享失败" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                
                            }];
                            [alert addAction:action];
                            [self.shareVC presentViewController:alert animated:true completion:^{
                                
                            }];
                        }
                        [shareView dismissUseAnimated:true];
                    }];
}


-(void)setShareModel:(ShareListModel *)shareModel
{
    _shareModel = shareModel;
    if ([shareModel.url isEqualToString:@""]) {
        _shareModel.url = @"http://www.us-app.com/";
    }
    if ([shareModel.content isEqualToString:@""]) {
        _shareModel.content = @"还在种类繁多的电商平台里大海捞针？不如下载US APP，凭借对同志人群生活方式、购物理念的独到理解，US将为你带来更优质、更私密、更便捷的的全新购物体验。";
    }
    if ([shareModel.title isEqualToString:@""]) {
        _shareModel.title = @"世上怎会有这种东西?!";
    }
    
    if ([shareModel.descriptions isEqualToString:@""]) {
        _shareModel.descriptions = @"还在种类繁多的电商平台里大海捞针？不如下载US APP，凭借对同志人群生活方式、购物理念的独到理解，US将为你带来更优质、更私密、更便捷的的全新购物体验。";
    }
    
    if ([shareModel.shareImg isEqual:[NSNull null]]) {
        _shareModel.shareImg  = @"bg_head";
    }
}

-(void)setShareVC:(UIViewController *)shareVC
{
    _shareVC = shareVC;
}

@end
