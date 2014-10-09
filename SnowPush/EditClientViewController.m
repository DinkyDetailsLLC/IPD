//
//  EditClientViewController.m
//  SnowPush
//
//  Created by Dannis on 9/23/14.
//  Copyright (c) 2014 Dannis. All rights reserved.
//

#import "EditClientViewController.h"

@interface EditClientViewController ()
{
    NSString *FileName;
    NSString *fileType;
    BOOL isimageSelected;
    UIImage *ClientImage;
    BOOL isSaltSelected;
    BOOL isShovelSelected;
    BOOL isPlowSelected;
    BOOL isRemovalSelected;
    BOOL isImageChanged;
}
@end
@implementation EditClientViewController
@synthesize CompNameTf,CityTf,ClientImageView,ContaractCost,AddressTf,SeasonalCost,StateTf,ZipTf,EmailTf,PhoneNoTf,TripCost;
@synthesize EditClientScrollView,imageLab;
@synthesize editTag;
@synthesize ClientInformation;
@synthesize saltBtn,shovelBtn,plowBtn,removalBtn;
@synthesize saltLab,shovelLab,plowLab,removalLab;
@synthesize imageEditor;
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
    self.imageEditor = [[DemoImageEditor alloc]init];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImageViewTapped)];
    [ClientImageView addGestureRecognizer:tap];
    [tap setNumberOfTapsRequired:1];
    
    UITapGestureRecognizer *editScrollViewTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(editScrollViewTapped)];
    [EditClientScrollView addGestureRecognizer:editScrollViewTap];
    
    
    if (editTag==1) {
     
        CompNameTf.text=ClientInformation.Comp_name;
        AddressTf.text=ClientInformation.Address;
        CityTf.text=ClientInformation.City;
        StateTf.text=ClientInformation.State;
        ZipTf.text=ClientInformation.Zip;
        PhoneNoTf.text=ClientInformation.phoneNo;
        EmailTf.text=ClientInformation.Email;
        TripCost.text=ClientInformation.TripCost;
        ContaractCost.text=ClientInformation.ContractCost;
        SeasonalCost.text=ClientInformation.SeasonalCost;
        
        ClientImageView.image=[self loadImage:ClientInformation.Image];
        ClientImage=[self loadImage:ClientInformation.Image];
        isimageSelected=YES;
        
        if (ClientInformation.salt==1) {
            isSaltSelected=YES;
            saltBtn.selected=YES;
             [saltBtn setImage:[UIImage imageNamed:@"green-dot.png"] forState:UIControlStateNormal];
        }
        
        if (ClientInformation.shovel==1) {
            shovelBtn.selected=YES;
            isShovelSelected=YES;
            [shovelBtn setImage:[UIImage imageNamed:@"green-dot.png"] forState:UIControlStateNormal];
        }
        
        if (ClientInformation.plow==1) {
            plowBtn.selected=YES;
            isPlowSelected=YES;
            [plowBtn setImage:[UIImage imageNamed:@"green-dot.png"] forState:UIControlStateNormal];
        }
        
        if (ClientInformation.removal==1) {
            removalBtn.selected=YES;
            isRemovalSelected=YES;
            [removalBtn setImage:[UIImage imageNamed:@"green-dot.png"] forState:UIControlStateNormal];
        }
        
    }
    CompNameTf.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
    AddressTf.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
    CityTf.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
    StateTf.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
    ZipTf.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
    PhoneNoTf.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
    EmailTf.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
    TripCost.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
    ContaractCost.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
    SeasonalCost.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:17];
    saltLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:20];
    shovelLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:20];
    plowLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:20];
    removalLab.font=[UIFont fontWithName:@"MYRIADPRO-COND" size:20];
    
    
    if ([AppDelegate sharedInstance].DeviceHieght==480) {
        EditClientScrollView.frame=CGRectMake(0, 50, 320, 430);
        CompNameTf.frame=CGRectMake(7, 5, 307, 33);
        AddressTf.frame=CGRectMake(7, 41, 307, 33);
        CityTf.frame=CGRectMake(7, 77, 148, 33);
        StateTf.frame=CGRectMake(159, 77, 70, 33);
        ZipTf.frame=CGRectMake(234, 77, 80, 33);
        PhoneNoTf.frame=CGRectMake(7, 113, 307, 33);
        EmailTf.frame=CGRectMake(7, 149, 307, 33);
        ClientImageView.frame=CGRectMake(7, 185, 307, 130);
        imageLab.frame=CGRectMake(12, 292, 42, 21);
        TripCost.frame=CGRectMake(7, 319, 148, 33);
        ContaractCost.frame=CGRectMake(7, 356, 148, 33);
        SeasonalCost.frame=CGRectMake(8, 393, 148, 33);
        
        saltLab.frame=CGRectMake(238, 320, 42, 20);
        saltBtn.frame=CGRectMake(285, 320, 20, 20);
        shovelLab.frame=CGRectMake(222, 348, 58, 20);
        shovelBtn.frame=CGRectMake(285, 348, 20, 20);
        plowLab.frame=CGRectMake(222, 376, 58, 20);
        plowBtn.frame=CGRectMake(285, 376, 20, 20);
        removalLab.frame=CGRectMake(203, 400, 77, 20);
        removalBtn.frame=CGRectMake(285, 400, 20, 20);
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - saveImage method

- (void)saveImage:(UIImage *)image  WithCupInfo:(ClientInfo*)Client {
    //  Make file name first
    
    if (editTag==1) {
        
        ClientInfo *Clientdetail=[[ClientInfo alloc]init];
        Clientdetail.Comp_name=CompNameTf.text;
        Clientdetail.Address=AddressTf.text;
        Clientdetail.State=StateTf.text;
        Clientdetail.City=CityTf.text;
        Clientdetail.Zip=ZipTf.text;
        Clientdetail.Email=EmailTf.text;
        Clientdetail.phoneNo=PhoneNoTf.text;
        
        Clientdetail.TripCost=TripCost.text;
        Clientdetail.ContractCost=ContaractCost.text;
        Clientdetail.SeasonalCost=SeasonalCost.text;
        if (isSaltSelected) {
            Clientdetail.salt=1;
        }else{
            Clientdetail.salt=0;
        }if (isShovelSelected) {
            Clientdetail.shovel=1;
        }else{
            Clientdetail.shovel=0;
        }if (isPlowSelected) {
            Clientdetail.plow=1;
        }else{
            Clientdetail.plow=0;
        }if (isRemovalSelected) {
            Clientdetail.removal=1;
        }else{
            Clientdetail.removal=0;
        }
        
        if (isImageChanged==YES) {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            // NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            
            NSString *filePath = ClientInformation.Image;
            NSError *error;
            BOOL success = [fileManager removeItemAtPath:filePath error:&error];
            if (success) {
                
            }
            NSString *imagen=Clientdetail.Comp_name;
            imagen=[[[[imagen stringByReplacingOccurrencesOfString:@" " withString:@""]stringByReplacingOccurrencesOfString:@"." withString:@""]stringByReplacingOccurrencesOfString:@"@" withString:@""]stringByReplacingOccurrencesOfString:@"_" withString:@""];
            NSString *filename = [imagen stringByAppendingString:@".png"]; // or .jpg
            
            //  Get the path of the app documents directory
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            //  Append the filename and get the full image path
            NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:filename];
            
            //  Now convert the image to PNG/JPEG and write it to the image path
            
         
            
            NSData *imageData = UIImagePNGRepresentation(image);
            
            NSData *imagepat=UIImagePNGRepresentation(ClientImage);
            
            [imageData writeToFile:savedImagePath atomically:NO];
            
            //  Here you save the savedImagePath to your DB
            
            Clientdetail.Image=savedImagePath;
        }else{
            Clientdetail.Image=ClientInformation.Image;
        }

        
        
        BOOL yes=[[DataBase getSharedInstance]updateClientDetail:Clientdetail whereCompName:ClientInformation.Comp_name];
        if (yes==YES) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"client detail updated successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            alert.tag=2;
            [alert show];
        }     

        
    }else{
    
    ClientInfo *Clientdetail=[[ClientInfo alloc]init];
    Clientdetail.Comp_name=CompNameTf.text;
    Clientdetail.Address=AddressTf.text;
    Clientdetail.State=StateTf.text;
    Clientdetail.City=CityTf.text;
    Clientdetail.Zip=ZipTf.text;
    Clientdetail.Email=EmailTf.text;
    Clientdetail.phoneNo=PhoneNoTf.text;
    
    Clientdetail.TripCost=TripCost.text;
    Clientdetail.ContractCost=ContaractCost.text;
    Clientdetail.SeasonalCost=SeasonalCost.text;
    if (isSaltSelected) {
        Clientdetail.salt=1;
    }else{
        Clientdetail.salt=0;
    }if (isShovelSelected) {
        Clientdetail.shovel=1;
    }else{
        Clientdetail.shovel=0;
    }if (isPlowSelected) {
        Clientdetail.plow=1;
    }else{
        Clientdetail.plow=0;
    }if (isRemovalSelected) {
        Clientdetail.removal=1;
    }else{
        Clientdetail.removal=0;
    }

   NSString *imagen=Clientdetail.Comp_name;
        
     imagen=[[[[imagen stringByReplacingOccurrencesOfString:@" " withString:@""]stringByReplacingOccurrencesOfString:@"." withString:@""]stringByReplacingOccurrencesOfString:@"@" withString:@""]stringByReplacingOccurrencesOfString:@"_" withString:@""];
        
          NSString *filename = [imagen stringByAppendingString:@".png"]; // or .jpg
        
        //  Get the path of the app documents directory
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        //  Append the filename and get the full image path
        NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:filename];
        
        NSUserDefaults *defalt= [NSUserDefaults standardUserDefaults];
        [defalt setInteger:[image imageOrientation] forKey:@"kImageOrientaion"];
   //
        
        //  Now convert the image to PNG/JPEG and write it to the image path
        
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        [imageData writeToFile:savedImagePath atomically:NO];
        
        //  Here you save the savedImagePath to your DB
        
       Clientdetail.Image=savedImagePath;
        BOOL yes=[[DataBase getSharedInstance]SaveClientDetail:Clientdetail];
        if (yes==YES) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Save client detail" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            alert.tag=1;
            [alert show];
        }     
    }
}

