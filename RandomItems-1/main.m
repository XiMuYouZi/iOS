//
//  main.m
//  RandomItems
//
//  Created by Mia on 15/9/15.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool{
        NSMutableArray *items= [[NSMutableArray alloc]init];
        
        [items addObject:@"one"];
        [items addObject:@"two"];
        [items addObject:@"three"];
        
        [items insertObject:@"zero" atIndex:0];
        
       /* for (int i=0; i<[items count]; i++) {
            NSString * item=[items objectAtIndex:i];
            NSLog(@"%@", item); */
        
        for (NSString *item in items) {
            NSLog(@"%@",item);
        
        }
        //BNRItem *item=[[BNRItem alloc]init];
        //[item setItemName:@"red sofa"];
        //[item setSerialNumber:@"A1B2C"];
        //[item setValueInDollars:100];
        //item.itemName=@"green tea";
        //item.serialNumber=@"W21DD";
        //item.valueInDollars=122;
       // NSLog(@"%@,%@,%@,%d",[item itemName],[item dateCreated],[item serialNumber],[item valueInDollars]);
        
        /*BNRItem *item=[[BNRItem alloc]initWithItemName:@"red coffee" valueInDollars:1000 serialNumber:@"AD232"];
        NSLog(@"%@",item);
        
        BNRItem *itemwithname=[[BNRItem alloc]initWithItemName:@"balck tea"];
        NSLog(@"%@",itemwithname);
        
        BNRItem *itemWithNoName=[[BNRItem alloc]init];
        NSLog(@"%@,(%@),Worth:%d,record on:%@",[itemWithNoName itemName],[itemWithNoName serialNumber],[itemWithNoName  valueInDollars],[itemWithNoName dateCreated]);*/
        for (int i=0; i<10; i++) {
            BNRItem *item =[BNRItem randonItem];
            [items addObject:item];
        }
        
        for (BNRItem *item in items) {
            NSLog(@"%@", item);
        }
        items=nil;
        
      
    }
    return 0;
}
