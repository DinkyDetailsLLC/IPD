//
//  DataBase.m
//  SnowPush
//
//  Created by Dannis on 9/25/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import "DataBase.h"

#import <sqlite3.h>

static DataBase *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;


@implementation DataBase

#pragma mark - get shared instance method

+(DataBase*)getSharedInstance
{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance findDBPath];
    }
    return sharedInstance;
}

#pragma mark - find dbpath method

- (NSString*)findDBPath
{
    NSString *databaseName = @"NewSnowPush.sqlite";
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    databasepath = [[NSString alloc] initWithFormat:@"%@", [documentsDir stringByAppendingPathComponent:databaseName]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:databasepath];
    
    if(!success) {
        NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
        [fileManager copyItemAtPath:databasePathFromApp toPath:databasepath error:nil];
    }
    return databasepath;
    
}


#pragma mark - coupon methods

- (BOOL) SaveClientDetail:(ClientInfo*)client{
    //[self findDBPath];
    const char *dbpath = [databasepath UTF8String];
    // NSLog(@"DBPATH:%s",dbpath);
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
       
       
        NSString *insertSQL = [NSString stringWithFormat:@"insert into ClientDetail (Comp_Name,Address,city,state,zip,PhoneNo,email,Image,tripCost,contactCost,seasonalCost,Salt,shovel,plow,removal) values(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",%d,%d,%d,%d)",client.Comp_name,client.Address,client.City,client.State,client.Zip,client.phoneNo,client.Email,client.Image,client.TripCost,client.ContractCost,client.SeasonalCost,client.salt,client.shovel,client.plow,client.removal];
        
        //  NSLog(@"%@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        // NSLog(@"%i",sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL));
        
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        
        //  NSLog(@"%i",sqlite3_step(statement));
         NSLog(@"error %s.",sqlite3_errmsg(database));
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        { sqlite3_finalize(statement);
            sqlite3_close(database);
            return YES;
        }
        else { sqlite3_finalize(statement);
            sqlite3_close(database);
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}


-(NSMutableArray*)receiveAllData
{
    //[self findDBPath];
    NSMutableArray *record = [[NSMutableArray alloc]init];
    //  NSLog(@"%@",databasepath);
    //  NSLog(@"%s",[databasepath UTF8String]);
    const char *dbpath=[databasepath UTF8String];
    //NSLog(@"DBPATH:%s",dbpath);
    if (sqlite3_open(dbpath, &database)==SQLITE_OK) {
        NSString *selectSQL=[NSString stringWithFormat:@"select * from ClientDetail order by Comp_Name asc"];
        const char *select_stmt=[selectSQL UTF8String];
        // NSLog(@"%i",sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL));
        int res = sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL);
        if (res!=SQLITE_OK){
            // NSLog(@"Problem with prepare statement.");
        }
        else{
            //NSInteger temp=0,num=0;
            
            while(sqlite3_step(statement)==SQLITE_ROW){
                CInfo = [[ClientInfo alloc]init];
                
                // medInfo.ID=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]intValue];
                
                CInfo.Comp_name=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)];
                CInfo.Address=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
                CInfo.City=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
                CInfo.State=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
                CInfo.Zip=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 4)];
                CInfo.phoneNo=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 5)];
                CInfo.Email=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 6)];
                CInfo.Image=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 7)];
                CInfo.TripCost=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 8)];
                CInfo.ContractCost=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 9)];
                CInfo.SeasonalCost=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 10)];
                CInfo.salt=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 11)]intValue];
                CInfo.shovel=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 12)]intValue];
                CInfo.plow=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 13)]intValue];
                CInfo.removal=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 14)]intValue];
                [record addObject:CInfo];
            }
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
    return record;
    
}

