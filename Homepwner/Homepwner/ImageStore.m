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
-(NSString *)imagePathForKey:(NSString *)key;

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

//建立永久存储照片的路径
-(NSString*)imagePathForKey:(NSString *)key
{
    NSArray *documentDirectories=
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory=[documentDirectories firstObject];
    return [documentDirectory stringByAppendingString:key];
}

//永久存储照片
-(void)setImage:(UIImage *)image forKey:(NSString *)key
{
    //[self.dictionary setObject:image forKey:key];
    self.dictionary[key]=image;
    NSString *imagePath=[self imagePathForKey:key];
//    从图片中提取jpeg的二进制数据，不压缩
    NSData *data=UIImageJPEGRepresentation(image, 1);
//    把JPEG数据写入路径中保存
    [data writeToFile:imagePath atomically:YES];
}



//返回照片
-(UIImage *)imageForKey:(NSString *)key
{
//    先从程序的ImageStore的dictionary中获取照片,也就是缓存中
    UIImage *result=self.dictionary[key];
    
//    如果无法获取，就从永久路径中获取
    if (!result) {
        NSString *imagePath=[self imagePathForKey:key];
        result=[UIImage imageWithContentsOfFile:imagePath];
//        从永久路径中获取照片后放入缓存中
        if (result) {
            self.dictionary[key]=result;
        }else{
            NSLog(@"ERROR:unable to find %@",[self imagePathForKey:key]);
        }
    }
    return  result;
}


//删除照片
-(void)deleteImageForKey:(NSString *)key
{
    if (!key) {
        return;
    }
    
    [self.dictionary removeObjectForKey:key];
//    从永久存储中移除image
    NSString * imagePath=[self imagePathForKey:key];
    [[NSFileManager defaultManager]removeItemAtPath:imagePath error:nil];
}

@end
