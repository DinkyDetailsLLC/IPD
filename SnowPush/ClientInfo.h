//
//  ClientInfo.h
//  SnowPush
//
//  Created by Dannis on 9/25/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClientInfo : NSObject
@property NSString *Comp_name,*Address,*City,*State,*Zip,*phoneNo,*Email,*Image,*TripCost,*ContractCost,*SeasonalCost,*date,*startTime,*finishTime;

@property int salt,shovel,plow,removal,hours,calculated,contract,seasonal,sendInVoice,paidInFull,trip;

@property NSString *imageBefore,*imageAfter,*snowFall;

@property NSInteger invoice_no;

@end
