//
//  ViewController.m
//  SnowPush
//
//  Created by Dannis on 9/22/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import "ViewController.h"
#import "TicketViewController.h"
@interface ViewController ()
{
    NSURLConnection *Connection;
    NSMutableData *WebData;
    
}
@end

@implementation ViewController
@synthesize ReportView;
@synthesize Latitude,Longitude;
@synthesize ForeCastLab,TodaysDateLab,DateLab;
@synthesize FirstTimeLab,SecondTimeLab,ThirdTimeLab,FourthTimeLab,FifthTimeLab,SixthTimeLab,seventhTimeLab;
@synthesize FirstImageView,SecondImageView,ThirdImageView,FourthImageView,FifthImageView,SixthImageView,SeventhImageVIew;
@synthesize FirstTempLab,SecondTempLab,ThirdTempLab,FourthTempLab,FifthTempLab,SixthTempLab,SeventhTempLab;
@synthesize WetherTableView;
- (void)viewDidLoad
{
    //http://api.wunderground.com/api/a988d453ebe759ad/hourly/planner/conditions/forecast10day/q/-33.957550,151.230850.json
    //http://api.wunderground.com/api/a988d453ebe759ad/hourly7day/conditions/q/-33.957550,151.230850.json
    
       
  //  NSData *weatherData = [NSData dataWithContentsOfURL:url];

    [super viewDidLoad];
    ReportView.hidden=YES;
    self.manager=[[CLLocationManager alloc]init];
    self.manager.delegate=self;
    self.manager.distanceFilter=kCLDistanceFilterNone;
    self.manager.desiredAccuracy=kCLLocationAccuracyBest;
    [self.manager startUpdatingLocation];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    ReportView.hidden=YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)ClientBtnClicked:(id)sender
{
    [self performSegueWithIdentifier:@"AllClients" sender:self];
}

-(IBAction)ReportBtnClicked:(id)sender
{
 ReportView.hidden=NO;
}

-(IBAction)ViewAllTickets:(id)sender
{
    UIButton *but=(UIButton*)sender;
    TicketViewController *TicketView=[self.storyboard instantiateViewControllerWithIdentifier:@"TicketViewController"];
    TicketView.ViewTag=but.tag;
    [self.navigationController pushViewController:TicketView animated:NO];
}

-(IBAction)ViewOpenTickets:(id)sender
{
    UIButton *but=(UIButton*)sender;
    TicketViewController *TicketView=[self.storyboard instantiateViewControllerWithIdentifier:@"TicketViewController"];
    TicketView.ViewTag=but.tag;
    [self.navigationController pushViewController:TicketView animated:NO];
}

-(IBAction)ViewPaidTickets:(id)sender
{
    UIButton *but=(UIButton*)sender;
    TicketViewController *TicketView=[self.storyboard instantiateViewControllerWithIdentifier:@"TicketViewController"];
    TicketView.ViewTag=but.tag;
    [self.navigationController pushViewController:TicketView animated:NO];
}

-(IBAction)ChangeZip:(id)sender
{

}

#pragma mark - connection delegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    
    if (location != nil) {
        
        self.Latitude = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
        self.Longitude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
        
        }
    [manager stopUpdatingLocation];
   // [self CallWetherApi];
    //  [manager performSelector:@selector(startUpdatingLocation) withObject:nil afterDelay:60*30];
    NSLog(@"lat & long %@ & %@",self.Latitude,self.Longitude);
}


-(void)CallWetherApi
{
    NSString *UrlString=[NSString stringWithFormat:@"http://api.wunderground.com/api/a988d453ebe759ad/hourly/conditions/forecast/q/%@,%@.json",self.Latitude,self.Longitude];
    NSURL *url          = [NSURL URLWithString:UrlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    Connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    if(Connection)
    {
        WebData = [[NSMutableData alloc]init];
    }
    
}

#pragma mark - NSURLConnectionDelegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    if (connection==Connection) {
        [WebData setLength:0];
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if (connection==Connection) {
        [WebData appendData:data];
    }
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"can not Connect to Server" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
    // [self hideLoader];
    //  isReloading = NO ;
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    // isReloading = NO ;
    NSError *err;
    if (connection==Connection) {
        // NSString *ste=[NSJSONSerialization JSONObjectWithData:webData options:kNilOptions error:&err];
        NSArray *arr=[NSJSONSerialization JSONObjectWithData:WebData options:kNilOptions error:&err];
        //  NSDictionary *json=[NSJSONSerialization JSONObjectWithData:webData options:kNilOptions error:&err];
        NSLog(@"arr  %@ ",arr);
        
    }
}


@end
