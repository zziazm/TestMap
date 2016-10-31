//
//  ViewController.m
//  TestMap
//
//  Created by zm on 2016/10/31.
//  Copyright © 2016年 zmMac. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface ViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>
@property (strong, nonatomic)  MKMapView *mapView;

@property (nonatomic,strong)CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CLLocationManager *locationManager=[[CLLocationManager alloc]init];
    self.locationManager=locationManager;
    
    //请求授权
    [locationManager requestWhenInUseAuthorization];
    
    MKMapView * mv = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:mv];
    mv.userTrackingMode = MKUserTrackingModeFollow;
    mv.delegate = self;
    [mv setShowsUserLocation:YES];
    mv.mapType = MKMapTypeStandard;
    mv.showsTraffic=YES;
    _mapView = mv;
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView{
    
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    //创建编码对象
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    //反地理编码
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error!=nil || placemarks.count==0) {
            return ;
        }
        //获取地标
        CLPlacemark *placemark=[placemarks firstObject];
        //设置标题
        userLocation.title=placemark.locality;
        //设置子标题
        userLocation.subtitle=placemark.name;
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
