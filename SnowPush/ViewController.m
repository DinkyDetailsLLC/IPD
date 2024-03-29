//
//  ViewController.m
//  SnowPush
//
//  Created by Dannis on 9/22/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import "ViewController.h"
#import "TicketViewController.h"
static sqlite3 *dbconn = nil;
#define kFILENAME @"SnowPush.xml"
#define KImagesFolderName @"SnowPushImages.zip"

// Bolean whether tutorial shown on first launch or not
bool tutsShown;

@interface ViewController ()
{
    NSURLConnection *Connection;
    NSMutableData *WebData;
    
    NSURLConnection *connection2;
    NSMutableData *Webdata2;
    
    NSMutableArray *ForeCastDay;
    NSMutableArray *HourlyOfToday;
    NSString *super0;
    int WTag;
    int documentTag;
    int tutsImageCount;
}
@end

@implementation ViewController
@synthesize ReportView;
@synthesize Latitude,Longitude;
@synthesize ForeCastLab,TodaysDateLab;
@synthesize WetherTableView;
@synthesize ReportLab,ViewAllTicketBtn,ViewOpenTicketBtn,ViewPaidTicketBtn;
@synthesize ChangeZipBtn,ClientBtn,reportBtn,ReportImageView;
@synthesize ScrollsView;
@synthesize iCloudBtn;
@synthesize document = _document;
@synthesize query = _query;
//@synthesize HourlyScrollView;
@synthesize lineLab1,lineLab2;
@synthesize tutsImageView;
@synthesize btnChangeTutImage;

- (void)viewDidLoad
{
    // my api === 131d40d9ea437c31
    
    //client afpi == a988d453ebe759ad
     // self.eventManager = [[EventManager alloc] init];
    //http://api.wunderground.com/api/a988d453ebe759ad/hourly/planner/conditions/forecast10day/q/-33.957550,151.230850.json
    //http://api.wunderground.com/api/a988d453ebe759ad/hourly7day/conditions/q/-33.957550,151.230850.json
    
       
//  NSData *weatherData = [NSData dataWithContentsOfURL:url];    45103
    
    
// Tutorial image implemeted here
    tutImages = @[@"tut_1.jpg",@"tut_2.jpg",@"tut_3.jpg",];
    tutsImageCount=0;
    if (!tutsShown) {
        [self setTutImage];
        tutsImageView.hidden=NO;
        btnChangeTutImage.hidden=NO;
    } else {
        tutsImageView.hidden=YES;
        btnChangeTutImage.hidden=YES;
        
        WTag=0;
        [super viewDidLoad];
        
        super0 = @"\u2070";
        
        hud=[[MBProgressHUD alloc]init];
        [self.view addSubview:hud];
        documentTag=0;
        
        
        ReportView.hidden=YES;
        self.manager=[[CLLocationManager alloc]init];
        self.manager.delegate=self;
        self.manager.distanceFilter=kCLDistanceFilterNone;
        self.manager.desiredAccuracy=kCLLocationAccuracyBest;
        [self.manager startUpdatingLocation];
        
        NSDateFormatter *formater=[[NSDateFormatter alloc]init];
        [formater setDateFormat:@"MM/dd/yyyy"];
        
        TodaysDateLab.text=[NSString stringWithFormat:@"Today's Date - %@",[formater stringFromDate:[NSDate date]]];
        TodaysDateLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:12];
        ReportLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
        ViewAllTicketBtn.titleLabel.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
        ViewOpenTicketBtn.titleLabel.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
        ViewPaidTicketBtn.titleLabel.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
        ForeCastLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
        if ([AppDelegate sharedInstance].DeviceHieght==480) {
            ScrollsView.frame=CGRectMake(11, 81, 298, 76);
            ForeCastLab.frame=CGRectMake(6, 58, 75, 21);
            
            TodaysDateLab.frame=CGRectMake(164, 63, 144, 16);
            
            WetherTableView.frame=CGRectMake(6, 154, 307, 146);
            
            ChangeZipBtn.frame=CGRectMake(239, 309, 78, 22);
            iCloudBtn.frame=CGRectMake(6, 309, 100, 29);
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
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSError *error;
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/MyImageFolder"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
        
        NSURL *ubiq = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
        if (ubiq) {
            NSLog(@"iCloud access at %@", ubiq);
            // TODO: Load document...
            [self loadDocument];
        } else {
            NSLog(@"No iCloud access");
        }
    }
// Tutorial images ends
    
    
//    WTag=0;
//    [super viewDidLoad];
//    
//   super0 = @"\u2070";
//
//    hud=[[MBProgressHUD alloc]init];
//    [self.view addSubview:hud];
//    documentTag=0;
//   
//    
//    ReportView.hidden=YES;
//    self.manager=[[CLLocationManager alloc]init];
//    self.manager.delegate=self;
//    self.manager.distanceFilter=kCLDistanceFilterNone;
//    self.manager.desiredAccuracy=kCLLocationAccuracyBest;
//    [self.manager startUpdatingLocation];
//    
//    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
//    [formater setDateFormat:@"MM/dd/yyyy"];
//    
//    TodaysDateLab.text=[NSString stringWithFormat:@"Today's Date - %@",[formater stringFromDate:[NSDate date]]];
//    TodaysDateLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:12];
//    ReportLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
//    ViewAllTicketBtn.titleLabel.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
//    ViewOpenTicketBtn.titleLabel.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
//    ViewPaidTicketBtn.titleLabel.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
//    ForeCastLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
//    if ([AppDelegate sharedInstance].DeviceHieght==480) {
//         ScrollsView.frame=CGRectMake(11, 81, 298, 76);
//        ForeCastLab.frame=CGRectMake(6, 58, 75, 21);
//        
//        TodaysDateLab.frame=CGRectMake(164, 63, 144, 16);
//        
//        WetherTableView.frame=CGRectMake(6, 154, 307, 146);
//        
//        ChangeZipBtn.frame=CGRectMake(239, 309, 78, 22);
//        iCloudBtn.frame=CGRectMake(6, 309, 100, 29);
//        ClientBtn.frame=CGRectMake(85, 314, 150, 150);
//        reportBtn.frame=CGRectMake(277, 442, 30, 30);
//        
//        ReportView.frame=CGRectMake(0, 265, 320, 273);
//        ViewAllTicketBtn.frame=CGRectMake(10, 50, 300, 45);
//        ViewOpenTicketBtn.frame=CGRectMake(10, 103, 300, 45);
//        ViewPaidTicketBtn.frame=CGRectMake(10, 156, 300, 45);
//        ReportLab.frame=CGRectMake(120, 7, 81, 23);
//        ReportImageView.frame=CGRectMake(0, 0, 320, 267);
//        
//        lineLab1.frame=CGRectMake(6, 78, 307, 1);
//        lineLab2.frame=CGRectMake(6, 152, 307, 1);
//    
//    }
//    
//    WetherTableView.allowsSelection=NO;
//    
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    
//    NSError *error;
//    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/MyImageFolder"];
//    
//    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
//        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
//
//    NSURL *ubiq = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
//    if (ubiq) {
//        NSLog(@"iCloud access at %@", ubiq);
//        // TODO: Load document...
//        [self loadDocument];
//    } else {
//        NSLog(@"No iCloud access");
//    }
	// Do any additional setup after loading the view, typically from a nib.
  //  [self CallWetherApi];
}


