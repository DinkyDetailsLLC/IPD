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
- (NSString*)findDBPath;
#pragma mark - New client

- (BOOL) SaveClientDetail:(ClientInfo*)client;

-(NSMutableArray*)receiveAllData;

-(NSMutableArray*)receiveAllDataDESC;

-(NSMutableArray*)receiveSpecificClientfromClientsList:(NSString*)Client;

-(BOOL)updateClientDetail:(ClientInfo*)client whereCompName:(NSString*)CompName;

-(BOOL)deleteClientFromClientsList:(ClientInfo*)Client;
-(BOOL)IsclientAvailble:(ClientInfo*)Client;

#pragma mark - new ticket

-(BOOL)SaveNewTicket:(ClientInfo*)ticket;

-(NSMutableArray*)receiveAllDataFromNewTicket;

-(NSMutableArray*)reciveAllOpenAndPaidTickets:(ClientInfo*)client;

-(NSMutableArray*)RecieveSpecificClientsOpenAndPaidTickets:(ClientInfo*)Client;

-(NSMutableArray*)RecieveTotalCompanysAllTickets:(ClientInfo*)Client;

-(NSMutableArray*)RecieveSpecificClientsOpenAndPaidTicketsASC:(ClientInfo*)Client;

-(NSMutableArray*)reciveAllOpenAndPaidTicketsDESC:(ClientInfo*)client;

-(NSMutableArray*)receiveAllDataFromNewTicketDESC;



-(BOOL)updateTicketDetail:(ClientInfo*)ticket;

-(BOOL)IsTicketAvailable:(NSInteger)invoice;

-(BOOL)SaveTicketWithInvoice:(ClientInfo*)ticket;

@end
