//
//  ClientDetailViewController.m
//  SnowPush
//
//  Created by Dannis on 9/22/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import "ClientDetailViewController.h"
#import "OpenPaidTicketsViewController.h"
#import "MapViewController.h"
#import "EditClientViewController.h"
#import "NewTicketViewController.h"
#import <MessageUI/MessageUI.h>
@interface ClientDetailViewController ()<
MFMailComposeViewControllerDelegate,
MFMessageComposeViewControllerDelegate,
UINavigationControllerDelegate
>
{
    NSArray *NotifyArr;
    NSMutableArray *NewNotifyArr;
    NSMutableArray *ImageCountArr;
}
@end

@implementation ClientDetailViewController
@synthesize ClientReportView;
@synthesize NotifyTableView,NotifyView;
@synthesize SingleClientDetail;

@synthesize ClientDetailCompName,AddressLab,PhoneNumLab,emailLab,PriseLab,TripCostLab,ContractLab,SeasionalCostLab;

@synthesize SaltImageView,ShovelImageView,PlowImageView,RemovalImageView;

@synthesize QuickNotifyLab,OpenTicketBtn,paidTicketBtn,NewTicketBtn,TicketsLab;

@synthesize ClientDetailImageView,QuickNotifyAddBtn,QuickNotifyImageView,TIcketImageVIew;

@synthesize MapBtn,lineImageView,priseImageView;

@synthesize ClientEmailBtn,ClientReportBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    ClientReportView.hidden=YES;
    NotifyView.hidden=YES;
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ImageCountArr=[[NSMutableArray alloc]init];
    
    NotifyArr=[[NSArray alloc]initWithObjects:@"We're Running behind. Be there Soon",@"Ahead of Schedule.Be there in 10 min ",@"Thank you.... have a greate day!", nil];
    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"NotifyArr"]) {
        NewNotifyArr=[[NSMutableArray alloc]initWithArray:NotifyArr];

    }else{
        NewNotifyArr=[[NSMutableArray alloc]init];
        NewNotifyArr=[[NSUserDefaults standardUserDefaults]objectForKey:@"NotifyArr"];
    }
    
    NSArray *totalArr=[[DataBase getSharedInstance]RecieveTotalCompanysAllTickets:SingleClientDetail];
    int total=0;
    if (totalArr.count>0) {
        for (int i=0; i<totalArr.count; i++) {
            ClientInfo *client=[totalArr objectAtIndex:i];
            total=total+client.calculated;
        }
    }
    
    PriseLab.text=[NSString stringWithFormat:@"$%.2f",(float)total];