-(IBAction)tutImageChange:(id)sender{
    tutsImageCount++;
    
    if (tutsImageCount>2) {
        tutsImageView.hidden =YES;
        btnChangeTutImage.hidden=YES;
        tutsShown=YES;
        [[NSUserDefaults standardUserDefaults]setBool:tutsShown forKey:@"tutsShown"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        WTag=0;
        [super viewDidLoad];
        
        super0 = @"\u2070";
        
        hud=[[MBProgressHUD alloc]init];
        [self.view addSubview:hud];
        documentTag=0;
        
        
        ReportView.hidden=YES;
        self.manager=[[CLLocationManager alloc]init];
        self.manager.delegate=self;
        self.manager.distanceFilter=kCLDistanceFilterNone;
        self.manager.desiredAccuracy=kCLLocationAccuracyBest;
        [self.manager startUpdatingLocation];
        
        NSDateFormatter *formater=[[NSDateFormatter alloc]init];
        [formater setDateFormat:@"MM/dd/yyyy"];
        
        TodaysDateLab.text=[NSString stringWithFormat:@"Today's Date - %@",[formater stringFromDate:[NSDate date]]];
        TodaysDateLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:12];
        ReportLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
        ViewAllTicketBtn.titleLabel.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
        ViewOpenTicketBtn.titleLabel.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
        ViewPaidTicketBtn.titleLabel.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
        ForeCastLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
        if ([AppDelegate sharedInstance].DeviceHieght==480) {
            ScrollsView.frame=CGRectMake(11, 81, 298, 76);
            ForeCastLab.frame=CGRectMake(6, 58, 75, 21);
            
            TodaysDateLab.frame=CGRectMake(164, 63, 144, 16);
            
            WetherTableView.frame=CGRectMake(6, 154, 307, 146);
            
            ChangeZipBtn.frame=CGRectMake(239, 309, 78, 22);
            iCloudBtn.frame=CGRectMake(6, 309, 100, 29);
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
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSError *error;
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/MyImageFolder"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
        
        NSURL *ubiq = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
        if (ubiq) {
            NSLog(@"iCloud access at %@", ubiq);
            // TODO: Load document...
            [self loadDocument];
        } else {
            NSLog(@"No iCloud access");
        }
        
    } else [self setTutImage];
}

-(void)setTutImage{
    [tutsImageView setImage:[UIImage imageNamed:[tutImages objectAtIndex:tutsImageCount]]];
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
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please give me your current zip code so I can load the most recent data for you" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
    alert.alertViewStyle=UIAlertViewStylePlainTextInput;
    alert.tag=1;
    [alert textFieldAtIndex:0].delegate=self;
    [alert textFieldAtIndex:0].keyboardType=UIKeyboardTypeNumberPad;
    [alert show];
}

#pragma mark - connection delegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    // CLLocation *currentLocation = newLocation;
    if (location != nil) {
        
        self.Latitude = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
        self.Longitude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
        
        }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(placemarks && placemarks.count > 0)
         {
             CLPlacemark *placemark= [placemarks objectAtIndex:0];
             // address defined in .h file
            [AppDelegate sharedInstance].UserCurrentAdd = [NSString stringWithFormat:@"%@, %@, %@, %@", [placemark thoroughfare], [placemark locality], [placemark administrativeArea], [placemark country]];
             NSLog(@"New Address Is:%@", [AppDelegate sharedInstance].UserCurrentAdd);
            
         }
     }];
    
    [manager stopUpdatingLocation];
    
    NSLog(@"Resolving the Address");
  
   [self CallWetherApi];
    //  [manager performSelector:@selector(startUpdatingLocation) withObject:nil afterDelay:60*30];
    NSLog(@"lat & long %@ & %@",self.Latitude,self.Longitude);
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error;
{
   
       //  NSLog(@"%@",error);
        [hud hide:YES];
   
}

