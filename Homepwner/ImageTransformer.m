//
//  ImageTransformer.m
//  Homepwner
//
//  Created by Mia on 15/10/27.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "ImageTransformer.h"

@implementation ImageTransformer

+ (Class)transformedValueClass
{
    return [UIImage class];
}

- (id)transformedValue:(id)value
{
    if (!value) {
        return nil;
    }
    
    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }
    
    return UIImagePNGRepresentation(value);
}

- (id)reverseTransformedValue:(id)value
{
    return [UIImage imageWithData:value];
}

@end
