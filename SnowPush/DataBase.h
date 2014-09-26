//
//  DataBase.h
//  SnowPush
//
//  Created by Dannis on 9/25/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClientInfo.h"
@interface DataBase : NSObject
{
    NSString *databasepath;
    ClientInfo *CInfo;
}

+(DataBase*)getSharedInstance;

#pragma Favorit List Methods

- (BOOL) SaveClientDetail:(ClientInfo*)client;

-(NSMutableArray*)receiveAllData;

-(BOOL)CheckCouponId:(NSString*)CoupId;

//-(BOOL)deleteDataFromFavoritesList:(CouponInfo*)coupon;

@end