-(void)CallWetherApi
{
     [hud show:YES];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Zip"];
   NSString *UrlString=[NSString stringWithFormat:@"http://api.wunderground.com/api/131d40d9ea437c31/hourly/conditions/forecast10day/q/%@,%@.json",self.Latitude,self.Longitude];
    
    // NSString *UrlString=[NSString stringWithFormat:@"http://api.wunderground.com/api/131d40d9ea437c31/hourly/conditions/forecast10day/q/452001.json"];
    
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
    if (connection==connection2) {
        [Webdata2 setLength:0];
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if (connection==Connection) {
        [WebData appendData:data];
    }
    if (connection==connection2) {
        [Webdata2 appendData:data];
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
      //  NSLog(@"arr  %@ ",arr);
        NSDateFormatter *formater=[[NSDateFormatter alloc]init];
        [formater setDateFormat:@"HH:mm"];
        NSString *CurrentTime=[formater stringFromDate:[NSDate date]];
        NSString *checkTime=@"22:00";
        NSString *ChackTime2=@"23:00";
        
        NSComparisonResult result=[CurrentTime compare:checkTime options:NSCaseInsensitiveSearch];
        
        NSComparisonResult result2=[CurrentTime compare:ChackTime2 options:NSCaseInsensitiveSearch];
        
        NSArray *forecastArr=[[[arr objectForKey:@"forecast"]objectForKey:@"simpleforecast"]objectForKey:@"forecastday"];
      ForeCastDay=[[NSMutableArray alloc]init];
        HourlyOfToday=[[NSMutableArray alloc]init];
        NSDateComponents *components=[[NSCalendar currentCalendar]components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:[NSDate date]];
        NSInteger day=[components day];
        
        NSDate *nextDat=[[NSDate date]addTimeInterval:60*60*24];
        
        NSDateComponents *nextDayComp=[[NSCalendar currentCalendar]components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:nextDat];
        NSInteger nextday=[nextDayComp day];
        
        
        for (int i=0; i<forecastArr.count; i++) {
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            
            if ([[[[forecastArr objectAtIndex:i]objectForKey:@"date"]objectForKey:@"day"]integerValue]!=day) {
                [dic setObject:[[forecastArr objectAtIndex:i] objectForKey:@"conditions"] forKey:@"conditions"];
                [dic setObject:[[[forecastArr objectAtIndex:i]objectForKey:@"date" ] objectForKey:@"weekday"] forKey:@"day"];
                [dic setObject:[[[forecastArr objectAtIndex:i]objectForKey:@"low" ] objectForKey:@"fahrenheit"] forKey:@"celsius"];
                [dic setObject:[[[forecastArr objectAtIndex:i] objectForKey:@"high"] objectForKey:@"fahrenheit"] forKey:@"fahrenheit"];
                [dic setObject:[[forecastArr objectAtIndex:i] objectForKey:@"icon"] forKey:@"icon"];
                [dic setObject:[[forecastArr objectAtIndex:i] objectForKey:@"icon_url"] forKey:@"icon_url"];
                [ForeCastDay addObject:dic];
            }
        }
        NSArray *HArr=[arr objectForKey:@"hourly_forecast"];
        
        for (int i=0; i<HArr.count; i++) {
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
           
    
            if (result==NSOrderedAscending) {
                if (i<25) {
                    [dic setObject:[[[HArr objectAtIndex:i] objectForKey:@"FCTTIME"] objectForKey:@"civil"] forKey:@"time"];
                    [dic setObject:[[[HArr objectAtIndex:i]objectForKey:@"FCTTIME"] objectForKey:@"weekday_name"] forKey:@"weekday"];
                   [dic setObject:[[[HArr objectAtIndex:i] objectForKey:@"temp"] objectForKey:@"english"] forKey:@"tempF"];
                    [dic setObject:[[HArr objectAtIndex:i] objectForKey:@"icon"] forKey:@"icon"];
                    [dic setObject:[[HArr objectAtIndex:i] objectForKey:@"icon_url"] forKey:@"icon_url"];
                    [HourlyOfToday addObject:dic];
                }else{
                    break;
                }
            }else if (result==NSOrderedSame || (result==NSOrderedDescending && result2==NSOrderedAscending)){
                
//                if (![[NSUserDefaults standardUserDefaults]objectForKey:@"Zip"]) {
//                    if (i<10) {
//                        [dic setObject:[[[HArr objectAtIndex:i] objectForKey:@"FCTTIME"] objectForKey:@"civil"] forKey:@"time"];
//                        [dic setObject:[[[HArr objectAtIndex:i]objectForKey:@"FCTTIME"] objectForKey:@"weekday_name"] forKey:@"weekday"];
//                       [dic setObject:[[[HArr objectAtIndex:i] objectForKey:@"temp"] objectForKey:@"english"] forKey:@"tempF"];
//                        [dic setObject:[[HArr objectAtIndex:i] objectForKey:@"icon"] forKey:@"icon"];
//                        [dic setObject:[[HArr objectAtIndex:i] objectForKey:@"icon_url"] forKey:@"icon_url"];
//                        [HourlyOfToday addObject:dic];
//                    }else{
//                        break;
//                    }
//                }else{
                NSString *str=[[[HArr objectAtIndex:i] objectForKey:@"FCTTIME"] objectForKey:@"civil"];
                    
                    if ([[[[HArr objectAtIndex:i]objectForKey:@"FCTTIME"]objectForKey:@"mday"]integerValue]==day) {
                      //  NSLog(@"%@ str ",str);
                        NSArray *arrt=[str componentsSeparatedByString:@" "];
                        NSString *ampm=[arrt objectAtIndex:1];
                        NSArray *HMArr=[[arrt objectAtIndex:0] componentsSeparatedByString:@":"];
                        int hour=[[HMArr objectAtIndex:0]intValue];
                        if (hour>=10 && ([ampm isEqualToString:@"PM"] || [ampm isEqualToString:@"pm"]) && hour!=12) {
                            [dic setObject:[[[HArr objectAtIndex:i] objectForKey:@"FCTTIME"] objectForKey:@"civil"] forKey:@"time"];
                            [dic setObject:[[[HArr objectAtIndex:i]objectForKey:@"FCTTIME"] objectForKey:@"weekday_name"] forKey:@"weekday"];
                            [dic setObject:[[[HArr objectAtIndex:i] objectForKey:@"temp"] objectForKey:@"english"] forKey:@"tempF"];
                            [dic setObject:[[HArr objectAtIndex:i] objectForKey:@"icon"] forKey:@"icon"];
                            [dic setObject:[[HArr objectAtIndex:i] objectForKey:@"icon_url"] forKey:@"icon_url"];
                            [HourlyOfToday addObject:dic];
                        }
                        
                    }else if ([[[[HArr objectAtIndex:i]objectForKey:@"FCTTIME"]objectForKey:@"mday"]integerValue]==nextday){
                      //  NSLog(@"%@ str ",str);
//                        NSArray *arrt=[str componentsSeparatedByString:@" "];
//                        NSString *ampm=[arrt objectAtIndex:1];
//                        NSArray *HMArr=[[arrt objectAtIndex:0] componentsSeparatedByString:@":"];
//                        int hour=[[HMArr objectAtIndex:0]intValue];
//                        if ((hour<=4 || hour==12) && ([ampm isEqualToString:@"AM"] || [ampm isEqualToString:@"am"] )) {
                            [dic setObject:[[[HArr objectAtIndex:i] objectForKey:@"FCTTIME"] objectForKey:@"civil"] forKey:@"time"];
                            [dic setObject:[[[HArr objectAtIndex:i]objectForKey:@"FCTTIME"] objectForKey:@"weekday_name"] forKey:@"weekday"];
                            [dic setObject:[[[HArr objectAtIndex:i] objectForKey:@"temp"] objectForKey:@"english"] forKey:@"tempF"];
                            [dic setObject:[[HArr objectAtIndex:i] objectForKey:@"icon"] forKey:@"icon"];
                            [dic setObject:[[HArr objectAtIndex:i] objectForKey:@"icon_url"] forKey:@"icon_url"];
                            [HourlyOfToday addObject:dic];
                     //   }
                    }else{
                        break;
                    }
               // }
                
            }else if (result2==NSOrderedSame || result2==NSOrderedDescending){
                NSString *str=[[[HArr objectAtIndex:i] objectForKey:@"FCTTIME"] objectForKey:@"civil"];
                
                if ([[[[HArr objectAtIndex:i]objectForKey:@"FCTTIME"]objectForKey:@"mday"]integerValue]==day) {
                   // NSLog(@"%@ str ",str);
                    NSArray *arrt=[str componentsSeparatedByString:@" "];
                    NSString *ampm=[arrt objectAtIndex:1];
                    NSArray *HMArr=[[arrt objectAtIndex:0] componentsSeparatedByString:@":"];
                    int hour=[[HMArr objectAtIndex:0]intValue];
                    if (hour>=11 && ([ampm isEqualToString:@"PM"] || [ampm isEqualToString:@"pm"]) && hour!=12) {
                        [dic setObject:[[[HArr objectAtIndex:i] objectForKey:@"FCTTIME"] objectForKey:@"civil"] forKey:@"time"];
                        [dic setObject:[[[HArr objectAtIndex:i]objectForKey:@"FCTTIME"] objectForKey:@"weekday_name"] forKey:@"weekday"];
                        [dic setObject:[[[HArr objectAtIndex:i] objectForKey:@"temp"] objectForKey:@"english"] forKey:@"tempF"];
                        [dic setObject:[[HArr objectAtIndex:i] objectForKey:@"icon"] forKey:@"icon"];
                        [dic setObject:[[HArr objectAtIndex:i] objectForKey:@"icon_url"] forKey:@"icon_url"];
                        [HourlyOfToday addObject:dic];
                    }
                    
                }else if ([[[[HArr objectAtIndex:i]objectForKey:@"FCTTIME"]objectForKey:@"mday"]integerValue]==nextday){
                        [dic setObject:[[[HArr objectAtIndex:i] objectForKey:@"FCTTIME"] objectForKey:@"civil"] forKey:@"time"];
                        [dic setObject:[[[HArr objectAtIndex:i]objectForKey:@"FCTTIME"] objectForKey:@"weekday_name"] forKey:@"weekday"];
                        [dic setObject:[[[HArr objectAtIndex:i] objectForKey:@"temp"] objectForKey:@"english"] forKey:@"tempF"];
                        [dic setObject:[[HArr objectAtIndex:i] objectForKey:@"icon"] forKey:@"icon"];
                        [dic setObject:[[HArr objectAtIndex:i] objectForKey:@"icon_url"] forKey:@"icon_url"];
                        [HourlyOfToday addObject:dic];
                }else{
                    break;
                }
            }
            
        }
        [self HourlyTempretureToday];
        [WetherTableView reloadData];
    }
    
    if (connection==connection2) {
         NSArray *arr=[NSJSONSerialization JSONObjectWithData:Webdata2 options:kNilOptions error:nil];
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

    [HourlyScrollView removeFromSuperview];
    HourlyScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(11, 91, 298, 76)];
    HourlyScrollView.showsVerticalScrollIndicator=YES;
    HourlyScrollView.scrollEnabled=YES;
    HourlyScrollView.userInteractionEnabled=YES;
    [self.view addSubview:HourlyScrollView];
    
    if ([[AppDelegate sharedInstance]DeviceHieght]==480) {
        HourlyScrollView.frame=CGRectMake(11, 81, 298, 76);
        HourlyScrollView.backgroundColor=[UIColor whiteColor];
    }
    
    for (int i=0; i<HourlyOfToday.count; i++) {
        
        NSDictionary *dic=[HourlyOfToday objectAtIndex:i];
        
        UILabel *timeLab=[[UILabel alloc]initWithFrame:CGRectMake((15+30)*i, 0, 33, 20)];
        timeLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:10];
       // timeLab.textColor=[UIColor whiteColor];
        timeLab.text=[dic objectForKey:@"time"];
        [HourlyScrollView addSubview:timeLab];
        
         UIImageView *IconImage=[[UIImageView alloc]initWithFrame:CGRectMake((15+30)*i, 22, 30, 30)];
        IconImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"icon_url"]]]];
        [HourlyScrollView addSubview:IconImage];
        
        UILabel *tempLab=[[UILabel alloc]initWithFrame:CGRectMake((15+30)*i, 55, 30, 20)];
       tempLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:12];
      //  tempLab.textColor=[UIColor whiteColor];
      //  NSString *time=[[dic objectForKey:@"humidity"]stringByReplacingOccurrencesOfString:@" " withString:@""];
      tempLab.text=[NSString stringWithFormat:@"%@%@",[dic objectForKey:@"tempF"],super0];
        tempLab.textAlignment=NSTextAlignmentCenter;
        [HourlyScrollView addSubview:tempLab];
        
    }
    [hud hide:YES];
    HourlyScrollView.contentSize=CGSizeMake(HourlyOfToday.count*(15+30), HourlyScrollView.frame.size.height);
    
    }

