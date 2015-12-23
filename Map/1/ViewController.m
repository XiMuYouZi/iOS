//
//  ViewController.m
//  1
//
//  Created by Mia on 15/12/19.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "ViewController.h"
#import "sqlite3.h"
#import <CoreLocation/CoreLocation.h>
#import  <AddressBook/AddressBook.h>
#import  <MapKit/MapKit.h>
#import  "MyAnnotation.h"

@interface ViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
@property(nonatomic,strong)CLLocationManager *locationManager;
@property(nonatomic,strong)CLLocation *currLocation;
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager=[[CLLocationManager alloc]init];
    self.locationManager.delegate=self;
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
    self.locationManager.distanceFilter=1000;
    
    
    
    //定义地图显示的样式
    self.map.mapType=MKMapTypeStandard;
    self.map.delegate=self;
    
//    跟踪用户的位置和方向变化
    self.locationManager =[[CLLocationManager alloc]init];
    [self.map setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
    
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:39.6 longitude:116.39];
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:30.3 longitude:120.2];
    
    // 计算距离
    CLLocationDistance distance = [location1 distanceFromLocation:location2]/1000;
    NSLog(@"北京距离上海：%.2f千米", distance);
    
    
    

}
-(void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    NSLog(@"error：%@",error);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.locationManager stopUpdatingLocation];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.locationManager startUpdatingLocation];

}


//定义大头针的样式
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *annotationview=(MKPinAnnotationView *)[self.map dequeueReusableAnnotationViewWithIdentifier:@"pin_anntation"];
    
    if (annotationview==nil) {
        annotationview=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pin_anntation"];
    }
//    点击大头针出来一个气泡
    annotationview.canShowCallout=YES;
    //设置颜色
    annotationview.pinColor=MKPinAnnotationColorGreen;
    //设置第一次出现从天而降
    annotationview.animatesDrop=YES;
    
    return annotationview;
}



- (IBAction)getCityInfo:(id)sender {
    
    if (self.textField.text==nil || [self.textField.text length]==0) {
        return;
    }
    
    CLCircularRegion *region=[[CLCircularRegion alloc]initWithCenter:_currLocation.coordinate radius:100000.0 identifier:@"GCregion"];
    
    CLGeocoder *gecoder=[[CLGeocoder alloc]init];
    [gecoder geocodeAddressString:self.textField.text   inRegion:region completionHandler:^(NSArray *placemarks, NSError *error) {
        static  int i=0;
        if ([placemarks count]>0) {
            for (CLPlacemark *placemark in placemarks) {
                i++;
                
                //根据textfield里面的地理位置显示经纬度
                NSString *country=placemark.country;
                NSString *administ=placemark.administrativeArea;
                NSString *locality=placemark.locality;
                NSString *sublocality=placemark.subLocality;
                NSString *throughfare=placemark.thoroughfare;
                NSString *subthroighfare=placemark.subThoroughfare;
                CLLocationCoordinate2D coordinate=placemark.location.coordinate;
                NSLog(@"\n ~~~~第%d个城市~~~~~ \n%@ \n%@ \n%@ \n%@ \n%@ \n%@ \n经度：%3.5f \n纬度：%3.5f",i,country,administ,locality,sublocality,throughfare,subthroighfare,coordinate.latitude,coordinate.longitude);
                
//                计算两个地点的距离
                CLLocation *location1=placemark.location;
                CLLocation *location2 = [[CLLocation alloc] initWithLatitude:30.3 longitude:120.2];
                CLLocationDistance distance = [location1 distanceFromLocation:location2]/1000;
                NSLog(@"%@距离上海：%.2f千米",self.textField.text, distance);
                
                
                //根据textfield里面的地理位置在地图上显示大头针
                MKCoordinateRegion viewRegion=MKCoordinateRegionMakeWithDistance(placemark.location.coordinate,1000,1000);
                [self.map setRegion:viewRegion animated:YES];
                MyAnnotation *annotation=[[MyAnnotation alloc]init];
                annotation.street=throughfare;
                annotation.state=country;
                annotation.city=locality;
                annotation.coordinate=placemark.location.coordinate;
                [self.map addAnnotation:annotation];
                
//                调用apple地图导航
                NSMutableArray *array=[NSMutableArray array];
                for (CLPlacemark *placemark in placemarks)
               {
                CLLocationCoordinate2D coordinates=placemark.location.coordinate;
                NSDictionary *address=placemark.addressDictionary;
                MKPlacemark *place=[[MKPlacemark alloc]initWithCoordinate:coordinates addressDictionary:address];
                MKMapItem *mapItem=[[MKMapItem alloc]initWithPlacemark:place];
                [array addObject:mapItem];
                }
                
                NSDictionary *option=[[NSDictionary alloc]initWithObjectsAndKeys:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsDirectionsModeKey,MKMapTypeStandard,MKLaunchOptionsMapTypeKey,MKLaunchOptionsShowsTrafficKey, nil];
                if (array.count>0) {
//                    NSLog(@"%f",placemark.location distanceFromLocation:array[0]]);
                    [MKMapItem openMapsWithItems:array launchOptions:option];
                }
                
                
            }
            
            
            [self.textField resignFirstResponder];
            
        }
    }];
}



