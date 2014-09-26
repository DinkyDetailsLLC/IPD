//
//  TicketViewController.m
//  SnowPush
//
//  Created by Dannis on 9/22/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import "TicketViewController.h"

@interface TicketViewController ()
{
    UIColor *SectionViewColor;
    UILabel *HeaderLab;
}
@end

@implementation TicketViewController
@synthesize TicketSearchTextField;
@synthesize TicketTableView;
@synthesize ViewTag;
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
    
    if (ViewTag==0) {
        SectionViewColor=[UIColor whiteColor];
    }else if (ViewTag==1){
     SectionViewColor=[UIColor colorWithRed:245/255.0f green:132/255.0f blue:60/255.0f alpha:1];
    }else if (ViewTag==2){
     SectionViewColor=[UIColor colorWithRed:78/255.0f green:238/255.0f blue:191/255.0f alpha:1];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)TicketBackBtnClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:NO];
}

-(IBAction)TicketMoreBtnClicked:(id)sender{

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
    CustomTableCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TicketCell"];
    
    if (ViewTag==0) {
        cell.InvoiceLab2.hidden=YES;
    }else{
        cell.InvoiceLab.hidden=YES;
        cell.CircleButton.hidden=YES;
    }
    
    if (indexPath.section==0) {

        if (indexPath.row==1) {
            [cell.CircleButton setImage:[UIImage imageNamed:@"circleGreen.png"] forState:UIControlStateNormal];
        }
    }
    
    return cell;
}

#pragma mark - UITableView Delegates method

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
   HeaderLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    HeaderLab.textAlignment=NSTextAlignmentRight;
    HeaderLab.backgroundColor=SectionViewColor;
    if (section==0) {
        HeaderLab.text=@"Time Warner Cable";
    }else{
    HeaderLab.text=@"Some other Company";
    }
    return HeaderLab;
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

@end
