//
//  ImageStore.m
//  Homepwner
//
//  Created by Mia on 15/10/19.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "ImageStore.h"

@interface ImageStore ()
@property (nonatomic,strong)NSMutableDictionary *dictionary;

@end

@implementation ImageStore

+(instancetype)shareStore
{
    static ImageStore *sharedStore=nil;
    if (!sharedStore) {
        sharedStore=[[self alloc]initPrivate];
    }
    return sharedStore;
}

-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[ImageStore shareStore" userInfo:nil];
    return nil;
}


-(instancetype)initPrivate
{
    self=[super init];
    if (self) {
        _dictionary=[[NSMutableDictionary alloc]init];
    }
    return self;
}



//存储照片
-(void)setImage:(UIImage *)image forKey:(NSString *)key
{
    //[self.dictionary setObject:image forKey:key];
    self.dictionary[key]=image;
}



//返回照片
-(UIImage *)imageForKey:(NSString *)key
{
    return [self.dictionary objectForKey:key];
}


//删除照片
-(void)deleteImageForKey:(NSString *)key
{
    if (!key) {
        return;
    }
    
    [self.dictionary removeObjectForKey:key];
}

@end
