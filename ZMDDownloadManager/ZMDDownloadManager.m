//
//  ZMDDownloadManager.m
//  ZMDDownloadDemo
//
//  Created by Zian Chen on 8/27/13.
//  Copyright (c) 2013 Zian Mobile Development. All rights reserved.
//

#import "ZMDDownloadManager.h"
#import "ZMDDownloadOperation.h"

#define REMOTE_PROD_SERVER @"http://www.people.com/people/recipe/app/json/"

@interface ZMDDownloadManager ()
@property (nonatomic, strong) AFHTTPClient *client;
@property (nonatomic, strong) NSOperationQueue *fetchQueue;
@end

@implementation ZMDDownloadManager

- (id)init {
    self = [super init];
    if (self) {
        _client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"https://itunes.apple.com"]];
        _fetchQueue = [NSOperationQueue new];
    }
    return self;
}


- (void)fetchWithTerm:(NSString *)searchTerm withPriority:(NSOperationQueuePriority)priority {
    
    NSDictionary *params = @{@"term": searchTerm,
                             @"limit": @(10)};
    NSMutableURLRequest *request = [_client requestWithMethod:@"GET"
                                                         path:@"search"
                                                   parameters:params];
    
    //NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/search?term=jack+johnson"];
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    ZMDDownloadOperation *op = [[ZMDDownloadOperation alloc] initWithRequest:request];
    op.requestName = searchTerm;
    [op setQueuePriority:priority];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"Response object: %@", responseObject);
        NSLog(@"%@ DONE", searchTerm);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [_fetchQueue addOperation:op];
}

- (void)checkOperations {
    
    for (ZMDDownloadOperation *operation in [_fetchQueue operations]) {
        NSLog(@"Operation: %@\nIs executing: %d", operation.request.URL, operation.isExecuting);
    }
}


- (void)prioritizeRequestNames:(NSArray *)array {
    
    //Temporarily suspend the queue to start modification.
    [_fetchQueue setSuspended:YES];
    
    //Counter to keep track of priority fetch count.
    __block int priorityDoneCount = 0;
    
    for (ZMDDownloadOperation *op in [_fetchQueue operations]) {
        
        if ([array containsObject:op.requestName]) {
            
            NSLog(@"set operation to high: %@", op.requestName);
            
            op.queuePriority = NSOperationQueuePriorityVeryHigh;
            
            [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                priorityDoneCount++;
                
                //When priority fetch are all done, resume the rest of operations.
                if (priorityDoneCount == [array count]) {
                    [self resumeAllOperations];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error in priority block: %@", [error localizedDescription]);
            }];
        
        } else {
            [op pause];
        }
    }
    
    [_fetchQueue setSuspended:NO];
}

- (void)resumeAllOperations {
    for (ZMDDownloadOperation *operation in [_fetchQueue operations]) {
        [operation resume];
    }
}

#pragma mark - Singleton

+ (instancetype)sharedInstance {
    static ZMDDownloadManager *instance = nil;
    static dispatch_once_t dispatch;
    
    dispatch_once(&dispatch, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

@end
