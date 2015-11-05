//
//  PlayingCard.m
//  CardGame
//
//  Created by Mia on 15/11/3.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard



//定义扑克牌的内容是花色加上大小
-(NSString *)contents
{
//   调用类方法生成大小
    NSArray *rankStrings=[PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}




//因为下面同时设置了suit的setter和getter，所以必须申明
@synthesize suit=_suit;

-(NSString *)suits
{
//    如果suits没有值就返回？，如果有值，就返回suits本身
    return _suit ? _suit:@"?";
}

//重写suits的设值方法，保证花色只能设置为规定的四种
-(void)setSuit:(NSString *)suit
{
//    把suit作为参数和前面的花色数组里面字符比较，如果相同就返回_suit,否则就不返回任何值
    if ([@[@"♠",@"♥",@"♦",@"♣"] containsObject:suit]) {
        _suit=suit;
        
    }
}




//下面定义了两个类方法，用来生成牌 的大小和花色对象
+(NSArray *)validSuits
{
    return @[@"♠",@"♥",@"♦",@"♣"] ;
}

+(NSArray * )rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}




+(NSUInteger)maxRank
{
    return [[self rankStrings]count]-1;
}


//覆盖属性rank的getter，保证rank不会大于13
-(void)setRank:(NSUInteger)rank
{
    if (rank<=[PlayingCard maxRank]) {
        _rank=rank;
    }
}



@end
