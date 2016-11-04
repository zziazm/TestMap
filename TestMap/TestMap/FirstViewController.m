//
//  FirstViewController.m
//  TestMap
//
//  Created by zm on 2016/11/1.
//  Copyright © 2016年 zmMac. All rights reserved.
//

#import "FirstViewController.h"
#import <MapKit/MapKit.h>
#import "CustomAnnotation.h"
@interface FirstViewController ()

@end

@implementation FirstViewController
- (void)latitude:(double)latitude longitude:(double)longitude completion:(void(^)(NSString*title, NSString * subtitle))completion{
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error==nil && placemarks.count==0) {
            NSLog(@"错误信息:%@",error);
            completion(nil, nil);
            return;
        }
        //获取地标信息
        CLPlacemark *placemark=[placemarks firstObject];
        //获取父标题名称
        NSString * title=placemark.locality;
        //获取子标题名称
        NSString * subtitle=placemark.name;
        completion(title, subtitle);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        //将具体的位置转换为经纬度
    CLLocationCoordinate2D coordinate= CLLocationCoordinate2DMake(39.9464, 116.4737);//[self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    
    //添加大头针
    CustomAnnotation *annotation=[[CustomAnnotation  alloc]init];
    annotation.coordinate=coordinate;
    [self latitude:coordinate.latitude longitude:coordinate.longitude completion:^(NSString *title, NSString *subtitle) {
        annotation.title=title;
        //获取子标题名称
        annotation.subtitle=subtitle;
        //添加大头针到地图
        [self.mapView addAnnotation:annotation];
    }];
//    //反地理编码
//    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
//    CLLocation *location=[[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
//    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        if (error==nil && placemarks.count==0) {
//            NSLog(@"错误信息:%@",error);
//            return ;
//        }
//        //获取地标信息
//        CLPlacemark *placemark=[placemarks firstObject];
//        //获取父标题名称
//        annotation.title=placemark.locality;
//        //获取子标题名称
//        annotation.subtitle=placemark.name;
//        
//        //添加大头针到地图
//        [self.mapView addAnnotation:annotation];
//    }];

    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //latitude	CLLocationDegrees	39.946435813015256
    //longitude	CLLocationDegrees	116.47372929869215
    //获取用户点击的位置
//    CGPoint point=[[touches anyObject]locationInView:self.mapView];
//    //将具体的位置转换为经纬度
//    CLLocationCoordinate2D coordinate=[self.mapView convertPoint:point toCoordinateFromView:self.mapView];
//    
//    //添加大头针
//    CustomAnnotation *annotation=[[CustomAnnotation  alloc]init];
//    annotation.coordinate=coordinate;
//
//    //反地理编码
//    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
//    CLLocation *location=[[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
//    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        if (error==nil && placemarks.count==0) {
//            NSLog(@"错误信息:%@",error);
//            return ;
//        }
//        //获取地标信息
//        CLPlacemark *placemark=[placemarks firstObject];
//        //获取父标题名称
//        annotation.title=placemark.locality;
//        //获取子标题名称
//        annotation.subtitle=placemark.name;
//        
//        //添加大头针到地图
//        [self.mapView addAnnotation:annotation];
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- MKMapViewDelegate

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]]){
        MKUserLocation *a = annotation;
        NSLog(@"%f %f %@ %@",a.coordinate.latitude, a.coordinate.longitude, a.title, a.subtitle);
        [self latitude:a.coordinate.latitude longitude:a.coordinate.longitude completion:^(NSString *title, NSString *subtitle) {
            a.title=title;
            //获取子标题名称
            a.subtitle=subtitle;
            //添加大头针到地图
//            [self.mapView addAnnotation:annotation];
        }];

        return nil;

    }else{
        MKPinAnnotationView *pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView)
        {
            // 没有可以复用的View，新建一个。
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            pinView.pinColor = MKPinAnnotationColorRed;
            pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            // 如果有的话，可以通过设置accessoryView定义callout。
        }
        else{
            pinView.annotation = annotation;
            [pinView setSelected:YES];

        }
        return pinView;
    }
    
    
//    NSString * viewId = @"id";
//    MKAnnotationView * annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:viewId];
//    if (annotationView == nil) {
//        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:viewId];
//    }
//    
//    annotationView.backgroundColor = [UIColor blueColor];
//    annotationView.frame = CGRectMake(0, 0, 15, 15);
//    annotationView.image = [UIImage imageNamed:@"6330492_94.jpg"];
//    annotationView.canShowCallout = YES;
//    UIButton *button = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
//    [button setBackgroundColor:[UIColor redColor]];
//    button.layer.cornerRadius = 5;
//    annotationView.leftCalloutAccessoryView = button;
//    
//    UIButton *button1 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
//    [button1 setBackgroundColor:[UIColor redColor]];
//    button1.layer.cornerRadius = 5;
//    annotationView.rightCalloutAccessoryView = button1;
    
    
//    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
//    [button2 setBackgroundColor:[UIColor redColor]];
//    button2.layer.cornerRadius = 5;
    
//    annotationView.detailCalloutAccessoryView = button2;
    
    
//    return annotationView;


}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
