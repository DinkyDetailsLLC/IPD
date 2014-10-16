//
//  MapViewController.m
//  SnowPush
//
//  Created by Dannis on 9/25/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
{
MKPinAnnotationView *annotationView;
    CLLocationCoordinate2D userCord;
    MKPolyline *routeLine;
    UIColor* pathColor;
}
@property (strong, nonatomic) CLLocation *selectedLocation;
@end

@implementation MapViewController
@synthesize MyMapVIew;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MyMapVIew.delegate=self;
    MyMapVIew.showsUserLocation = YES;
    
    if ([AppDelegate sharedInstance].DeviceHieght==480) {
       MyMapVIew.frame=CGRectMake(0, 51, 320, 429);
    
    }
    pathColor=[UIColor redColor];
    [self updateMaps];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)MapBackBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    userCord=userLocation.location.coordinate;
    [MyMapVIew setCenterCoordinate:mapView.userLocation.location.coordinate animated:YES];
}

- (void)updateMaps {
    //6
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressDictionary:self.placeDictionary completionHandler:^(NSArray *placemarks, NSError *error) {
        if([placemarks count]) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            CLLocation *location = placemark.location;
            CLLocationCoordinate2D coordinate = location.coordinate;
            for (id<MKAnnotation> annotation in self.MyMapVIew.annotations)
            {
               // NSLog(@" in for annotation ");
                if ([annotation isKindOfClass:[MapPoint class]])
                {
                 //   NSLog(@"in if annotation");
                    [self.MyMapVIew removeAnnotation:annotation];
                }
            }
            MapPoint *placeObject = [[MapPoint alloc] initWithName:[NSString stringWithFormat:@"%@",[self.placeDictionary objectForKey:@"Street"]] address:nil coordinate:coordinate];
            [self.MyMapVIew addAnnotation:placeObject];
           
            MKPlacemark *destItem=[[MKPlacemark alloc]initWithPlacemark:placemark];
        
            MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
            request.source = [MKMapItem mapItemForCurrentLocation];
            request.transportType = MKDirectionsTransportTypeAny;
            request.destination = [[MKMapItem alloc]initWithPlacemark:destItem];
            request.requestsAlternateRoutes = YES;
            
            
            MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
            // __block typeof(self) weakSelf = self;
            [directions calculateDirectionsWithCompletionHandler:
             ^(MKDirectionsResponse *response, NSError *error) {
                 
                 //stop loading animation here
                 
                 if (error) {
                     NSLog(@"Error is %@",error);
                 } else {
                     //do something about the response, like draw it on map
                     MKRoute *route = [response.routes firstObject];
                     [self.MyMapVIew addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
                 }
             }];
            
            
//            MKMapPoint *PointArray=malloc(sizeof(CLLocationCoordinate2D)*2);
//            PointArray[0]=MKMapPointForCoordinate(userCord);
//            PointArray[1]=MKMapPointForCoordinate(coordinate);
//            
//            routeLine=[MKPolyline polylineWithPoints:PointArray count:2];
//            
//            free(PointArray);
//            [MyMapVIew addOverlay:routeLine level:MKOverlayLevelAboveRoads];
        
            MKCoordinateRegion region;
            region.center.latitude=(userCord.latitude+coordinate.latitude)/2;
            region.center.longitude=(userCord.longitude+coordinate.longitude)/2;
          //  region.span.latitudeDelta=userCord.latitude-coordinate.latitude;
            
          //  [self.MyMapVIew setRegion:region];
           
            
          //  [self.MyMapVIew setCenterCoordinate:coordinate animated:YES];
        } else {
            NSLog(@"error");
        }
    }];
    
}

#pragma mark - MKMapViewDelegate methods.

-(MKOverlayView*)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    MKOverlayView *overlayview=nil;
    
    MKPolylineView *routeLineView=[[MKPolylineView alloc]initWithOverlay:overlay];
    routeLineView.fillColor=pathColor;
    routeLineView.strokeColor=pathColor;
    routeLineView.lineWidth=5;
    routeLineView.lineCap=kCGLineJoinMiter;
    overlayview=routeLineView;
    return overlayview;
}

/*- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"4");
    //Zoom back to the user location after adding a new set of annotations.
    
    //Get the center point of the visible map.
    
    CLLocationCoordinate2D centre = [mv centerCoordinate];
    
    MKCoordinateRegion region;
    
    //If this is the first launch of the app then set the center point of the map to the user's location.
    if (firstLaunch) {
        region = MKCoordinateRegionMakeWithDistance(Locmangr.location.coordinate,10000,10000);
        firstLaunch=NO;
    }else {
        //Set the center point to the visible region of the map and change the radius to match the search radius passed to the Google query string.
        region = MKCoordinateRegionMakeWithDistance(centre,1000,1000);
    }
    
    //Set the visible region of the map.
    [mv setRegion:region animated:YES];
    
}*/

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    //Define our reuse indentifier.
    static NSString *identifier = @"MapPoint";
   // NSLog(@"5");
    
    if ([annotation isKindOfClass:[MapPoint class]]) {
        
        annotationView = (MKPinAnnotationView *) [self.MyMapVIew dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        annotationView.pinColor=MKPinAnnotationColorRed;
        //Get an image to display on the left hand side of the callout.
//        UIImageView *test = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map_marker.png"]];
//        
//        //Resize the image to make it fit nicely.
//        [test setFrame:CGRectMake(0, 0, 30, 30)];
//        
//        //Set the image in the callout.
//        annotationView.leftCalloutAccessoryView = test;
        
        // [identifier release];
        return annotationView;
    }
    
    return nil;
}
/*- (void)plotPositions:(NSArray *)data
{
    
    //Remove any existing custom annotations but not the user location blue dot.
    if (data==nil) {
        NSLog(@"data is nil");
    }else{
        
        for (id<MKAnnotation> annotation in NearMeMap.annotations)
        {
            NSLog(@" in for annotation ");
            if ([annotation isKindOfClass:[MapPoint class]])
            {
                NSLog(@"in if annotation");
                [NearMeMap removeAnnotation:annotation];
            }
        }
        
        int i;
        //Loop through the array of places returned from the Google API.
        for (i=0; i<[data count]; i++)
        {
            
            //Retrieve the NSDictionary object in each index of the array.
            NSDictionary* place = [data objectAtIndex:i];
            
            //There is a specific NSDictionary object that gives us location info.
            NSDictionary *geo = [place objectForKey:@"geometry"];
            
            
            //Get our name and address info for adding to a pin.
            NSString *name=[place objectForKey:@"name"];
            NSString *vicinity=[place objectForKey:@"vicinity"];
            
            //Get the lat and long for the location.
            NSDictionary *loc = [geo objectForKey:@"location"];
            
            //Create a special variable to hold this coordinate info.
            CLLocationCoordinate2D placeCoord;
            
            //Set the lat and long.
            placeCoord.latitude=[[loc objectForKey:@"lat"] doubleValue];
            placeCoord.longitude=[[loc objectForKey:@"lng"] doubleValue];
            
            //Create a new annotiation.
            MapPoint *placeObject = [[MapPoint alloc] initWithName:name address:vicinity coordinate:placeCoord];
            
            
            [NearMeMap addAnnotation:placeObject];
            
            //[place release];
            // [geo release];
            // [name release];
            // [vicinity release];
            // [loc release];
            
        }
        
    }
    
}*/



@end
