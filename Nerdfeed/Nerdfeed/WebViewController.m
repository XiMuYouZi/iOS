//
//  WebViewController.m
//  
//
//  Created by Mia on 15/10/27.
//
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

-(void)loadView
{
    UIWebView *webview=[[UIWebView alloc]init];
    webview.scalesPageToFit=YES;
    self.view=webview;
}


-(void)setURL:(NSURL *)URL
{
    _URL=URL;
    if (_URL) {
        NSURLRequest *req=[NSURLRequest requestWithURL:_URL];
        [(UIWebView *)self.view loadRequest:req];
    }
}

//竖屏默认不会显示课程列表，可以添加一个按钮，点击该按钮就会用UIPopoverController的形式显示课程列表
-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
//    设置按钮的标题
    barButtonItem.title=@"BNR Courses";
//    把按钮添加到导航栏的左侧
    self.navigationItem.leftBarButtonItem=barButtonItem;
}



//横屏的时候移除该按钮
-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
     self.navigationItem.leftBarButtonItem=nil;
}
@end