#pragma mark - alert view delegates method

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        
  
    if ([[alertView buttonTitleAtIndex:buttonIndex]isEqualToString:@"OK"]) {
          WTag=2;
                 NSLog(@"text %@",[alertView textFieldAtIndex:0].text);
        [self CallWetherApiWithNewZip:[alertView textFieldAtIndex:0].text];
    }
    
    }
}

#pragma mark - text field delegates methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    return NO;
}

#pragma mark - wether api zip 

-(void)CallWetherApiWithNewZip:(NSString*)zipCode
{
    [[NSUserDefaults standardUserDefaults]setObject:@"Zip" forKey:@"Zip"];
    NSString *UrlString=[NSString stringWithFormat:@"http://api.wunderground.com/api/131d40d9ea437c31/hourly/conditions/forecast10day/q/%@.json",zipCode];
    
    // NSString *UrlString=[NSString stringWithFormat:@"http://api.wunderground.com/api/131d40d9ea437c31/hourly/conditions/forecast10day/q/452001.json"];
    
    NSURL *url          = [NSURL URLWithString:UrlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    Connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [hud show:YES];
    
    if(Connection)
    {
        WebData = [[NSMutableData alloc]init];
    }

}

-(IBAction) btniCloudPressed:(id)sender
{
    // create the document with it’s root element
    APDocument *doc = [[APDocument alloc] initWithRootElement:[APElement elementWithName:@"NewSnowPush"]];
    APElement *rootElement = [doc rootElement]; // retrieves same element we created the line above
    
    NSMutableArray *addrList = [[NSMutableArray alloc] init];
    NSMutableArray *NameArr=[[NSMutableArray alloc]init];
    NSString *select_query;
    const char *select_stmt;
    sqlite3_stmt *compiled_stmt;
    if (sqlite3_open([[[DataBase getSharedInstance]findDBPath] UTF8String], &dbconn) == SQLITE_OK)
    {
        select_query = [NSString stringWithFormat:@"SELECT * FROM ClientDetail"];
        select_stmt = [select_query UTF8String];
        if(sqlite3_prepare_v2(dbconn, select_stmt, -1, &compiled_stmt, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(compiled_stmt) == SQLITE_ROW)
            {
                NSString *addr = [NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,0)]];
                addr = [NSString stringWithFormat:@"%@#%@",addr,[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,1)]];
                addr = [NSString stringWithFormat:@"%@#%@",addr,[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,2)]];
                addr = [NSString stringWithFormat:@"%@#%@",addr,[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,3)]];
                addr = [NSString stringWithFormat:@"%@#%@",addr,[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,4)]];
                addr = [NSString stringWithFormat:@"%@#%@",addr,[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,5)]];
                addr = [NSString stringWithFormat:@"%@#%@",addr,[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,6)]];
                addr = [NSString stringWithFormat:@"%@#%@",addr,[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,7)]];
                 addr = [NSString stringWithFormat:@"%@#%@",addr,[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,8)]];
                 addr = [NSString stringWithFormat:@"%@#%@",addr,[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,9)]];
                 addr = [NSString stringWithFormat:@"%@#%@",addr,[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,10)]];
                 addr = [NSString stringWithFormat:@"%@#%@",addr,[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,11)]];
                 addr = [NSString stringWithFormat:@"%@#%@",addr,[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,12)]];
                 addr = [NSString stringWithFormat:@"%@#%@",addr,[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,13)]];
                 addr = [NSString stringWithFormat:@"%@#%@",addr,[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,14)]];
                
                //NSLog(@"%@",addr);
                [addrList addObject:addr];
            }
            sqlite3_finalize(compiled_stmt);
        }
        else
        {
            NSLog(@"Error while creating detail view statement. '%s'", sqlite3_errmsg(dbconn));
        }
        
    }
    
    for(int i =0 ; i < [addrList count]; i++)
    {
        NSArray *addr = [[NSArray alloc] initWithArray:[[addrList objectAtIndex:i] componentsSeparatedByString:@"#"]];
        
       
        
        APElement *property = [APElement elementWithName:@"ClientDetail"];
        [NameArr addObject:[addr objectAtIndex:0]];
        [property addAttributeNamed:@"Comp_Name" withValue:[addr objectAtIndex:0]];
        [property addAttributeNamed:@"Address" withValue:[addr objectAtIndex:1]];
        [property addAttributeNamed:@"city" withValue:[addr objectAtIndex:2]];
        [property addAttributeNamed:@"state" withValue:[addr objectAtIndex:3]];
        [property addAttributeNamed:@"zip" withValue:[addr objectAtIndex:4]];
        [property addAttributeNamed:@"PhoneNo" withValue:[addr objectAtIndex:5]];
        [property addAttributeNamed:@"email" withValue:[addr objectAtIndex:6]];
        [property addAttributeNamed:@"Image" withValue:[addr objectAtIndex:7]];
        [property addAttributeNamed:@"tripCost" withValue:[addr objectAtIndex:8]];
        [property addAttributeNamed:@"contactCost" withValue:[addr objectAtIndex:9]];
        [property addAttributeNamed:@"seasonalCost" withValue:[addr objectAtIndex:10]];
        [property addAttributeNamed:@"Salt" withValue:[addr objectAtIndex:11]];
        [property addAttributeNamed:@"shovel" withValue:[addr objectAtIndex:12]];
        [property addAttributeNamed:@"plow" withValue:[addr objectAtIndex:13]];
        [property addAttributeNamed:@"removal" withValue:[addr objectAtIndex:14]];
        [rootElement addChild:property];
        
    }
    sqlite3_close(dbconn);
    APElement *fullscore = [APElement elementWithName:@"NewTicket"];
    [rootElement addChild:fullscore];
    
    for (int i=0; i<NameArr.count; i++) {
        if (sqlite3_open([[[DataBase getSharedInstance]findDBPath] UTF8String], &dbconn) == SQLITE_OK)
        {
       NSString*  newselect_query = [NSString stringWithFormat:@"select * from NewTicket where comp_name=\"%@\"",[NameArr objectAtIndex:i]];
    const char  *Newselect_stmt = [newselect_query UTF8String];
    if(sqlite3_prepare_v2(dbconn, Newselect_stmt, -1, &compiled_stmt, NULL) == SQLITE_OK)
    {
        NSLog(@"Error while creating detail view statement. '%s'", sqlite3_errmsg(dbconn));
        
        while(sqlite3_step(compiled_stmt) == SQLITE_ROW)
        {
            APElement *answer = [APElement elementWithName:@"Ticket"];
            [answer addAttributeNamed:@"invoice" withValue:[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,0)]]];
            [answer addAttributeNamed:@"date" withValue:[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,1)]]];
            [answer addAttributeNamed:@"comp_name" withValue:[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,2)]]];
            [answer addAttributeNamed:@"start_time" withValue:[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,3)]]];
            [answer addAttributeNamed:@"finish_time" withValue:[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,4)]]];
            [answer addAttributeNamed:@"phone_num" withValue:[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,5)]]];
            [answer addAttributeNamed:@"email" withValue:[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,6)]]];
            [answer addAttributeNamed:@"image_before" withValue:[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,7)]]];
            [answer addAttributeNamed:@"image_after" withValue:[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,8)]]];
            [answer addAttributeNamed:@"snow_fall" withValue:[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,9)]]];
            [answer addAttributeNamed:@"hours" withValue:[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,10)]]];
            [answer addAttributeNamed:@"calculated" withValue:[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,11)]]];
            [answer addAttributeNamed:@"trip" withValue:[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,12)]]];
            [answer addAttributeNamed:@"contract" withValue:[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,13)]]];
            [answer addAttributeNamed:@"seasonal" withValue:[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,14)]]];
            [answer addAttributeNamed:@"send_invoice" withValue:[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,15)]]];
            [answer addAttributeNamed:@"paid_in_full" withValue:[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,16)]]];
            [fullscore addChild:answer];
            
        }
      
        sqlite3_finalize(compiled_stmt);
    }else{
      NSLog(@"Error while creating detail view statement. '%s'", sqlite3_errmsg(dbconn));
    }
        
    }
}
    sqlite3_close(dbconn);
    
    NSString *prettyXML = [doc prettyXML];
    NSLog(@"\n\n%@",prettyXML);
    
    
    //***** PARSE XML FILE *****
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"SnowPush.xml" ];
    NSData *file = [NSData dataWithBytes:[prettyXML UTF8String] length:strlen([prettyXML UTF8String])];
    [file writeToFile:path atomically:YES];
    
    
    NSString *fileName = [NSString stringWithFormat:@"SnowPush.xml"];
    NSURL *ubiq = [[NSFileManager defaultManager]URLForUbiquityContainerIdentifier:nil];
    NSURL *ubiquitousPackage = [[ubiq URLByAppendingPathComponent:@"Documents"]  URLByAppendingPathComponent:fileName];
    
    
    MyDocument *mydoc = [[MyDocument alloc] initWithFileURL:ubiquitousPackage];
    mydoc.xmlContent = prettyXML;
    [mydoc saveToURL:[mydoc fileURL]forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success)
     {
        if (success)
         {
             NSLog(@"XML: Synced with icloud");
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iCloud Syncing" message:@"Successfully synced with iCloud." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
             
         }
         else
             NSLog(@"XML: Syncing FAILED with icloud");
         
        }];
    
    [self iCloudSyncing];
    
