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
    NSDate *StartdateTime;
    NSDate *EndDateTime;
    UIImage *BeforeImg;
    UIImage *AfterImg;
    int pickerTag;
    BOOL isImageBeforeSelected;
    BOOL isImageBeforeChanged;
    BOOL isImageAfterSelected;
    BOOL isImageAfterChanged;
    NSMutableArray *ImageArr;
    NSDateFormatter *dateF;
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
@synthesize EditTicketTag,EditTicketInfo,eventManager;
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
    self.eventManager = [[EventManager alloc] init];
    dateF=[[NSDateFormatter alloc]init];
    [dateF setDateFormat:@"MM.dd.yyyy HH:mm"];
     [[NSUserDefaults standardUserDefaults]setObject:@"not paid" forKey:@"Paid"];
    [self requestAccessToEvents];
     self.imageEditor = [[ImageEditor alloc]init];
    ImageArr=[[NSMutableArray alloc]init];
    isImageBeforeSelected=NO;
    isImageAfterSelected=NO;
    isImageAfterChanged=NO;
    isImageBeforeChanged=NO;
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
    [dateFormate setDateFormat:@"MM/dd/yyyy"];
    
    
    if (EditTicketTag==1) {
        
      //  NSLog(@"Dic %@",EditTicketInfo);
        
        NSArray *arr=[[DataBase getSharedInstance]receiveSpecificClientfromClientsList:[EditTicketInfo objectForKey:@"companyName"]];
        if (arr.count>0) {
            NewTicketInfo=[arr objectAtIndex:0];
        }
        imageBeforeLab.text=@"";
        imageAfterLab.text=@"";

        isImageBeforeSelected=YES;
        isImageAfterSelected=YES;
        DateTf.text=[EditTicketInfo objectForKey:@"date"];
        CompNameTf.text=[EditTicketInfo objectForKey:@"companyName"];
        PhoneNumTf.text=[EditTicketInfo objectForKey:@"phoneNumber"];
        EmailTf.text=[EditTicketInfo objectForKey:@"email"];
        if([[EditTicketInfo objectForKey:@"calculated"] intValue]>0){
             CalculatedTf.text=[EditTicketInfo objectForKey:@"calculated"];
          
        }else{
         CalculatedTf.text=@"";
        }
        
        if ([[EditTicketInfo objectForKey:@"hours"] intValue]>0) {
             HoursTf.text=[EditTicketInfo objectForKey:@"hours"];
        }else{
        HoursTf.text=@"";
        }
       
        if ([[EditTicketInfo objectForKey:@"trip"] intValue]==1) {
            [tripBtn setImage:[UIImage imageNamed:@"green-dot.png"] forState:UIControlStateNormal];
            [ContractBtn setImage:[UIImage imageNamed:@"grey-dot.png"] forState:UIControlStateNormal];
            [SeasonalBtn setImage:[UIImage imageNamed:@"grey-dot.png"] forState:UIControlStateNormal];
            tripBtn.selected=YES;
            ContractBtn.selected=NO;
            SeasonalBtn.selected=NO;
            
        }else if ([[EditTicketInfo objectForKey:@"contract"] intValue]==1){
            [tripBtn setImage:[UIImage imageNamed:@"grey-dot.png"] forState:UIControlStateNormal];
            [ContractBtn setImage:[UIImage imageNamed:@"green-dot.png"] forState:UIControlStateNormal];
            [SeasonalBtn setImage:[UIImage imageNamed:@"grey-dot.png"] forState:UIControlStateNormal];
            tripBtn.selected=NO;
            ContractBtn.selected=YES;
            SeasonalBtn.selected=NO;
            
        }else if([[EditTicketInfo objectForKey:@"seasonal"] intValue]==1){
            [tripBtn setImage:[UIImage imageNamed:@"grey-dot.png"] forState:UIControlStateNormal];
            [ContractBtn setImage:[UIImage imageNamed:@"grey-dot.png"] forState:UIControlStateNormal];
            [SeasonalBtn setImage:[UIImage imageNamed:@"green-dot.png"] forState:UIControlStateNormal];
            
            tripBtn.selected=NO;
            ContractBtn.selected=NO;
            SeasonalBtn.selected=YES;
        }
        
        FinshTimeTf.text=[EditTicketInfo objectForKey:@"finishTime"];
       
        StartTime.text=[EditTicketInfo objectForKey:@"startTime"];
        SnowFallTf.text=[EditTicketInfo objectForKey:@"snowFall"];
        ImageAfter.image=[UIImage imageWithContentsOfFile:[EditTicketInfo objectForKey:@"imageAfter"]];
        if ([UIImage imageWithContentsOfFile:[EditTicketInfo objectForKey:@"imageAfter"]]==nil) {
            isImageAfterSelected=NO;
            ImageAfter.image=[UIImage imageNamed:@"transparentImage.png"];
            imageAfterLab.text=@"Image after";
        }
        ImageBefore.image=[UIImage imageWithContentsOfFile:[EditTicketInfo objectForKey:@"imageBefore"]];
        
        if ([[EditTicketInfo objectForKey:@"paidInFull"] intValue]==1) {
            [paidInFullBtn setImage:[UIImage imageNamed:@"service_Checked.png"] forState:UIControlStateNormal];
            paidInFullBtn.selected=YES;
              [[NSUserDefaults standardUserDefaults]setObject:@"paid" forKey:@"Paid"];
        }
        
        if ([[EditTicketInfo objectForKey:@"sendInVoice"] intValue]==1) {
            [SendVoiceBtn setImage:[UIImage imageNamed:@"service_Checked.png"] forState:UIControlStateNormal];
            SendVoiceBtn.selected=YES;
        }

    }else{
    
    DateTf.text=[dateFormate stringFromDate:[NSDate date]];
        CompNameTf.text=NewTicketInfo.Comp_name;
    PhoneNumTf.text=NewTicketInfo.phoneNo;
    EmailTf.text=NewTicketInfo.Email;
    }
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
        StartdateTime=timePicker.date;
    }else{
        timePicker.tag=2;
          FTime = [outputFormatter stringFromDate:timePicker.date];
        EndDateTime=timePicker.date;
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
        StartdateTime=timePicker.date;
    }else{
      
        FTime = [outputFormatter stringFromDate:timePicker.date];
        EndDateTime=timePicker.date;
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
    
    [self createCalendar];
    
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
    }else if (!isImageBeforeSelected){
        UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"please select image before" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Alert show];
    }
    else{
        if (ContractBtn.selected){
            if (![self CheckLength:HoursTf.text]) {
                UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"please enter hours" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [Alert show];
                return;
            }
    }
        ClientInfo *addNewTicket=[[ClientInfo alloc]init];
//        NSString *Comp=[NSString stringWithFormat:@"    %@",NewTicketInfo.Comp_name];
//        if (EditTicketTag==1) {
//            Comp=[NSString stringWithFormat:@"    %@",[EditTicketInfo objectForKey:@"companyName"]];
//        }
//        if ([CompNameTf.text isEqualToString:Comp]) {
//            checkName=YES;
//        }
//        if (checkName==YES) {
//        
//            addNewTicket.Comp_name=NewTicketInfo.Comp_name;
//            if (EditTicketTag==1) {
//                addNewTicket.Comp_name=[EditTicketInfo objectForKey:@"companyName"];
//            }
//        }else{
            addNewTicket.Comp_name=CompNameTf.text;
       // }
    
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
        
        if (EditTicketTag==1) {
            if (isImageBeforeChanged==YES) {
                NSFileManager *fileManager = [NSFileManager defaultManager];
                // NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                
                NSString *filePath =[EditTicketInfo objectForKey:@"imageBefore"];
                NSError *error;
                BOOL success = [fileManager removeItemAtPath:filePath error:&error];
                if (success) {
                    
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
                
                NSMutableDictionary *BeforeDic=[[NSMutableDictionary alloc]init];
                [BeforeDic setObject:savedImageBeforePath forKey:@"imagePath"];
                [BeforeDic setObject:@"Image Before" forKey:@"imageName"];
                [ImageArr addObject:BeforeDic];
                
            }else{
            addNewTicket.imageBefore=[EditTicketInfo objectForKey:@"imageBefore"];
                NSMutableDictionary *AfterDic=[[NSMutableDictionary alloc]init];
                [AfterDic setObject:[EditTicketInfo objectForKey:@"imageBefore"] forKey:@"imagePath"];
                [AfterDic setObject:@"Image After" forKey:@"imageName"];
                
                [ImageArr addObject:AfterDic];
            }
           
            
            if (isImageAfterChanged==YES) {
                NSFileManager *fileManager = [NSFileManager defaultManager];
                // NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                
                NSString *filePath =[EditTicketInfo objectForKey:@"imageAfter"];
                NSError *error;
                BOOL success = [fileManager removeItemAtPath:filePath error:&error];
                if (success) {
                    
                }
                
                NSString *imageA=CompNameTf.text;
                imageA=[[[[imageA stringByReplacingOccurrencesOfString:@" " withString:@""]stringByReplacingOccurrencesOfString:@"." withString:@""]stringByReplacingOccurrencesOfString:@"@" withString:@""]stringByReplacingOccurrencesOfString:@"_" withString:@""];
                NSString *filenameAfter = [imageA stringByAppendingString:@"ImageAfter.png"]; // or .jpg
                NSArray *pathsA = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectoryA = [pathsA objectAtIndex:0];
                NSString *savedImageAfterPath = [documentsDirectoryA stringByAppendingPathComponent:filenameAfter];
                NSData *imageDataA = UIImageJPEGRepresentation(AfterImg, 1.0);
                [imageDataA writeToFile:savedImageAfterPath atomically:NO];
                addNewTicket.imageAfter=savedImageAfterPath;
                
                NSMutableDictionary *AfterDic=[[NSMutableDictionary alloc]init];
                [AfterDic setObject:savedImageAfterPath forKey:@"imagePath"];
                [AfterDic setObject:@"Image After" forKey:@"imageName"];
                
                [ImageArr addObject:AfterDic];
            }else{
             addNewTicket.imageAfter=[EditTicketInfo objectForKey:@"imageAfter"];
                NSMutableDictionary *AfterDic=[[NSMutableDictionary alloc]init];
                [AfterDic setObject:[EditTicketInfo objectForKey:@"imageAfter"] forKey:@"imagePath"];
                [AfterDic setObject:@"Image After" forKey:@"imageName"];
                
                [ImageArr addObject:AfterDic];
            }
            
        
            addNewTicket.invoice_no=[[EditTicketInfo objectForKey:@"invoice"]integerValue];
            
            BOOL yes=[[DataBase getSharedInstance]updateTicketDetail:addNewTicket];
            if (yes==YES) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Ticket Updated successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                alert.tag=1;
                alert.delegate=self;
                [alert show];
                
            }
        }else{
        
       
        NSString *imageB=CompNameTf.text;
        imageB=[[[[imageB stringByReplacingOccurrencesOfString:@" " withString:@""]stringByReplacingOccurrencesOfString:@"." withString:@""]stringByReplacingOccurrencesOfString:@"@" withString:@""]stringByReplacingOccurrencesOfString:@"_" withString:@""];
        NSString *filenameBefore = [imageB stringByAppendingString:@"ImageBefore.png"]; // or .jpg
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *savedImageBeforePath = [documentsDirectory stringByAppendingPathComponent:filenameBefore];
        NSData *imageData = UIImageJPEGRepresentation(BeforeImg, 1.0);
        [imageData writeToFile:savedImageBeforePath atomically:NO];
        addNewTicket.imageBefore=savedImageBeforePath;
        
        NSMutableDictionary *BeforeDic=[[NSMutableDictionary alloc]init];
        [BeforeDic setObject:savedImageBeforePath forKey:@"imagePath"];
        [BeforeDic setObject:@"Image Before" forKey:@"imageName"];
        [ImageArr addObject:BeforeDic];
       
            if (isImageAfterSelected==YES) {
        NSString *imageA=CompNameTf.text;
        imageA=[[[[imageA stringByReplacingOccurrencesOfString:@" " withString:@""]stringByReplacingOccurrencesOfString:@"." withString:@""]stringByReplacingOccurrencesOfString:@"@" withString:@""]stringByReplacingOccurrencesOfString:@"_" withString:@""];
        NSString *filenameAfter = [imageA stringByAppendingString:@"ImageAfter.png"]; // or .jpg
        NSArray *pathsA = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectoryA = [pathsA objectAtIndex:0];
        NSString *savedImageAfterPath = [documentsDirectoryA stringByAppendingPathComponent:filenameAfter];
        NSData *imageDataA = UIImageJPEGRepresentation(AfterImg, 1.0);
        [imageDataA writeToFile:savedImageAfterPath atomically:NO];
        addNewTicket.imageAfter=savedImageAfterPath;
        
        NSMutableDictionary *AfterDic=[[NSMutableDictionary alloc]init];
        [AfterDic setObject:savedImageAfterPath forKey:@"imagePath"];
        [AfterDic setObject:@"Image After" forKey:@"imageName"];
        
                [ImageArr addObject:AfterDic];
            }
            
        BOOL yes=[[DataBase getSharedInstance]SaveNewTicket:addNewTicket];
        if (yes==YES) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"New Ticket Created" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            alert.tag=1;
            alert.delegate=self;
            [alert show];
            
        }
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
        [[NSUserDefaults standardUserDefaults]setObject:@"paid" forKey:@"Paid"];
    }else{
        [paidInFullBtn setImage:[UIImage imageNamed:@"service_Check.png"] forState:UIControlStateNormal];
        paidInFullBtn.selected=NO;
        [[NSUserDefaults standardUserDefaults]setObject:@"not paid" forKey:@"Paid"];
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
    if (textField==HoursTf) {
        [self setValueInCalculated];
    }
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
    NSLog(@" %ld ",(long)v.tag);
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
        if (EditTicketTag==1) {
            isImageBeforeChanged=YES;
        }
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
        if (EditTicketTag==1) {
            isImageAfterChanged=YES;
        }
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
    
    
    NSArray *toRecipients = [NSArray arrayWithObject:EmailTf.text];
    // NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    // NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
    
    [picker setToRecipients:toRecipients];
    //[picker setCcRecipients:ccRecipients];
    // [picker setBccRecipients:bccRecipients];
    
    // Attach an image to the email
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"jpg"];
    
    
//    
//        NSData *myData = [NSData dataWithContentsOfFile:imageBeforePath];
//        [picker addAttachmentData:myData mimeType:@"image/png" fileName:@"image before"];
//    
//    NSData *newData=[NSData dataWithContentsOfFile:ImageAfterPath];
//    [picker addAttachmentData:newData mimeType:@"image/png" fileName:@"image after"];
    // Fill out the email body text
    
    for (int i = 0; i < ImageArr.count; i++)
    {
       
        NSDictionary *dic=[ImageArr objectAtIndex:i];
        
        UIImage *image = [UIImage imageWithContentsOfFile:[dic objectForKey:@"imagePath"] ];
        NSData*   imageData = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0)];
                          
    [picker addAttachmentData:imageData mimeType:@"image/png" fileName:[dic objectForKey:@"imageName"]];
    }
    
    NSString *paid;
    if (paidInFullBtn.selected==YES) {
        paid=@"Yes";
    }else{
    paid=@"No";
    }
    
     NSMutableString *emailBody = [[NSMutableString alloc] initWithString:@"<html><body>"] ;
    [emailBody appendString:@"<p>********************************************************************************************************************************************************************************\nThank you for your Business... Attached are the following details of your last service trip brought to you by SnowPush.\n********************************************************************************************************************************************************************************</p>\n\n"];
   [emailBody appendString:[NSString stringWithFormat:@"<p>Date:%@</p>\n\n",DateTf.text]];
