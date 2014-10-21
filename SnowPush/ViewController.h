//
//  ViewController.h
//  SnowPush
//
//  Created by Dannis on 9/22/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "MyDocument.h"
#import "ZipArchive.h"
#import "MyNewZipDocument.h"
@interface ViewController : UIViewController<NSURLConnectionDelegate,CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
  MBProgressHUD *hud;
    
    UIScrollView *HourlyScrollView;
}

@property (strong)MyDocument* document;
@property (strong)NSMetadataQuery *query;
@property(nonatomic,strong)CLLocationManager *manager;

@property (nonatomic,strong)NSString* Latitude;
@property(nonatomic,strong)NSString* Longitude;
@property (weak, nonatomic) IBOutlet UIButton *iCloudBtn;

//@property (weak, nonatomic) IBOutlet UIScrollView *HourlyScrollView;
@property (weak, nonatomic) IBOutlet UIView *ScrollsView;

@property (weak, nonatomic) IBOutlet UILabel *ForeCastLab;

@property (weak, nonatomic) IBOutlet UILabel *TodaysDateLab;

@property (weak, nonatomic) IBOutlet UITableView *WetherTableView;

@property (weak, nonatomic) IBOutlet UIButton *ViewAllTicketBtn;

@property (weak, nonatomic) IBOutlet UIButton *ViewOpenTicketBtn;

@property (weak, nonatomic) IBOutlet UIButton *ViewPaidTicketBtn;

@property (weak, nonatomic) IBOutlet UILabel *ReportLab;

@property (weak, nonatomic) IBOutlet UIButton *ClientBtn;

@property (weak, nonatomic) IBOutlet UIButton *reportBtn;

@property (weak, nonatomic) IBOutlet UIButton *ChangeZipBtn;

@property (weak, nonatomic) IBOutlet UIImageView *ReportImageView;

@property (weak, nonatomic) IBOutlet UILabel *lineLab1;

@property (weak, nonatomic) IBOutlet UILabel *lineLab2;

-(IBAction)ClientBtnClicked:(id)sender;

-(IBAction)ReportBtnClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *ReportView;

-(IBAction)ViewAllTickets:(id)sender;

-(IBAction)ViewOpenTickets:(id)sender;

-(IBAction)ViewPaidTickets:(id)sender;

-(IBAction)ChangeZip:(id)sender;
-(IBAction) btniCloudPressed:(id)sender;
@end
