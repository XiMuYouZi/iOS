//
//  Card.h
//  CardGame
//
//  Created by Mia on 15/11/3.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic,strong)NSString *contents;
@property(nonatomic)BOOL chosen;
@property(nonatomic)BOOL matched;

-(int)match:(NSArray *)otherCards;
@end
