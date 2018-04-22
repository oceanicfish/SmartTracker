//
//  TKOMapView.h
//  Trakio
//
//  Created by yang wei on 03/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TKOSystem.h"
#import "TKOEmployee.h"
#import "TKOLocation.h"

@interface TKOMapView : UIView <CLLocationManagerDelegate, MKMapViewDelegate>

@property(nonatomic, strong)CLLocationManager * locationManager;
@property(nonatomic, strong)MKMapView * map;
@property(nonatomic, strong)NSDictionary * mylocations;
@property(nonatomic, strong)UIView * topMargin;
@property(nonatomic, strong)TKOEmployee * employee;

-(id)initWithEmployee:(TKOEmployee *)emp;
-(id)initWithLocations:(NSDictionary *)ls;
-(void)tkShowAnnotations;
-(void)tkShowUserCurrentLocation;

@end
