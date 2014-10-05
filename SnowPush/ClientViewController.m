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
{

    BOOL isSearching;
    NSMutableString *ChangeStr;
    NSMutableArray *AllClientList;
    NSMutableArray *SearchArr;
}
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
    //(Comp_Name,Address,city,state,zip,PhoneNo,email,Image,tripCost,contactCost,seasonalCost,Salt,shovel,plow,removal)
    
    isSearching=NO;
    AllClientList=[[NSMutableArray alloc]init];
    SearchArr=[[NSMutableArray alloc]init];
    AllClientArr=[[DataBase getSharedInstance]receiveAllData];
    
    for (int i=0; i<AllClientArr.count; i++) {
        ClientInfo *Client=[AllClientArr objectAtIndex:i];
        NSMutableDictionary *Dic=[[NSMutableDictionary alloc]init];
        [Dic setObject:Client.Comp_name forKey:@"CompName"];
        [Dic setObject:Client.Address forKey:@"address"];
        [Dic setObject:Client.City forKey:@"city"];
        [Dic setObject:Client.State forKey:@"state"];
        [Dic setObject:Client.Zip forKey:@"zip"];
        [Dic setObject:Client.phoneNo forKey:@"phone"];
        [Dic setObject:Client.Email forKey:@"email"];
        [Dic setObject:Client.Image forKey:@"image"];
        [Dic setObject:Client.TripCost forKey:@"tripCost"];
        [Dic setObject:Client.ContractCost forKey:@"contractCost"];
        [Dic setObject:Client.SeasonalCost forKey:@"seasonalCost"];
        [Dic setObject:[NSString stringWithFormat:@"%d",Client.salt] forKey:@"salt"];
        [Dic setObject:[NSString stringWithFormat:@"%d",Client.shovel] forKey:@"shovel"];
        [Dic setObject:[NSString stringWithFormat:@"%d",Client.plow] forKey:@"plow"];
        [Dic setObject:[NSString stringWithFormat:@"%d",Client.removal] forKey:@"removal"];
        [AllClientList addObject:Dic];
    }
    SearchArr=[[NSMutableArray alloc]initWithArray:AllClientList];
    
    if ([AppDelegate sharedInstance].DeviceHieght==480) {
        AllClientTableView.frame=CGRectMake(0, 92, 320, 388);
    }
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    AllClientArr=[[DataBase getSharedInstance]receiveAllData];
    AllClientList=[[NSMutableArray alloc]init];
    for (int i=0; i<AllClientArr.count; i++) {
        ClientInfo *Client=[AllClientArr objectAtIndex:i];
        NSMutableDictionary *Dic=[[NSMutableDictionary alloc]init];
        [Dic setObject:Client.Comp_name forKey:@"CompName"];
        [Dic setObject:Client.Address forKey:@"address"];
        [Dic setObject:Client.City forKey:@"city"];
        [Dic setObject:Client.State forKey:@"state"];
        [Dic setObject:Client.Zip forKey:@"zip"];
        [Dic setObject:Client.phoneNo forKey:@"phone"];
        [Dic setObject:Client.Email forKey:@"email"];
        [Dic setObject:Client.Image forKey:@"image"];
        [Dic setObject:Client.TripCost forKey:@"tripCost"];
        [Dic setObject:Client.ContractCost forKey:@"contractCost"];
        [Dic setObject:Client.SeasonalCost forKey:@"seasonalCost"];
        [Dic setObject:[NSString stringWithFormat:@"%d",Client.salt] forKey:@"salt"];
        [Dic setObject:[NSString stringWithFormat:@"%d",Client.shovel] forKey:@"shovel"];
        [Dic setObject:[NSString stringWithFormat:@"%d",Client.plow] forKey:@"plow"];
        [Dic setObject:[NSString stringWithFormat:@"%d",Client.removal] forKey:@"removal"];
        [AllClientList addObject:Dic];
    }
    
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
    if (isSearching==YES) {
        return SearchArr.count;
    }
    return AllClientList.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AllClient"];
    
   // ClientInfo *Client=[AllClientArr objectAtIndex:indexPath.row];
    
    
    
    NSDictionary *Client=[AllClientList objectAtIndex:indexPath.row];
    
    if (isSearching==YES) {
        Client=[SearchArr objectAtIndex:indexPath.row];
    }
    
    cell.NameLab.text=[Client objectForKey:@"CompName"];
    cell.NameLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
   
    NSMutableArray *ImgArr=[[NSMutableArray alloc]init];
    
    if ([[Client objectForKey:@"plow"]intValue ]==1) {
        [ImgArr addObject:@"plow"];
    }
    if ([[Client objectForKey:@"shovel"]intValue ]==1) {
        [ImgArr addObject:@"shavel"];
    }
    if ([[Client objectForKey:@"salt"]intValue ]==1) {
        [ImgArr addObject:@"salt"];
    }
    if ([[Client objectForKey:@"removal"]intValue ]==1) {
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
                    if ([[ImgArr objectAtIndex:i]isEqualToString:@"salt"]) {}
                    else if ([[ImgArr objectAtIndex:i]isEqualToString:@"shavel"]){
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
    }else{
        cell.CatePortImage.hidden=YES;
        cell.minusImage.hidden=YES;
        cell.IceImage.hidden=YES;
        cell.BoxImage.hidden=YES;
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

#pragma mark - UITextField delegate methods

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==SearchTextField) {
        isSearching=YES;
        NSLog(@"%@",textField.text);
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==SearchTextField) {
        isSearching=NO;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==SearchTextField) {
        if (isSearching==YES) {
                NSMutableString *newString=[[NSMutableString alloc]initWithString:textField.text];
            if ([string isEqualToString: @""])
            {
                
                NSRange ran=NSMakeRange(0, newString.length-1);
              //
                
                NSString *str=[newString stringByReplacingCharactersInRange:ran withString:@""];
                
                NSRange NewRan=[newString rangeOfString:str];
                
              //  NSString* s= [newString lastPathComponent];
                
                newString=[newString stringByReplacingCharactersInRange:NewRan withString:@""];
                
            }else{
             [newString appendString:string];
            }
            
            if ([newString isEqualToString:@""]) {
                SearchArr=[NSMutableArray arrayWithArray:AllClientList];
            }else{
            
            NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"CompName contains[c] %@", newString];
            NSArray*  searchResults = [AllClientList filteredArrayUsingPredicate:resultPredicate];
                SearchArr=[NSMutableArray arrayWithArray:searchResults];}

            [AllClientTableView reloadData];
           
          
            return isSearching;
        }
    }
    
    /*NSString *city=[[SearchTable cellForRowAtIndexPath:indexPath]textLabel].text;
     
     [SearchBut setTitle:city forState:UIControlStateNormal];
     NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"city contains[c] %@", city];
     NSArray*  searchResults = [SynogueList filteredArrayUsingPredicate:resultPredicate];
     SearchArr=[NSMutableArray arrayWithArray:searchResults];
     [tbl reloadData];
     textField.text = @"\u200B";
*/
    
    return NO;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==SearchTextField) {
        [SearchTextField resignFirstResponder];
    }
    return NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField;
{
  
        SearchArr=[NSMutableArray arrayWithArray:AllClientList];
   
    
    [AllClientTableView reloadData];
    
  
    //return isSearching;

    return YES;
}

@end
