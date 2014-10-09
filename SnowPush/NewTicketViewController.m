//
//  NewTicketViewController.m
//  SnowPush
//
//  Created by Dannis on 9/23/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import "NewTicketViewController.h"
#import <MessageUI/MessageUI.h>
@interface NewTicketViewController ()<
MFMailComposeViewControllerDelegate,
MFMessageComposeViewControllerDelegate,
UINavigationControllerDelegate
>
{
    NSString *STime;;
    NSString *FTime;
    UIImage *BeforeImg;
    UIImage *AfterImg;
    int pickerTag;
    BOOL isImageBeforeSelected;
    BOOL isImageAfterSelected;
}
@end

@implementation NewTicketViewController
@synthesize DateTf,CalculatedTf,CompNameTf,ContractBtn,ContractLab;
@synthesize FinshTimeTf,paidInFull,paidInFullBtn,PhoneNumTf;
@synthesize EmailTf,ImageAfter,ImageBefore;
@synthesize SeasonalBtn,SeasonalLab,SendVoiceBtn,sendVoiceLab,SnowFallTf,StartTime;
@synthesize HoursTf,TotalLab,tripBtn,tripLab;
@synthesize NewTicketScrollView,imageAfterLab,imageBeforeLab;
@synthesize NewTicketInfo;
@synthesize SelectTimeLab,SelectTimeSetBtn,SelectTimeView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.imageEditor = [[ImageEditor alloc]init];
    
    isImageBeforeSelected=NO;
    isImageAfterSelected=NO;
    
    DateTf.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
    StartTime.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
    FinshTimeTf.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
    PhoneNumTf.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
    EmailTf.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
    SnowFallTf.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
    HoursTf.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
    CalculatedTf.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:18];
    TotalLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:20];
    sendVoiceLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:18];
    paidInFull.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:18];
    
    tripLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:20];
    ContractLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:20];
    SeasonalLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:20];
    
    CompNameTf.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:25];
    
    UITapGestureRecognizer *scrollTapped=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ScrollViewTaped)];
    [NewTicketScrollView addGestureRecognizer:scrollTapped];
    
    
    NSDateFormatter *dateFormate=[[NSDateFormatter alloc]init];
    [dateFormate setDateFormat:@"dd/MM/yyyy"];
    
    DateTf.text=[dateFormate stringFromDate:[NSDate date]];
    CompNameTf.text=[NSString stringWithFormat:@"    %@",NewTicketInfo.Comp_name];
    PhoneNumTf.text=NewTicketInfo.phoneNo;
    EmailTf.text=NewTicketInfo.Email;
    
    if ([AppDelegate sharedInstance].DeviceHieght==480) {
        NewTicketScrollView.frame=CGRectMake(0, 50, 320, 430);
        CompNameTf.frame=CGRectMake(7, 39, 307, 33);
        DateTf.frame=CGRectMake(7, 3, 307, 33);
        StartTime.frame=CGRectMake(7, 75, 148, 33);
        FinshTimeTf.frame=CGRectMake(161, 75, 152, 33);
        PhoneNumTf.frame=CGRectMake(7, 111, 307, 33);
        EmailTf.frame=CGRectMake(7, 147, 307, 33);
        ImageBefore.frame=CGRectMake(7, 183, 150, 120);
        ImageAfter.frame=CGRectMake(162, 183, 150, 120);
        SnowFallTf.frame=CGRectMake(7, 306, 148, 33);
        HoursTf.frame=CGRectMake(7, 342, 148, 33);
        TotalLab.frame=CGRectMake(7, 375, 42, 20);
        CalculatedTf.frame=CGRectMake(7, 393, 148, 33);
        
        imageBeforeLab.frame=CGRectMake(13, 275, 89, 21);
        imageAfterLab.frame=CGRectMake(172, 275, 89, 21);
        
        tripLab.frame=CGRectMake(232, 306, 42, 20);
        tripBtn.frame=CGRectMake(283, 306, 20, 20);
        ContractLab.frame=CGRectMake(197, 330, 77, 20);
        ContractBtn.frame=CGRectMake(283, 330, 20, 20);
        SeasonalLab.frame=CGRectMake(197, 355, 77, 20);
        SeasonalBtn.frame=CGRectMake(283, 355, 20, 20);
        
        sendVoiceLab.frame=CGRectMake(197, 387, 112, 20);
        SendVoiceBtn.frame=CGRectMake(173, 387, 20, 20);
        paidInFull.frame=CGRectMake(197, 409, 112, 20);
        paidInFullBtn.frame=CGRectMake(173, 409, 20, 20);
        
    }
    
    UITapGestureRecognizer *ImageBeforeTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImageViewTapped:)];
    [ImageBefore addGestureRecognizer:ImageBeforeTap];
    
    UITapGestureRecognizer *imageAfterTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImageViewTapped:)];
    [ImageAfter addGestureRecognizer:imageAfterTap];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addTimePicker:(int)timeTag
{
    SelectTimeView.hidden=NO;
    [timePicker removeFromSuperview];
    timePicker = [[UIDatePicker alloc] init];
    timePicker.frame = CGRectMake(20, 20, 200, 110); // set frame as your need
    timePicker.datePickerMode = UIDatePickerModeTime;
    
    [self.SelectTimeView addSubview: timePicker];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm"];
    //  NSLog(@"%@",[outputFormatter stringFromDate:datePicker.date]);
  
    if (timeTag==1) {
        timePicker.tag=1;
          STime = [outputFormatter stringFromDate:timePicker.date];
    }else{
        timePicker.tag=2;
          FTime = [outputFormatter stringFromDate:timePicker.date];
    }
    
    //    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateStyle:NSDateFormatterNoStyle];
    //    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    // NSRange amRange = [dateString rangeOfString:[formatter AMSymbol]];
    // NSRange pmRange = [dateString rangeOfString:[formatter PMSymbol]];
    
    [timePicker addTarget:self action:@selector(timeChange) forControlEvents:UIControlEventValueChanged];
    timePicker.transform = CGAffineTransformMakeScale(1, 0.76);

}

