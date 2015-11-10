//
//  ViewController.m
//  Matchismo
//
//  Created by Mia on 15/11/4.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
//按钮数组，容纳所有的12个按钮
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property(nonatomic)int flipCount;
@property(nonatomic,strong)Deck *deck;
@property(nonatomic,strong)CardMatchingGame *game;
@end

@implementation ViewController

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
}

//惰性初始化
-(CardMatchingGame *)game
{
    if (!_game) _game=[[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count]
                                                       usingDeck:[self createDeck]];
    return _game;
    
}

-(Deck *)createDeck
{
    return[[PlayingCardDeck alloc]init];
    
}

//只要连接一个按钮即可，其他按钮都会连接到这个方法
- (IBAction)touchCardButton:(id)sender {
    //sender代表被点击的按钮，下面的代码表示获取点击的是哪个按钮
    NSUInteger cardIndex=[self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
    
}


//每次选择完毕都要更新界面的扑克牌的状态，比如匹配的扑克牌必须不能再被选择,扑克牌被选择就显示正面的内容，没被选中就显示背面
-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons ) {
        NSUInteger cardIndex=[self.cardButtons indexOfObject: cardButton];
        Card * card= [self.game cardAtIndex:cardIndex];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        cardButton.enabled=!card.matched;
    }
    self.scoreLabel.text=[NSString stringWithFormat:@"Scores:%ld",(long)self.game.score];
}

-(NSString *)titleForCard:(Card *)card
{
    return card.chosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard:(Card*)card
{
    return [UIImage imageNamed:card.chosen ? @"cardfront":@"cardback"];
}


@end
