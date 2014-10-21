//
//  AppDelegate.h
//  SnowPush
//
//  Created by Dannis on 9/22/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,NSURLConnectionDelegate>
{
    NSURLConnection *Connection;
    NSMutableData *WebData;
    
}
@property (strong, nonatomic) UIWindow *window;





@property int DeviceHieght;

@property NSString* UserCurrentAdd;

+(AppDelegate*)sharedInstance;

@end
