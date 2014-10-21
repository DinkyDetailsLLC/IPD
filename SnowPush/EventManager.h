//
//  EventManager.h
//  SnowPush
//
//  Created by Dannis on 10/17/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@interface EventManager : NSObject

@property (nonatomic, strong) EKEventStore *eventStore;

@property (nonatomic, strong) NSString *selectedCalendarIdentifier;

@property (nonatomic, strong) NSString *selectedEventIdentifier;

@property (nonatomic) BOOL eventsAccessGranted;


-(NSArray *)getLocalEventCalendars;

-(void)saveCustomCalendarIdentifier:(NSString *)identifier;

-(BOOL)checkIfCalendarIsCustomWithIdentifier:(NSString *)identifier;

-(void)removeCalendarIdentifier:(NSString *)identifier;

-(NSString *)getStringFromDate:(NSDate *)date;

-(NSArray *)getEventsOfSelectedCalendar;

-(void)deleteEventWithIdentifier:(NSString *)identifier;

@end
