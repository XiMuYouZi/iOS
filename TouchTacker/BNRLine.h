//
//  BNRLine.h
//  TouchTacker
//
//  Created by Mia on 15/10/20.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface BNRLine : NSObject
@property(nonatomic) CGPoint Begin;
@property(nonatomic) CGPoint End;
@property(nonatomic,strong)NSMutableArray * containingArray;



@end
