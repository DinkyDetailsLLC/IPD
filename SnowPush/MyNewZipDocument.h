//
//  MyNewZipDocument.h
//  SnowPush
//
//  Created by Dannis on 10/20/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//
//Minor issues with getting things to sync.. Found this Zip in/out for iCloud which seems to solve some of my issues.

#import <UIKit/UIKit.h>

@interface MyNewZipDocument : UIDocument
@property (strong) NSData *ZipDataContent;
@end
