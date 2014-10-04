//
//  NewTicketViewController.m
//  SnowPush
//
//  Created by Dannis on 9/23/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import "NewTicketViewController.h"

@interface NewTicketViewController ()

@end

@implementation NewTicketViewController
@synthesize DateTf,CalculatedTf,CompNameTf,ContractBtn,ContractLab;
@synthesize FinshTimeTf,paidInFull,paidInFullBtn,PhoneNumTf;
@synthesize EmailTf,ImageAfter,ImageBefore;
@synthesize SeasonalBtn,SeasonalLab,SendVoiceBtn,sendVoiceLab,SnowFallTf,StartTime;
@synthesize HoursTf,TotalLab,tripBtn,tripLab;
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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)NewTicketBackBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}
- (IBAction)TripBtnClicked:(id)sender {
}

- (IBAction)ContractBtnClicked:(id)sender {
}

- (IBAction)SeasonalBtnClicked:(id)sender {
}
- (IBAction)sendVoiceBtnClicked:(id)sender {
}

- (IBAction)PaidInFullBtnClicked:(id)sender {
}
@end