-(NSMutableArray*)receiveAllDataDESC
{
    //[self findDBPath];
    NSMutableArray *record = [[NSMutableArray alloc]init];
    //  NSLog(@"%@",databasepath);
    //  NSLog(@"%s",[databasepath UTF8String]);
    const char *dbpath=[databasepath UTF8String];
    //NSLog(@"DBPATH:%s",dbpath);
    if (sqlite3_open(dbpath, &database)==SQLITE_OK) {
        NSString *selectSQL=[NSString stringWithFormat:@"select * from ClientDetail order by Comp_Name desc"];
        const char *select_stmt=[selectSQL UTF8String];
        // NSLog(@"%i",sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL));
        int res = sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL);
        if (res!=SQLITE_OK){
            // NSLog(@"Problem with prepare statement.");
        }
        else{
            //NSInteger temp=0,num=0;
            
            while(sqlite3_step(statement)==SQLITE_ROW){
                CInfo = [[ClientInfo alloc]init];
                
                // medInfo.ID=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]intValue];
                
                CInfo.Comp_name=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)];
                CInfo.Address=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
                CInfo.City=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
                CInfo.State=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
                CInfo.Zip=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 4)];
                CInfo.phoneNo=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 5)];
                CInfo.Email=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 6)];
                CInfo.Image=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 7)];
                CInfo.TripCost=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 8)];
                CInfo.ContractCost=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 9)];
                CInfo.SeasonalCost=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 10)];
                CInfo.salt=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 11)]intValue];
                CInfo.shovel=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 12)]intValue];
                CInfo.plow=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 13)]intValue];
                CInfo.removal=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 14)]intValue];
                [record addObject:CInfo];
            }
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
    return record;
    
}

-(NSMutableArray*)receiveSpecificClientfromClientsList:(NSString*)Client
{
    //[self findDBPath];
    NSMutableArray *record = [[NSMutableArray alloc]init];
    //  NSLog(@"%@",databasepath);
    //  NSLog(@"%s",[databasepath UTF8String]);
    const char *dbpath=[databasepath UTF8String];
    //NSLog(@"DBPATH:%s",dbpath);
    if (sqlite3_open(dbpath, &database)==SQLITE_OK) {
        NSString *selectSQL=[NSString stringWithFormat:@"select * from ClientDetail where Comp_Name=\"%@\"",Client];
        const char *select_stmt=[selectSQL UTF8String];
        // NSLog(@"%i",sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL));
        int res = sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL);
        if (res!=SQLITE_OK){
            // NSLog(@"Problem with prepare statement.");
        }
        else{
            //NSInteger temp=0,num=0;
            
            while(sqlite3_step(statement)==SQLITE_ROW){
                CInfo = [[ClientInfo alloc]init];
                
                // medInfo.ID=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]intValue];
                
                CInfo.Comp_name=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)];
                CInfo.Address=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
                CInfo.City=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
                CInfo.State=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
                CInfo.Zip=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 4)];
                CInfo.phoneNo=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 5)];
                CInfo.Email=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 6)];
                CInfo.Image=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 7)];
                CInfo.TripCost=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 8)];
                CInfo.ContractCost=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 9)];
                CInfo.SeasonalCost=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 10)];
                CInfo.salt=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 11)]intValue];
                CInfo.shovel=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 12)]intValue];
                CInfo.plow=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 13)]intValue];
                CInfo.removal=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 14)]intValue];
                [record addObject:CInfo];
            }
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
    return record;
    
}

