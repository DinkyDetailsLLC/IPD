//
//  NewTicketViewController.h
//  SnowPush
//
//  Created by Dannis on 9/23/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageEditor.h"
#import <EventKit/EventKit.h>
#import "EventManager.h"
@interface NewTicketViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>

{
    UIDatePicker *timePicker;
}
@property (nonatomic, strong) EventManager *eventManager;
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

@property (weak, nonatomic) IBOutlet UIButton *SendVoiceBtn;

@property (weak, nonatomic) IBOutlet UIButton *paidInFullBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *NewTicketScrollView;

@property (weak, nonatomic) IBOutlet UILabel *imageBeforeLab;

@property (weak, nonatomic) IBOutlet UILabel *imageAfterLab;

@property(nonatomic,retain)ClientInfo *NewTicketInfo;

@property (weak, nonatomic) IBOutlet UIView *SelectTimeView;

@property (weak, nonatomic) IBOutlet UILabel *SelectTimeLab;

@property (weak, nonatomic) IBOutlet UIButton *SelectTimeSetBtn;

- (IBAction)SelectSetBtnClicked:(id)sender;

- (IBAction)NewTicketSaveBtnClicked:(id)sender;

- (IBAction)sendVoiceBtnClicked:(id)sender;

- (IBAction)PaidInFullBtnClicked:(id)sender;

- (IBAction)NewTicketBackBtnClicked:(id)sender;

- (IBAction)TripContractSeasonalBtnClicked:(id)sender;

@property(nonatomic,strong) ImageEditor *imageEditor;

@property int EditTicketTag;

@property NSDictionary *EditTicketInfo;

@end
