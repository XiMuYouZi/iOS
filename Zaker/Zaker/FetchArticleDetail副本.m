//
//  FetchArticleDetail.m
//  Zaker
//
//  Created by Mia on 15/11/18.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "FetchArticleDetail.h"

@interface FetchArticleDetail ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (weak, nonatomic) IBOutlet UIWebView *webview;
@end

@implementation FetchArticleDetail


-(void)viewDidLoad
{
    [self fetchArticle];
     [self.spinner stopAnimating];


}

-(void)fetchArticle
{
//    [self.spinner startAnimating];

    NSURLRequest *REQ=[NSURLRequest requestWithURL:_URL];
    [self.webview loadRequest:REQ];
//    [self.spinner stopAnimating];

}

//-(void)setURL:(NSURL *)URL
//{
//    [self.spinner startAnimating];
//
//    _URL=URL;
//
//    if (_URL) {
//        NSURLRequest *REQ=[NSURLRequest requestWithURL:_URL];
//        [self.webview loadRequest:REQ];
//        [self.spinner stopAnimating];
//
//        NSLog(@"%@",_URL);
//
//    }
//    }

@end