-(BOOL)updateClientDetail:(ClientInfo*)client whereCompName:(NSString*)CompName
{
    BOOL isSuccess;
    
    const char *dbpath = [databasepath UTF8String];
    
    // NSLog(@"DBPATH:%s",dbpath);
    
    // BOOL isSuccess=NO;
    
    // NSLog(@"updateing contact");
    
    //sqlite3_stmt *statement;
    
    //const char*dbpath=[databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        
    {
        
         /* CREATE TABLE "ClientDetail" ("Comp_Name" TEXT, "Address" TEXT, "city" TEXT, "state" TEXT, "zip" TEXT, "PhoneNo" TEXT, "email" TEXT, "Image" TEXT, "tripCost" TEXT, "contactCost" TEXT, "seasonalCost" TEXT, "Salt" INTEGER DEFAULT 0, "shovel" INTEGER DEFAULT 0, "plow" INTEGER DEFAULT 0, "removal" INTEGER DEFAULT 0) */
        
        
        NSString *querySQL = [NSString stringWithFormat:@"update ClientDetail set Comp_Name=\"%@\",Address=\"%@\",city=\"%@\",state=\"%@\",zip=\"%@\",PhoneNo=\"%@\",email=\"%@\",Image=\"%@\",tripCost=\"%@\",contactCost=\"%@\",seasonalCost=\"%@\",Salt=%d,shovel=%d,plow=%d,removal=%d where Comp_Name=\"%@\" ",client.Comp_name,client.Address,client.City,client.State,client.Zip,client.phoneNo,client.Email,client.Image,client.TripCost,client.ContractCost,client.SeasonalCost,client.salt,client.shovel,client.plow,client.removal,CompName];
        
        //NSLog(@"%@",querySQL);
        
        const char *update_stmt = [querySQL UTF8String];
        
        // NSLog(@" error msg.%s",sqlite3_errmsg(database));
        
        // NSLog(@"%i",sqlite3_prepare_v2(database, update_stmt, -1, &statement, NULL));
        
        if(sqlite3_prepare_v2(database, update_stmt, -1, &statement, NULL)==SQLITE_OK)
            
        {
            
            //                        NSLog(@"---> %d",sqlite3_step(statement));
            
            //            //sqlite3_bind_text(statement,1,update_stmt,-1,SQLITE_TRANSIENT);
            
            //            NSLog(@"%i",sqlite3_step(statement));
            
            if (sqlite3_step(statement) == SQLITE_DONE)
                
            {
                
                isSuccess=YES;
                
                //  NSLog(@"Updated");
                
                
                
            }
            
            else
                
            {
                
                isSuccess=NO;
                
                //  NSLog(@"File to update");
                
            }
            
            sqlite3_finalize(statement);
            
        }
        
        sqlite3_close(database);
        
    }
    
    return isSuccess;
}

-(BOOL)deleteClientFromClientsList:(ClientInfo*)Client
{
    //[self findDBPath];
    BOOL isSuccess=NO;
    //   [self findDBPath];
    // NSLog(@"%@",databasepath);
    
    const char *dbpath=[databasepath UTF8String];
    
    // NSLog(@"DBPATH:%s",dbpath);
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *deleteSQL = [NSString stringWithFormat:@"delete from ClientDetail where Comp_Name=\"%@\" and email=\"%@\"",Client.Comp_name,Client.Email];
        
        // NSLog(@"%@",deleteSQL);
        const char *delete_stmt = [deleteSQL UTF8String];
        sqlite3_prepare_v2(database, delete_stmt,-1, &statement, NULL);
        //NSLog(@"%d",sqlite3_step(statement));
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            sqlite3_close(database);
            isSuccess=YES;
        }
        else {
            sqlite3_close(database);
            
            isSuccess=NO;
        }
        sqlite3_reset(statement);
    }
    sqlite3_close(database);
    return isSuccess;
}


