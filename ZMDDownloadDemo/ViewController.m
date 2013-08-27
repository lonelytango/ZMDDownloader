//
//  ViewController.m
//  ZMDDownloadDemo
//
//  Created by Zian Chen on 8/27/13.
//  Copyright (c) 2013 Zian Mobile Development. All rights reserved.
//

#import "ViewController.h"
#import "ZMDDownloadManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSArray *fetchURLStrings = @[@"https://itunes.apple.com/search?term=jack+johnson&limit=10",
                                 @"https://itunes.apple.com/search?term=priscilla&limit=10",
                                 @"https://itunes.apple.com/search?term=nadia&limit=10",
                                 @"https://itunes.apple.com/search?term=allin&limit=10",
                                 @"https://itunes.apple.com/search?term=dave+alvin&limit=10",
                                 @"https://itunes.apple.com/search?term=anastacia&limit=10",
                                 @"https://itunes.apple.com/search?term=ken+andrews&limit=10",
                                 @"https://itunes.apple.com/search?term=michael+andrews&limit=10",
                                 @"https://itunes.apple.com/search?term=david+archuleta&limit=10",
                                 @"https://itunes.apple.com/search?term=billie+joe&limit=10",
                                 @"https://itunes.apple.com/search?term=louis+armstrong&limit=10",
                                 @"https://itunes.apple.com/search?term=joseph+arthur&limit=10",
                                 @"https://itunes.apple.com/search?term=chuck&limit=10",
                                 @"https://itunes.apple.com/search?term=crystal&limit=10",
                                 @"https://itunes.apple.com/search?term=sara+bareilles&limit=10",
                                 @"https://itunes.apple.com/search?term=jon+bon&limit=10",
                                 @"https://itunes.apple.com/search?term=olivia&limit=10",
                                 @"https://itunes.apple.com/search?term=karl+blau&limit=10",
                                 @"https://itunes.apple.com/search?term=brandon&limit=10",
                                 @"https://itunes.apple.com/search?term=ralston&limit=10",
                                 @"https://itunes.apple.com/search?term=colin&limit=10",
                                 @"https://itunes.apple.com/search?term=mark+foster&limit=10",
                                 @"https://itunes.apple.com/search?term=glenn+frey&limit=10",
                                 @"https://itunes.apple.com/search?term=david+gates&limit=10",
                                 @"https://itunes.apple.com/search?term=hank+green&limit=10",
                                 @"https://itunes.apple.com/search?term=dave+grohl&limit=10",
                                 @"https://itunes.apple.com/search?term=robert+hunter&limit=10",
                                 @"https://itunes.apple.com/search?term=janis+joplin&limit=10",
                                 @"https://itunes.apple.com/search?term=kenna&limit=10"
                                 ];
    
    NSArray *priorityArray = @[@"https://itunes.apple.com/search?term=joseph+arthur&limit=10",
                               @"https://itunes.apple.com/search?term=chuck&limit=10",
                               @"https://itunes.apple.com/search?term=crystal&limit=10",
                               @"https://itunes.apple.com/search?term=sara+bareilles&limit=10"];
    
    for (NSString *urlString in fetchURLStrings) {
        NSURL *url = [NSURL URLWithString:urlString];
        [[ZMDDownloadManager sharedInstance] fetchWithURL:url withPriority:NSOperationQueuePriorityLow];
    }
    
    [[ZMDDownloadManager sharedInstance] prioritizeURLStrings:priorityArray];
    
    [[ZMDDownloadManager sharedInstance] checkOperations];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
