//
//  AppDelegate.m
//  SnowPush
//
//  Created by Dannis on 9/22/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import "AppDelegate.h"
#define kFILENAME @"SnowPush.xml"
@implementation AppDelegate

@synthesize DeviceHieght;

@synthesize document = _document;
@synthesize query = _query;
@synthesize UserCurrentAdd;
- (void)loadData:(NSMetadataQuery *)query {
    
    if ([query resultCount] == 1) {
        
        NSMetadataItem *item = [query resultAtIndex:0];
        
        NSString *filename = [item valueForAttribute:NSMetadataItemDisplayNameKey];
        NSNumber *filesize = [item valueForAttribute:NSMetadataItemFSSizeKey];
        NSDate *updated = [item valueForAttribute:NSMetadataItemFSContentChangeDateKey];
        
        NSLog(@"%@ (%@ bytes, updated %@) ", filename, filesize, updated);
        
        NSURL *url = [item valueForAttribute:NSMetadataItemURLKey];
        MyDocument *doc = [[MyDocument alloc] initWithFileURL:url];
        self.document = doc;
        if([filename isEqualToString:@"SnowPush"]){
        [self.document openWithCompletionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"iCloud document opened");
                NSData *file = [NSData dataWithContentsOfURL:url];
                NSXMLParser *parser = [[NSXMLParser alloc] initWithData:file];
                [parser setDelegate:self];
                [parser parse];
            } else {
                NSLog(@"failed opening document from iCloud");
            }
        }];
        }
	}
    else {
        
        NSURL *ubiq = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
        NSURL *ubiquitousPackage = [[ubiq URLByAppendingPathComponent:@"Documents"] URLByAppendingPathComponent:kFILENAME];
        
        MyDocument *doc = [[MyDocument alloc] initWithFileURL:ubiquitousPackage];
        self.document = doc;
        
        [doc saveToURL:[doc fileURL] forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                [doc openWithCompletionHandler:^(BOOL success) {
                    
                    NSLog(@"new document opened from iCloud");
                    
                }];
            }
        }];
    }
    
}

- (void)queryDidFinishGathering:(NSNotification *)notification {
    
    NSMetadataQuery *query = [notification object];
    [query disableUpdates];
    [query stopQuery];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSMetadataQueryDidFinishGatheringNotification
                                                  object:query];
    
     _query= nil;
    
	[self loadData:query];
    
}

