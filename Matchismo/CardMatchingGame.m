//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Mia on 15/11/4.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Card.h"
@interface CardMatchingGame()
@property(nonatomic ,readwrite)NSInteger score;
@property(nonatomic,strong)NSMutableArray *cards;
@end


@implementation CardMatchingGame


//使用惰性实例化，不像init会在程序启动就初始化，这里的初始化只会在需要cards的值的时候才会初始化
-(NSMutableArray *)cards
{
    if (!_cards) {
        _cards=[[NSMutableArray alloc]init];
        
    }
    return _cards;
}

//调用自定义的init方法，从deck中抽取数量为count的牌放到数组cards中
-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self=[super init];
    if (self) {
        for (int i=0; i<count; i++) {
            Card *card=[deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
                
            }else{
                self=nil;
                break;
                
            }
        }
    }
    return self;
}

//不许调用默认的init
-(instancetype)init
{
    return nil;
}


//让系统知道用户选择了那张牌
-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
    
}


//实现游戏的逻辑
static const int MISMATCH_PENALTY=2 ; //没有匹配，就扣除2分
static const int MATCH_BONUS=4 ; //匹配上了就把得分乘以4倍
static const int COST_TO_CHOOSE=1;   //每次翻牌都会扣除1分

-(void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card =[self cardAtIndex:index];
    
    if (!card.matched) {
        if (card.chosen) {
            card.chosen=NO;
        }else{
            for (Card *otherCard in self.cards) {
                if (otherCard.chosen && !otherCard.matched) {
                    int matchScore=[card match:@[otherCard]];
                    if (matchScore) {
                        self.score+=matchScore*MATCH_BONUS;
                        card.matched=YES;
                        otherCard.matched=YES;
                        
                    }else{
                        self.score-=MISMATCH_PENALTY;
                        otherCard.chosen=NO;
                    }
                    break;
                }
            }
        }
        self.score-=COST_TO_CHOOSE;
        card.chosen=YES;
    }
}



@end