//    BOOL isDir=NO;
//    
//    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    
//    NSArray *subpaths;
//    
//    NSString *toCompress = @"MyImageFolder";
//    NSString *pathToCompress = [documentsDirectory stringByAppendingPathComponent:toCompress];
//    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if ([fileManager fileExistsAtPath:pathToCompress isDirectory:&isDir] && isDir){
//        subpaths = [fileManager subpathsAtPath:pathToCompress];
//    } else if ([fileManager fileExistsAtPath:pathToCompress]) {
//        subpaths = [NSArray arrayWithObject:pathToCompress];
//    }
//    
//    NSString *zipFilePath = [documentsDirectory stringByAppendingPathComponent:@"SnowPushImages.zip"];
//    
//    ZipArchive *za = [[ZipArchive alloc] init];
//    [za CreateZipFile2:zipFilePath];
//    if (isDir) {
//        for(NSString *path in subpaths){
//            NSString *fullPath = [pathToCompress stringByAppendingPathComponent:path];
//            if([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && !isDir){
//                [za addFileToZip:fullPath newname:path];
//            }
//        }
//    } else {
//        [za addFileToZip:pathToCompress newname:toCompress];
//    }
//    
//    BOOL successCompressing = [za CloseZipFile2];
    
}

#pragma mark - get back icloud data

