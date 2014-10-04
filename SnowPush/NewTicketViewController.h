//
//  NewTicketViewController.h
//  SnowPush
//
//  Created by Dannis on 9/23/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTicketViewController : UIViewController<UITextFieldDelegate>
- (IBAction)NewTicketBackBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *DateTf;

@property (weak, nonatomic) IBOutlet UITextField *CompNameTf;

@property (weak, nonatomic) IBOutlet UITextField *FinshTimeTf;

@property (weak, nonatomic) IBOutlet UITextField *PhoneNumTf;

@property (weak, nonatomic) IBOutlet UITextField *EmailTf;

@property (weak, nonatomic) IBOutlet UIImageView *ImageBefore;

@property (weak, nonatomic) IBOutlet UIImageView *ImageAfter;

@property (weak, nonatomic) IBOutlet UITextField *SnowFallTf;

@property (weak, nonatomic) IBOutlet UITextField *HoursTf;

@property (weak, nonatomic) IBOutlet UILabel *TotalLab;

@property (weak, nonatomic) IBOutlet UITextField *CalculatedTf;

@property (weak, nonatomic) IBOutlet UILabel *tripLab;

@property (weak, nonatomic) IBOutlet UILabel *ContractLab;

@property (weak, nonatomic) IBOutlet UILabel *SeasonalLab;

@property (weak, nonatomic) IBOutlet UILabel *sendVoiceLab;

@property (weak, nonatomic) IBOutlet UILabel *paidInFull;

@property (weak, nonatomic) IBOutlet UIButton *tripBtn;

@property (weak, nonatomic) IBOutlet UIButton *SeasonalBtn;

@property (weak, nonatomic) IBOutlet UIButton *ContractBtn;

@property (weak, nonatomic) IBOutlet UITextField *StartTime;


- (IBAction)TripBtnClicked:(id)sender;
- (IBAction)ContractBtnClicked:(id)sender;
- (IBAction)SeasonalBtnClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *SendVoiceBtn;

@property (weak, nonatomic) IBOutlet UIButton *paidInFullBtn;

- (IBAction)sendVoiceBtnClicked:(id)sender;
- (IBAction)PaidInFullBtnClicked:(id)sender;

@end