#pragma mark - retrive Image method

- (UIImage *)loadImage:(NSString *)filePath  {
//    UIImage *image=[[UIImage alloc]initWithContentsOfFile:filePath];
//     UIImage *convertedImage=[UIImage imageWithCIImage:image.CIImage scale:1.0 orientation:[image imageOrientation]];
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
    
    
    if (editTag==1) {
        if (![self CheckLength:CompNameTf.text]) {
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter Company Name" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }else if (![self CheckLength:AddressTf.text]){
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter Address" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }else if (![self CheckLength:CityTf.text]){
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter City" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }else if (![self CheckLength:StateTf.text]){
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter State" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }else if (![self CheckLength:ZipTf.text]){
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter Zip" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }else if (![self CheckLength:PhoneNoTf.text])
        {
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter Phone Number" delegate:self cancelButtonTitle:@"Ok"otherButtonTitles: nil];
            [Alert show];
        }else if (![self checkPhoneLength:PhoneNoTf.text])
        {
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter valid Phone Number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }else if (![self CheckLength:EmailTf.text]){
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter email" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }else if (![self CheckMail:EmailTf.text]){
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter valid email" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }else if (![self CheckLength:TripCost.text]){
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter trip cost" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }else if (![self CheckLength:ContaractCost.text]){
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter contract cost" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }else if (![self CheckLength:SeasonalCost.text]){
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter seasonal cost" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }else if (!isimageSelected){
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please select image" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }
        
        else{
            
            
            [self saveImage:ClientImage WithCupInfo:nil];
            
        }
    }else{
    
        if (![self CheckLength:CompNameTf.text]) {
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter Company Name" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }else if (![self CheckLength:AddressTf.text]){
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter Address" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }else if (![self CheckLength:CityTf.text]){
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter City" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }else if (![self CheckLength:StateTf.text]){
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter State" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }else if (![self CheckLength:ZipTf.text]){
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter Zip" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }else if (![self CheckLength:PhoneNoTf.text])
        {
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter Phone Number" delegate:self cancelButtonTitle:@"Ok"otherButtonTitles: nil];
            [Alert show];
        }else if (![self checkPhoneLength:PhoneNoTf.text])
        {
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter valid Phone Number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }else if (![self CheckLength:EmailTf.text]){
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter email" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }else if (![self CheckMail:EmailTf.text]){
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter valid email" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }else if (![self CheckLength:TripCost.text]){
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter trip cost" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }else if (![self CheckLength:ContaractCost.text]){
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter contract cost" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }else if (![self CheckLength:SeasonalCost.text]){
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter seasonal cost" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }
        else if (!isimageSelected){
            UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please select image" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [Alert show];
        }
        else{
    
            [self saveImage:ClientImage WithCupInfo:nil];

        }
    
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
    
    if ([AppDelegate sharedInstance].DeviceHieght==480) {
        if (textField==TripCost) {
            EditClientScrollView.frame=CGRectMake(0,-100, EditClientScrollView.frame.size.width, EditClientScrollView.frame.size.height);
        }else if (textField==ContaractCost)
        {
            EditClientScrollView.frame=CGRectMake(0, -150, EditClientScrollView.frame.size.width, EditClientScrollView.frame.size.height);
        }
        else if(textField==SeasonalCost){
            EditClientScrollView.frame=CGRectMake(0, -170, EditClientScrollView.frame.size.width, EditClientScrollView.frame.size.height);
        }
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
    
    if ([AppDelegate sharedInstance].DeviceHieght==480) {
         EditClientScrollView.frame=CGRectMake(0,50,320, 430);
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==CompNameTf) {
        [AddressTf becomeFirstResponder];
    }else if (textField==AddressTf){
        [CityTf becomeFirstResponder];
    }else if (textField==CityTf){
        [StateTf becomeFirstResponder];
    }else if (textField==StateTf){
        [ZipTf becomeFirstResponder];
    }else if (textField==ZipTf){
        [PhoneNoTf becomeFirstResponder];
    }else if(textField==PhoneNoTf){
        [EmailTf becomeFirstResponder];
    }else if (textField==EmailTf) {
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
        [textField resignFirstResponder];
    
    }
    
    return NO;
}

- (IBAction)EditClientBackbtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}
//green-dot.png
- (IBAction)SaltSelected:(id)sender {
    
    UIButton *but=(UIButton*)sender;
    if ([but isSelected]==NO) {
        but.selected=YES;
        isSaltSelected=YES;
        [but setImage:[UIImage imageNamed:@"green-dot.png"] forState:UIControlStateNormal];
    }else{
     [but setImage:[UIImage imageNamed:@"grey-dot.png"] forState:UIControlStateNormal];
        isSaltSelected=NO;
        but.selected=NO;
    }
    
}

- (IBAction)shovelSelected:(id)sender {
    UIButton *but=(UIButton*)sender;
    if ([but isSelected]==NO) {
        but.selected=YES;
        isShovelSelected=YES;
        [but setImage:[UIImage imageNamed:@"green-dot.png"] forState:UIControlStateNormal];
    }else{
        [but setImage:[UIImage imageNamed:@"grey-dot.png"] forState:UIControlStateNormal];
        isShovelSelected=NO;
        but.selected=NO;
    }
}

- (IBAction)plowSelected:(id)sender {
    UIButton *but=(UIButton*)sender;
    if ([but isSelected]==NO) {
        but.selected=YES;
        isPlowSelected=YES;
        [but setImage:[UIImage imageNamed:@"green-dot.png"] forState:UIControlStateNormal];
    }else{
        [but setImage:[UIImage imageNamed:@"grey-dot.png"] forState:UIControlStateNormal];
        isPlowSelected=NO;
        but.selected=NO;
    }
}

- (IBAction)removalSelected:(id)sender {
    UIButton *but=(UIButton*)sender;
    if ([but isSelected]==NO) {
        but.selected=YES;
        isRemovalSelected=YES;
        [but setImage:[UIImage imageNamed:@"green-dot.png"] forState:UIControlStateNormal];
    }else{
        [but setImage:[UIImage imageNamed:@"grey-dot.png"] forState:UIControlStateNormal];
        isRemovalSelected=NO;
        but.selected=NO;
    }
}


#pragma mark - checking methods
-(BOOL)CheckLength:(NSString*)sender
{
    if ([sender length]==0) {
        return NO;
    }
    return YES;
}

-(BOOL)CheckMail:(NSString*)sender
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailValidation = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if (![emailValidation evaluateWithObject:sender]) {
        return NO;
    }
    return YES;
}

-(BOOL)checkPhoneLength:(NSString*)sender
{
    if ([sender length]>10 || [sender length]<10) {
        return NO;
    }
    return YES;
}
//
//-(BOOL)pwd1:(NSString*)sender
//{
//    if ([PwdTf.text length]==0) {
//        return NO;
//    }
//    
//    return YES;
//}
//
//-(BOOL)Pwd2:(NSString*)sender
//{
//    if ([PwdTf.text length]<6) {
//        return NO;
//    }
//    return YES;
//}

#pragma mark - image view tapped

-(void)ImageViewTapped
{
    if (EmailTf) {
        [EmailTf resignFirstResponder];
    }
    
    if (TripCost) {
        [TripCost resignFirstResponder];
    }
    
    if (SeasonalCost) {
        [SeasonalCost resignFirstResponder];
    }
    
    if (ContaractCost) {
        [ContaractCost resignFirstResponder];
    }
    
    if(CompNameTf){
        [CompNameTf resignFirstResponder];
        
    }
    
    if(AddressTf){
        [AddressTf resignFirstResponder];
    }
    
    if(StateTf){
        [StateTf resignFirstResponder];
    }
    
    if(CityTf){
        [CityTf resignFirstResponder];
    }
    
    if(ZipTf){
        [ZipTf resignFirstResponder];
    }
    
    if(PhoneNoTf){
        [PhoneNoTf resignFirstResponder];
    }
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Option" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Open Gallery", @"Open Camera", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault; [actionSheet showInView:self.view];
    actionSheet.backgroundColor=[UIColor clearColor];
    NSLog(@"action sheet opende");
    
}

#pragma mark - action delegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0)
    {
        
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        
        picker.delegate=self;
        
        //        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        //
        //        {
        //
        //            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //
        //        }
        //        else
        //
        //        {
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        //   }
        
        [self presentViewController:picker animated:YES completion:nil];
        
        
    }
    
    else if (buttonIndex==1)
    {
        
        NSString *model = [[UIDevice currentDevice] model];
        if ([model isEqualToString:@"iPhone Simulator"] || [model isEqualToString:@"iPad Simulator"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!!!" message:@"No Camera found!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            
            [self presentViewController:picker animated:YES completion:nil];
            
            picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        }
        
        
        
        
    }
    
    
    
}


#pragma mark -image picker delegate method

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (editTag==1) {
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        ClientImageView.image=image;
        ClientImage=[info objectForKey:UIImagePickerControllerOriginalImage];
        imageLab.text=@"";
        isimageSelected=YES;
        isImageChanged=YES;
        //    imageViewForProfile.layer.borderWidth = 1.0f;
        //    imageViewForProfile.layer.borderColor = [UIColor lightGrayColor].CGColor;
        //    imageViewForProfile.layer.masksToBounds = YES;
        [self dismissViewControllerAnimated:YES completion:^{
        }];
        self.imageEditor.doneCallback = ^(UIImage *editedImage, BOOL canceled){
            if(!canceled) {
                self.ClientImageView.image=editedImage;
                ClientImage=editedImage;
                
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        };
        self.imageEditor.sourceImage = image;
        self.imageEditor.previewImage = image;
        [self.imageEditor reset:NO];
        [self.navigationController pushViewController:self.imageEditor animated:YES];
        [self.navigationController setNavigationBarHidden:YES animated:NO];

    }else{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    ClientImageView.image=image;
    ClientImage=image;
    imageLab.text=@"";
    isimageSelected=YES;
//    imageViewForProfile.layer.borderWidth = 1.0f;
//    imageViewForProfile.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    imageViewForProfile.layer.masksToBounds = YES;
    [self dismissViewControllerAnimated:YES completion:^{
    }];
        self.imageEditor.doneCallback = ^(UIImage *editedImage, BOOL canceled){
            if(!canceled) {
                self.ClientImageView.image=editedImage;
                ClientImage=editedImage;
                
            }
            [self.navigationController popViewControllerAnimated:YES];

        };
        self.imageEditor.sourceImage = image;
        self.imageEditor.previewImage = image;
        [self.imageEditor reset:NO];
        [self.navigationController pushViewController:self.imageEditor animated:YES];
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
 }

-(void)editScrollViewTapped
{
    if (TripCost) {
        [TripCost resignFirstResponder];
    }
    
    if (SeasonalCost) {
        [SeasonalCost resignFirstResponder];
    }
    
    if (ContaractCost) {
        [ContaractCost resignFirstResponder];
    }
}

#pragma mark - alert view delegates

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[alertView buttonTitleAtIndex:buttonIndex]isEqualToString:@"OK"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
