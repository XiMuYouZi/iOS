//
//  FetchArticleDetail.m
//  Zaker
//
//  Created by Mia on 15/11/19.
//  Copyright (c) 2015年 Mia. All rights reserved.
//
#import <ShareSDK/ShareSDK.h>

#import "FetchArticleDetail.h"

@interface FetchArticleDetail ()
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation FetchArticleDetail

-(void)viewDidLoad
{
    [self fetchArticle];
    
    
}

-(void)fetchArticle
{
    //    [self.spinner startAnimating];
    
    NSURLRequest *REQ=[NSURLRequest requestWithURL:_URL];
    [self.webview loadRequest:REQ];
    self.navigationItem.title=self.Title;
//    NSLog(@"articleDetial:%@",self.Title);
    //    [self.spinner stopAnimating];
    
}
- (IBAction)share:(UIButton *)sender
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"分享内容:%@",_URL]
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:@"这是一条测试信息"
        
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //创建iPad弹出菜单容器,详见第六步
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];

    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%ld,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
    
}

@end