- (void)loadData:(NSMetadataQuery *)query {
    
    if ([query resultCount] >0) {
        for (NSMetadataItem *item in [query results]) {
                       
            NSString *filename = [item valueForAttribute:NSMetadataItemDisplayNameKey];
            NSNumber *filesize = [item valueForAttribute:NSMetadataItemFSSizeKey];
            NSDate *updated = [item valueForAttribute:NSMetadataItemFSContentChangeDateKey];
            
            NSLog(@"%@ (%@ bytes, updated %@) ", filename, filesize, updated);
            
            NSURL *url = [item valueForAttribute:NSMetadataItemURLKey];
            if([filename isEqualToString:@"SnowPush"]){

            MyDocument *doc = [[MyDocument alloc] initWithFileURL:url];
            self.document = doc;
                            [self.document openWithCompletionHandler:^(BOOL success) {
                    if (success) {
                        NSLog(@"iCloud document opened");
                        NSData *file = [NSData dataWithContentsOfURL:url];
                        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:file];
                        [parser setDelegate:self];
                        [parser parse];
                    } else {
                        NSLog(@"failed opening document from iCloud");
                    }
                }];
            }
            if([filename isEqualToString:@"SnowPushImages"])
            {
                
                 MyNewZipDocument *doc = [[MyNewZipDocument alloc] initWithFileURL:url];
                [doc openWithCompletionHandler:^(BOOL success) {
                    if (success) {
                        NSLog(@"Pictures : Success to open from iCloud");
                        NSData *file = [NSData dataWithContentsOfURL:url];
                        
                        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                        NSString *zipFolder = [documentsDirectory stringByAppendingPathComponent:@"Pics.zip"];
                        [[NSFileManager defaultManager] createFileAtPath:zipFolder contents:file attributes:nil];
                        //NSLog(@"zipFilePath : %@",zipFolder);
                        
                        NSString *outputFolder = [documentsDirectory stringByAppendingPathComponent:@"Pictures"];//iCloudPics
                        ZipArchive* za = [[ZipArchive alloc] init];
                        if( [za UnzipOpenFile: zipFolder] ) {
                            if( [za UnzipFileTo:outputFolder overWrite:YES] != NO ) {
                                NSLog(@"Pics : unzip successfully");
                            }
                            [za UnzipCloseFile];
                        }
                        
                        NSError *err;
                        NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:outputFolder error:&err];
                        if (files == nil) {
                            NSLog(@"EMPTY Folder: %@",outputFolder);
                        }
                        // Add all sbzs to a list
                        for (NSString *file in files) {
                            //if ([file.pathExtension compare:@".jpeg" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
                            NSLog(@" Pictures %@",file);
                            
                            NSString *oldPath=[outputFolder stringByAppendingPathComponent:file];
                            
                            NSString *newPath=[documentsDirectory stringByAppendingPathComponent:@"/MyImageFolder"];
                            NSString* foofile = [newPath stringByAppendingPathComponent:file];
                            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
                            
                            if (fileExists==NO) {
                                NSError *err;
                                [[NSFileManager defaultManager]moveItemAtPath:oldPath toPath:foofile error:&err];
                                NSLog(@"err %@",err);
                        
                               
                            }
                            
                            //                            NSFileManager *fm = [NSFileManager defaultManager];
                            //                            NSDictionary *attributes = [fm fileAttributesAtPath:[NSString stringWithFormat:@"%@/%@",documentsDirectory,file]                                                                 traverseLink:NO];
                            //
                            //                            NSNumber* fileSize = [attributes objectForKey:NSFileSize];
                            //                            int e = [fileSize intValue]; //Size in bytes
                            //                            NSLog(@"%@__%d",file,e);
                        }
                        
                    }
                    else 
                    {
                        NSLog(@"Pictures : failed to open from iCloud");
                     //   [self hideProcessingView];
                    }
                }]; 
            }
        }
        
	}
    else {
        if (documentTag==0) {
            
      
        NSURL *ubiq = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
        NSURL *ubiquitousPackage = [[ubiq URLByAppendingPathComponent:@"Documents"] URLByAppendingPathComponent:kFILENAME];
        
        MyDocument *doc = [[MyDocument alloc] initWithFileURL:ubiquitousPackage];
        self.document = doc;
        
        [doc saveToURL:[doc fileURL] forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                [doc openWithCompletionHandler:^(BOOL success) {
                    
                    NSLog(@"new document opened from iCloud");
                    
                }];
            }
        }];
    }
    }
    documentTag++;
    if (documentTag==1) {
        [self loadDocument2];
    }
    
}

