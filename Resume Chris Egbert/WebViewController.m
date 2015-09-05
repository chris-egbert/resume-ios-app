//
//  WebViewController.m
//  Resume Chris Egbert
//
//  Created by Chris Egbert on 9/5/15.
//  Copyright (c) 2015 Wave Unified Communications. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

@synthesize
  urlString=_urlString,
  labelLabel=_labelLabel,
  titleLabel=_titleLabel,
  titleString=_titleString,
  labelString=_labelString,
  webView=_webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Init the web view
    self.titleLabel.text = self.titleString;
    self.labelLabel.text = self.labelString;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
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

@end
