//
//  ApiRequest.h
//  Resume Chris Egbert
//
//  Created by Chris Egbert on 9/7/15.
//  Copyright (c) 2015 Wave Unified Communications. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ApiRequestDelegate;

@interface ApiRequest : NSObject

@property (nonatomic, retain) NSString *urlString;
@property (nonatomic) id<ApiRequestDelegate> delegate;


- (void)execAsyncRequest;

@end

// Delegate definition
@protocol ApiRequestDelegate <NSObject>

- (void)apiRequest:(ApiRequest *)apiRequest response:(NSDictionary *)response;

@end