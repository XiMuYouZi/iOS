//
//  nextpage.h
//  test
//
//  Created by Mia on 16/1/19.
//  Copyright © 2016年 Mia. All rights reserved.
//


#import <UIKit/UIKit.h>

//typedef void(^data) (NSDictionary *urls);
//typedef void(^pastdata) (NSDictionary *data);

@interface nextpage : UIViewController
@property(nonatomic,strong)NSDictionary *resultData;
@property(nonatomic,strong) void(^passdata) (NSDictionary *data);

@end
