//
//  ModelController.h
//  Resume Chris Egbert
//
//  Created by Chris Egbert on 9/5/15.
//  Copyright (c) 2015 Wave Unified Communications. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(UIViewController *)viewController;

@end

