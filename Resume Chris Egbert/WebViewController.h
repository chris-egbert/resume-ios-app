//
//  WebViewController.h
//  Resume Chris Egbert
//
//  Created by Chris Egbert on 9/5/15.
//  Copyright (c) 2015 Wave Unified Communications. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

// Storyboard Properties
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelLabel;

// Config properties
@property (nonatomic, retain) NSString *urlString;
@property (nonatomic, retain) NSString *titleString;
@property (nonatomic, retain) NSString *labelString;


@end
