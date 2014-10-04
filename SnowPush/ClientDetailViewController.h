//
//  ClientDetailViewController.h
//  SnowPush
//
//  Created by Dannis on 9/22/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClientDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UITextFieldDelegate>
-(IBAction)ClientDetailBackBtnClicked:(id)sender;
-(IBAction)ClientReportsViewPopUp:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *ClientReportView;
-(IBAction)EmailBtnClicked:(id)sender;
-(IBAction)EditButClicked:(id)sender;

-(IBAction)NewTicketBtnClicked:(id)sender;
-(IBAction)OpenTicketsBtnClicked:(id)sender;
-(IBAction)PaidTicketsBtn:(id)sender;
- (IBAction)MapBtnClicked:(id)sender;
- (IBAction)NotifyAddBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *NotifyView;
@property (weak, nonatomic) IBOutlet UITableView *NotifyTableView;

@property (weak, nonatomic) IBOutlet UILabel *ClientDetailCompName;

@property (weak, nonatomic) IBOutlet UILabel *AddressLab;

@property (weak, nonatomic) IBOutlet UILabel *PhoneNumLab;

@property (weak, nonatomic) IBOutlet UILabel *emailLab;

@property (weak, nonatomic) IBOutlet UILabel *PriseLab;

@property (weak, nonatomic) IBOutlet UILabel *TripCostLab;

@property (weak, nonatomic) IBOutlet UILabel *ContractLab;

@property (weak, nonatomic) IBOutlet UILabel *SeasionalCostLab;

@property (weak, nonatomic) IBOutlet UIImageView *PlowImageView;

@property (weak, nonatomic) IBOutlet UIImageView *ShovelImageView;

@property (weak, nonatomic) IBOutlet UIImageView *SaltImageView;

@property (weak, nonatomic) IBOutlet UIImageView *RemovalImageView;

@property (weak, nonatomic) IBOutlet UILabel *QuickNotifyLab;

@property (weak, nonatomic) IBOutlet UIButton *OpenTicketBtn;

@property (weak, nonatomic) IBOutlet UIButton *paidTicketBtn;

@property (weak, nonatomic) IBOutlet UIButton *NewTicketBtn;

@property (weak, nonatomic) IBOutlet UILabel *TicketsLab;

@property(nonatomic,retain) ClientInfo *SingleClientDetail;

@end