- (void)queryDidFinishGathering:(NSNotification *)notification {
    
    NSMetadataQuery *query = [notification object];
    [query disableUpdates];
    [query stopQuery];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSMetadataQueryDidFinishGatheringNotification
                                                  object:query];
    
    _query= nil;
    
	[self loadData:query];
    
}

- (void)loadDocument {
    
    NSMetadataQuery *query = [[NSMetadataQuery alloc] init];
    _query = query;
    [query setSearchScopes:[NSArray arrayWithObject:NSMetadataQueryUbiquitousDocumentsScope]];
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"%K == %@", NSMetadataItemFSNameKey, kFILENAME];
    [query setPredicate:pred];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryDidFinishGathering:) name:NSMetadataQueryDidFinishGatheringNotification object:query];
    
    [query startQuery];
    
}

- (void)loadDocument2 {
    
    NSMetadataQuery *query = [[NSMetadataQuery alloc] init];
    _query = query;
    [query setSearchScopes:[NSArray arrayWithObject:NSMetadataQueryUbiquitousDocumentsScope]];
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"%K == %@", NSMetadataItemFSNameKey, KImagesFolderName];
    [query setPredicate:pred];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryDidFinishGathering:) name:NSMetadataQueryDidFinishGatheringNotification object:query];
    
    [query startQuery];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)nameSpaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqual:@"ClientDetail"])
    {/*tripCost
      contactCost
      seasonalCost
      Salt
      shovel
      plow
      removal*/
        NSLog(@"Property attributes : %@|%@|%@|%@|%@|%@|%@|%@", [attributeDict objectForKey:@"Comp_Name"],[attributeDict objectForKey:@"Address"], [attributeDict objectForKey:@"city"], [attributeDict objectForKey:@"state"],[attributeDict objectForKey:@"zip"],[attributeDict objectForKey:@"PhoneNo"],[attributeDict objectForKey:@"email"],[attributeDict objectForKey:@"Image"]);
        
        ClientInfo *clientI=[[ClientInfo alloc]init];
        clientI.Comp_name=[attributeDict objectForKey:@"Comp_Name"];
        clientI.Address=[attributeDict objectForKey:@"Address"];
        clientI.City=[attributeDict objectForKey:@"city"];
        clientI.State=[attributeDict objectForKey:@"state"];
        clientI.Zip=[attributeDict objectForKey:@"zip"];
        clientI.phoneNo=[attributeDict objectForKey:@"PhoneNo"];
        clientI.Email=[attributeDict objectForKey:@"email"];
        clientI.Image=[attributeDict objectForKey:@"Image"];
        clientI.TripCost=[attributeDict objectForKey:@"tripCost"]; 
        clientI.ContractCost=[attributeDict objectForKey:@"contactCost"];
        clientI.SeasonalCost=[attributeDict objectForKey:@"seasonalCost"];
        clientI.salt=[[attributeDict objectForKey:@"Salt"]intValue];
        clientI.shovel=[[attributeDict objectForKey:@"shovel"]intValue];
        clientI.plow=[[attributeDict objectForKey:@"plow"]intValue];
        clientI.removal=[[attributeDict objectForKey:@"removal"]intValue];
        
        BOOL cl=[[DataBase getSharedInstance]IsclientAvailble:clientI];
        if (cl==NO) {
            BOOL insert=[[DataBase getSharedInstance]SaveClientDetail:clientI];
        }
        
        
    }else if ([elementName isEqual:@"Ticket"]){
        /*date,comp_name,start_time,finish_time,phone_num,email,image_before,image_after,snow_fall,hours,calculated,trip,contract,seasonal,send_invoice,paid_in_full*/
        NSLog(@"Property attributes : %@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@",[attributeDict objectForKey:@"invoice"], [attributeDict objectForKey:@"date"],[attributeDict objectForKey:@"comp_name"], [attributeDict objectForKey:@"start_time"], [attributeDict objectForKey:@"finish_time"],[attributeDict objectForKey:@"phone_num"],[attributeDict objectForKey:@"email"],[attributeDict objectForKey:@"image_before"],[attributeDict objectForKey:@"snow_fall"],[attributeDict objectForKey:@"image_after"],[attributeDict objectForKey:@"hours"],[attributeDict objectForKey:@"calculated"],[attributeDict objectForKey:@"trip"],[attributeDict objectForKey:@"contract"],[attributeDict objectForKey:@"seasonal"],[attributeDict objectForKey:@"send_invoice"],[attributeDict objectForKey:@"paid_in_full"]);
        
        ClientInfo *ticketI=[[ClientInfo alloc]init];
        ticketI.invoice_no=[[attributeDict objectForKey:@"invoice"]integerValue];
        ticketI.Comp_name=[attributeDict objectForKey:@"comp_name"];
        ticketI.date=[attributeDict objectForKey:@"date"];
        ticketI.startTime=[attributeDict objectForKey:@"start_time"];
        ticketI.finishTime=[attributeDict objectForKey:@"finish_time"];
        ticketI.phoneNo=[attributeDict objectForKey:@"phone_num"];
        ticketI.Email=[attributeDict objectForKey:@"email"];
        ticketI.snowFall=[attributeDict objectForKey:@"snow_fall"];
        ticketI.hours=[[attributeDict objectForKey:@"hours"]intValue];
        ticketI.calculated=[[attributeDict objectForKey:@"calculated"]intValue];
        ticketI.sendInVoice=[[attributeDict objectForKey:@"send_invoice"]intValue];
        ticketI.paidInFull=[[attributeDict objectForKey:@"paid_in_full"]intValue];
        ticketI.trip=[[attributeDict objectForKey:@"trip"]intValue];
        ticketI.contract=[[attributeDict objectForKey:@"contract"]intValue];
        ticketI.seasonal=[[attributeDict objectForKey:@"contract"]intValue];
        ticketI.imageBefore=[attributeDict objectForKey:@"image_before"];
        ticketI.imageAfter=[attributeDict objectForKey:@"image_after"];
        
        BOOL tC=[[DataBase getSharedInstance]IsTicketAvailable:ticketI.invoice_no];
        
        if (tC==NO) {
            BOOL saveT=[[DataBase getSharedInstance]SaveTicketWithInvoice:ticketI];
        }
        
    }
    
    
    
    //like this way fetch all data and insert in db
}

