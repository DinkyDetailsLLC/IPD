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
    NSMutableArray *AllTickets;
    NSMutableArray *numberOfSection;
    NSMutableArray *SearchArr;
    BOOL isSearching;
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
    
    TicketSearchTextField.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:18];
    
    if (ViewTag==0) {
        SectionViewColor=[UIColor whiteColor];
    }else if (ViewTag==1){
     SectionViewColor=[UIColor colorWithRed:245/255.0f green:132/255.0f blue:60/255.0f alpha:1];
    }else if (ViewTag==2){
     SectionViewColor=[UIColor colorWithRed:78/255.0f green:238/255.0f blue:191/255.0f alpha:1];
    }
    
    if ([AppDelegate sharedInstance].DeviceHieght==480) {
        TicketTableView.frame=CGRectMake(0, 107, 320, 373);
    }
  
    if (ViewTag==0) {
        AllTickets=[[DataBase getSharedInstance]receiveAllDataFromNewTicket];
        numberOfSection=[[NSMutableArray alloc]init];
        NSMutableArray *DetailArr=[[NSMutableArray alloc]init];
        NSMutableDictionary *detailDic=[[NSMutableDictionary alloc]init];
         NSString *CDate=@"";
        
//        AllTickets = [AllTickets sortedArrayUsingComparator:^NSComparisonResult(ClientInfo *a, ClientInfo *b) {
//            return [a.Comp_name compare:b.Comp_name]==NSOrderedAscending;
//            
//            // [time1 compare: time2] == NSOrderDescending
//        }];
        
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
            if (![CDate isEqualToString:client.Comp_name]) {
                detailDic=[[NSMutableDictionary alloc]init];
                DetailArr=[[NSMutableArray alloc]init];
                [detailDic setObject:client.Comp_name forKey:@"company"];
                [DetailArr addObject:dic];
                [detailDic setObject:DetailArr forKey:@"dateDetail"];
                [numberOfSection addObject:detailDic];
            }else{
                [DetailArr addObject:dic];
                [detailDic setObject:DetailArr forKey:@"dateDetail"];
                [numberOfSection removeLastObject];
                [numberOfSection addObject:detailDic];
            }
            
            CDate=client.Comp_name;
            
        }
    }else{
        int val=0;
        if (ViewTag==2){
            val=1;
        }
        ClientInfo *client=[[ClientInfo alloc]init];
        client.paidInFull=val;
        
        AllTickets=[[DataBase getSharedInstance]reciveAllOpenAndPaidTickets:client];
        numberOfSection=[[NSMutableArray alloc]init];
        NSMutableArray *DetailArr=[[NSMutableArray alloc]init];
        NSMutableDictionary *detailDic=[[NSMutableDictionary alloc]init];
          NSString *CDate=@"";
        
//        AllTickets = [AllTickets sortedArrayUsingComparator:^NSComparisonResult(ClientInfo *a, ClientInfo *b) {
//            return [a.Comp_name compare:b.Comp_name]==NSOrderedAscending;
//            
//            // [time1 compare: time2] == NSOrderDescending
//        }];
        
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
            if (![CDate isEqualToString:client.Comp_name]) {
                detailDic=[[NSMutableDictionary alloc]init];
                DetailArr=[[NSMutableArray alloc]init];
                [detailDic setObject:client.Comp_name forKey:@"company"];
                [DetailArr addObject:dic];
                [detailDic setObject:DetailArr forKey:@"dateDetail"];
                [numberOfSection addObject:detailDic];
            }else{
                [DetailArr addObject:dic];
                [detailDic setObject:DetailArr forKey:@"dateDetail"];
                [numberOfSection removeLastObject];
                [numberOfSection addObject:detailDic];
            }
            CDate=client.Comp_name;
            
        }
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
    if (isSearching) {
        return SearchArr.count;
    }
    
    return numberOfSection.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr=[[NSArray alloc]init];
    
    if (isSearching) {
          arr=[[NSArray alloc]initWithArray:[[SearchArr objectAtIndex:section]objectForKey:@"dateDetail"]];
        return arr.count;
    }
    
    if (numberOfSection.count>0) {
        arr=[[NSArray alloc]initWithArray:[[numberOfSection objectAtIndex:section]objectForKey:@"dateDetail"]];
    }
    return arr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TicketCell"];
    cell.InvoiceLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
    cell.InvoiceLab2.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:22];
    cell.PriseLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
    cell.DateLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
    if (ViewTag==0) {
        NSDictionary *dic;
        
        if (isSearching) {
             dic=[[[SearchArr objectAtIndex:indexPath.section]objectForKey:@"dateDetail"]objectAtIndex:indexPath.row];
        }else{
            dic=[[[numberOfSection objectAtIndex:indexPath.section]objectForKey:@"dateDetail"]objectAtIndex:indexPath.row];}
        
        cell.InvoiceLab.text=[dic objectForKey:@"companyName"];
        cell.DateLab.text=[dic objectForKey:@"date"];
        float rs=[[dic objectForKey:@"calculated"]floatValue];
        cell.PriseLab.text=[NSString stringWithFormat:@"$%.2f",rs];
        cell.InvoiceLab2.hidden=YES;
        
        if ([[dic objectForKey:@"paidInFull"]integerValue]==1) {
            
            [cell.CircleButton setImage:[UIImage imageNamed:@"green-dot.png"] forState:UIControlStateNormal];
            
        }
        
    }else{
        
        NSDictionary *dic;
        if (isSearching) {
            dic=[[[SearchArr objectAtIndex:indexPath.section]objectForKey:@"dateDetail"]objectAtIndex:indexPath.row];
        }else{
            dic=[[[numberOfSection objectAtIndex:indexPath.section]objectForKey:@"dateDetail"]objectAtIndex:indexPath.row];}

        cell.InvoiceLab.hidden=YES;
        cell.InvoiceLab2.text=[dic objectForKey:@"companyName"];
        cell.DateLab.text=[dic objectForKey:@"date"];
        float rs=[[dic objectForKey:@"calculated"]floatValue];
        cell.PriseLab.text=[NSString stringWithFormat:@"$%.2f",rs];
        cell.CircleButton.hidden=YES;
        
    }
    
    /*  NSDictionary *dic=[[[numberOfSection objectAtIndex:indexPath.section]objectForKey:@"dateDetail"]objectAtIndex:indexPath.row];
     cell.InvoiceLab.text=[dic objectForKey:@"companyName"];
     float rs=[[dic objectForKey:@"calculated"] floatValue];
     cell.PriseLab.text=[NSString stringWithFormat:@"$%.2f",rs];*/
    
    return cell;
}

