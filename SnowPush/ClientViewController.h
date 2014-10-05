//
//  ClientViewController.h
//  SnowPush
//
//  Created by Dannis on 9/22/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClientViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

{
    NSArray *AllClientArr;
}

-(IBAction)BackBtnClicked:(id)sender;
-(IBAction)MoreBtnClicked:(id)sender;
-(IBAction)EditBtnClicked:(id)sender;
-(IBAction)PlusBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *AllClientTableView;
@property (weak, nonatomic) IBOutlet UITextField *SearchTextField;

@end
