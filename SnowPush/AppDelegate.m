//
//  AppDelegate.m
//  SnowPush
//
//  Created by Dannis on 9/22/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize DeviceHieght;


@synthesize UserCurrentAdd;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    [AppDelegate sharedInstance].DeviceHieght=[UIScreen mainScreen].bounds.size.height;
    
//  NSMetadataQuery  *metadataQuery = [[NSMetadataQuery alloc] init];
//    
//    [metadataQuery setPredicate:[NSPredicate
//                                  predicateWithFormat:@"%K like 'SnowPush.xml'",
//                                  NSMetadataItemFSNameKey]];
//    
////    [metadataQuery setSearchScopes:[NSArray
////                                     arrayWithObjects:NSMetadataQueryUbiquitousDocumentsScope,nil]];
////    
////    [[NSNotificationCenter defaultCenter]
////     addObserver:self
////     selector:@selector(metadataQueryDidFinishGathering:)
////     name: NSMetadataQueryDidFinishGatheringNotification
////     object:metadataQuery];
//    
//    [metadataQuery startQuery];
//    
//    [self loadData:metadataQuery];
    
    tutsShown=[[NSUserDefaults standardUserDefaults]boolForKey:@"tutsShown"];
    
       return YES;
}

+(AppDelegate*)sharedInstance
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//     self.eventManager = [[EventManager alloc] init];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- (void)loadData:(NSMetadataQuery *)queryData
//{
//    for (NSMetadataItem *item in [queryData results])
//    {
//        NSString *filename = [item valueForAttribute:NSMetadataItemDisplayNameKey];
//        NSNumber *filesize = [item valueForAttribute:NSMetadataItemFSSizeKey];
//        NSDate *updated = [item valueForAttribute:NSMetadataItemFSContentChangeDateKey];
//        NSLog(@"%@ (%@ bytes, updated %@) ", filename, filesize, updated);
//        
//        NSURL *url = [item valueForAttribute:NSMetadataItemURLKey];
//        MyDocument *doc = [[MyDocument alloc] initWithFileURL:url];
//        if([filename isEqualToString:@"ClientDetails"])
//        {
//            [doc openWithCompletionHandler:^(BOOL success) {
//                if (success) {
//                    NSLog(@"XML: Success to open from iCloud");
//                    NSData *file = [NSData dataWithContentsOfURL:url];
//                    //NSString *xmlFile = [[NSString alloc] initWithData:file encoding:NSASCIIStringEncoding];
//                    //NSLog(@"%@",xmlFile);
//                    
//                    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:file];
//                    [parser setDelegate:self];
//                    [parser parse];
//                    //We hold here until the parser finishes execution
//                }
//                else
//                {
//                    NSLog(@"XML: failed to open from iCloud");
//                }
//            }]; 
//        }
//    }
//}


@end
