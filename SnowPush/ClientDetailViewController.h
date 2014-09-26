//
//  ClientDetailViewController.h
//  SnowPush
//
//  Created by Dannis on 9/22/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClientDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
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

@end
