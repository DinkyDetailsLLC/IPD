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
    NSMutableArray *AllTickets;
    NSMutableArray *numberOfSection;
    NSMutableArray *searchArr;
    BOOL isSearching;
}
@end

@implementation OpenPaidTicketsViewController
@synthesize OPTSearchTF;
@synthesize OPTTableView;
@synthesize OPTViewTag;
@synthesize OPTClientDtail;
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
    
    isSearching=NO;
    
    OPTSearchTF.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:18];
    
    if ([AppDelegate sharedInstance].DeviceHieght==480) {
        OPTTableView.frame=CGRectMake(0, 105, 320, 375);
    }
    AllTickets=[[NSMutableArray alloc]init];
    
    int val=0;
    
    if (OPTViewTag==2) {
        val=1;
    }
    ClientInfo *client=[[ClientInfo alloc]init];
    client.Comp_name=OPTClientDtail.Comp_name;
    client.paidInFull=val;
    AllTickets=[[DataBase getSharedInstance]RecieveSpecificClientsOpenAndPaidTickets:client];
    numberOfSection=[[NSMutableArray alloc]init];
    NSMutableArray *DetailArr=[[NSMutableArray alloc]init];
    NSMutableDictionary *detailDic=[[NSMutableDictionary alloc]init];
     NSString *CDate=@"";
    for (int i=0; i<AllTickets.count; i++) {
       
        ClientInfo *client=[AllTickets objectAtIndex:i];
       
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:client.date forKey:@"date"];
        [dic setObject:client.Comp_name forKey:@"companyName"];
        [dic setObject:client.startTime forKey:@"startTime"];
        [dic setObject:client.finishTime forKey:@"finishTime"];
        [dic setObject:client.phoneNo forKey:@"phoneNumber"];
        [dic setObject:client.Email forKey:@"email"];
        [dic setObject:client.imageBefore forKey:@"imageBefore"];
        [dic setObject:client.imageAfter forKey:@"imageAfter"];
        [dic setObject:client.snowFall forKey:@"snowFall"];
        [dic setObject:[NSString stringWithFormat:@"%d",client.hours] forKey:@"hours"];
        [dic setObject:[NSString stringWithFormat:@"%d",client.calculated] forKey:@"calculated"];
        [dic setObject:[NSString stringWithFormat:@"%d",client.trip] forKey:@"trip"];
        [dic setObject:[NSString stringWithFormat:@"%d",client.contract] forKey:@"contract"];
        [dic setObject:[NSString stringWithFormat:@"%d",client.seasonal] forKey:@"seasonal"];
        [dic setObject:[NSString stringWithFormat:@"%d",client.sendInVoice] forKey:@"sendInVoice"];
        [dic setObject:[NSString stringWithFormat:@"%d",client.paidInFull] forKey:@"paidInFull"];
        
        if (![CDate isEqualToString:client.date]) {
           detailDic=[[NSMutableDictionary alloc]init];
            DetailArr=[[NSMutableArray alloc]init];
            [detailDic setObject:client.date forKey:@"date"];
            [DetailArr addObject:dic];
              [detailDic setObject:DetailArr forKey:@"dateDetail"];
            [numberOfSection addObject:detailDic];
        }else{
          [DetailArr addObject:dic];
            [detailDic setObject:DetailArr forKey:@"dateDetail"];
            [numberOfSection removeLastObject];
            [numberOfSection addObject:detailDic];
        }
          CDate=client.date;
    }
    searchArr=[[NSMutableArray alloc]initWithArray:numberOfSection];
    
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
    if (isSearching) {
        return searchArr.count;
    }
    return numberOfSection.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr=[[NSArray alloc]init];
    
    if (isSearching) {
        arr=[[NSArray alloc]initWithArray:[[numberOfSection objectAtIndex:section]objectForKey:@"dateDetail"]];
        return arr.count;
    }
    
    if (numberOfSection.count>0) {
        arr=[[NSArray alloc]initWithArray:[[numberOfSection objectAtIndex:section]objectForKey:@"dateDetail"]];
    }
    return arr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OPTCell"];
    cell.InvoiceLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
    cell.PriseLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:18];
    if (OPTViewTag==2) {
        cell.OPTCircleImageView.image=[UIImage imageNamed:@"green-dot.png"];
    }
    
    NSDictionary *dic;
    
    if (isSearching) {
        dic=[[[searchArr objectAtIndex:indexPath.section]objectForKey:@"dateDetail"]objectAtIndex:indexPath.row];
    }else{
    dic=[[[numberOfSection objectAtIndex:indexPath.section]objectForKey:@"dateDetail"]objectAtIndex:indexPath.row];
    }
    
    cell.InvoiceLab.text=[dic objectForKey:@"companyName"];
    float rs=[[dic objectForKey:@"calculated"] floatValue];
    cell.PriseLab.text=[NSString stringWithFormat:@"$%.2f",rs];
    
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
    if (isSearching) {
         HeaderLab.text=[[searchArr objectAtIndex:section]objectForKey:@"date"];
    }else{
        HeaderLab.text=[[numberOfSection objectAtIndex:section]objectForKey:@"date"];}
    
    return HeaderLab;
}

#pragma mark - UITextField delegate methods

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==OPTSearchTF) {
        isSearching=YES;
        NSLog(@"%@",textField.text);
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==OPTSearchTF) {
        isSearching=NO;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==OPTSearchTF) {
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
                searchArr=[NSMutableArray arrayWithArray:numberOfSection];
            }else{
                
                NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"date contains[c] %@", newString];
                NSArray*  searchResults = [numberOfSection filteredArrayUsingPredicate:resultPredicate];
                searchArr=[NSMutableArray arrayWithArray:searchResults];}
            
            [OPTTableView reloadData];
            
            
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
    if (textField==OPTSearchTF) {
        [OPTSearchTF resignFirstResponder];
    }
    return NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField;
{
    
    searchArr=[NSMutableArray arrayWithArray:numberOfSection];
    
    
    [OPTTableView reloadData];
    
    
    //return isSearching;
    
    return YES;
}

@end
