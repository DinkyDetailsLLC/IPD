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

#pragma mark - New client

- (BOOL) SaveClientDetail:(ClientInfo*)client;

-(NSMutableArray*)receiveAllData;

-(BOOL)updateClientDetail:(ClientInfo*)client whereCompName:(NSString*)CompName;

-(BOOL)deleteClientFromClientsList:(ClientInfo*)Client;

#pragma mark - new ticket

-(BOOL)SaveNewTicket:(ClientInfo*)ticket;

-(NSMutableArray*)receiveAllDataFromNewTicket;

-(NSMutableArray*)reciveAllOpenAndPaidTickets:(ClientInfo*)client;

-(NSMutableArray*)RecieveSpecificClientsOpenAndPaidTickets:(ClientInfo*)Client;

-(NSMutableArray*)RecieveTotalCompanysAllTickets:(ClientInfo*)Client;

-(BOOL)updateTicketDetail:(ClientInfo*)ticket whereCompName:(NSString*)CompName andPaid:(int)paid andStartTime:(NSString*)start andEndTime:(NSString*)end;

@end
