//
//  ApiRequest.m
//  Resume Chris Egbert
//
//  Created by Chris Egbert on 9/7/15.
//  Copyright (c) 2015 Wave Unified Communications. All rights reserved.
//

#import "ApiRequest.h"

@implementation ApiRequest

- (void)execAsyncRequest {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,  0ul);
    dispatch_async(queue, ^{
        
        NSURL *url = [NSURL URLWithString:self.urlString];
        
        NSLog(@"Calling API URL: %@", self.urlString);
        
        NSError *err = nil;
        NSString *response = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&err];
        NSData* responseData = [response dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *jsonError = nil;
        NSDictionary *myJson = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&jsonError];
        NSLog(@"Response to promo credit: %@", myJson);
        
        // Callback on Main Thread
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            NSLog(@"Assigning  data on main queue");
            
            // Send the response to the delegate
            [self.delegate apiRequest:self response:myJson];
            
        });
    });

}

@end