//PriseLab.font=[UIFont fontWithName:@"LETTERGOTHICSTD" size:35];
    ClientReportView.hidden=YES;
    NotifyView.hidden=YES;
    NotifyTableView.delegate=self;
    NotifyTableView.dataSource=self;
    
    ClientDetailCompName.text=SingleClientDetail.Comp_name;
   // ClientDetailCompName.text=@"Time Warner Cable";
    ClientDetailCompName.font=[UIFont fontWithName:@"LETTERGOTHICSTD" size:25];
    
    
    AddressLab.text=[NSString stringWithFormat:@"%@ \n %@,%@ %@",SingleClientDetail.Address,SingleClientDetail.City,SingleClientDetail.State,SingleClientDetail.Zip];
    AddressLab.font=[UIFont fontWithName:@"LETTERGOTHICSTD" size:14];
    
    PhoneNumLab.text=SingleClientDetail.phoneNo;
    PhoneNumLab.font=[UIFont fontWithName:@"LETTERGOTHICSTD" size:12];
    
    emailLab.text=SingleClientDetail.Email;
    emailLab.font=[UIFont fontWithName:@"LETTERGOTHICSTD" size:12];
    
    TripCostLab.text=[NSString stringWithFormat:@"Trip Cost - $%@",SingleClientDetail.TripCost];
    TripCostLab.font=[UIFont fontWithName:@"LETTERGOTHICSTD" size:12];
    
    ContractLab.text=[NSString stringWithFormat:@"Contract Cost - $%@/hr",SingleClientDetail.ContractCost];
    ContractLab.font=[UIFont fontWithName:@"LETTERGOTHICSTD" size:12];
    
    SeasionalCostLab.text=[NSString stringWithFormat:@"Seasonal Cost - $%@",SingleClientDetail.SeasonalCost];
    SeasionalCostLab.font=[UIFont fontWithName:@"LETTERGOTHICSTD" size:12];
    
    QuickNotifyLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
    OpenTicketBtn.titleLabel.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
    paidTicketBtn.titleLabel.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
    NewTicketBtn.titleLabel.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
    TicketsLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
    
    ClientDetailImageView.image=[self loadImage:SingleClientDetail.Image];
    ClientDetailImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    ClientDetailImageView.layer.borderWidth=4;
    ClientDetailImageView.layer.masksToBounds=YES;
    if (SingleClientDetail.salt==1) {
        [ImageCountArr addObject:@"salt"];//ice.png
    }
    
    if (SingleClientDetail.shovel==1) {
        [ImageCountArr addObject:@"shavel"];//image2.png
    }
    
    if (SingleClientDetail.plow==1) {
        [ImageCountArr addObject:@"plow"];//images3.png
    }
    
    if (SingleClientDetail.removal==1) {
        [ImageCountArr addObject:@"removal"];//image4.png
    }
    
    if (ImageCountArr.count>0) {
        
        for (int i=0; i<ImageCountArr.count; i++) {
            if (ImageCountArr.count==3) {
                SaltImageView.hidden=YES;
                ShovelImageView.frame=CGRectMake(113, 387, 30, 30);
                PlowImageView.frame=CGRectMake(145, 387, 30, 30);
                RemovalImageView.frame=CGRectMake(177, 387, 30, 30);
                if (i==0) {
                    if ([[ImageCountArr objectAtIndex:i]isEqualToString:@"salt"]) {
                        ShovelImageView.image=[UIImage imageNamed:@"ice.png"];
                    }else if ([[ImageCountArr objectAtIndex:i]isEqualToString:@"shavel"]){
                        ShovelImageView.image=[UIImage imageNamed:@"image2.png"];
                    }else if ([[ImageCountArr objectAtIndex:i ]isEqualToString:@"plow"]){
                        ShovelImageView.image=[UIImage imageNamed:@"images3.png"];
                    }else{
                        ShovelImageView.image=[UIImage imageNamed:@"image4.png"];
                    }
                }
                
                else if (i==1){
                    if ([[ImageCountArr objectAtIndex:i]isEqualToString:@"salt"]) {
                        PlowImageView.image=[UIImage imageNamed:@"ice.png"];
                    }else if ([[ImageCountArr objectAtIndex:i]isEqualToString:@"shavel"]){
                         PlowImageView.image=[UIImage imageNamed:@"image2.png"];
                    }else if ([[ImageCountArr objectAtIndex:i ]isEqualToString:@"plow"]){
                         PlowImageView.image=[UIImage imageNamed:@"images3.png"];
                    }else{
                      PlowImageView.image=[UIImage imageNamed:@"image4.png"];
                    }
                }
                
                
                else {
                    if ([[ImageCountArr objectAtIndex:i]isEqualToString:@"salt"]) {
                        RemovalImageView.image=[UIImage imageNamed:@"ice.png"];
                    }else if ([[ImageCountArr objectAtIndex:i]isEqualToString:@"shavel"]){
                         RemovalImageView.image=[UIImage imageNamed:@"image2.png"];
                    }else if ([[ImageCountArr objectAtIndex:i ]isEqualToString:@"plow"]){
                         RemovalImageView.image=[UIImage imageNamed:@"images3.png"];
                    }else{
                        RemovalImageView.image=[UIImage imageNamed:@"image4.png"];
                    }
                }
                
            }
            
            
            else if (ImageCountArr.count==2){
                SaltImageView.hidden=YES;
                ShovelImageView.hidden=YES;
                PlowImageView.frame=CGRectMake(129, 387, 30, 30);
                RemovalImageView.frame=CGRectMake(161, 387, 30, 30);

                if (i==0){
                    if ([[ImageCountArr objectAtIndex:i]isEqualToString:@"salt"]) {
                        PlowImageView.image=[UIImage imageNamed:@"ice.png"];
                    }else if ([[ImageCountArr objectAtIndex:i]isEqualToString:@"shavel"]){
                        PlowImageView.image=[UIImage imageNamed:@"image2.png"];
                    }else if ([[ImageCountArr objectAtIndex:i ]isEqualToString:@"plow"]){
                        PlowImageView.image=[UIImage imageNamed:@"images3.png"];
                    }else{
                        PlowImageView.image=[UIImage imageNamed:@"image4.png"];
                    }
                }
                
                
                else {
                    if ([[ImageCountArr objectAtIndex:i]isEqualToString:@"salt"]) {
                        RemovalImageView.image=[UIImage imageNamed:@"ice.png"];
                    }else if ([[ImageCountArr objectAtIndex:i]isEqualToString:@"shavel"]){
                        RemovalImageView.image=[UIImage imageNamed:@"image2.png"];
                    }else if ([[ImageCountArr objectAtIndex:i ]isEqualToString:@"plow"]){
                        RemovalImageView.image=[UIImage imageNamed:@"images3.png"];
                    }else{
                        RemovalImageView.image=[UIImage imageNamed:@"image4.png"];
                    }
                }
            }
            
            
            else if (ImageCountArr.count==1){
                SaltImageView.hidden=YES;
                ShovelImageView.hidden=YES;
                PlowImageView.hidden=YES;
                RemovalImageView.frame=CGRectMake(145, 387, 30, 30);

                if ([[ImageCountArr objectAtIndex:i]isEqualToString:@"salt"]) {
                    RemovalImageView.image=[UIImage imageNamed:@"ice.png"];
                }else if ([[ImageCountArr objectAtIndex:i]isEqualToString:@"shavel"]){
                    RemovalImageView.image=[UIImage imageNamed:@"image2.png"];
                }else if ([[ImageCountArr objectAtIndex:i ]isEqualToString:@"plow"]){
                    RemovalImageView.image=[UIImage imageNamed:@"images3.png"];
                }else{
                    RemovalImageView.image=[UIImage imageNamed:@"image4.png"];
                }
            }
        }
        
       
    }else{
        SaltImageView.hidden=YES;
        ShovelImageView.hidden=YES;
        PlowImageView.hidden=YES;
        RemovalImageView.hidden=YES;
    }
    
    
    if ([AppDelegate sharedInstance].DeviceHieght==480) {
        ClientDetailImageView.frame=CGRectMake(5, 53, 312, 150);
        MapBtn.frame=CGRectMake(140, 177, 40, 40);
        ClientDetailCompName.frame=CGRectMake(26, 220, 270, 26);
        lineImageView.frame=CGRectMake(12, 245, 297, 3);
        AddressLab.frame=CGRectMake(25, 256, 270, 33);
        PhoneNumLab.frame=CGRectMake(25, 300, 270, 17);
        emailLab.frame=CGRectMake(25, 315, 270, 13);
        SaltImageView.frame=CGRectMake(107, 339, 25, 25);
        ShovelImageView.frame=CGRectMake(134, 339, 25, 25);
        PlowImageView.frame=CGRectMake(162, 339, 25, 25);
        RemovalImageView.frame=CGRectMake(188, 339, 25, 25);
        PriseLab.frame=CGRectMake(25, 379, 270, 26);
        priseImageView.frame=CGRectMake(40, 379, 241, 26);
        TripCostLab.frame=CGRectMake(12, 424, 165, 13);
        ContractLab.frame=CGRectMake(12, 442, 165, 13);
        SeasionalCostLab.frame=CGRectMake(12, 461, 165, 13);
        ClientEmailBtn.frame=CGRectMake(242, 449, 27, 25);
        ClientReportBtn.frame=CGRectMake(287, 449, 25, 25);
        
        ClientReportView.frame=CGRectMake(0, 245, 320, 235);
        TIcketImageVIew.frame=CGRectMake(0, 0, 320, 238);
        TicketsLab.frame=CGRectMake(120, 5, 81, 23);
        NewTicketBtn.frame=CGRectMake(10, 55, 300, 45);
        OpenTicketBtn.frame=CGRectMake(10, 116, 300, 45);
        paidTicketBtn.frame=CGRectMake(10, 175, 300, 45);
        
        NotifyView.frame=CGRectMake(0, 100, 320, 380);
        QuickNotifyImageView.frame=CGRectMake(0, 0, 320, 380);
       
        QuickNotifyAddBtn.frame=CGRectMake(8, 34, 25, 25);
        NotifyTableView.frame=CGRectMake(0, 70, 320, 310);
        
        if (ImageCountArr.count==3) {
            ShovelImageView.frame=CGRectMake(121, 339, 25, 25);
            PlowImageView.frame=CGRectMake(149, 339, 25, 25);
            RemovalImageView.frame=CGRectMake(175, 339, 25, 25);
        }else if (ImageCountArr.count==2){
            PlowImageView.frame=CGRectMake(135, 339, 25, 25);
            RemovalImageView.frame=CGRectMake(161, 339, 25, 25);
        }else if (ImageCountArr.count==1){
         RemovalImageView.frame=CGRectMake(148, 339, 25, 25);
        }
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - retrive Image method

- (UIImage *)loadImage:(NSString *)filePath  {
    return [UIImage imageWithContentsOfFile:filePath];
}


-(IBAction)ClientDetailBackBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)ClientReportsViewPopUp:(id)sender
{
    ClientReportView.hidden=NO;
}

