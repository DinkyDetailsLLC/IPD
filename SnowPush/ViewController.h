//
//  ViewController.h
//  SnowPush
//
//  Created by Dannis on 9/22/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSURLConnectionDelegate,CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager *manager;

@property (nonatomic,strong)NSString* Latitude;
@property(nonatomic,strong)NSString* Longitude;

@property (weak, nonatomic) IBOutlet UILabel *ForeCastLab;

@property (weak, nonatomic) IBOutlet UILabel *TodaysDateLab;
@property (weak, nonatomic) IBOutlet UILabel *DateLab;

@property (weak, nonatomic) IBOutlet UILabel *FirstTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *SecondTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *ThirdTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *FourthTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *FifthTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *SixthTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *seventhTimeLab;

@property (weak, nonatomic) IBOutlet UIImageView *FirstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *SecondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ThirdImageView;
@property (weak, nonatomic) IBOutlet UIImageView *FourthImageView;
@property (weak, nonatomic) IBOutlet UIImageView *FifthImageView;
@property (weak, nonatomic) IBOutlet UIImageView *SixthImageView;
@property (weak, nonatomic) IBOutlet UIImageView *SeventhImageVIew;


@property (weak, nonatomic) IBOutlet UILabel *FirstTempLab;
@property (weak, nonatomic) IBOutlet UILabel *SecondTempLab;
@property (weak, nonatomic) IBOutlet UILabel *ThirdTempLab;
@property (weak, nonatomic) IBOutlet UILabel *FourthTempLab;
@property (weak, nonatomic) IBOutlet UILabel *FifthTempLab;
@property (weak, nonatomic) IBOutlet UILabel *SixthTempLab;
@property (weak, nonatomic) IBOutlet UILabel *SeventhTempLab;

@property (weak, nonatomic) IBOutlet UITableView *WetherTableView;


-(IBAction)ClientBtnClicked:(id)sender;
-(IBAction)ReportBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *ReportView;

-(IBAction)ViewAllTickets:(id)sender;
-(IBAction)ViewOpenTickets:(id)sender;
-(IBAction)ViewPaidTickets:(id)sender;

-(IBAction)ChangeZip:(id)sender;

@end
