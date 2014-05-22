//
//  APCNetworkActivityIndicatorManager.m
//  APCNetworkActivityIndicatorManager
//
//  Created by Allen Chen on 5/22/14.
//
//

#import <UIKit/UIKit.h>

#import "APCNetworkActivityIndicatorManager.h"

@interface APCNetworkActivityIndicatorManager ()
@property (nonatomic) NSInteger count;
@property (nonatomic, strong) dispatch_queue_t q;
@end

@implementation APCNetworkActivityIndicatorManager

- (instancetype)init
{
    if (self = [super init]) {
        _count = 0;
        _q = dispatch_queue_create("com.allenpc.APCNetworkActivityIndicatorManager", DISPATCH_QUEUE_SERIAL);
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateIndicator)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (void)start
{
    [[self sharedManager] startIndicator];
}

+ (void)stop
{
    [[self sharedManager] stopIndicator];
}

#pragma mark - Private

+ (instancetype)sharedManager
{
    static APCNetworkActivityIndicatorManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)startIndicator
{
    dispatch_async(self.q, ^{
        self.count++;
    });
}

- (void)stopIndicator
{
    dispatch_async(self.q, ^{
        self.count--;
    });
}

- (void)setCount:(NSInteger)count
{
    _count = (count < 0) ? 0 : count;
    [self updateIndicator];
}

- (void)updateIndicator
{
    NSInteger count = self.count;
    dispatch_block_t block = ^{
        if (count == 0) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        } else {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        }
    };
    
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

@end
