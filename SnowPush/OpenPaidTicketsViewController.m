//
//  OpenPaidTicketsViewController.m
//  SnowPush
//
//  Created by Dannis on 9/25/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import "OpenPaidTicketsViewController.h"

@interface OpenPaidTicketsViewController ()
{
    UILabel *HeaderLab;
}
@end

@implementation OpenPaidTicketsViewController
@synthesize OPTSearchTF;
@synthesize OPTTableView;
@synthesize OPTViewTag;
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

- (IBAction)OpTBackBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)OPTMoreBtnClicked:(id)sender {
    
}



#pragma mark - UITableView DataSource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OPTCell"];
    
    if (OPTViewTag==2) {
        cell.OPTCircleImageView.image=[UIImage imageNamed:@"green-dot.png"];
    }
    
    return cell;
}

#pragma mark - UITableView Delegates method

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
        HeaderLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
        HeaderLab.textAlignment=NSTextAlignmentRight;
       HeaderLab.backgroundColor=[UIColor whiteColor];
    
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    [format setDateFormat:@"dd/MM/yyyy"];
    
    HeaderLab.text=[format stringFromDate:[NSDate date]];
    
    return HeaderLab;
}
@end