-(void)getLocations
    {

        // 根据经纬度显示地理位置信息
        CLGeocoder *gecoder =[[CLGeocoder alloc ]init];
        [gecoder reverseGeocodeLocation:_currLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            if ([placemarks count]>0) {
//                NSDictionary *addressDictonary=placemark.addressDictionary;
//                
//                NSString *street=[addressDictonary objectForKey:(NSString *)kABPersonAddressStreetKey];
//                street =((street==nil)?@"":street);
//                
//                NSString *state=[addressDictonary objectForKey:(NSString *)kABPersonAddressStateKey];
//                state =((state==nil)?@"":state);
//
//                NSString *city=[addressDictonary objectForKey:(NSString *)kABPersonAddressCityKey];
//                city =((city==nil)?@"":city);
                CLPlacemark *placemark =placemarks[0];
                    

//                    获取地理信息反编码
                    NSString *iso=placemark.ISOcountryCode;
                    NSString *country=placemark.country;
                    NSString *postalCode=placemark.postalCode;
                    NSString *administ=placemark.administrativeArea;
                    NSString *subadminist=placemark.subAdministrativeArea;
                    NSString *locality=placemark.locality;
                    NSString *sublocality=placemark.subLocality;
                    NSString *throughfare=placemark.thoroughfare;
                    NSString *subthroighfare=placemark.subThoroughfare;
                    NSLog(@"%@%@%@%@%@%@%@%@%@",iso,country,postalCode,administ,subadminist,locality,sublocality,throughfare,subthroighfare);
                    
                    //根据经纬度在地图上显示大头针
                    MKCoordinateRegion viewRegion=MKCoordinateRegionMakeWithDistance(placemark.location.coordinate,1000,1000);
                    [self.map setRegion:viewRegion animated:YES];
                    MyAnnotation *annotation=[[MyAnnotation alloc]init];
                    annotation.street=throughfare;
                    annotation.state=country;
                    annotation.city=locality;
                    annotation.coordinate=placemark.location.coordinate;
                    [self.map addAnnotation:annotation];

                    
                
                


                
                
            }
        }];
        
    }
    





//位置变化后更新
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
//    _currLocation=[[CLLocation alloc]initWithLatitude:23.1266360 longitude:113.3170350];
    _currLocation=[locations lastObject];
    NSLog(@"当前经度：%f  当前经度：%f 当前高度：%f",_currLocation.coordinate.latitude, _currLocation.coordinate.longitude,_currLocation.altitude);
    [self getLocations];


}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位出错：%@",error);
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"始终授权");
            
            break;

            
            case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"使用时才授权");
            
            break;

          case kCLAuthorizationStatusDenied:
            NSLog(@"拒绝授权");
            
            break;

          case kCLAuthorizationStatusRestricted:
            NSLog(@"限制授权");
            
            
            break;

        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"无法确定是否授权");
            [self.locationManager requestAlwaysAuthorization];

            
            break;


            
    
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