-(void)timeChange
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm"];
    if (timePicker.tag==1) {
      
        STime = [outputFormatter stringFromDate:timePicker.date];
    }else{
      
        FTime = [outputFormatter stringFromDate:timePicker.date];
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - back btn method

- (IBAction)NewTicketBackBtnClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (IBAction)TripContractSeasonalBtnClicked:(id)sender {
    UIButton *But=(UIButton*)sender;
    if (But.tag==1) {
        [tripBtn setImage:[UIImage imageNamed:@"green-dot.png"] forState:UIControlStateNormal];
        [ContractBtn setImage:[UIImage imageNamed:@"grey-dot.png"] forState:UIControlStateNormal];
        [SeasonalBtn setImage:[UIImage imageNamed:@"grey-dot.png"] forState:UIControlStateNormal];
        tripBtn.selected=YES;
        ContractBtn.selected=NO;
        SeasonalBtn.selected=NO;
        
    }else if (But.tag==2){
        [tripBtn setImage:[UIImage imageNamed:@"grey-dot.png"] forState:UIControlStateNormal];
        [ContractBtn setImage:[UIImage imageNamed:@"green-dot.png"] forState:UIControlStateNormal];
        [SeasonalBtn setImage:[UIImage imageNamed:@"grey-dot.png"] forState:UIControlStateNormal];
        tripBtn.selected=NO;
        ContractBtn.selected=YES;
        SeasonalBtn.selected=NO;
        
    }else{
        [tripBtn setImage:[UIImage imageNamed:@"grey-dot.png"] forState:UIControlStateNormal];
        [ContractBtn setImage:[UIImage imageNamed:@"grey-dot.png"] forState:UIControlStateNormal];
        [SeasonalBtn setImage:[UIImage imageNamed:@"green-dot.png"] forState:UIControlStateNormal];
        
        tripBtn.selected=NO;
        ContractBtn.selected=NO;
        SeasonalBtn.selected=YES;
    }
    [self setValueInCalculated];
    
}

#pragma mark - new ticket save btn method

- (IBAction)SelectSetBtnClicked:(id)sender {
    if (timePicker.tag==1) {
        StartTime.text=STime;
    }else {
        FinshTimeTf.text=FTime;
    }
    SelectTimeView.hidden=YES;
    [self.view reloadInputViews];
    
}

- (IBAction)NewTicketSaveBtnClicked:(id)sender {
    BOOL checkName=NO;
    if (![self CheckLength:DateTf.text]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter current date" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if (![self CheckLength:CompNameTf.text]){
       
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"please enter company name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
       
    }else if (![self CheckLength:StartTime.text]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"please enter start time" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if (![self CheckLength:FinshTimeTf.text]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"please enter finish time" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else if (![self CheckLength:PhoneNumTf.text]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"please enter phone number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else if (![self checkPhoneLength:PhoneNumTf.text]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"please enter valid phone number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else if (![self CheckLength:EmailTf.text])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"please enter email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else if (![self CheckLength:SnowFallTf.text]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"please enter snowfalls" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else if (![self CheckLength:HoursTf.text]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"please enter hours" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else if (![self CheckLength:CalculatedTf.text]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"please choose any radial trip/contract/seasonal" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if (!isImageBeforeSelected){
        UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"please select image before" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Alert show];
    }else if (!isImageAfterSelected){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"please select image after" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else{
    
        ClientInfo *addNewTicket=[[ClientInfo alloc]init];
        NSString *Comp=[NSString stringWithFormat:@"    %@",NewTicketInfo.Comp_name];
        if ([CompNameTf.text isEqualToString:Comp]) {
            checkName=YES;
        }
        if (checkName==YES) {
            addNewTicket.Comp_name=NewTicketInfo.Comp_name;
        }else{
            addNewTicket.Comp_name=CompNameTf.text;
        }
    
        addNewTicket.date=DateTf.text;
        addNewTicket.startTime=StartTime.text;
        addNewTicket.finishTime=FinshTimeTf.text;
        addNewTicket.phoneNo=PhoneNumTf.text;
        addNewTicket.Email=EmailTf.text;
        addNewTicket.snowFall=SnowFallTf.text;
        addNewTicket.hours=HoursTf.text.intValue;
        addNewTicket.calculated=CalculatedTf.text.intValue;
        
        if (SendVoiceBtn.selected) {
            addNewTicket.sendInVoice=1;
        }else{
            addNewTicket.sendInVoice=0;
        }
        
        if (paidInFullBtn.selected) {
            addNewTicket.paidInFull=1;
        }else{
            addNewTicket.paidInFull=0;
        }
        
        if (tripBtn.selected) {
            addNewTicket.trip=1;
        }else{
            addNewTicket.trip=0;
        }
        
        if (ContractBtn.selected) {
            addNewTicket.contract=1;
        }else{
            addNewTicket.contract=0;
        }
        
        if (SeasonalBtn.selected) {
            addNewTicket.seasonal=1;
        }else{
            addNewTicket.seasonal=0;
        }
        
        NSString *imageB=CompNameTf.text;
        imageB=[[[[imageB stringByReplacingOccurrencesOfString:@" " withString:@""]stringByReplacingOccurrencesOfString:@"." withString:@""]stringByReplacingOccurrencesOfString:@"@" withString:@""]stringByReplacingOccurrencesOfString:@"_" withString:@""];
        NSString *filenameBefore = [imageB stringByAppendingString:@"ImageBefore.png"]; // or .jpg
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *savedImageBeforePath = [documentsDirectory stringByAppendingPathComponent:filenameBefore];
        NSData *imageData = UIImageJPEGRepresentation(BeforeImg, 1.0);
        [imageData writeToFile:savedImageBeforePath atomically:NO];
        addNewTicket.imageBefore=savedImageBeforePath;
    
        NSString *imageA=CompNameTf.text;
        imageA=[[[[imageA stringByReplacingOccurrencesOfString:@" " withString:@""]stringByReplacingOccurrencesOfString:@"." withString:@""]stringByReplacingOccurrencesOfString:@"@" withString:@""]stringByReplacingOccurrencesOfString:@"_" withString:@""];
        NSString *filenameAfter = [imageA stringByAppendingString:@"ImageAfter.png"]; // or .jpg
        NSArray *pathsA = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectoryA = [pathsA objectAtIndex:0];
        NSString *savedImageAfterPath = [documentsDirectoryA stringByAppendingPathComponent:filenameAfter];
        NSData *imageDataA = UIImageJPEGRepresentation(BeforeImg, 1.0);
        [imageDataA writeToFile:savedImageBeforePath atomically:NO];
        addNewTicket.imageAfter=savedImageAfterPath;
        
        BOOL yes=[[DataBase getSharedInstance]SaveNewTicket:addNewTicket];
        if (yes==YES) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"New Ticket Created" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            alert.tag=1;
            alert.delegate=self;
            [alert show];
            
        }
    
    
    }
}

-(void)setValueInCalculated
{
    if (tripBtn.selected==YES) {
        CalculatedTf.text=NewTicketInfo.TripCost;
    }else if (ContractBtn.selected==YES){
        int newValue=HoursTf.text.intValue*NewTicketInfo.ContractCost.intValue;
     CalculatedTf.text=[NSString stringWithFormat:@"%d",newValue];
    }else if (SeasonalBtn.selected==YES){
        CalculatedTf.text=NewTicketInfo.SeasonalCost;
    }
    [self.view reloadInputViews];
}

#pragma mark - send voice btn method

- (IBAction)sendVoiceBtnClicked:(id)sender {
    UIButton *but=(UIButton*)sender;
    if (but.selected==NO) {
        [SendVoiceBtn setImage:[UIImage imageNamed:@"service_Checked.png"] forState:UIControlStateNormal];
        SendVoiceBtn.selected=YES;
    }else{
         [SendVoiceBtn setImage:[UIImage imageNamed:@"service_Check.png"] forState:UIControlStateNormal];
        SendVoiceBtn.selected=NO;
    }
}

#pragma mark - paid in full btn method

- (IBAction)PaidInFullBtnClicked:(id)sender {
    UIButton *but=(UIButton*)sender;
    if (but.selected==NO) {
        [paidInFullBtn setImage:[UIImage imageNamed:@"service_Checked.png"] forState:UIControlStateNormal];
        paidInFullBtn.selected=YES;
    }else{
        [paidInFullBtn setImage:[UIImage imageNamed:@"service_Check.png"] forState:UIControlStateNormal];
        paidInFullBtn.selected=NO;
    }
}

#pragma mark - text field delegate methods 

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==StartTime) {
        [StartTime resignFirstResponder];
        [self addTimePicker:1];
      
    }else if (textField==FinshTimeTf){
        [FinshTimeTf resignFirstResponder];
        [self addTimePicker:2];
    }
    if (textField==SnowFallTf) {
        NewTicketScrollView.frame=CGRectMake(0, -70, 321, 517);
    }else if (textField==HoursTf){
        NewTicketScrollView.frame=CGRectMake(0, -110, 321, 517);
    }else if (textField==CalculatedTf){
        NewTicketScrollView.frame=CGRectMake(0, -170, 321, 517);
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
NewTicketScrollView.frame=CGRectMake(0, 51, 321, 517);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==FinshTimeTf){
        [PhoneNumTf becomeFirstResponder];
    }else if (textField==PhoneNumTf)
    {
        [EmailTf becomeFirstResponder];
    }else if (textField== EmailTf){
        [SnowFallTf becomeFirstResponder];
    }else if (textField==SnowFallTf){
        [HoursTf becomeFirstResponder];
    }else if (textField==HoursTf){
        [CalculatedTf becomeFirstResponder];
    }else
    {
        [textField resignFirstResponder];
    }
    
    return NO;
}