-(IBAction)EmailBtnClicked:(id)sender
{
    NotifyView.hidden=NO;
}

-(IBAction)EditButClicked:(id)sender
{
    [self performSegueWithIdentifier:@"editClient" sender:self];
}

-(IBAction)NewTicketBtnClicked:(id)sender
{
    [self performSegueWithIdentifier:@"NewTicket" sender:self];
}

-(IBAction)OpenTicketsBtnClicked:(id)sender
{
    UIButton *Btn=(UIButton*)sender;
    OpenPaidTicketsViewController *OPTView=[self.storyboard instantiateViewControllerWithIdentifier:@"OpenPaidTicketsViewController"];
    OPTView.OPTViewTag=Btn.tag;
    OPTView.OPTClientDtail=SingleClientDetail;
    [self.navigationController pushViewController:OPTView animated:YES];
}
-(IBAction)PaidTicketsBtn:(id)sender
{
    UIButton *Btn=(UIButton*)sender;
    OpenPaidTicketsViewController *OPTView=[self.storyboard instantiateViewControllerWithIdentifier:@"OpenPaidTicketsViewController"];
    OPTView.OPTViewTag=Btn.tag;
     OPTView.OPTClientDtail=SingleClientDetail;
    [self.navigationController pushViewController:OPTView animated:YES];
}

