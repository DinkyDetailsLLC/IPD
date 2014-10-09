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
#import "DemoImageEditor.h"
@interface EditClientViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
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

@property (weak, nonatomic) IBOutlet UIScrollView *EditClientScrollView;
@property (weak, nonatomic) IBOutlet UILabel *imageLab;

@property (weak, nonatomic) IBOutlet UIButton *saltBtn;

@property (weak, nonatomic) IBOutlet UIButton *shovelBtn;

@property (weak, nonatomic) IBOutlet UIButton *plowBtn;

@property (weak, nonatomic) IBOutlet UIButton *removalBtn;

@property (weak, nonatomic) IBOutlet UILabel *saltLab;

@property (weak, nonatomic) IBOutlet UILabel *shovelLab;

@property (weak, nonatomic) IBOutlet UILabel *plowLab;

@property (weak, nonatomic) IBOutlet UILabel *removalLab;


- (IBAction)EditClientSaveBtnClicked:(id)sender;

- (IBAction)EditClientBackbtnClicked:(id)sender;

- (IBAction)SaltSelected:(id)sender;

- (IBAction)shovelSelected:(id)sender;

- (IBAction)plowSelected:(id)sender;

- (IBAction)removalSelected:(id)sender;

@property int editTag;

@property(nonatomic,retain) ClientInfo *ClientInformation;
@property(nonatomic,strong) DemoImageEditor *imageEditor;
@end