-(BOOL)IsclientAvailble:(ClientInfo*)Client
{
    //[self findDBPath];
    
    BOOL Check=NO;
    
  //  NSMutableArray *record = [[NSMutableArray alloc]init];
    //  NSLog(@"%@",databasepath);
    //  NSLog(@"%s",[databasepath UTF8String]);
    const char *dbpath=[databasepath UTF8String];
    //NSLog(@"DBPATH:%s",dbpath);
    if (sqlite3_open(dbpath, &database)==SQLITE_OK) {
        NSString *selectSQL=[NSString stringWithFormat:@"select * from ClientDetail where Comp_Name=\"%@\" and email=\"%@\"",Client.Comp_name,Client.Email];
        const char *select_stmt=[selectSQL UTF8String];
        // NSLog(@"%i",sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL));
        int res = sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL);
        if (res!=SQLITE_OK){
            // NSLog(@"Problem with prepare statement.");
        }
        else{
            //NSInteger temp=0,num=0;
            
            if (sqlite3_step(statement)==SQLITE_ROW){
                Check=YES;
            }else{
                Check=NO;
            }
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
    return Check;
    
}

#pragma mark - newTicket table methods

-(BOOL)SaveNewTicket:(ClientInfo*)ticket
{
  /* CREATE TABLE "NewTicket" ("invoice_no" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE  DEFAULT 0, "date" TEXT, "comp_name" TEXT, "start_time" TEXT, "finish_time" TEXT, "phone_num" TEXT, "email" TEXT, "image_before" TEXT, "image_after" TEXT, "snow_fall" TEXT, "hours" INTEGER, "calculated" INTEGER, "trip" INTEGER DEFAULT 0, "contract" INTEGER DEFAULT 0, "seasonal" INTEGER DEFAULT 0, "send_invoice" INTEGER DEFAULT 0, "paid_in_full" INTEGER DEFAULT 0)*/
    
    
    const char *dbpath = [databasepath UTF8String];
    // NSLog(@"DBPATH:%s",dbpath);
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        
    //    NSString *insertSQL = [NSString stringWithFormat:@"insert into ClientDetail (Comp_Name,Address,city,state,zip,PhoneNo,email,Image,tripCost,contactCost,seasonalCost,Salt,shovel,plow,removal) values(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",%d,%d,%d,%d)",client.Comp_name,client.Address,client.City,client.State,client.Zip,client.phoneNo,client.Email,client.Image,client.TripCost,client.ContractCost,client.SeasonalCost,client.salt,client.shovel,client.plow,client.removal];
        
        
        NSString *insertSQL=[NSString stringWithFormat:@"insert into NewTicket(date,comp_name,start_time,finish_time,phone_num,email,image_before,image_after,snow_fall,hours,calculated,trip,contract,seasonal,send_invoice,paid_in_full) values(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",%d,%d,%d,%d,%d,%d,%d)",ticket.date,ticket.Comp_name,ticket.startTime,ticket.finishTime,ticket.phoneNo,ticket.Email,ticket.imageBefore,ticket.imageAfter,ticket.snowFall,ticket.hours,ticket.calculated,ticket.trip,ticket.contract,ticket.seasonal,ticket.sendInVoice,ticket.paidInFull];
        //  NSLog(@"%@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        // NSLog(@"%i",sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL));
        
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        
        //  NSLog(@"%i",sqlite3_step(statement));
        NSLog(@"error %s.",sqlite3_errmsg(database));
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        { sqlite3_finalize(statement);
            sqlite3_close(database);
            return YES;
        }
        else { sqlite3_finalize(statement);
            sqlite3_close(database);
            return NO;
        }
        sqlite3_reset(statement);
    }
    
    return NO;
}

-(NSMutableArray*)receiveAllDataFromNewTicket
{
    //[self findDBPath];
    NSMutableArray *record = [[NSMutableArray alloc]init];
    //  NSLog(@"%@",databasepath);
    //  NSLog(@"%s",[databasepath UTF8String]);
    const char *dbpath=[databasepath UTF8String];
    //NSLog(@"DBPATH:%s",dbpath);
    if (sqlite3_open(dbpath, &database)==SQLITE_OK) {
        NSString *selectSQL=[NSString stringWithFormat:@"select * from NewTicket order by comp_name asc"];
        const char *select_stmt=[selectSQL UTF8String];
        // NSLog(@"%i",sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL));
        int res = sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL);
        if (res!=SQLITE_OK){
            // NSLog(@"Problem with prepare statement.");
        }
        else{
            //NSInteger temp=0,num=0;
            
            while(sqlite3_step(statement)==SQLITE_ROW){
                CInfo = [[ClientInfo alloc]init];
                
                // medInfo.ID=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]intValue];
                CInfo.invoice_no=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]integerValue];
                CInfo.date=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
                CInfo.Comp_name=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
                CInfo.startTime=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
                CInfo.finishTime=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 4)];
                CInfo.phoneNo=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 5)];
                CInfo.Email=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 6)];
                CInfo.imageBefore=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 7)];
                CInfo.imageAfter=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 8)];
                CInfo.snowFall=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 9)];
                CInfo.hours=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 10)]intValue];
                CInfo.calculated=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 11)]intValue];
                CInfo.trip=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 12)]intValue];
                CInfo.contract=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 13)]intValue];
                CInfo.seasonal=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 14)]intValue];
                CInfo.sendInVoice=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 15)]intValue];
                CInfo.paidInFull=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 16)]intValue];
                [record addObject:CInfo];
            }
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
    return record;
    
}

