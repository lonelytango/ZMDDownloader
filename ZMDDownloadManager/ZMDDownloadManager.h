//
//  ZMDDownloadManager.h
//  ZMDDownloadDemo
//
//  Created by Zian Chen on 8/27/13.
//  Copyright (c) 2013 Zian Mobile Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMDDownloadManager : NSObject

+ (instancetype)sharedInstance;

- (void)checkOperations;

- (void)fetchWithURL:(NSURL *)url withPriority:(NSOperationQueuePriority)priority;

- (void)prioritizeURLStrings:(NSArray *)array;

//- (void)fetchWithSearchTerm:(NSString *)searchTerm;

//- (void)fetchWithSearchTerm:(NSString *)searchTerm withPriority:(NSOperationQueuePriority)priority;

@end
