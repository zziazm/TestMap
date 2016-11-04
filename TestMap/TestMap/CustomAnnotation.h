//
//  CustomAnnotation.h
//  TestMap
//
//  Created by zm on 2016/11/1.
//  Copyright © 2016年 zmMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface CustomAnnotation : NSObject<MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;
//标题
@property (nonatomic, copy) NSString *title;
//子标题
@property (nonatomic, copy) NSString *subtitle;
@end
