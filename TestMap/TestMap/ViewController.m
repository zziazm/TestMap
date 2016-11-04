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
    
    _buttton = [UIButton buttonWithType:UIButtonTypeSystem];
    _buttton.frame = CGRectMake(100, 64, 60, 30);
    [_buttton setTitle:@"放大" forState:UIControlStateNormal];
    [self.view addSubview:_buttton];
    [_buttton addTarget:self action:@selector(max:) forControlEvents:UIControlEventTouchDown];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView{
    
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
}

- (void)max:(id)sender {
    
    //获取维度跨度并缩小一倍
    CGFloat latitudeDelta = self.mapView.region.span.latitudeDelta * 0.5;
    //获取经度跨度并缩小一倍
    CGFloat longitudeDelta = self.mapView.region.span.longitudeDelta * 0.5;
    //经纬度跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
    //设置当前区域
    MKCoordinateRegion region = MKCoordinateRegionMake(self.mapView.centerCoordinate, span);
    
    [self.mapView setRegion:region animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
