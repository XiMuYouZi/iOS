//
//  articleSummaryDB.h
//  Zaker
//
//  Created by Mia on 15/12/30.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface articleSummaryDB : NSObject
@property (strong,nonatomic)FMDatabase *db;
@property(strong ,nonatomic)NSArray *allArticles;

-(void)createDB;
-(void)inserts:(NSArray *)articles;
-(void)query;

@end
