//
//  NetRequestViewController.h
//  Resume Chris Egbert
//
//  Created by Chris Egbert on 9/7/15.
//  Copyright (c) 2015 Wave Unified Communications. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiRequest.h"

@interface NetRequestViewController : UIViewController <ApiRequestDelegate>

// IB Outlets
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *uiActIndView;
@property (weak, nonatomic) IBOutlet UILabel *jsonTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *jsonDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *jsonTimestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *jsonImgUrlLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

// IB Actions
- (IBAction)clearImageCachePressed:(id)sender;
- (IBAction)refreshPressed:(id)sender;

// Local vars
@property (nonatomic, retain) NSString *titleString;
@property (nonatomic, retain) NSString *labelString;
@property (nonatomic, retain) NSDictionary *apiResponseDictionary;

// Local methods
- (void)updateImage:(NSNotification *)notification;

// Delegate Action
- (void)apiRequest:(ApiRequest *)apiRequest response:(NSDictionary *)response;

@end