//    
    [emailBody appendString:[NSString stringWithFormat:@"<p><h1><font face=\"MYRIADPRO-COND\">Name:%@</font></h1><p>\n\n",CompNameTf.text]];
    [emailBody appendString:[NSString stringWithFormat:@"<br>Start Time:%@</br>",StartTime.text]];
    [emailBody appendString:[NSString stringWithFormat:@"End Time:%@",FinshTimeTf.text]];
    [emailBody appendString:[NSString stringWithFormat:@"<br>Snowfall:%@</br>",SnowFallTf.text]];
    [emailBody appendString:[NSString stringWithFormat:@"Hours Worked:%@",HoursTf.text]];
    [emailBody appendString:@"<br></br><br></br>"];
   // [emailBody appendString:@""];
    [emailBody appendString:[NSString stringWithFormat:@"<p>______________________________________________________<h1><font face=\"MYRIADPRO-COND\">Total Billed:$%@</font></h1></p>",CalculatedTf.text]];
    [emailBody appendString:[NSString stringWithFormat:@"Paid:%@",paid]];
    [emailBody appendString:@"</body></html>"];
    [picker setMessageBody:emailBody isHTML:YES];
    
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}


/*- (void)createEmail {
    //Create a string with HTML formatting for the email body
    NSMutableString *emailBody = [[[NSMutableString alloc] initWithString:@"<html><body>"] retain];
    //Add some text to it however you want
    [emailBody appendString:@"<p>Some email body text can go here</p>"];
    //Pick an image to insert
    //This example would come from the main bundle, but your source can be elsewhere
    UIImage *emailImage = [UIImage imageNamed:@"myImageName.png"];
    //Convert the image into data
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(emailImage)];
    //Create a base64 string representation of the data using NSData+Base64
    NSString *base64String = [imageData base64EncodedString];
    //Add the encoded string to the emailBody string
    //Don't forget the "<b>" tags are required, the "<p>" tags are optional
    [emailBody appendString:[NSString stringWithFormat:@"<p><b><img src='data:image/png;base64,%@'></b></p>",base64String]];
    //You could repeat here with more text or images, otherwise
    //close the HTML formatting
    [emailBody appendString:@"</body></html>"];
    NSLog(@"%@",emailBody);
    
    //Create the mail composer window
    MFMailComposeViewController *emailDialog = [[MFMailComposeViewController alloc] init];
    emailDialog.mailComposeDelegate = self;
    [emailDialog setSubject:@"My Inline Image Document"];
    [emailDialog setMessageBody:emailBody isHTML:YES];
    
    [self presentModalViewController:emailDialog animated:YES];
    [emailDialog release];
    [emailBody release];
}*/

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
    [self saveEvent];
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
                [self saveEvent];
           
            }
        }
    }
}

