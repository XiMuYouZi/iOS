//
//  ImageStore.h
//  Homepwner
//
//  Created by Mia on 15/10/19.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageStore : NSObject
+(instancetype)shareStore;
-(void)setImage:(UIImage *)image forKey:(NSString *)key;
-(UIImage *)imageForKey:(NSString *)key;
-(void)deleteImageForKey:(NSString*)key;


@end
