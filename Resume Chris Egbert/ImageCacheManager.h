//
//  ImageCacheManager.h
//  PlayHouse
//
//  Created by Christopher Egbert on 3/25/13.
//  Copyright (c) 2013 Soubom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ImageCacheManager : NSObject

+ (BOOL)hasCachedImageForUrl:(NSString *)url;
+ (UIImage *)getCachedImageForUrl:(NSString *)url;
+ (void)setCachedImage:(UIImage *)image ForUrl:(NSString *)url;
+ (void)deleteCachedImageForUrl:(NSString *)url;

@end
