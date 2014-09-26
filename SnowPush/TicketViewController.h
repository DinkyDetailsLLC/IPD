//
//  TicketViewController.h
//  SnowPush
//
//  Created by Dannis on 9/22/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *TicketTableView;
@property (weak, nonatomic) IBOutlet UITextField *TicketSearchTextField;


@property int ViewTag;

-(IBAction)TicketBackBtnClicked:(id)sender;

-(IBAction)TicketMoreBtnClicked:(id)sender;

@end
