//
//  FetchArticleDetail.m
//  Zaker
//
//  Created by Mia on 15/11/19.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

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
    NSLog(@"%@",self.navigationController.navigationItem.title);
    //    [self.spinner stopAnimating];
    
}

@end