#pragma mark - UITableView Delegates method

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
   HeaderLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    HeaderLab.textAlignment=NSTextAlignmentRight;
    HeaderLab.backgroundColor=SectionViewColor;
    HeaderLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:25];
       if (isSearching) {
          HeaderLab.text=[[SearchArr objectAtIndex:section]objectForKey:@"company"];
    }else{
        HeaderLab.text=[[numberOfSection objectAtIndex:section]objectForKey:@"company"];

    }
    return HeaderLab;
}


#pragma mark - UITextField delegate methods

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==TicketSearchTextField) {
        isSearching=YES;
        NSLog(@"%@",textField.text);
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==TicketSearchTextField) {
        isSearching=NO;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==TicketSearchTextField) {
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
                SearchArr=[NSMutableArray arrayWithArray:numberOfSection];
            }else{
                
                NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"company contains[c] %@", newString];
                NSArray*  searchResults = [numberOfSection filteredArrayUsingPredicate:resultPredicate];
                SearchArr=[NSMutableArray arrayWithArray:searchResults];}
            
            [TicketTableView reloadData];
            
            
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
    if (textField==TicketSearchTextField) {
        [TicketSearchTextField resignFirstResponder];
    }
    return NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField;
{
    
    SearchArr=[NSMutableArray arrayWithArray:numberOfSection];
    
    
    [TicketTableView reloadData];
    
    
    //return isSearching;
    
    return YES;
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
