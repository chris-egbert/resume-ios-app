//
//  Place.h
//  The Happening
//
//  Created by Christopher Egbert on 4/4/13.
//  Copyright (c) 2013 Soubom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "BaseObject.h"

@protocol PlaceDelegate;

@interface Place : BaseObject <MKAnnotation>

@property (nonatomic) NSString *address1;
@property (nonatomic) NSString *address2;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *state;
@property (nonatomic) NSString *zip;
@property (nonatomic) CLLocationCoordinate2D coord;

@property (nonatomic) id<PlaceDelegate> delegate;

- (void)initTestPlace;
- (void)locationGeocode;

// MKAnnotation Protocol
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;

@end


@protocol PlaceDelegate <NSObject>

- (void)locationGeocodeComplete:(Place *)place;

@end