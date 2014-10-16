//
//  MapViewController.h
//  SnowPush
//
//  Created by Dannis on 9/25/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapPoint.h"
@interface MapViewController : UIViewController<MKMapViewDelegate,MKOverlay>

@property (weak, nonatomic) IBOutlet MKMapView *MyMapVIew;

- (IBAction)MapBackBtnClicked:(id)sender;
@property (strong, nonatomic) NSMutableDictionary *placeDictionary;
@end
