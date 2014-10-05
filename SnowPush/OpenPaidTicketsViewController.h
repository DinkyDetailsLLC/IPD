//
//  OpenPaidTicketsViewController.h
//  SnowPush
//
//  Created by Dannis on 9/25/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenPaidTicketsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
- (IBAction)OpTBackBtnClicked:(id)sender;
- (IBAction)OPTMoreBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *OPTSearchTF;
@property (weak, nonatomic) IBOutlet UITableView *OPTTableView;

@property int OPTViewTag;

@property (nonatomic,retain)ClientInfo *OPTClientDtail;

@end
