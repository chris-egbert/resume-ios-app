//
//  PlacesViewController.m
//  Resume Chris Egbert
//
//  Created by Chris Egbert on 9/7/15.
//  Copyright (c) 2015 Wave Unified Communications. All rights reserved.
//

#import "PlacesViewController.h"

@interface PlacesViewController ()

@end

@implementation PlacesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Be the delegate for the map
    self.map.delegate = self;
    
    // Set the Title and Label
    self.titleLabel.text = self.titleString;
    self.labelLabel.text = self.labelString;
    
    // Show the current users location if permitted
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];

        // See if we're authorized to show local user status
        CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
        if (authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
            authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
            
            // Show the user
            [self.locationManager startUpdatingLocation];
            self.map.showsUserLocation = YES;
        }
    }
    
    // Init the test place
    Place *place = [[Place alloc] init];
    place.delegate = self;
    [place initTestPlace];
    
    // Async GeoCode
    [place locationGeocode];

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


#pragma mark - MKMapViewDelegate

// Required method... but not implemented
- (void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated {
    NSLog(@"Map View Tracking mode changed");
    
}

/*
 // User selected an annotation view
 - (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
 NSLog(@"Annotation View Selected: %@", view);
 }
 */

/*
 // Control the view for the specific Annotation
 - (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
 static NSString *viewIdentifier = @"annotationView";
 MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:viewIdentifier];
 if (annotationView == nil) {
 annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:viewIdentifier];
 }
 
 return annotationView;
 }
 */

#pragma mark - PlaceDelegate

// GeoCoding for this location is complete... Add it to the Map
- (void)locationGeocodeComplete:(Place *)place {
    
    NSLog(@"Got location GeoCode callback: %@", place);
    
    // Center the map
    [self.map setCenterCoordinate:place.coord animated:YES];
    
    // Set the region, centered at the location - Distance args are in meters
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(place.coord, 20000, 20000);
    
    [self.map setRegion:region animated:YES];
    
    // Add the test place as an annotation on the map
    [self.map addAnnotation:place];
}

@end