-(BOOL)zipFolder:(NSString *)toCompress zipFilePath:(NSString *)zipFilePath
{
    BOOL isDir=NO;
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *pathToCompress = [documentsDirectory stringByAppendingPathComponent:toCompress];
    
    NSArray *subpaths;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:pathToCompress isDirectory:&isDir] && isDir){
        subpaths = [fileManager subpathsAtPath:pathToCompress];
    } else if ([fileManager fileExistsAtPath:pathToCompress]) {
        subpaths = [NSArray arrayWithObject:pathToCompress];
    }
    
    zipFilePath = [documentsDirectory stringByAppendingPathComponent:zipFilePath];
    //NSLog(@"%@",zipFilePath);
    ZipArchive *za = [[ZipArchive alloc] init];
    [za CreateZipFile2:zipFilePath];
    if (isDir) {
        for(NSString *path in subpaths){
            NSString *fullPath = [pathToCompress stringByAppendingPathComponent:path];
            if([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && !isDir){
                [za addFileToZip:fullPath newname:path];
            }
        }
    } else {
        [za addFileToZip:pathToCompress newname:toCompress];
    }
    
    BOOL successCompressing = [za CloseZipFile2];
    if(successCompressing)
        return YES;
    else
        return NO;
}
-(IBAction) iCloudSyncing
{
    //***** PARSE ZIP FILE : Pictures *****
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    if([self zipFolder:@"MyImageFolder" zipFilePath:@"SnowPushImages"])
        NSLog(@"Picture Folder is zipped");
    
  NSURL*  ubiq = [[NSFileManager defaultManager]URLForUbiquityContainerIdentifier:nil];
  NSURL*  ubiquitousPackage = [[ubiq URLByAppendingPathComponent:@"Documents"]  URLByAppendingPathComponent:@"SnowPushImages.zip"];
    
  MyNewZipDocument*  mydoc = [[MyNewZipDocument alloc] initWithFileURL:ubiquitousPackage];
    NSString *zipFilePath = [documentsDirectory stringByAppendingPathComponent:@"SnowPushImages"];
    NSURL *u = [[NSURL alloc] initFileURLWithPath:zipFilePath];
    NSData *data = [[NSData alloc] initWithContentsOfURL:u];
    // NSLog(@"%@ %@",zipFilePath,data);
    mydoc.zipDataContent = data;
    
    [mydoc saveToURL:[mydoc fileURL] forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success)
     {
         if (success)
         {
             NSLog(@"PictureZip: Synced with icloud");
         }
         else
             NSLog(@"PictureZip: Syncing FAILED with icloud");
         
     }];
}

@end
