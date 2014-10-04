//
//  ClientViewController.m
//  SnowPush
//
//  Created by Dannis on 9/22/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import "ClientViewController.h"
#import "ClientDetailViewController.h"
#import "EditClientViewController.h"
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
    AllClientArr=[[DataBase getSharedInstance]receiveAllData];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    AllClientArr=[[DataBase getSharedInstance]receiveAllData];
    [AllClientTableView reloadData];
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
    
    ClientInfo *Client=[AllClientArr objectAtIndex:indexPath.row];
    cell.NameLab.text=Client.Comp_name;
    cell.NameLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
   
    NSMutableArray *ImgArr=[[NSMutableArray alloc]init];
    
    if (Client.plow==1) {
        [ImgArr addObject:@"plow"];
    }
    if (Client.shovel==1) {
        [ImgArr addObject:@"shavel"];
    }
    if (Client.salt==1) {
        [ImgArr addObject:@"salt"];
    }
    if (Client.removal==1) {
        [ImgArr addObject:@"removal"];
    }
    
    
    
   

    if (ImgArr.count>0) {
        for (int i=0; i<ImgArr.count; i++) {
            
            if (ImgArr.count==3){
                cell.minusImage.hidden=YES;

                if (i==0) {
                    
                    if ([[ImgArr objectAtIndex:i]isEqualToString:@"salt"]) {
                        
                        cell.BoxImage.image=[UIImage imageNamed:@"ice.png"];
                        
                    }else if ([[ImgArr objectAtIndex:i]isEqualToString:@"shavel"]){
                        
                        cell.BoxImage.image=[UIImage imageNamed:@"image2.png"];
                        
                    }else if ([[ImgArr objectAtIndex:i]isEqualToString:@"plow"]){
                        
                    }else{
                        
                        cell.BoxImage.image=[UIImage imageNamed:@"image4.png"];
                        
                    }
                }else if (i==1){
                    if ([[ImgArr objectAtIndex:i]isEqualToString:@"salt"]) {
                        
                        cell.CatePortImage.image=[UIImage imageNamed:@"ice.png"];
                        
                    }else if ([[ImgArr objectAtIndex:i]isEqualToString:@"shavel"]){
                        
                    }else if ([[ImgArr objectAtIndex:i]isEqualToString:@"plow"]){
                        
                          cell.CatePortImage.image=[UIImage imageNamed:@"images3.png"];
                        
                    }else{
                        
                          cell.CatePortImage.image=[UIImage imageNamed:@"image4.png"];
                    }
                }
                else{
                    if ([[ImgArr objectAtIndex:i]isEqualToString:@"salt"]) {
                        
                    }else if ([[ImgArr objectAtIndex:i]isEqualToString:@"shavel"]){
                        
                        cell.IceImage.image=[UIImage imageNamed:@"image2.png"];
                        
                    }else if ([[ImgArr objectAtIndex:i]isEqualToString:@"plow"]){
                        
                          cell.IceImage.image=[UIImage imageNamed:@"images3.png"];
                        
                    }else{
                        
                          cell.IceImage.image=[UIImage imageNamed:@"image4.png"];
                    }
                }
               
            
            }else if (ImgArr.count==2){
                
                cell.minusImage.hidden=YES;
                cell.IceImage.hidden=YES;
                
                if (i==0) {
                    if ([[ImgArr objectAtIndex:i]isEqualToString:@"salt"]) {
                        
                        cell.BoxImage.image=[UIImage imageNamed:@"ice.png"];
                        
                    }else if ([[ImgArr objectAtIndex:i]isEqualToString:@"shavel"]){
                        
                        cell.BoxImage.image=[UIImage imageNamed:@"image2.png"];
                        
                    }else if ([[ImgArr objectAtIndex:i]isEqualToString:@"plow"]){
                        
                    }else{
                        
                        cell.BoxImage.image=[UIImage imageNamed:@"image4.png"];
                        
                    }
                }else{
                    if ([[ImgArr objectAtIndex:i]isEqualToString:@"salt"]) {
                        
                        cell.CatePortImage.image=[UIImage imageNamed:@"ice.png"];
                        
                    }else if ([[ImgArr objectAtIndex:i]isEqualToString:@"shavel"]){
                        
                    }else if ([[ImgArr objectAtIndex:i]isEqualToString:@"plow"]){
                        
                        cell.CatePortImage.image=[UIImage imageNamed:@"images3.png"];
                        
                    }else{
                        
                        cell.CatePortImage.image=[UIImage imageNamed:@"image4.png"];
                    }
                }
            }else if (ImgArr.count==1){
                cell.CatePortImage.hidden=YES;
                cell.minusImage.hidden=YES;
                cell.IceImage.hidden=YES;
                if ([[ImgArr objectAtIndex:i]isEqualToString:@"salt"]) {
                    
                    cell.BoxImage.image=[UIImage imageNamed:@"ice.png"];
                    
                }else if ([[ImgArr objectAtIndex:i]isEqualToString:@"shavel"]){
                    
                    cell.BoxImage.image=[UIImage imageNamed:@"image2.png"];
                    
                }else if ([[ImgArr objectAtIndex:i]isEqualToString:@"plow"]){
                    
                }else{
                    
                    cell.BoxImage.image=[UIImage imageNamed:@"image4.png"];
                    
                }
            }
            
        }
    }
    
       return cell;
}

#pragma mark - UITableView Delegates

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ClientDetailView" sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[ClientDetailViewController class]]) {
        //  [(MoreViewController*).SegueId]
        ClientDetailViewController *clientDetailView=(ClientDetailViewController*)[segue destinationViewController];
        NSIndexPath *indexPath=[AllClientTableView indexPathForSelectedRow];
        
        ClientInfo *client=[AllClientArr objectAtIndex:indexPath.row];
        
        clientDetailView.SingleClientDetail=client;
        
    }else if ([segue.destinationViewController isKindOfClass:[EditClientViewController class]])
    {
        
        EditClientViewController *AddClient=(EditClientViewController*)[segue destinationViewController];
        AddClient.editTag=0;
        
    }
}


@end
