//
//  BNRItem.h
//  Homepwner
//
//  Created by Mia on 15/10/27.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>


@interface BNRItem : NSManagedObject

@property (nonatomic, retain) NSString * itemName;
@property (nonatomic, retain) NSString * serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSString * itemKey;
@property (nonatomic, retain) UIImage * thumbnail;
@property (nonatomic) double orderingValue;

@property (nonatomic, retain) NSManagedObject *assetType;

- (void)setThumbnailFromImage:(UIImage *)image;

@end