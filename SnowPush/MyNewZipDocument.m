//
//  MyNewZipDocument.m
//  SnowPush
//
//  Created by Dannis on 10/20/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

//Minor issues with getting things to sync.. Found this Zip in/out for iCloud which seems to solve some of my issues. 

#import "MyNewZipDocument.h"

@implementation MyNewZipDocument
@synthesize ZipDataContent;

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError **)outError
{
    // NSLog(@"* ---> typename: %@",typeName);
    self.ZipDataContent = [NSData dataWithBytes:[contents bytes] length:[contents length]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"noteModified" object:self];
    return YES;
}


// Called whenever the application (auto)saves the content of a note
- (id)contentsForType:(NSString *)typeName error:(NSError **)outError
{
    
    return [NSData dataWithData:self.ZipDataContent];
    
}

@end