-(NSMutableArray*)receiveAllDataFromNewTicketDESC
{
    //[self findDBPath];
    NSMutableArray *record = [[NSMutableArray alloc]init];
    //  NSLog(@"%@",databasepath);
    //  NSLog(@"%s",[databasepath UTF8String]);
    const char *dbpath=[databasepath UTF8String];
    //NSLog(@"DBPATH:%s",dbpath);
    if (sqlite3_open(dbpath, &database)==SQLITE_OK) {
        NSString *selectSQL=[NSString stringWithFormat:@"select * from NewTicket order by comp_name desc"];
        const char *select_stmt=[selectSQL UTF8String];
        // NSLog(@"%i",sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL));
        int res = sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL);
        if (res!=SQLITE_OK){
            // NSLog(@"Problem with prepare statement.");
        }
        else{
            //NSInteger temp=0,num=0;
            
            while(sqlite3_step(statement)==SQLITE_ROW){
                CInfo = [[ClientInfo alloc]init];
                
                // medInfo.ID=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]intValue];
                 CInfo.invoice_no=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]integerValue];
                CInfo.date=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
                CInfo.Comp_name=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
                CInfo.startTime=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
                CInfo.finishTime=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 4)];
                CInfo.phoneNo=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 5)];
                CInfo.Email=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 6)];
                CInfo.imageBefore=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 7)];
                CInfo.imageAfter=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 8)];
                CInfo.snowFall=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 9)];
                CInfo.hours=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 10)]intValue];
                CInfo.calculated=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 11)]intValue];
                CInfo.trip=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 12)]intValue];
                CInfo.contract=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 13)]intValue];
                CInfo.seasonal=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 14)]intValue];
                CInfo.sendInVoice=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 15)]intValue];
                CInfo.paidInFull=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 16)]intValue];
                [record addObject:CInfo];
            }
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
    return record;
    
}

-(NSMutableArray*)reciveAllOpenAndPaidTickets:(ClientInfo*)client
{
    NSMutableArray *record = [[NSMutableArray alloc]init];
    //  NSLog(@"%@",databasepath);
    //  NSLog(@"%s",[databasepath UTF8String]);
    const char *dbpath=[databasepath UTF8String];
    //NSLog(@"DBPATH:%s",dbpath);
    if (sqlite3_open(dbpath, &database)==SQLITE_OK) {
        NSString *selectSQL=[NSString stringWithFormat:@"select * from NewTicket where paid_in_full=%d order by comp_name asc",client.paidInFull];
        const char *select_stmt=[selectSQL UTF8String];
        // NSLog(@"%i",sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL));
        int res = sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL);
        if (res!=SQLITE_OK){
            // NSLog(@"Problem with prepare statement.");
        }
        else{
            //NSInteger temp=0,num=0;
            
            while(sqlite3_step(statement)==SQLITE_ROW){
                CInfo = [[ClientInfo alloc]init];
                
                // medInfo.ID=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]intValue];
                 CInfo.invoice_no=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]integerValue];
                CInfo.date=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
                CInfo.Comp_name=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
                CInfo.startTime=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
                CInfo.finishTime=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 4)];
                CInfo.phoneNo=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 5)];
                CInfo.Email=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 6)];
                CInfo.imageBefore=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 7)];
                CInfo.imageAfter=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,8)];
                CInfo.snowFall=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 9)];
                CInfo.hours=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 10)]intValue];
                CInfo.calculated=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 11)]intValue];
                CInfo.trip=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 12)]intValue];
                CInfo.contract=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 13)]intValue];
                CInfo.seasonal=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 14)]intValue];
                CInfo.sendInVoice=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 15)]intValue];
                CInfo.paidInFull=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 16)]intValue];
                [record addObject:CInfo];
            }
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
    return record;

}