#pragma mark - calender events methods

/*-(void)event
{
  //  EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    
 ///////////////////////////////////////////?*****************************************************?/////////////////////////////////////
 
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // the selector is available, so we must be on iOS 6 or newer
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    // display error message here
                }
                else if (!granted)
                {
                    // display access denied error message here
                }
                else
                {
                    // access granted
                    // ***** do the important stuff here *****
                    
                    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                    event.title     = CompNameTf.text;
                    if (EditTicketTag==1) {
                        event.location=@"";
                    }else 
                    event.location=NewTicketInfo.Address;
                    
                    NSMutableArray *service=[[NSMutableArray alloc]init];
                    if (EditTicketTag==1) {
                        
                    }else{
                        if (NewTicketInfo.salt==1) {
                            [service addObject:@"salt"];
                        }if (NewTicketInfo.shovel==1) {
                            [service addObject:@"shovel"];
                        }if (NewTicketInfo.plow==1) {
                            [service addObject:@"plow"];
                        }if (NewTicketInfo.removal==1) {
                            [service addObject:@"removal"];
                        }
                    }
                    
                    NSString *noteStr=[NSString stringWithFormat:@"%@,%@,%@",[service componentsJoinedByString:@","],CalculatedTf.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"Paid"]];
                    
                    event.notes=noteStr;
                    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
                    [tempFormatter setDateFormat:@"MM.dd.yyyy HH:mm"];
                    
                    
//                    NSString *dateandtime =[NSString stringWithFormat:@"%@%@%@",datestring,@" ",starttimestring];
//                    NSString *dateandtimeend =[NSString stringWithFormat:@"%@%@%@",datestring,@" ",endtimestring];
                    
                    
                    
                    event.startDate =[dateF dateFromString:StartdateTime];
                    event.endDate =[dateF dateFromString:EndDateTime];
                    
                    
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 24]];
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
                    
                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                    
                   event.calendar= [[AppDelegate sharedInstance].eventManager.eventStore calendarWithIdentifier:@"SnowPush"];
                    
                    NSError *err;
                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];

                }
            });
        }];
    }
    else
    {
        // this code runs in iOS 4 or iOS 5
        // ***** do the important stuff here *****
    }
}
*/

