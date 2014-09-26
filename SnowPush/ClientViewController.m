//
//  ClientViewController.m
//  SnowPush
//
//  Created by Dannis on 9/22/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import "ClientViewController.h"

@interface ClientViewController ()

@end

@implementation ClientViewController
@synthesize AllClientTableView;
@synthesize SearchTextField;
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
    AllClientArr=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)BackBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(IBAction)MoreBtnClicked:(id)sender
{

}
-(IBAction)EditBtnClicked:(id)sender
{

}
-(IBAction)PlusBtnClicked:(id)sender
{
    [self performSegueWithIdentifier:@"EditClient" sender:self];
}


#pragma mark - UITableView DataSource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return AllClientArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AllClient"];
    
    
   // cell.NameLab.text=@"Client Name";
    
    if ([[AllClientArr objectAtIndex:indexPath.row]isEqualToString:@"1" ]) {
        cell.IceImage.hidden=YES;
        cell.minusImage.hidden=YES;
        cell.CatePortImage.hidden=YES;
    }else if ([[AllClientArr objectAtIndex:indexPath.row] isEqualToString:@"2"]){
        cell.IceImage.hidden=YES;
        cell.minusImage.hidden=YES;
        cell.CatePortImage.hidden=YES;
        cell.BoxImage.image=[UIImage imageNamed:@"image2.png"];
    }else if ([[AllClientArr objectAtIndex:indexPath.row] isEqualToString:@"4"]){
        cell.IceImage.hidden=YES;
        cell.minusImage.hidden=YES;
        cell.CatePortImage.image=[UIImage imageNamed:@"image4.png"];
        cell.BoxImage.image=[UIImage imageNamed:@"ice.png"];

    }
    else if ([[AllClientArr objectAtIndex:indexPath.row] isEqualToString:@"5"]){
        cell.IceImage.hidden=YES;
        cell.minusImage.hidden=YES;
        
    }
    else if ([[AllClientArr objectAtIndex:indexPath.row] isEqualToString:@"6"]){
        cell.IceImage.hidden=YES;
        cell.minusImage.hidden=YES;
        
    }
    else if ([[AllClientArr objectAtIndex:indexPath.row] isEqualToString:@"7"]){
        cell.IceImage.image=[UIImage imageNamed:@"image4.png"];;
        cell.minusImage.hidden=YES;
        cell.CatePortImage.image=[UIImage imageNamed:@"ice.png"];
       // cell.BoxImage.image=[UIImage imageNamed:@"ice.png"];
    }
    else if ([[AllClientArr objectAtIndex:indexPath.row] isEqualToString:@"8"]){
        cell.IceImage.hidden=YES;
        cell.minusImage.hidden=YES;
        cell.CatePortImage.image=[UIImage imageNamed:@"image4.png"];
      //  cell.BoxImage.image=[UIImage imageNamed:@"ice.png"];
        
    }
    else if ([[AllClientArr objectAtIndex:indexPath.row] isEqualToString:@"9"]){
      
        cell.minusImage.hidden=YES;
          cell.IceImage.hidden=YES;
        cell.CatePortImage.image=[UIImage imageNamed:@"image2.png"];
       // cell.BoxImage.image=[UIImage imageNamed:@"ice.png"];
        
    }
    
    else if ([[AllClientArr objectAtIndex:indexPath.row] isEqualToString:@"10"]){
        
        cell.minusImage.hidden=YES;
        cell.IceImage.hidden=YES;
        cell.CatePortImage.hidden=YES;
        cell.BoxImage.image=[UIImage imageNamed:@"ice.png"];
        
    }
    return cell;
}

#pragma mark - UITableView Delegates

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ClientDetailView" sender:self];
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
