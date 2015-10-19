//
//  BNRItem.m
//  RandomItems
//
//  Created by Mia on 15/9/15.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem


-(NSString* )description
{
    NSString *descraptionString=
    [[NSString alloc] initWithFormat:@"%@ (%@):Worth: $%d, record on %@",
     self.itemName,
     self.serialNumber,
     self.valueInDollars,
     self.dateCreate];
    return descraptionString;
}

/*----------------------------------*/


-(instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber
{
    //调用父类的指定初始化方法，把初始化的结果赋值给self,比如一些变量的初始化
    self=[super init];
    
    //父类的指定初始化方法的返回值如果不是nil，就执行if下面的语句
    if(self){
        _itemName=name;
        _serialNumber=sNumber;
        _valueInDollars=value;
        _dateCreate=[[NSDate alloc]init];
    }
    
    /*
     上面一段话的意思如下：
     首先需要明确在初始化的时候我们不仅要初始化子类，还要初始化父类
     这个语句完成了两项任务
     1、确认是否可以父类初始化
     2、如果可以父类初始化，则进行初始化并赋值给子类，并执行if 语句里面的内容
     */
    return self;
}

/*----------------------------------*/


-(instancetype)initWithItemName:(NSString *)name
{
    //直接调用上一个初始化方法，但是只传入一个参数name，其他的参数是固定值
    return [self initWithItemName:name valueInDollars:0 serialNumber:@" "];
}


/*----------------------------------*/
-(instancetype)init
{
    return [self initWithItemName:@"item"];
}


/*----------------------------------*/

+(instancetype) randonItem
{
    NSArray *randomAdjectList=@[@"fluffy",@"rusty",@"shiny",@"ws"];
    NSArray *randomNounList=@[@"bear",@"spork",@"mac"];
    NSInteger adjectiveIndex=arc4random()%[randomAdjectList count];
    NSInteger nonIndex=arc4random()%[randomNounList count];
    NSString *randomName=[NSString stringWithFormat:@"%@ %@",
                          randomAdjectList[adjectiveIndex],
                          randomNounList [nonIndex]];
    
    int randomVaule =arc4random()%100;
    NSString *randomSerialNumber =[NSString stringWithFormat:@"%c%c%c%c",
                                   '0'+arc4random()%10,
                                   'A'+arc4random()%26,
                                   '0'+arc4random()%10,
                                   'A'+arc4random()%26,
                                   '0'+arc4random()%10];
    
    BNRItem *newItem=[[self alloc] initWithItemName:randomName valueInDollars:randomVaule serialNumber:randomSerialNumber];
    return newItem;
    
}


/*----------------------------------*/

-(void)dealloc
{
    NSLog(@"destoryed:%@",self);
}

/*----------------------------------*/

/*

-(void) setItemName:(NSString *)str
{
    _itemName=str;
}

-(NSString*)itemName
{
    return _itemName;
}


-(void)setSerialNumber:(NSString *)str
{
    _serialNumber=str;
}

-(NSString*)serialNumber
{
    return _serialNumber;

}



-(void)setValueInDollars:(int)v
{
    _valueInDollars=v;
}

-(int)valueInDollars
{
    return _valueInDollars;
}



-(NSDate*)dateCreated
{
    return _dateCreate;
}
*/

@end
