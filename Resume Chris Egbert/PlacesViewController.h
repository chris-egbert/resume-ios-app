//
//  PlacesViewController.h
//  Resume Chris Egbert
//
//  Created by Chris Egbert on 9/7/15.
//  Copyright (c) 2015 Wave Unified Communications. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Place.h"

@interface PlacesViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, PlaceDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelLabel;

@property (nonatomic, retain) NSString *titleString;
@property (nonatomic, retain) NSString *labelString;

@property (strong, nonatomic) CLLocationManager *locationManager;

// MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated;

// PlaceDelegate
- (void)locationGeocodeComplete:(Place *)place;

@end