#pragma mark - tap gesture method

-(void)ScrollViewTaped
{
    if (SnowFallTf) {
        [SnowFallTf resignFirstResponder];
    }
    if (HoursTf) {
        [HoursTf resignFirstResponder];
    }
    if (CalculatedTf){
        [CalculatedTf resignFirstResponder];
    }
}


#pragma mark - images tapped methods

-(void)ImageViewTapped:(UITapGestureRecognizer*)sender
{
    if (SnowFallTf) {
        [SnowFallTf resignFirstResponder];
    }
    
    if (HoursTf) {
        [HoursTf resignFirstResponder];
    }
    
   
    UIView *v=sender.view;
    NSLog(@" %d ",v.tag);
    pickerTag=v.tag;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Option" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Open Gallery", @"Open Camera", nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
    actionSheet.backgroundColor=[UIColor clearColor];
    NSLog(@"action sheet opende");
    
}

#pragma mark -image picker delegate method

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (pickerTag==1) {
        ImageBefore.image=image;
        BeforeImg=image;
        imageBeforeLab.text=@"";
        isImageBeforeSelected=YES;
        
        self.imageEditor.doneCallback = ^(UIImage *editedImage, BOOL canceled){
            if(!canceled) {
                self.ImageBefore.image=editedImage;
                BeforeImg=editedImage;
                
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        };
        self.imageEditor.sourceImage = image;
        self.imageEditor.previewImage = image;
        [self.imageEditor reset:NO];
        [self.navigationController pushViewController:self.imageEditor animated:YES];
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        
    }else{
        ImageAfter.image=image;
        AfterImg=image;
        imageAfterLab.text=@"";
        isImageAfterSelected=YES;
        
        self.imageEditor.doneCallback = ^(UIImage *editedImage, BOOL canceled){
            if(!canceled) {
                self.ImageAfter.image=editedImage;
                AfterImg=editedImage;
                
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        };
        self.imageEditor.sourceImage = image;
        self.imageEditor.previewImage = image;
        [self.imageEditor reset:NO];
        [self.navigationController pushViewController:self.imageEditor animated:YES];
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
    
//    ClientImageView.image=image;
//    ClientImage=image;
//    imageLab.text=@"";
//    isimageSelected=YES;
    //    imageViewForProfile.layer.borderWidth = 1.0f;
    //    imageViewForProfile.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //    imageViewForProfile.layer.masksToBounds = YES;
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


#pragma mark - action delegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (buttonIndex==0)
        {
            UIImagePickerController* picker = [[UIImagePickerController alloc] init];
            picker.delegate=self;
            
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];
        }else if (buttonIndex==1)
        {
            NSString *model = [[UIDevice currentDevice] model];
            if ([model isEqualToString:@"iPhone Simulator"] || [model isEqualToString:@"iPad Simulator"])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!!!" message:@"No Camera found!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
            }
            else
            {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                picker.allowsEditing = YES;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                [self presentViewController:picker animated:YES completion:nil];
                picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            }
     }
    
}