- (IBAction)MapBtnClicked:(id)sender {
    
    MapViewController *mapView=[self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    [self.navigationController pushViewController:mapView animated:NO];
}

- (IBAction)NotifyAddBtnClicked:(id)sender {
    
    UIAlertView *AddNotifyAlert=[[UIAlertView alloc]initWithTitle:@"Add to Quick Notify" message:nil delegate:self cancelButtonTitle:@"Add" otherButtonTitles:@"Cancel", nil];
    AddNotifyAlert.alertViewStyle=UIAlertViewStylePlainTextInput;
    [AddNotifyAlert textFieldAtIndex:0].delegate=self;
    [AddNotifyAlert show];
  
}


#pragma mark - table view data source methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return NewNotifyArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text=[NewNotifyArr objectAtIndex:indexPath.row];
    cell.textLabel.textColor=[UIColor colorWithWhite:0 alpha:0.7];
    //cell.backgroundColor=[UIColor colorWithWhite:1 alpha:0.5];
    cell.textLabel.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:24];
    
    return cell;
}

#pragma mark - table view delegates methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotifyView.hidden=YES;
    [self displayMailComposerSheet];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.destinationViewController isKindOfClass:[EditClientViewController class]]) {
        //  [(MoreViewController*).SegueId]
        EditClientViewController *addClient=(EditClientViewController*)[segue destinationViewController];
        addClient.editTag=1;
        addClient.ClientInformation=SingleClientDetail;
    }else if ([segue.destinationViewController isKindOfClass:[NewTicketViewController class]]) {
        //  [(MoreViewController*).SegueId]
        NewTicketViewController *newTicket=(NewTicketViewController*)[segue destinationViewController];
        newTicket.NewTicketInfo=SingleClientDetail;
    }
}

#pragma mark - alert view delegates

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[alertView buttonTitleAtIndex:buttonIndex]isEqualToString:@"Add"]) {
        [NewNotifyArr addObject:[alertView textFieldAtIndex:0].text];
        [NotifyTableView reloadData];
        
        [[NSUserDefaults standardUserDefaults]setObject:NewNotifyArr forKey:@"NotifyArr"];
    }
}

#pragma mark - text field delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField
{}

-(void)textFieldDidEndEditing:(UITextField *)textField
{}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
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
     NSArray *toRecipients = [NSArray arrayWithObject:SingleClientDetail.Email];
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
    
    NSIndexPath *index=[NotifyTableView indexPathForSelectedRow];
    
    
    NSString *emailBody = [NewNotifyArr objectAtIndex:index.row];
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
}


@end
