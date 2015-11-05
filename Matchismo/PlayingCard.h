//
//  PlayingCard.h
//  CardGame
//
//  Created by Mia on 15/11/3.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card  //父类是Card
@property(strong,nonatomic)NSString *suit; //定义扑克牌花色
@property(nonatomic)NSUInteger rank; //定义扑克牌大小

+(NSArray*) validSuits;
+(NSUInteger)maxRank;
@end