#pragma mark - checking methods
-(BOOL)CheckLength:(NSString*)sender
{
    if ([sender length]==0) {
        return NO;
    }
    return YES;
}

-(BOOL)CheckMail:(NSString*)sender
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailValidation = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if (![emailValidation evaluateWithObject:sender]) {
        return NO;
    }
    return YES;
}

-(BOOL)checkPhoneLength:(NSString*)sender
{
    if ([sender length]>10 || [sender length]<10) {
        return NO;
    }
    return YES;
}

#pragma mark - Compose Mail/SMS

// -------------------------------------------------------------------------------
//	displayMailComposerSheet
//  Displays an email composition interface inside the application.
//  Populates all the Mail fields.
// -------------------------------------------------------------------------------
- (void)displayMailComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setSubject:@"Hello !"];
    
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObject:NewTicketInfo.Email];
    // NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    // NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
    
    [picker setToRecipients:toRecipients];
    //[picker setCcRecipients:ccRecipients];
    // [picker setBccRecipients:bccRecipients];
    
    // Attach an image to the email
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"jpg"];
    //    NSData *myData = [NSData dataWithContentsOfFile:path];
    //    [picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"rainy"];
    
    // Fill out the email body text
    
    //NSIndexPath *index=[NotifyTableView indexPathForSelectedRow];
    
    
    NSString *emailBody =@"snow push invoice";
    [picker setMessageBody:emailBody isHTML:NO];
    
    [self presentViewController:picker animated:YES completion:NULL];
}
/*
 - (void)displaySMSComposerSheet
 {
 MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
 picker.messageComposeDelegate = self;
 
 // You can specify one or more preconfigured recipients.  The user has
 // the option to remove or add recipients from the message composer view
 // controller.
 picker.recipients = @[@"Phone number here"];
 
 // You can specify the initial message text that will appear in the message
 // composer view controller.
 NSUserDefaults *defult=[NSUserDefaults standardUserDefaults];
 NSString *first=[defult objectForKey:@"first_Num"];
 NSString *Second=[defult objectForKey:@"Second_Num"];
 
 NSArray *toRecipients = [NSArray arrayWithObjects:first,Second,nil];
 
 [picker setRecipients:toRecipients];
 
 picker.body = self.feedBackMsg;
 
 if (picker!=nil) {
 
 if (![first isEqualToString:@""] || ![Second isEqualToString:@""]) {
 [self presentViewController:picker animated:YES completion:NULL];
 }
 }
 
 }*/


#pragma mark - Delegate Methods

// -------------------------------------------------------------------------------
//	mailComposeController:didFinishWithResult:
//  Dismisses the email composition interface when users tap Cancel or Send.
//  Proceeds to update the message field with the result of the operation.
// -------------------------------------------------------------------------------
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	//self.feedbackMsg.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			//self.feedbackMsg.text = @"Result: Mail sending canceled";
			break;
		case MFMailComposeResultSaved:
            //	self.feedbackMsg.text = @"Result: Mail saved";
			break;
		case MFMailComposeResultSent:
            //	self.feedbackMsg.text = @"Result: Mail sent";
            
			break;
		case MFMailComposeResultFailed:
            //	self.feedbackMsg.text = @"Result: Mail sending failed";
			break;
		default:
            //	self.feedbackMsg.text = @"Result: Mail not sent";
			break;
	}
    
	[self dismissViewControllerAnimated:YES completion:NULL];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - alertView delegate method

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        NSString *title=[alertView buttonTitleAtIndex:buttonIndex];
        if ([title isEqualToString:@"OK"]) {
            if (SendVoiceBtn.selected) {
                [self displayMailComposerSheet];
            }else{
            [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
}

@end
