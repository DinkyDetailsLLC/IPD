//
//  MyDocument.m
//  SnowPush
//
//  Created by Dannis on 10/11/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import "MyDocument.h"

@implementation MyDocument
@synthesize xmlContent;
- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError **)outError
{
    // NSLog(@"* ---> typename: %@",typeName);
    self.xmlContent = [[NSString alloc]
                       initWithBytes:[contents bytes]
                       length:[contents length]
                       encoding:NSUTF8StringEncoding];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"noteModified" object:self];
    return YES;
}

// Called whenever the application (auto)saves the content of a note
- (id)contentsForType:(NSString *)typeName error:(NSError **)outError
{
    
    return [NSData dataWithBytes:[self.xmlContent UTF8String] length:[self.xmlContent length]];
    
}
@end
