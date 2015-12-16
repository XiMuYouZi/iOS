//
//  ArticleComment.m
//  Zaker
//
//  Created by Mia on 15/12/11.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "ArticleComment.h"

@interface ArticleComment ()

@end

@implementation ArticleComment




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
    
    
    return cell;
}



@end
