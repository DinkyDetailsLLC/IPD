//
//  EditClientViewController.h
//  SnowPush
//
//  Created by Dannis on 9/23/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBase.h"
#import "ClientInfo.h"
@interface EditClientViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *CompNameTf;
@property (weak, nonatomic) IBOutlet UITextField *AddressTf;
@property (weak, nonatomic) IBOutlet UITextField *CityTf;
@property (weak, nonatomic) IBOutlet UITextField *StateTf;
@property (weak, nonatomic) IBOutlet UITextField *PhoneNoTf;
@property (weak, nonatomic) IBOutlet UITextField *EmailTf;
@property (weak, nonatomic) IBOutlet UIImageView *ClientImageView;
@property (weak, nonatomic) IBOutlet UITextField *TripCost;
@property (weak, nonatomic) IBOutlet UITextField *ContaractCost;
@property (weak, nonatomic) IBOutlet UITextField *SeasonalCost;
@property (weak, nonatomic) IBOutlet UITextField *ZipTf;
- (IBAction)EditClientSaveBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *EditClientScrollView;
- (IBAction)EditClientBackbtnClicked:(id)sender;

@end
