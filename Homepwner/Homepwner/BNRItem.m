//
//  BNRItem.m
//  RandomItems
//
//  Created by Mia on 15/9/15.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "BNRItem.h"


@implementation BNRItem


//根据用户选择的图片创建缩略图，然后赋给tableviewcell的imageview
-(void)setThumbnailFromImage:(UIImage *)image
{
    CGSize origImageSize=image.size;
    
//    缩略图大小
    CGRect newRect=CGRectMake(0, 0, 40, 40);
    
//    确定放大倍数并保持宽高比不变
    float ratio=MAX(newRect.size.width/origImageSize.width, newRect.size.height/origImageSize.height);
    
//    根据当前设备的屏幕scaling factor创建透明图形上下文
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    
//    创建圆角矩形
    UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    
//    根据圆角矩形裁剪上下文
    [path addClip];
    
//    让图片在缩略图中居中显示
    CGRect projectRect;
    projectRect.size.width=ratio*origImageSize.width;
    projectRect.size.height=ratio*origImageSize.height;
    projectRect.origin.x=(newRect.size.width-projectRect.size.width)/2.0;
    projectRect.origin.y=(newRect.size.height-projectRect.size.height)/2.0;
    
//    在上下文中绘制图片
    [image drawInRect:projectRect];
    
//    通过图形上下文得到UIImage对象，并赋给thumbnail属性
    UIImage *smallImage=UIGraphicsGetImageFromCurrentImageContext();
    self.thumbnail=smallImage;
    
//    清理上下文
    UIGraphicsEndImageContext();

}

//实现nscoding协议的保存方法
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.itemName forKey:@"itemName"];
    [aCoder encodeObject:self.serialNumber forKey:@"serialNumber"];
    [aCoder encodeObject:self.dateCreate forKey:@"dateCreate"];
    [aCoder encodeObject:self.itemKey forKey:@"itemKey"];
    [aCoder encodeInt:self.valueInDollars forKey:@"vauleInDollars"];
    [aCoder encodeObject:self.thumbnail forKey:@"thumbnail"];
    
}


//实现nscoding协议的读取方法
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self=[super init];
    if (self) {
        _itemName=[aDecoder decodeObjectForKey:@"itemName"];
        _serialNumber=[aDecoder decodeObjectForKey:@"serialNumber"];
        _dateCreate=[aDecoder decodeObjectForKey:@"dateCreate"];
        _itemKey=[aDecoder decodeObjectForKey:@"itemKey"];
        _valueInDollars=[aDecoder decodeIntForKey:@"vauleInDollars"];
        _thumbnail=[aDecoder decodeObjectForKey:@"thumbnail"];
    }
    return self;
}


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
        
        //创建一个唯一的NSUUID对象，作为照片的键值
        NSUUID *uuid =[[NSUUID alloc]init];
        NSString *key=[uuid UUIDString];
        _itemKey =key;
    }
    
    /*上面一段话的意思如下：
     首先需要明确在初始化的时候我们不仅要初始化子类，还要初始化父类这个语句完成了两项任务
     1、确认是否可以父类初始化
     2、如果可以父类初始化，则进行初始化并赋值给子类，并执行if 语句里面的内容*/
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


//定义一个随机数组的类方法

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
                                   'A'+arc4random()%26];
    
    BNRItem *newItem=[[self alloc] initWithItemName:randomName valueInDollars:randomVaule serialNumber:randomSerialNumber];
    return newItem;
    
}


/*----------------------------------*/

-(void)dealloc
{
    NSLog(@"destoryed:%@",self);
}

/*----------------------------------*/



@end
