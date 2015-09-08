//
//  NetRequestViewController.m
//  Resume Chris Egbert
//
//  Created by Chris Egbert on 9/7/15.
//  Copyright (c) 2015 Wave Unified Communications. All rights reserved.
//

#import "NetRequestViewController.h"
#import "ImageCacheManager.h"

@interface NetRequestViewController ()

@property (nonatomic) BOOL imageCacheSubscriptionSet;

@end

@implementation NetRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel.text = self.titleString;
    self.labelLabel.text = self.labelString;
    
    // Initially set the subscription
    self.imageCacheSubscriptionSet = NO;
    
    // Call the load network data method
    [self loadNetworkData];
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

#pragma mark - IB Actions

// Clear Image Cache button pressed
- (IBAction)clearImageCachePressed:(id)sender {
    [ImageCacheManager deleteCachedImageForUrl:[self.apiResponseDictionary objectForKey:@"url"]];
}

// Refresh the network request - Async
- (IBAction)refreshPressed:(id)sender {
    // Call the load network data method
    [self loadNetworkData];
}

#pragma mark - Local Methods

// Update view data
- (void)updateViewData {
    self.jsonTitleLabel.text = [self.apiResponseDictionary objectForKey:@"title"];
    self.jsonDescriptionLabel.text = [self.apiResponseDictionary objectForKey:@"description"];
    self.jsonImgUrlLabel.text = [self.apiResponseDictionary objectForKey:@"url"];
    self.jsonTimestampLabel.text = [self.apiResponseDictionary objectForKey:@"timestamp_requested"];
    
    [self.imgView setImage:[ImageCacheManager getCachedImageForUrl:[self.apiResponseDictionary objectForKey:@"url"]]];
}

// Pull network config data
- (void)loadNetworkData {
    
    // Start the activity indicator
    self.uiActIndView.hidden = NO;
    [self.uiActIndView startAnimating];
    
    // Kick off the Api Request for data
    ApiRequest *apiRequest = [[ApiRequest alloc] init];
    apiRequest.delegate = self;
    apiRequest.urlString = @"https://cloud-dev.waveuc.com/json-example.php";
    [apiRequest execAsyncRequest];
}

// Update an image based on network callback
- (void)updateImage:(NSNotification *)notification {
    NSLog(@"Network Image Locally downloaded callback");
    NSDictionary *userInfo = [notification userInfo];
    NSString *urlString = [userInfo objectForKey:@"url"];
    
    // Get the updated image
    [self.imgView setImage:[ImageCacheManager getCachedImageForUrl:urlString]];
}

#pragma mark - ApiRequest Delegate Methods

// Response to Api Request
- (void)apiRequest:(ApiRequest *)apiRequest response:(NSDictionary *)response {
    NSLog(@"Received Api response: %@", response);
    
    // Stop the activity indicator
    self.uiActIndView.hidden = YES;
    [self.uiActIndView stopAnimating];
    
    // Assign the response locally for future use
    self.apiResponseDictionary = response;
    
    // Subscribe for image updates
    if (!self.imageCacheSubscriptionSet) {
        self.imageCacheSubscriptionSet = YES;
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter addObserver:self selector:@selector(updateImage:) name:@"ImageCacheUpdated" object:nil];
    }
    
    // Update the actual view data
    [self updateViewData];
}

@end
