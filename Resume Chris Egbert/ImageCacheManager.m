//
//  ImageCacheManager.m
//  PlayHouse
//
//  Created by Christopher Egbert on 3/25/13.
//  Copyright (c) 2013 Soubom. All rights reserved.
//

#import "ImageCacheManager.h"

static NSMutableDictionary *imageCache;

@implementation ImageCacheManager


+ (BOOL)hasCachedImageForUrl:(NSString *)url {
    BOOL result = NO;
    if ([imageCache objectForKey:url]) {
        result = YES;
    }
    
    return result;
}

// Delete a cached image
+ (void)deleteCachedImageForUrl:(NSString *)url {
    [imageCache removeObjectForKey:url];
}

+ (UIImage *)getCachedImageForUrl:(NSString *)url {
    
    // Don't try to resolve empty URL string
    if (!url || [url isEqualToString:@""]) {
        UIImage *newImage = [UIImage imageNamed:@"imageCachePlaceholder"];
        return newImage;
    }
    
    if ([self hasCachedImageForUrl:url]) {
      return [imageCache objectForKey:url];
    } else {
        UIImage *newImage = [UIImage imageNamed:@"imageCachePlaceholder"];
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,  0ul);
        dispatch_async(queue, ^{
            NSLog(@"Calling URL: %@", url);
            NSURL *imageURL = [NSURL URLWithString:url];
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSLog(@"Calling image replace on main queue");
                UIImage *replaceImage = [UIImage imageWithData:imageData];
                [ImageCacheManager setCachedImage:replaceImage ForUrl:url];
                NSLog(@"Image replaced");
                
                // Notify that this URL has been downloaded
                NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
                NSDictionary *userInfo = @{@"url" : url};
                [notificationCenter postNotificationName:@"ImageCacheUpdated" object:nil userInfo:userInfo];
            });
        });
        
        return newImage;
    }
}

+ (void)setCachedImage:(UIImage *)image ForUrl:(NSString *)url {
    if (!imageCache) {
        imageCache = [[NSMutableDictionary alloc] init];
    }
    [imageCache setValue:image forKey:url];

}

@end
