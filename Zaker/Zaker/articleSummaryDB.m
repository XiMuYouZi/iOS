//
//  articleSummaryDB.m
//  Zaker
//
//  Created by Mia on 15/12/30.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "articleSummaryDB.h"
#import "FMResultSet.h"

@implementation articleSummaryDB


-(void)createDB
{
    //1.获得程序沙盒的document目录的路径
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    
    NSString *fileName = [doc stringByAppendingPathComponent:@"student.sqlite"];
    NSLog(@"%@",fileName);
    
    
    //2.创建数据库
    _db = [FMDatabase databaseWithPath:fileName];
    
    //3.使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。
    if ([_db open])
    {
        //4.创表
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS Articles (id integer PRIMARY KEY ,articles text )"];
        
        
        
        if (result)
        {
            
            NSLog(@"创建表成功");
        }else
        {
            NSLog(@"创建表失败");
            
            
        }
    }
    [_db close];

    
}

-(void)inserts:(NSString *)articles
{
    
    static NSInteger id=2;
    

    id++;
    if ([_db open]) {
        FMResultSet *Resultset=[_db executeQuery:@"select * from Articles where id=?",@2];
        if (!Resultset) {
            [_db executeUpdate:@"INSERT INTO Articles (id,articles) VALUES (?,?);",@(id),articles];

        }else{
              [_db executeUpdate:@"update Articles set articles = ? where id = ?",articles,@2];
        }


    }
    [_db close];

    
}


-(void)query
{
    if ([_db open]) {
        FMResultSet *set=[_db executeQuery:@"select * from Articles where id=?",@2];
        static int i=0;
        while ([set next]) {
            i++;
            NSString *articles=[set  objectForColumnName:@"articles"];
            
//            使用json读取数据，保留数据源格式NSArray
            NSData *data=[articles dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *array=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            _allArticles=array;
        }
    }
}

@end