-(NSMutableArray*)reciveAllOpenAndPaidTicketsDESC:(ClientInfo*)client
{
    NSMutableArray *record = [[NSMutableArray alloc]init];
    //  NSLog(@"%@",databasepath);
    //  NSLog(@"%s",[databasepath UTF8String]);
    const char *dbpath=[databasepath UTF8String];
    //NSLog(@"DBPATH:%s",dbpath);
    if (sqlite3_open(dbpath, &database)==SQLITE_OK) {
        NSString *selectSQL=[NSString stringWithFormat:@"select * from NewTicket where paid_in_full=%d order by comp_name desc",client.paidInFull];
        const char *select_stmt=[selectSQL UTF8String];
        // NSLog(@"%i",sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL));
        int res = sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL);
        if (res!=SQLITE_OK){
            // NSLog(@"Problem with prepare statement.");
        }
        else{
            //NSInteger temp=0,num=0;
            
            while(sqlite3_step(statement)==SQLITE_ROW){
                CInfo = [[ClientInfo alloc]init];
                
                // medInfo.ID=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]intValue];
                 CInfo.invoice_no=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]integerValue];
                CInfo.date=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
                CInfo.Comp_name=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
                CInfo.startTime=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
                CInfo.finishTime=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 4)];
                CInfo.phoneNo=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 5)];
                CInfo.Email=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 6)];
                CInfo.imageBefore=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 7)];
                CInfo.imageAfter=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 8)];
                CInfo.snowFall=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 9)];
                CInfo.hours=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 10)]intValue];
                CInfo.calculated=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 11)]intValue];
                CInfo.trip=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 12)]intValue];
                CInfo.contract=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 13)]intValue];
                CInfo.seasonal=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 14)]intValue];
                CInfo.sendInVoice=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 15)]intValue];
                CInfo.paidInFull=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 16)]intValue];
                [record addObject:CInfo];
            }
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
    return record;
    
}

-(NSMutableArray*)RecieveSpecificClientsOpenAndPaidTickets:(ClientInfo*)Client
{
    NSMutableArray *record = [[NSMutableArray alloc]init];
    //  NSLog(@"%@",databasepath);
    //  NSLog(@"%s",[databasepath UTF8String]);
    const char *dbpath=[databasepath UTF8String];
    //NSLog(@"DBPATH:%s",dbpath);
    if (sqlite3_open(dbpath, &database)==SQLITE_OK) {
        NSString *selectSQL=[NSString stringWithFormat:@"select * from NewTicket where paid_in_full=%d and comp_name=\"%@\" order by date",Client.paidInFull,Client.Comp_name];
        const char *select_stmt=[selectSQL UTF8String];
        // NSLog(@"%i",sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL));
        int res = sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL);
        if (res!=SQLITE_OK){
            // NSLog(@"Problem with prepare statement.");
        }
        else{
            //NSInteger temp=0,num=0;
            
            while(sqlite3_step(statement)==SQLITE_ROW){
                CInfo = [[ClientInfo alloc]init];
                
                // medInfo.ID=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]intValue];
                 CInfo.invoice_no=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]integerValue];
                CInfo.date=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
                CInfo.Comp_name=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
                CInfo.startTime=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
                CInfo.finishTime=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 4)];
                CInfo.phoneNo=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 5)];
                CInfo.Email=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 6)];
                CInfo.imageBefore=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,7)];
                CInfo.imageAfter=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 8)];
                CInfo.snowFall=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 9)];
                CInfo.hours=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 10)]intValue];
                CInfo.calculated=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 11)]intValue];
                CInfo.trip=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 12)]intValue];
                CInfo.contract=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 13)]intValue];
                CInfo.seasonal=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 14)]intValue];
                CInfo.sendInVoice=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 15)]intValue];
                CInfo.paidInFull=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 16)]intValue];
                [record addObject:CInfo];
            }
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
    return record;

}

-(NSMutableArray*)RecieveSpecificClientsOpenAndPaidTicketsASC:(ClientInfo*)Client
{
    NSMutableArray *record = [[NSMutableArray alloc]init];
    //  NSLog(@"%@",databasepath);
    //  NSLog(@"%s",[databasepath UTF8String]);
    const char *dbpath=[databasepath UTF8String];
    //NSLog(@"DBPATH:%s",dbpath);
    if (sqlite3_open(dbpath, &database)==SQLITE_OK) {
        NSString *selectSQL=[NSString stringWithFormat:@"select * from NewTicket where paid_in_full=%d and comp_name=\"%@\" order by date desc",Client.paidInFull,Client.Comp_name];
        const char *select_stmt=[selectSQL UTF8String];
        // NSLog(@"%i",sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL));
        int res = sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL);
        if (res!=SQLITE_OK){
            // NSLog(@"Problem with prepare statement.");
        }
        else{
            //NSInteger temp=0,num=0;
            
            while(sqlite3_step(statement)==SQLITE_ROW){
                CInfo = [[ClientInfo alloc]init];
                
                // medInfo.ID=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]intValue];
                 CInfo.invoice_no=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)]integerValue];
                CInfo.date=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
                CInfo.Comp_name=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
                CInfo.startTime=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
                CInfo.finishTime=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 4)];
                CInfo.phoneNo=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 5)];
                CInfo.Email=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 6)];
                CInfo.imageBefore=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 7)];
                CInfo.imageAfter=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 8)];
                CInfo.snowFall=[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 9)];
                CInfo.hours=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 10)]intValue];
                CInfo.calculated=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 11)]intValue];
                CInfo.trip=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 12)]intValue];
                CInfo.contract=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 13)]intValue];
                CInfo.seasonal=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 14)]intValue];
                CInfo.sendInVoice=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 15)]intValue];
                CInfo.paidInFull=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 16)]intValue];
                [record addObject:CInfo];
            }
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
    return record;
    
}