- (IBAction)saveEvent {
    // Check if a title was typed in for the event.
    
    if (self.eventManager.selectedEventIdentifier.length > 0) {
        [self.eventManager deleteEventWithIdentifier:self.eventManager.selectedEventIdentifier];
        self.eventManager.selectedEventIdentifier = @"";
    }
    
    // Create a new event object.
    EKEvent *event = [EKEvent eventWithEventStore:self.eventManager.eventStore];
    
    // Set the event title.
    event.title = CompNameTf.text;
   
        event.location=NewTicketInfo.Address;
    
    NSMutableArray *service=[[NSMutableArray alloc]init];
    
        if (NewTicketInfo.salt==1) {
            [service addObject:@"salt"];
        }if (NewTicketInfo.shovel==1) {
            [service addObject:@"shovel"];
        }if (NewTicketInfo.plow==1) {
            [service addObject:@"plow"];
        }if (NewTicketInfo.removal==1) {
            [service addObject:@"removal"];
        }
  
    
    NSString *noteStr=[NSString stringWithFormat:@"%@,%@,%@",[service componentsJoinedByString:@","],CalculatedTf.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"Paid"]];
    
    event.notes=noteStr;
    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
    [tempFormatter setDateFormat:@"MM.dd.yyyy HH:mm"];
    // Set its calendar.
       event.calendar = [self.eventManager.eventStore calendarWithIdentifier:self.eventManager.selectedCalendarIdentifier];
    NSString *sdate=[DateTf.text stringByReplacingOccurrencesOfString:@"/" withString:@"."];
    NSString *start=[NSString stringWithFormat:@"%@ %@",sdate,StartTime.text];
    NSString *end=[NSString stringWithFormat:@"%@ %@",sdate,FinshTimeTf.text];
    
    StartdateTime=[tempFormatter dateFromString:start];
    EndDateTime=[tempFormatter dateFromString:end];
    // Set the start and end dates to the event.
    event.startDate = StartdateTime;
    event.endDate = EndDateTime;
    
    
    // Add any alarms the user has set.
