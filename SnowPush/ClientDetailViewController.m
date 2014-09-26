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
@interface ClientDetailViewController ()
{
    NSArray *NotifyArr;
}
@end

@implementation ClientDetailViewController
@synthesize ClientReportView;
@synthesize NotifyTableView,NotifyView;
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
    
    ClientReportView.hidden=YES;
    NotifyView.hidden=YES;
    NotifyTableView.delegate=self;
    NotifyTableView.dataSource=self;
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
    
    
}


#pragma mark - table view data source methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return NotifyArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text=[NotifyArr objectAtIndex:indexPath.row];
    cell.textLabel.textColor=[UIColor colorWithWhite:0 alpha:0.7];
    cell.backgroundColor=[UIColor colorWithWhite:1 alpha:0.5];
    
    return cell;
}

#pragma mark - table view delegates methods


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