-(NSMutableArray*)RecieveTotalCompanysAllTickets:(ClientInfo*)Client
{
    NSMutableArray *record = [[NSMutableArray alloc]init];
    //  NSLog(@"%@",databasepath);
    //  NSLog(@"%s",[databasepath UTF8String]);
    const char *dbpath=[databasepath UTF8String];
    //NSLog(@"DBPATH:%s",dbpath);
    if (sqlite3_open(dbpath, &database)==SQLITE_OK) {
        NSString *selectSQL=[NSString stringWithFormat:@"select * from NewTicket where comp_name=\"%@\" and email=\"%@\" and paid_in_full=1",Client.Comp_name,Client.Email];
        const char *select_stmt=[selectSQL UTF8String];
        // NSLog(@"%i",sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL));
        int res = sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL);
        if (res!=SQLITE_OK){
            // NSLog(@"Problem with prepare statement.");
        }
        else{
            //NSInteger temp=0,num=0;
            
            while(sqlite3_step(statement)==SQLITE_ROW){
                CInfo = [[ClientInfo alloc]init];
                
                CInfo.calculated=[[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 10)]intValue];
             
                [record addObject:CInfo];
            }
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
    return record;
    
}

-(BOOL)updateTicketDetail:(ClientInfo*)ticket
{
    BOOL isSuccess;
    
    const char *dbpath = [databasepath UTF8String];
    
    // NSLog(@"DBPATH:%s",dbpath);
    
    // BOOL isSuccess=NO;
    
    // NSLog(@"updateing contact");
    
    //sqlite3_stmt *statement;
    
    //const char*dbpath=[databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        
    {
        
        /* CREATE TABLE "NewTicket" ("date" TEXT, "comp_name" TEXT, "start_time" TEXT, "finish_time" TEXT, "phone_num" TEXT, "email" TEXT, "image_before" TEXT, "image_after" TEXT, "snow_fall" TEXT, "hours" TEXT, "calculated" TEXT, "trip" INTEGER, "contract" INTEGER, "seasonal" INTEGER, "send_invoice" INTEGER, "paid_in_full" INTEGER)*/
        
        
        NSString *querySQL = [NSString stringWithFormat:@"update NewTicket set date=\"%@\",comp_name=\"%@\",start_time=\"%@\",finish_time=\"%@\",phone_num=\"%@\",email=\"%@\",image_before=\"%@\",image_after=\"%@\",snow_fall=\"%@\",hours=%d,calculated=%d,trip=%d,contract=%d,seasonal=%d,send_invoice=%d,paid_in_full=%d where invoice_no=%ld",ticket.date,ticket.Comp_name,ticket.startTime,ticket.finishTime,ticket.phoneNo,ticket.Email,ticket.imageBefore,ticket.imageAfter,ticket.snowFall,ticket.hours,ticket.calculated,ticket.trip,ticket.contract,ticket.seasonal,ticket.sendInVoice,ticket.paidInFull,(long)ticket.invoice_no];
        
        //NSLog(@"%@",querySQL);
        
        const char *update_stmt = [querySQL UTF8String];
        
        // NSLog(@" error msg.%s",sqlite3_errmsg(database));
        
        // NSLog(@"%i",sqlite3_prepare_v2(database, update_stmt, -1, &statement, NULL));
        
        if(sqlite3_prepare_v2(database, update_stmt, -1, &statement, NULL)==SQLITE_OK)
            
        {
            
            //                        NSLog(@"---> %d",sqlite3_step(statement));
            
            //            //sqlite3_bind_text(statement,1,update_stmt,-1,SQLITE_TRANSIENT);
            
            //            NSLog(@"%i",sqlite3_step(statement));
            
            if (sqlite3_step(statement) == SQLITE_DONE)
                
            {
                
                isSuccess=YES;
                
                //  NSLog(@"Updated");
                
                
                
            }
            
            else
                
            {
                
                isSuccess=NO;
                
                //  NSLog(@"File to update");
                
            }
            
            sqlite3_finalize(statement);
            
        }
        
        sqlite3_close(database);
        
    }
    
    return isSuccess;
}

