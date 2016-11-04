//
//  SecondViewController.m
//  TestMap
//
//  Created by zm on 2016/11/1.
//  Copyright © 2016年 zmMac. All rights reserved.
//

#import "SecondViewController.h"
#import "CustomAnnotation.h"
@interface SecondViewController ()<UISearchBarDelegate>
@property (nonatomic, strong) MKLocalSearch * localSearch;
@property (nonatomic, strong) MKLocalSearchRequest * searchRequest;
@property (nonatomic, strong) UISearchBar * searchBar;
@property (nonatomic, strong) NSMutableArray * resultArray;
@property (nonatomic, strong) CustomAnnotation * placeAnnotation;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    latitude	double	39.946399999999997
//    longitude	double	116.47369999999999
//    latitude	double	39.913851575562767
//    longitude	double	116.45626664148602
    self.searchRequest  = [[MKLocalSearchRequest alloc] init];
    CLLocationCoordinate2D points[2];
    points[0] = CLLocationCoordinate2DMake(39.946399999999997, 116.47369999999999);
    points[1] = CLLocationCoordinate2DMake(39.913851575562767, 116.45626664148602);
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:points count:2];
    [self.mapView addOverlay:polyline];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    _searchBar.delegate = self;
    self.navigationItem.titleView = _searchBar;
    // Do any additional setup after loading the view.
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *polylineRender = [[MKPolylineRenderer alloc] initWithPolyline:(MKPolyline *)overlay];
        [polylineRender setNeedsDisplay];
        polylineRender.fillColor = [UIColor redColor];
        polylineRender.strokeColor = [UIColor redColor];
        polylineRender.lineWidth = 1.0f;
        return polylineRender;
    }
    return nil;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.mapView removeAnnotations:self.mapView.annotations];
    self.searchRequest.naturalLanguageQuery = self.searchBar.text;
    self.localSearch = [[MKLocalSearch alloc] initWithRequest:self.searchRequest];
    [self.localSearch startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        self.resultArray = [NSMutableArray arrayWithArray:response.mapItems];
//        self.annotationArray = [NSMutableArray array];
        for (MKMapItem *mapItem in self.resultArray) {
            self.placeAnnotation = [[CustomAnnotation alloc] init];
            self.placeAnnotation.coordinate = mapItem.placemark.location.coordinate;
            self.placeAnnotation.title = mapItem.name;
//            self.placeAnnotation.url = mapItem.url;
//            [self.annotationArray addObject:self.placeAnnotation];
            [self.mapView addAnnotation:self.placeAnnotation];
        }
    }];
    [self.searchBar resignFirstResponder];
    [self.resultArray removeAllObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
