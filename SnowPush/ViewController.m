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
    NSMutableArray *ForeCastDay;
    NSMutableArray *HourlyOfToday;
    NSString *super0;
}
@end

@implementation ViewController
@synthesize ReportView;
@synthesize Latitude,Longitude;
@synthesize ForeCastLab,TodaysDateLab;
@synthesize WetherTableView;
@synthesize ReportLab,ViewAllTicketBtn,ViewOpenTicketBtn,ViewPaidTicketBtn;
@synthesize ChangeZipBtn,ClientBtn,reportBtn,ReportImageView;
@synthesize HourlyScrollView;
@synthesize lineLab1,lineLab2;
- (void)viewDidLoad
{
    // my api === 131d40d9ea437c31
    
    //client afpi == a988d453ebe759ad
    
    //http://api.wunderground.com/api/a988d453ebe759ad/hourly/planner/conditions/forecast10day/q/-33.957550,151.230850.json
    //http://api.wunderground.com/api/a988d453ebe759ad/hourly7day/conditions/q/-33.957550,151.230850.json
    
       
  //  NSData *weatherData = [NSData dataWithContentsOfURL:url];

    [super viewDidLoad];
    
   super0 = @"\u2070";

    hud=[[MBProgressHUD alloc]init];
    [self.view addSubview:hud];
    [hud show:YES];
    
    ReportView.hidden=YES;
    self.manager=[[CLLocationManager alloc]init];
    self.manager.delegate=self;
    self.manager.distanceFilter=kCLDistanceFilterNone;
    self.manager.desiredAccuracy=kCLLocationAccuracyBest;
    [self.manager startUpdatingLocation];
    
    ReportLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
    ViewAllTicketBtn.titleLabel.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
    ViewOpenTicketBtn.titleLabel.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
    ViewPaidTicketBtn.titleLabel.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
    
    if ([AppDelegate sharedInstance].DeviceHieght==480) {
        
        ForeCastLab.frame=CGRectMake(6, 58, 75, 21);
        
        TodaysDateLab.frame=CGRectMake(164, 63, 144, 16);
        
        WetherTableView.frame=CGRectMake(6, 154, 307, 146);
        
        ChangeZipBtn.frame=CGRectMake(239, 309, 78, 22);
        ClientBtn.frame=CGRectMake(85, 314, 150, 150);
        reportBtn.frame=CGRectMake(277, 442, 30, 30);
        
        ReportView.frame=CGRectMake(0, 265, 320, 273);
        ViewAllTicketBtn.frame=CGRectMake(10, 50, 300, 45);
        ViewOpenTicketBtn.frame=CGRectMake(10, 103, 300, 45);
        ViewPaidTicketBtn.frame=CGRectMake(10, 156, 300, 45);
        ReportLab.frame=CGRectMake(120, 7, 81, 23);
        ReportImageView.frame=CGRectMake(0, 0, 320, 267);
        
        lineLab1.frame=CGRectMake(6, 78, 307, 1);
        lineLab2.frame=CGRectMake(6, 152, 307, 1);
    }
    
    WetherTableView.allowsSelection=NO;
	// Do any additional setup after loading the view, typically from a nib.
  //  [self CallWetherApi];
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
    [self CallWetherApi];
    //  [manager performSelector:@selector(startUpdatingLocation) withObject:nil afterDelay:60*30];
    NSLog(@"lat & long %@ & %@",self.Latitude,self.Longitude);
}


