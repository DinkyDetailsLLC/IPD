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
@interface ClientDetailViewController ()
{
    NSArray *NotifyArr;
    NSMutableArray *NewNotifyArr;
}
@end

@implementation ClientDetailViewController
@synthesize ClientReportView;
@synthesize NotifyTableView,NotifyView;
@synthesize SingleClientDetail;

@synthesize ClientDetailCompName,AddressLab,PhoneNumLab,emailLab,PriseLab,TripCostLab,ContractLab,SeasionalCostLab;

@synthesize SaltImageView,ShovelImageView,PlowImageView,RemovalImageView;

@synthesize QuickNotifyLab,OpenTicketBtn,paidTicketBtn,NewTicketBtn,TicketsLab;
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
    
    NotifyArr=[[NSArray alloc]initWithObjects:@"We're Running behind. Be there Soon",@"Ahead of Schedule.Be there in 10 min ",@"Thank you.... have a greate day!", nil];
    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"NotifyArr"]) {
        NewNotifyArr=[[NSMutableArray alloc]initWithArray:NotifyArr];

    }else{
        NewNotifyArr=[[NSMutableArray alloc]init];
        NewNotifyArr=[[NSUserDefaults standardUserDefaults]objectForKey:@"NotifyArr"];
    }
    
    
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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self.navigationController pushViewController:OPTView animated:YES];
}
-(IBAction)PaidTicketsBtn:(id)sender
{
    UIButton *Btn=(UIButton*)sender;
    OpenPaidTicketsViewController *OPTView=[self.storyboard instantiateViewControllerWithIdentifier:@"OpenPaidTicketsViewController"];
    OPTView.OPTViewTag=Btn.tag;
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

@end
