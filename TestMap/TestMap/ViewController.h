//
//  ViewController.h
//  TestMap
//
//  Created by zm on 2016/10/31.
//  Copyright © 2016年 zmMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface ViewController : UIViewController
@property (nonatomic,strong)CLLocationManager *locationManager;
@property (nonatomic, strong) UIButton * buttton;
@property ( nonatomic, nullable) CLLocation *location;
@property (strong, nonatomic)  MKMapView *mapView;


@end