-(BOOL)IsTicketAvailable:(NSInteger)invoice
{
    BOOL ticket=NO;
    
   // NSMutableArray *record = [[NSMutableArray alloc]init];
    //  NSLog(@"%@",databasepath);
    //  NSLog(@"%s",[databasepath UTF8String]);
    const char *dbpath=[databasepath UTF8String];
    //NSLog(@"DBPATH:%s",dbpath);
    if (sqlite3_open(dbpath, &database)==SQLITE_OK) {
        NSString *selectSQL=[NSString stringWithFormat:@"select * from NewTicket where invoice_no=%i",invoice];
        const char *select_stmt=[selectSQL UTF8String];
        // NSLog(@"%i",sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL));
        int res = sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL);
        if (res!=SQLITE_OK){
            // NSLog(@"Problem with prepare statement.");
        }
        else{
            //NSInteger temp=0,num=0;
            
            if(sqlite3_step(statement)==SQLITE_ROW){
                ticket=YES;
            }else{
                ticket=NO;
            }
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
    return ticket;
    
}

-(BOOL)SaveTicketWithInvoice:(ClientInfo*)ticket
{
    /* CREATE TABLE "NewTicket" ("invoice_no" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE  DEFAULT 0, "date" TEXT, "comp_name" TEXT, "start_time" TEXT, "finish_time" TEXT, "phone_num" TEXT, "email" TEXT, "image_before" TEXT, "image_after" TEXT, "snow_fall" TEXT, "hours" INTEGER, "calculated" INTEGER, "trip" INTEGER DEFAULT 0, "contract" INTEGER DEFAULT 0, "seasonal" INTEGER DEFAULT 0, "send_invoice" INTEGER DEFAULT 0, "paid_in_full" INTEGER DEFAULT 0)*/
    
    
    const char *dbpath = [databasepath UTF8String];
    // NSLog(@"DBPATH:%s",dbpath);
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        
        //    NSString *insertSQL = [NSString stringWithFormat:@"insert into ClientDetail (Comp_Name,Address,city,state,zip,PhoneNo,email,Image,tripCost,contactCost,seasonalCost,Salt,shovel,plow,removal) values(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",%d,%d,%d,%d)",client.Comp_name,client.Address,client.City,client.State,client.Zip,client.phoneNo,client.Email,client.Image,client.TripCost,client.ContractCost,client.SeasonalCost,client.salt,client.shovel,client.plow,client.removal];
        
        
        NSString *insertSQL=[NSString stringWithFormat:@"insert into NewTicket(invoice_no,date,comp_name,start_time,finish_time,phone_num,email,image_before,image_after,snow_fall,hours,calculated,trip,contract,seasonal,send_invoice,paid_in_full) values(%d,\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",%d,%d,%d,%d,%d,%d,%d)",ticket.invoice_no,ticket.date,ticket.Comp_name,ticket.startTime,ticket.finishTime,ticket.phoneNo,ticket.Email,ticket.imageBefore,ticket.imageAfter,ticket.snowFall,ticket.hours,ticket.calculated,ticket.trip,ticket.contract,ticket.seasonal,ticket.sendInVoice,ticket.paidInFull];
        //  NSLog(@"%@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        // NSLog(@"%i",sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL));
        
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        
        //  NSLog(@"%i",sqlite3_step(statement));
        NSLog(@"error %s.",sqlite3_errmsg(database));
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        { sqlite3_finalize(statement);
            sqlite3_close(database);
            return YES;
        }
        else { sqlite3_finalize(statement);
            sqlite3_close(database);
            return NO;
        }
        sqlite3_reset(statement);
    }
    
    return NO;
}




@end