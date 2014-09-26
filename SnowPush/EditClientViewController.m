//
//  EditClientViewController.m
//  SnowPush
//
//  Created by Dannis on 9/23/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import "EditClientViewController.h"

@interface EditClientViewController ()

@end

@implementation EditClientViewController
@synthesize CompNameTf,CityTf,ClientImageView,ContaractCost,AddressTf,SeasonalCost,StateTf,ZipTf,EmailTf,PhoneNoTf,TripCost;
@synthesize EditClientScrollView;
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

#pragma mark - saveImage method

- (void)saveImage:(UIImage *)image  WithCupInfo:(ClientInfo*)CoupInfo {
    //  Make file name first
    
    UIView *aView=[[UIView alloc]initWithFrame:CGRectMake(35,250, 250,60)];
    aView.backgroundColor=[UIColor darkGrayColor];
    aView.layer.cornerRadius=2;
    aView.layer.borderWidth=1;
    aView.layer.borderColor=[UIColor colorWithWhite:0.8 alpha:1].CGColor;
    aView.layer.masksToBounds=YES;
    //        indicatorView=[[UIView alloc]initWithFrame:CGRectMake(60, 250, 200, 100)];
    //    indicatorView.backgroundColor=[UIColor whiteColor];
    //    indicatorView.layer.cornerRadius=8;
    //    indicatorView.layer.masksToBounds=YES;
    //    [Parentview addSubview:indicatorView];
    
   
    
    ClientInfo *Info=[[ClientInfo alloc]init];
    
    
//    Info.C_ID=CoupInfo.C_ID;
//    Info.C_Date=CoupInfo.C_Date;
//    // Info.C_Image=CoupInfo.ID;
//    Info.C_Name=CoupInfo.C_Name;
//    Info.C_Text=CoupInfo.C_Text;
//    Info.To_Date=CoupInfo.To_Date;
//    Info.Total_Like=CoupInfo.Total_Like;
    
    
    
   NSString *imagen=@"1";
    BOOL check=[[DataBase getSharedInstance]SaveClientDetail:Info];
    if (check==NO) {
        NSString *filename = [imagen stringByAppendingString:@".png"]; // or .jpg
        
        //  Get the path of the app documents directory
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        //  Append the filename and get the full image path
        NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:filename];
        
        //  Now convert the image to PNG/JPEG and write it to the image path
        NSData *imageData = UIImagePNGRepresentation(image);
        [imageData writeToFile:savedImagePath atomically:NO];
        
        //  Here you save the savedImagePath to your DB
        
//        Info.C_Image=savedImagePath;
//        
//        
//        NSString *ShareFileName=[CoupInfo.C_ID stringByAppendingString:@"Share.png"];
//        
//        NSString *ShareSavedImagePath=[documentsDirectory stringByAppendingPathComponent:ShareFileName];
//        
//        NSData *ShareImageData=UIImagePNGRepresentation(CoupInfo.C_ShareImage);
//        
//        [ShareImageData writeToFile:ShareSavedImagePath atomically:NO];
//        
//        Info.C_sImageUrl=ShareSavedImagePath;
//        
//        BOOL suc=[[DataBase getSharedInstance]AddToFavoriteListData:Info];
        //        if (suc==YES) {
        //            //[aView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:5];
        //        }else{
        //        [aView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:5];
        //        }
        
    }
    [aView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:4];
    
}

#pragma mark - retrive Image method

- (UIImage *)loadImage:(NSString *)filePath  {
    return [UIImage imageWithContentsOfFile:filePath];
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

- (IBAction)EditClientSaveBtnClicked:(id)sender {
    
    ClientInfo *Clientdetail=[[ClientInfo alloc]init];
    Clientdetail.Comp_name=CompNameTf.text;
    Clientdetail.Address=AddressTf.text;
    Clientdetail.State=StateTf.text;
    Clientdetail.City=CityTf.text;
    Clientdetail.Zip=ZipTf.text;
    Clientdetail.Email=EmailTf.text;
    Clientdetail.phoneNo=PhoneNoTf.text;
    Clientdetail.Image=PhoneNoTf.text;
    Clientdetail.TripCost=TripCost.text;
    Clientdetail.ContractCost=ContaractCost.text;
    Clientdetail.SeasonalCost=SeasonalCost.text;
    BOOL yes=[[DataBase getSharedInstance]SaveClientDetail:Clientdetail];
    if (yes==YES) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Save client detail" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
}

#pragma mark - text field

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==TripCost) {
        EditClientScrollView.frame=CGRectMake(0,-70, EditClientScrollView.frame.size.width, EditClientScrollView.frame.size.height);
    }else if (textField==ContaractCost)
    {
     EditClientScrollView.frame=CGRectMake(0, -120, EditClientScrollView.frame.size.width, EditClientScrollView.frame.size.height);
    }
    else if(textField==SeasonalCost){
     EditClientScrollView.frame=CGRectMake(0, -170, EditClientScrollView.frame.size.width, EditClientScrollView.frame.size.height);
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==TripCost) {
        EditClientScrollView.frame=CGRectMake(0,48, EditClientScrollView.frame.size.width, EditClientScrollView.frame.size.height);
    }else if (textField==ContaractCost)
    {
        EditClientScrollView.frame=CGRectMake(0, 48, EditClientScrollView.frame.size.width, EditClientScrollView.frame.size.height);
    }
    else if(textField==SeasonalCost){
        EditClientScrollView.frame=CGRectMake(0, 48, EditClientScrollView.frame.size.width, EditClientScrollView.frame.size.height);
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==EmailTf) {
        [TripCost becomeFirstResponder];
    }else if (textField==TripCost)
    {
        [ContaractCost becomeFirstResponder];
        
    }
    else if(textField==ContaractCost){
        [SeasonalCost becomeFirstResponder];
        // EditClientScrollView.frame=CGRectMake(0, 48, EditClientScrollView.frame.size.width, EditClientScrollView.frame.size.height);
    }
    else{
        [textField resignFirstResponder];}
    
   

    return NO;
}

- (IBAction)EditClientBackbtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}
@end
