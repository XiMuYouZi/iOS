//
//  FetchArticleSummaryCell.h
//  Zaker
//
//  Created by Mia on 15/12/3.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FetchArticleSummaryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property (weak, nonatomic) IBOutlet UILabel *HeadLabel;
@property (weak, nonatomic) IBOutlet UILabel *SubHeadLabel;
@property (weak, nonatomic) IBOutlet UILabel *FootNoteLabel;

@end
