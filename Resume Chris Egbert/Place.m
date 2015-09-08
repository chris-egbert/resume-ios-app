//
//  Place.m
//  The Happening
//
//  Created by Christopher Egbert on 4/4/13.
//  Copyright (c) 2013 Soubom. All rights reserved.
//

#import "Place.h"

@implementation Place

@synthesize
address1=_address1,
address2=_address2,
city=_city,
state=_state,
zip=_zip,
coord=_coord,
delegate=_delegate;

- (void)initTestPlace {
    self.label = @"Chris's Location";
    self.description = @"This is where Chris is located.";
    self.address1 = @"4830 W Kennedy Blvd";
    self.address2 = @"Ste 600";
    self.city = @"Tampa";
    self.state = @"FL";
    self.zip = @"33609";
}

- (void)locationGeocode {
    NSString *fullAddress = [NSString stringWithFormat:@"%@ %@, %@, %@ %@", self.address1, self.address2, self.city, self.state, self.zip];
    
    [self initCoordinatesWithAddress:fullAddress];
}

// Geocode address and assign to local resources
- (void)initCoordinatesWithAddress:(NSString *)fullAddress {
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    [geoCoder geocodeAddressString:fullAddress
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     for (CLPlacemark* aPlacemark in placemarks)
                     {
                         // NSLog(@"Placemark: %@", aPlacemark);
                         self.coord = aPlacemark.location.coordinate;
                     }
                     [self.delegate locationGeocodeComplete:self];
                 }];
    
}

// MKAnnotation Protocol

- (CLLocationCoordinate2D)coordinate {
    // NSLog(@"Coordinates: %f, %f", self.coord.longitude, self.coord.latitude);
    return self.coord;
}

- (NSString *)title {
    return self.label;
}

- (NSString *)subtitle {
    return self.description;
}


@end
