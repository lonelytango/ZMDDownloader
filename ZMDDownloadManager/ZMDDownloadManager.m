//
//  ZMDDownloadManager.m
//  ZMDDownloadDemo
//
//  Created by Zian Chen on 8/27/13.
//  Copyright (c) 2013 Zian Mobile Development. All rights reserved.
//

#import "ZMDDownloadManager.h"

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
        [_fetchQueue setMaxConcurrentOperationCount:8];
    }
    return self;
}


- (void)fetchWithURL:(NSURL *)url withPriority:(NSOperationQueuePriority)priority {
    
    //NSDictionary *params = @{@"term": searchTerm};
    //NSMutableURLRequest *request = [_client requestWithMethod:@"GET"
    //                                                     path:@"search"
    //                                               parameters:params];
    
    //NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/search?term=jack+johnson"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *op = [[AFJSONRequestOperation alloc] initWithRequest:request];
    [op setQueuePriority:priority];
    
    [op setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        NSLog(@"Total written: %lld, %lld", totalBytesRead, totalBytesExpectedToRead);
    }];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"Response object: %@", responseObject);
        NSLog(@"%@ DONE", operation.request.URL);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [_fetchQueue addOperation:op];
}

- (void)checkOperations {
    
    for (AFJSONRequestOperation *operation in [_fetchQueue operations]) {
        NSLog(@"Operation: %@\nIs executing: %d", operation.request.URL, operation.isExecuting);
    }
}


- (void)prioritizeURLStrings:(NSArray *)array {
    for (NSString *urlString in array) {
        for (AFJSONRequestOperation *operation in [_fetchQueue operations]) {
//            if (operation.isExecuting) {
//                [operation pause];
//            }
            
            if ([operation.request.URL.absoluteString isEqualToString:urlString]) {
                operation.queuePriority = NSOperationQueuePriorityVeryHigh;
                //[operation cancel];
                
                //AFJSONRequestOperation *newOperation = [[AFJSONRequestOperation alloc] initWithRequest:operation.request];
                //newOperation.queuePriority = NSOperationQueuePriorityVeryHigh;
                //[_fetchQueue addOperation:newOperation];
                
                NSLog(@"set operation to high: %@", operation.request.URL.absoluteString);
            }
        }
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