- (void)loadDocument {
    
    NSMetadataQuery *query = [[NSMetadataQuery alloc] init];
    _query = query;
    [query setSearchScopes:[NSArray arrayWithObject:NSMetadataQueryUbiquitousDocumentsScope]];
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"%K == %@", NSMetadataItemFSNameKey, kFILENAME];
    [query setPredicate:pred];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryDidFinishGathering:) name:NSMetadataQueryDidFinishGatheringNotification object:query];
    
    [query startQuery];
    
}


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
    
    NSURL *ubiq = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    if (ubiq) {
        NSLog(@"iCloud access at %@", ubiq);
        // TODO: Load document...
        [self loadDocument];
    } else {
        NSLog(@"No iCloud access");
    }
    
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

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)nameSpaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqual:@"ClientDetail"])
    {/*tripCost
      contactCost
      seasonalCost
      Salt
      shovel
      plow
      removal*/
        NSLog(@"Property attributes : %@|%@|%@|%@|%@|%@|%@|%@", [attributeDict objectForKey:@"Comp_Name"],[attributeDict objectForKey:@"Address"], [attributeDict objectForKey:@"city"], [attributeDict objectForKey:@"state"],[attributeDict objectForKey:@"zip"],[attributeDict objectForKey:@"PhoneNo"],[attributeDict objectForKey:@"email"],[attributeDict objectForKey:@"Image"]);
        
        ClientInfo *clientI=[[ClientInfo alloc]init];
        clientI.Comp_name=[attributeDict objectForKey:@"Comp_Name"];
        clientI.Address=[attributeDict objectForKey:@"Address"];
        clientI.City=[attributeDict objectForKey:@"city"];
        clientI.State=[attributeDict objectForKey:@"state"];
        clientI.Zip=[attributeDict objectForKey:@"zip"];
        clientI.phoneNo=[attributeDict objectForKey:@"PhoneNo"];
        clientI.Email=[attributeDict objectForKey:@"email"];
        clientI.Image=[attributeDict objectForKey:@"Image"];
        clientI.TripCost=[attributeDict objectForKey:@"tripCost"];
        clientI.ContractCost=[attributeDict objectForKey:@"contactCost"];
        clientI.SeasonalCost=[attributeDict objectForKey:@"seasonalCost"];
        clientI.salt=[[attributeDict objectForKey:@"Salt"]intValue];
        clientI.shovel=[[attributeDict objectForKey:@"shovel"]intValue];
        clientI.plow=[[attributeDict objectForKey:@"plow"]intValue];
        clientI.removal=[[attributeDict objectForKey:@"removal"]intValue];
        
        BOOL cl=[[DataBase getSharedInstance]IsclientAvailble:clientI];
        if (cl==NO) {
            BOOL insert=[[DataBase getSharedInstance]SaveClientDetail:clientI];
        }
        
        
    }else if ([elementName isEqual:@"Ticket"]){
        /*date,comp_name,start_time,finish_time,phone_num,email,image_before,image_after,snow_fall,hours,calculated,trip,contract,seasonal,send_invoice,paid_in_full*/
     NSLog(@"Property attributes : %@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@",[attributeDict objectForKey:@"invoice"], [attributeDict objectForKey:@"date"],[attributeDict objectForKey:@"comp_name"], [attributeDict objectForKey:@"start_time"], [attributeDict objectForKey:@"finish_time"],[attributeDict objectForKey:@"phone_num"],[attributeDict objectForKey:@"email"],[attributeDict objectForKey:@"image_before"],[attributeDict objectForKey:@"snow_fall"],[attributeDict objectForKey:@"image_after"],[attributeDict objectForKey:@"hours"],[attributeDict objectForKey:@"calculated"],[attributeDict objectForKey:@"trip"],[attributeDict objectForKey:@"contract"],[attributeDict objectForKey:@"seasonal"],[attributeDict objectForKey:@"send_invoice"],[attributeDict objectForKey:@"paid_in_full"]);
        
        ClientInfo *ticketI=[[ClientInfo alloc]init];
        ticketI.invoice_no=[[attributeDict objectForKey:@"invoice"]integerValue];
        ticketI.Comp_name=[attributeDict objectForKey:@"comp_name"];
        ticketI.date=[attributeDict objectForKey:@"date"];
        ticketI.startTime=[attributeDict objectForKey:@"start_time"];
        ticketI.finishTime=[attributeDict objectForKey:@"finish_time"];
        ticketI.phoneNo=[attributeDict objectForKey:@"phone_num"];
        ticketI.Email=[attributeDict objectForKey:@"email"];
        ticketI.snowFall=[attributeDict objectForKey:@"snow_fall"];
        ticketI.hours=[[attributeDict objectForKey:@"hours"]intValue];
        ticketI.calculated=[[attributeDict objectForKey:@"calculated"]intValue];
        ticketI.sendInVoice=[[attributeDict objectForKey:@"send_invoice"]intValue];
        ticketI.paidInFull=[[attributeDict objectForKey:@"paid_in_full"]intValue];
        ticketI.trip=[[attributeDict objectForKey:@"trip"]intValue];
        ticketI.contract=[[attributeDict objectForKey:@"contract"]intValue];
        ticketI.seasonal=[[attributeDict objectForKey:@"contract"]intValue];
        ticketI.imageBefore=[attributeDict objectForKey:@"image_before"];
        ticketI.imageAfter=[attributeDict objectForKey:@"image_after"];
        
        BOOL tC=[[DataBase getSharedInstance]IsTicketAvailable:ticketI.invoice_no];
        
        if (tC==NO) {
            BOOL saveT=[[DataBase getSharedInstance]SaveTicketWithInvoice:ticketI];
        }
        
    }
    
    
    
    //like this way fetch all data and insert in db
}

- (void)metadataQueryDidFinishGathering:
(NSNotification *)notification {
    NSMetadataQuery *query = [notification object];
    [query disableUpdates];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:NSMetadataQueryDidFinishGatheringNotification
     object:query];
    
    [query stopQuery];
    NSArray *results = [[NSArray alloc] initWithArray:[query results]];
    
//    if ([results count] == 1)
//    {
//        // File exists in cloud so get URL
//        _ubiquityURL = [results[0]
//                        valueForAttribute:NSMetadataItemURLKey];
//        
//        _document = [[MyDocument alloc]
//                     initWithFileURL:_ubiquityURL];
//        [_document openWithCompletionHandler:
//         ^(BOOL success) {
//             if (success){
//                 NSLog(@"Opened iCloud doc");
//                 _textView.text = _document.userText;
//             } else {
//                 NSLog(@"Failed to open iCloud doc");
//             }
//         }];
//    } else {
//        // File does not exist in cloud.
//        _document = [[MyDocument alloc]
//                     initWithFileURL:_ubiquityURL];
//        
//        [_document saveToURL:_ubiquityURL
//            forSaveOperation: UIDocumentSaveForCreating
//           completionHandler:^(BOOL success) {
//               if (success){
//                   NSLog(@"Saved to cloud");
//               }  else {
//                   NSLog(@"Failed to save to cloud");
//               }
//           }];
//    }
}

@end
