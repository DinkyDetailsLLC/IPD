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

- (void)findDBPath
{
    NSString *databaseName = @"SnowPush.sqlite";
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    databasepath = [[NSString alloc] initWithFormat:@"%@", [documentsDir stringByAppendingPathComponent:databaseName]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:databasepath];
    
    if(!success) {
        NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
        [fileManager copyItemAtPath:databasePathFromApp toPath:databasepath error:nil];
    }
    
    
}


#pragma mark - coupon methods

- (BOOL) SaveClientDetail:(ClientInfo*)client{
    //[self findDBPath];
    const char *dbpath = [databasepath UTF8String];
    // NSLog(@"DBPATH:%s",dbpath);
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        /* CREATE TABLE "ClientDetail" ("Comp_Name" TEXT, "Address" TEXT, "city" TEXT, "state" TEXT, "zip" TEXT, "PhoneNo" TEXT, "email" TEXT, "Image" TEXT, "tripCost" TEXT, "contactCost" TEXT, "seasonalCost" TEXT) */
       
        NSString *insertSQL = [NSString stringWithFormat:@"insert into ClientDetail (Comp_Name,Address,city,state,zip,PhoneNo,email,Image,tripCost,contactCost,seasonalCost) values(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",client.Comp_name,client.Address,client.City,client.State,client.Zip,client.phoneNo,client.Email,client.Image,client.TripCost,client.ContractCost,client.SeasonalCost];
        
        //  NSLog(@"%@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        // NSLog(@"%i",sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL));
        
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        
        //  NSLog(@"%i",sqlite3_step(statement));
        //  NSLog(@"error %s.",sqlite3_errmsg(database));
        
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
        NSString *selectSQL=[NSString stringWithFormat:@"select * from ClientDetail"];
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
                [record addObject:CInfo];
            }
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
    return record;
    
}

-(BOOL)CheckCouponId:(NSString*)CoupId
{
    // NSMutableArray *record = [[NSMutableArray alloc]init];
    // NSLog(@"%@",databasepath);
    // NSLog(@"%s",[databasepath UTF8String]);
    const char *dbpath=[databasepath UTF8String];
    //NSLog(@"DBPATH:%s",dbpath);
    if (sqlite3_open(dbpath, &database)==SQLITE_OK) {
        NSString *selectSQL=[NSString stringWithFormat:@"select * from FavoriteList where cid=\"%@\"",CoupId];
        const char *select_stmt=[selectSQL UTF8String];
        // NSLog(@"%i",sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL));
        int res = sqlite3_prepare_v2(database, select_stmt, -1, &statement, NULL);
        if (res!=SQLITE_OK){
            //  NSLog(@"Problem with prepare statement.");
        }
        else{
            //NSInteger temp=0,num=0;
            
            if (sqlite3_step(statement)==SQLITE_ROW){
                sqlite3_finalize(statement);
                sqlite3_close(database);
                return YES;
                
            }else{
                sqlite3_finalize(statement);
                sqlite3_close(database);
                return NO;
            }
        }
        sqlite3_reset(statement);
        
    }
    // sqlite3_finalize(statement);
    sqlite3_close(database);
    return NO;
}

//-(BOOL)deleteDataFromFavoritesList:(ClientInfo*)coupon
//{
//    //[self findDBPath];
//    BOOL isSuccess=NO;
//    //   [self findDBPath];
//    //NSLog(@"%@",databasepath);
//    
//    const char *dbpath=[databasepath UTF8String];
//    
//    // NSLog(@"DBPATH:%s",dbpath);
//    
//    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
//    {
//        NSString *deleteSQL = [NSString stringWithFormat:@"delete from FavoriteList where cid=\"%@\"",coupon.C_ID];
//        
//        // NSLog(@"%@",deleteSQL);
//        const char *delete_stmt = [deleteSQL UTF8String];
//        sqlite3_prepare_v2(database, delete_stmt,-1, &statement, NULL);
//        //NSLog(@"%d",sqlite3_step(statement));
//        if (sqlite3_step(statement) == SQLITE_DONE)
//        {
//            sqlite3_close(database);
//            isSuccess=YES;
//        }
//        else {
//            sqlite3_close(database);
//            
//            isSuccess=NO;
//        }
//        sqlite3_reset(statement);
//    }
//    sqlite3_finalize(statement);
//    sqlite3_close(database);
//    return isSuccess;
//}
@end