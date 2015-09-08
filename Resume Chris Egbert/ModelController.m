//
//  ModelController.m
//  Resume Chris Egbert
//
//  Created by Chris Egbert on 9/5/15.
//  Copyright (c) 2015 Wave Unified Communications. All rights reserved.
//

#import "ModelController.h"
#import "WelcomeViewController.h"
#import "WebViewController.h"
#import "PlacesViewController.h"
#import "NetRequestViewController.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


@interface ModelController ()

@property (readonly, strong, nonatomic) NSArray *pageData;
@end

@implementation ModelController

- (instancetype)init {
    self = [super init];
    if (self) {
      // Initialization code
    }
    return self;
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard {
    // Return the data view controller for the given index.
    if (([[self getPageList] count] == 0) || (index >= [[self getPageList] count])) {
        return nil;
    }
    
    NSString *viewControllerTitle = [[self getPageList] objectAtIndex:index];

    UIViewController *viewController = [self getViewControllerWithTitle:viewControllerTitle andStoryboard:storyboard];
    return viewController;
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController {
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [[self getPageList] indexOfObject:viewController.title];
}

// Static list of pages to be shown
- (NSArray *)getPageList {
    NSArray *pageList = @[
                          @"welcome",
                          @"map",
                          @"net-request",
                          @"resume",
                          ];
    return pageList;
}

// Instantiate the view controller to shown
- (UIViewController *)getViewControllerWithTitle:(NSString *)title andStoryboard:(UIStoryboard *)storyboard {

    UIViewController *viewController;
    
    if ([title isEqualToString:@"resume"]) {

        // Resume
        WebViewController *resumeViewController = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
        NSString *urlString = @"https://cloud-dev.waveuc.com/resume-chris-egbert.html";
        resumeViewController.labelString = urlString;
        resumeViewController.titleString = @"My Online Resume";
        resumeViewController.urlString = urlString;
        viewController = (UIViewController *)resumeViewController;

    } else if ([title isEqualToString:@"map"]) {

        // Map
        PlacesViewController *placesViewController = [storyboard instantiateViewControllerWithIdentifier:@"PlacesViewController"];
        placesViewController.titleString = @"Chris's Location";
        placesViewController.labelString = @"The red pin indicates where Chris is located";
        viewController = (UIViewController *)placesViewController;
        
    } else if ([title isEqualToString:@"net-request"]) {
        
        // Net Request
        NetRequestViewController *netRequestViewController = [storyboard instantiateViewControllerWithIdentifier:@"NetRequestViewController"];
        netRequestViewController.titleString = @"Network Async Request";
        netRequestViewController.labelString = @"Data is loaded asynchronously; Net image is cached";
        viewController = (UIViewController *)netRequestViewController;

        
    } else {
        
        // Welcome
        WelcomeViewController *welcomeViewController = [storyboard instantiateViewControllerWithIdentifier:@"WelcomeViewController"];
        viewController = (UIViewController *)welcomeViewController;
    }
    viewController.title = title;
    return viewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [[self getPageList] count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
