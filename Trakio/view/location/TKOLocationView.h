//
//  TKOLocationView.h
//  Trakio
//
//  Created by yang wei on 03/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKOLocationListView.h"
#import "TKOMapView.h"
#import "TKOEmployee.h"
#import "TKOLocation.h"
#import "TKOHistory.h"

@class TKOHomeView;
@class TKOTopBar;

@interface TKOLocationView : UIView

@property(nonatomic, strong)UIView * topMargin;
@property(nonatomic, strong)NSDictionary * locations;
@property(nonatomic, strong)TKOMapView * mapView;
@property(nonatomic, strong)TKOLocationListView * locationListView;
@property(nonatomic, strong)TKOTopBar * topBar;
@property(nonatomic, strong)UIButton * endMyDay;
@property(nonatomic, strong)TKOEmployee * employee;

-(id)initWithEmployee:(TKOEmployee *)emp;
-(id)initWithLocations:(NSDictionary *)ls;

-(void)showLocationList:(NSDictionary *)locations;

@end
