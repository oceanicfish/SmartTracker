//
//  TKOMapView.m
//  Trakio
//
//  Created by yang wei on 03/02/2016.
//  Copyright © 2016 com.cb.trakio. All rights reserved.
//

#import "TKOMapView.h"

@implementation TKOMapView 

@synthesize locationManager;
@synthesize map;
@synthesize mylocations;

-(MKAnnotationView *)mapView:(MKMapView *)mapView
           viewForAnnotation:(id<MKAnnotation>)annotation {
    
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
//    MKAnnotationView * pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
    
    MKPinAnnotationView * pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
    
    pinView.pinTintColor = [UIColor orangeColor];
    
    return pinView;
}

/** show Annotations
 *
 * show all locations on the map
 */
-(void)tkShowAnnotations {
    NSMutableArray * annotationslist = [[NSMutableArray alloc] initWithCapacity:4];
    
    CLLocationCoordinate2D pinCoordinate;
    
//    NSArray * locationNames = self.mylocations.allKeys;
    CLLocation * firstLocation;
    
    for (int i = 0; i < self.mylocations.count; i++) {
        TKOLocation * location = [self.mylocations objectForKey:[NSString stringWithFormat:@"%d", i]];
        NSString * locationName = location.name;
//        CLLocation * lo = [self.mylocations objectForKey:locationName];
        CLLocation * lo = [[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
        if (i == 0) {
            firstLocation = lo;
        }
//        pinCoordinate.latitude = lo.coordinate.latitude;
//        pinCoordinate.longitude = lo.coordinate.longitude;
        
        pinCoordinate.latitude = location.latitude;
        pinCoordinate.longitude = location.longitude;
        
        MKPointAnnotation * myAnnotation = [[MKPointAnnotation alloc] init];
        
        myAnnotation.coordinate = pinCoordinate;
        
        myAnnotation.title = locationName;
        myAnnotation.subtitle = location.address;
        
        [annotationslist addObject:myAnnotation];
    }
    
    [self.map addAnnotations:annotationslist];
    
    MKCoordinateRegion mapRegion;
    mapRegion.center = firstLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.03;
    mapRegion.span.longitudeDelta = 0.03;
    
    [self.map setRegion:mapRegion animated: YES];
}

/** update location
 *
 * invoke this function everytime when user change their locatioin
 */
-(void)mapView:(MKMapView *)mapView
didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    MKCoordinateRegion mapRegion;
    mapRegion.center = mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.03;
    mapRegion.span.longitudeDelta = 0.03;
    
    [mapView setRegion:mapRegion animated: YES];
}

/** show user current location
 *
 * show user current location when this method be invoked
 */
-(void)tkShowUserCurrentLocation {
    
    MKCoordinateRegion mapRegion;
    mapRegion.center = self.map.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.03;
    mapRegion.span.longitudeDelta = 0.03;
    
    [self.map setRegion:mapRegion animated: YES];
}

/** location update
 *
 * log coordinate everytime location updated
 */
-(void)locationManager:(CLLocationManager *)manager
    didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation * location = locations.lastObject;
    NSString *lt = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    NSString *lgt = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    NSLog(@"latitude: %@, longitude: %@", lt, lgt);
    
    /**
     * keeping tracking user's location will lead very fast power consumption
     * of user's cellphone
     */
        [self.locationManager stopUpdatingLocation];
}

/** layout change
 *
 * set up layout everytime layout is changed
 */
-(void)layoutSubviews {
    
    // MUST SET THE FOLLOWING ATTRIBUTE BEFORE USE CONSTRAINT !!!
    self.map.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.map
                         attribute:NSLayoutAttributeTop
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.map
                         attribute:NSLayoutAttributeLeft
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.map
                         attribute:NSLayoutAttributeWidth
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeWidth
                         multiplier:1
                         constant:0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.map
                         attribute:NSLayoutAttributeHeight
                         relatedBy:0
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:1
                         constant:0]];
}

-(id)initWithEmployee:(TKOEmployee *)emp {
    
    if (self = [super init]) {
        
        /**
         * set locations dictionary
         */
        self.employee = emp;
        
        /**
         * setting LocationManager (for user's location)
         */
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
        
        /**
         * setting MapView (show all annotation and user's location)
         */
        self.map = [[MKMapView alloc] init];
        self.map.delegate = self;
        self.map.showsBuildings = YES;
        self.map.showsUserLocation = YES;
        [self addSubview:self.map];
//        [self tkShowAnnotations];
        [self tkShowUserCurrentLocation];
        
    }
    
    return self;
}

-(id)initWithLocations:(NSDictionary *)ls{
    if (self = [super init]) {
        
        /**
         * set locations dictionary
         */
        self.mylocations = ls;
        
        /**
         * setting LocationManager (for user's location)
         */
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
        
        /**
         * setting MapView (show all annotation and user's location)
         */
        self.map = [[MKMapView alloc] init];
        self.map.delegate = self;
        self.map.showsBuildings = YES;
        self.map.showsUserLocation = YES;
        [self addSubview:self.map];
        [self tkShowAnnotations];
        [self tkShowUserCurrentLocation];
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
