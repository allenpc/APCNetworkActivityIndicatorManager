//
//  APCNetworkActivityIndicatorManager.h
//  APCNetworkActivityIndicatorManager
//
//  Created by Allen Chen on 5/22/14.
//
//  A simple, thread-safe class that manages the network activity indicator
//  across multiple code paths.

#import <Foundation/Foundation.h>

@interface APCNetworkActivityIndicatorManager : NSObject

+ (void)start;
+ (void)stop;

@end
