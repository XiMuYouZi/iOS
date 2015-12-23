//
//  MyAnnotation.h
//  1
//
//  Created by Mia on 15/12/23.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>

@property(nonatomic,readwrite)CLLocationCoordinate2D coordinate;
@property(nonatomic,copy)NSString *street;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *state;


@end