//    for (int i=0; i<self.arrAlarms.count; i++) {
//        // Get the date for the current alarm.
//        NSDate *alarmDate = [self.arrAlarms objectAtIndex:i];
//        
//        // Create a new alarm.
//        EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:alarmDate];
//        
//        // Add the alarm to the event.
//        [event addAlarm:alarm];
//    }
    
    
    // Specify the recurrence frequency and interval values based on the respective selected option.
    EKRecurrenceFrequency frequency;
    NSInteger interval=0;
   /* switch (self.indexOfSelectedRepeatOption) {
        case 1:
            frequency = EKRecurrenceFrequencyDaily;
            interval = 1;
            break;
        case 2:
            frequency = EKRecurrenceFrequencyDaily;
            interval = 3;
        case 3:
            frequency = EKRecurrenceFrequencyWeekly;
            interval = 1;
        case 4:
            frequency = EKRecurrenceFrequencyWeekly;
            interval = 2;
        case 5:
            frequency = EKRecurrenceFrequencyMonthly;
            interval = 1;
        case 6:
            frequency = EKRecurrenceFrequencyMonthly;
            interval = 6;
        case 7:
            frequency = EKRecurrenceFrequencyYearly;
            interval = 1;
            
        default:
            interval = 0;
            frequency = EKRecurrenceFrequencyDaily;
            break;
    }*/
    
    // Create a rule and assign it to the reminder object if the interval is greater than 0.
    if (interval > 0) {
        EKRecurrenceEnd *recurrenceEnd = [EKRecurrenceEnd recurrenceEndWithEndDate:event.endDate];
        EKRecurrenceRule *rule = [[EKRecurrenceRule alloc] initRecurrenceWithFrequency:frequency interval:interval end:recurrenceEnd];
        event.recurrenceRules = @[rule];
    }
    else{
        event.recurrenceRules = nil;
    }
    
    
    // Save and commit the event.
    NSError *error;
    if ([self.eventManager.eventStore saveEvent:event span:EKSpanFutureEvents commit:YES error:&error]) {
        // Call the delegate method to notify the caller class (the ViewController class) that the event was saved.
        //[self.delegate eventWasSuccessfullySaved];
        
        // Pop the current view controller from the navigation stack.
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        // An error occurred, so log the error description.
        NSLog(@"%@", [error localizedDescription]);
         [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)createCalendar{
    // Hide the keyboard. To do so, it's necessary to access the textfield of the first cell.
  
    BOOL CalA=NO;
    
    // Create a new calendar.
    EKCalendar *calendar = [EKCalendar calendarForEntityType:EKEntityTypeEvent
                                                  eventStore:self.eventManager.eventStore];
    
    // Set the calendar title.
    calendar.title = @"SnowPush";
    
    // Find the proper source type value.
    
    NSArray *AllCal=[self.eventManager getLocalEventCalendars];
    
    
    for (int i=0; i<AllCal.count; i++) {
        EKCalendar *check=[AllCal objectAtIndex:i];
        if ([check.title isEqualToString:calendar.title]) {
            CalA=YES;
             self.eventManager.selectedCalendarIdentifier=check.calendarIdentifier;
            break;
        }
    }
    
    if (CalA==NO) {
        
    
    
        for (int i=0; i<self.eventManager.eventStore.sources.count; i++) {
            EKSource *source = (EKSource *)[self.eventManager.eventStore.sources objectAtIndex:i];
            EKSourceType currentSourceType = source.sourceType;
        
            if (currentSourceType == EKSourceTypeLocal) {
                calendar.source = source;
                break;
            }
        }
    
    
    // Save and commit the calendar.
        NSError *error;
        [self.eventManager.eventStore saveCalendar:calendar commit:YES error:&error];
    
    // If no error occurs then turn the editing mode off, store the new calendar identifier and reload the calendars.
        if (error == nil) {
        // Turn off the edit mode.
       // [self.tblCalendars setEditing:NO animated:YES];
        
        // Store the calendar identifier.
            [self.eventManager saveCustomCalendarIdentifier:calendar.calendarIdentifier];
            self.eventManager.selectedCalendarIdentifier=calendar.calendarIdentifier;
        // Reload all calendars.
       // [self loadEventCalendars];
        }
        else{
        // Display the error description to the debugger.
            NSLog(@"%@", [error localizedDescription]);
        }
    
    }else {
        return;
    }
}

-(void)requestAccessToEvents{
    [self.eventManager.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (error == nil) {
            // Store the returned granted value.
            self.eventManager.eventsAccessGranted = granted;
        }
        else{
            // In case of error, just log its description to the debugger.
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}

@end