-(void)CallWetherApi
{
    NSString *UrlString=[NSString stringWithFormat:@"http://api.wunderground.com/api/a988d453ebe759ad/hourly/conditions/forecast10day/q/%@,%@.json",self.Latitude,self.Longitude];
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
        NSDictionary *arr=[NSJSONSerialization JSONObjectWithData:WebData options:kNilOptions error:&err];
        //  NSDictionary *json=[NSJSONSerialization JSONObjectWithData:webData options:kNilOptions error:&err];
        NSLog(@"arr  %@ ",arr);
        NSArray *forecastArr=[[[arr objectForKey:@"forecast"]objectForKey:@"simpleforecast"]objectForKey:@"forecastday"];
      ForeCastDay=[[NSMutableArray alloc]init];
        HourlyOfToday=[[NSMutableArray alloc]init];
        NSDateComponents *components=[[NSCalendar currentCalendar]components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:[NSDate date]];
        NSInteger day=[components day];
        for (int i=0; i<forecastArr.count; i++) {
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            
            if ([[[[forecastArr objectAtIndex:i]objectForKey:@"date"]objectForKey:@"day"]integerValue]!=day) {
                [dic setObject:[[forecastArr objectAtIndex:i] objectForKey:@"conditions"] forKey:@"conditions"];
                [dic setObject:[[[forecastArr objectAtIndex:i]objectForKey:@"date" ] objectForKey:@"weekday"] forKey:@"day"];
                [dic setObject:[[[forecastArr objectAtIndex:i]objectForKey:@"high" ] objectForKey:@"celsius"] forKey:@"celsius"];
                [dic setObject:[[[forecastArr objectAtIndex:i] objectForKey:@"high"] objectForKey:@"fahrenheit"] forKey:@"fahrenheit"];
                [dic setObject:[[forecastArr objectAtIndex:i] objectForKey:@"icon"] forKey:@"icon"];
                [dic setObject:[[forecastArr objectAtIndex:i] objectForKey:@"icon_url"] forKey:@"icon_url"];
                [ForeCastDay addObject:dic];
            }
        }
        NSArray *HArr=[arr objectForKey:@"hourly_forecast"];
        
        for (int i=0; i<HArr.count; i++) {
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            if ([[[[HArr objectAtIndex:i]objectForKey:@"FCTTIME"]objectForKey:@"mday"]integerValue]==day) {
                [dic setObject:[[[HArr objectAtIndex:i] objectForKey:@"FCTTIME"] objectForKey:@"civil"] forKey:@"time"];
                [dic setObject:[[[HArr objectAtIndex:i]objectForKey:@"FCTTIME"] objectForKey:@"weekday_name"] forKey:@"weekday"];
                [dic setObject:[[HArr objectAtIndex:i] objectForKey:@"humidity"] forKey:@"humidity"];
                [dic setObject:[[HArr objectAtIndex:i] objectForKey:@"icon"] forKey:@"icon"];
                [dic setObject:[[HArr objectAtIndex:i] objectForKey:@"icon_url"] forKey:@"icon_url"];
                [HourlyOfToday addObject:dic];
            }
        }
        [self HourlyTempretureToday];
        [WetherTableView reloadData];
    }
}

#pragma  mark - UITableView dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ForeCastDay.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableCell *cell=(CustomTableCell*)[tableView dequeueReusableCellWithIdentifier:@"wether"];
    NSDictionary *dic=[ForeCastDay objectAtIndex:indexPath.row];
    cell.Weekday.text=[dic objectForKey:@"day"];
    
    
    cell.Celcias.text=[NSString stringWithFormat:@"%@%@",[dic objectForKey:@"celsius"],super0];
    cell.farenhite.text=[NSString stringWithFormat:@"%@%@",[dic objectForKey:@"fahrenheit"],super0];
    cell.wetherImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[dic objectForKey:@"icon_url"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
    
    return cell;
}

#pragma mark - hourly tempreture of today method

-(void)HourlyTempretureToday
{

    for (int i=0; i<HourlyOfToday.count; i++) {
        
        NSDictionary *dic=[HourlyOfToday objectAtIndex:i];
        
        UILabel *timeLab=[[UILabel alloc]initWithFrame:CGRectMake((15+30)*i, 0, 33, 20)];
        timeLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:10];
        timeLab.textColor=[UIColor whiteColor];
        timeLab.text=[dic objectForKey:@"time"];
        [self.HourlyScrollView addSubview:timeLab];
        
         UIImageView *IconImage=[[UIImageView alloc]initWithFrame:CGRectMake((15+30)*i, 22, 30, 30)];
        IconImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"icon_url"]]]];
        [self.HourlyScrollView addSubview:IconImage];
        
        UILabel *tempLab=[[UILabel alloc]initWithFrame:CGRectMake((15+30)*i, 55, 30, 20)];
       tempLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:12];
        tempLab.textColor=[UIColor whiteColor];
        NSString *time=[[dic objectForKey:@"humidity"]stringByReplacingOccurrencesOfString:@" " withString:@""];
        tempLab.text=[NSString stringWithFormat:@"%@%@",[dic objectForKey:@"humidity"],super0];
        tempLab.textAlignment=NSTextAlignmentCenter;
        [self.HourlyScrollView addSubview:tempLab];
        
    }
    [hud hide:YES];
    self.HourlyScrollView.contentSize=CGSizeMake(HourlyOfToday.count*(15+30), HourlyScrollView.frame.size.height);
    
}

@end
