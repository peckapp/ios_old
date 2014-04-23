//
//  Registration.m
//  PeckApp
//
//  Created by STPLINC. on 5/21/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "Registration.h"
#import "Webservices.h"

@implementation Registration

@synthesize Username;
@synthesize Emailid;
@synthesize Password;
@synthesize Backgroundscroller;
@synthesize registration_req,activation_code_req;
@synthesize dict;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)viewWillAppear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addloader:) name:@"AddLoader" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(facebookLoginServerRequest:) name:@"FacebookUserDetails" object:nil];
    singleTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGesture:)];
    [self.Backgroundscroller addGestureRecognizer:singleTap];
    
    self.HeaderTitle.font = [UIFont boldSystemFontOfSize:self.HeaderTitle.font.pointSize];
    
    
}
-(void)facebookLoginServerRequest:(NSNotification *)notification
{
    NSDictionary* infoDict = [notification userInfo];
    NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]initWithDictionary:infoDict];
    [self facebookDataPost:dictionary];
    
}

-(void) addloader:(NSNotification *)notification
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel addLoaderForViewController:self];
}

#pragma mark-
#pragma mark server request methods
-(void)facebookDataPost:(NSMutableDictionary *)dictionary
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    facebookdata_post=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:facebook_data_post]];
    [facebookdata_post setPostValue:[dictionary JSONRepresentation] forKey:@"FacebookData"];
    [facebookdata_post setPostValue:appDel.fid forKey:@"fid"];
    DLog(@"[dict JSONRepresentation]=%@",[dictionary JSONRepresentation]);
    DLog(@"fid=%@",appDel.fid);
    [facebookdata_post setDelegate:self];
    [facebookdata_post startAsynchronous];
    
    
}



- (IBAction)singleTapGesture:(UITextField *) textField{
    
    
    if ([Username.text isEqual:@""])
    {
        self.Username.placeholder=@"Name";
        
        
    }
    if ([Password.text isEqual:@""])
    {
        self.Password.placeholder=@"Password";
        
    }
    
    
    if ([Emailid.text isEqual:@""])
    {
        self.Emailid.placeholder=@"Williams Email";
        
        
    }
    if ([self.Twittername.text isEqual:@""])
    {
        self.Twittername.placeholder=@"Twitter Handle";
        
        
    }
    
    if ([self.PhoneNo.text isEqual:@""])
    {
        self.PhoneNo.placeholder=@"Phone No";
        
        
    }
    
    
    
    [self.Username resignFirstResponder];
    [self.Emailid resignFirstResponder];
    [self.Twittername resignFirstResponder];
    [self.PhoneNo resignFirstResponder];
    [self.Comments resignFirstResponder];
    [self.Password resignFirstResponder];
    // self.Backgroundscroller.contentOffset=CGPointMake(0, 0);
    
    
}




-(IBAction)closeRegistration:(id)sender{
    
    [self.Backgroundscroller removeGestureRecognizer:singleTap];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationBar.hidden=YES;
    self.Backgroundscroller.delegate=self;
    self.Backgroundscroller.contentSize=CGSizeMake(0, 860);
    for (UIView *view in [self.Backgroundscroller subviews])
    {
        if([view  isKindOfClass:[UITextField class]])
        {
            UITextField *textField = (UITextField *)view;
            [textField setValue:[UIColor colorWithRed:(204.0/255.0) green:(195.0/255.0) blue:(219.0/255.0) alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
            UILabel *label1 =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 10)];
            label1.backgroundColor = [UIColor clearColor];
            textField.leftView=label1;
            textField.leftViewMode=UITextFieldViewModeAlways;
            
        }
        
        
        
    }
    
    //    UILabel *label1 =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 12, 10)];
    //    label1.backgroundColor = [UIColor clearColor];
    //    self.Username.leftView=label1;
    //    self.Username.leftViewMode=UITextFieldViewModeAlways;
    //    self.Username.delegate=self;
    //
    //    UILabel *label2 =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 12, 10)];
    //    label2.backgroundColor = [UIColor clearColor];
    //    self.Password.leftView=label2;
    //    self.Password.leftViewMode=UITextFieldViewModeAlways;
    //    self.Password.delegate=self;
    //
    //
    //    UILabel *label3 =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 12, 10)];
    //    label3.backgroundColor = [UIColor clearColor];
    //    self.Emailid.leftView=label3;
    //    self.Emailid.leftViewMode=UITextFieldViewModeAlways;
    //    self.Emailid.delegate=self;
    //
    //    UILabel *label4 =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 12, 10)];
    //    label4.backgroundColor = [UIColor clearColor];
    //    self.Twittername.leftView=label4;
    //    self.Twittername.leftViewMode=UITextFieldViewModeAlways;
    //    self.Twittername.delegate=self;
    //
    //    UILabel *label5 =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 12, 10)];
    //    label5.backgroundColor = [UIColor clearColor];
    //    self.PhoneNo.leftView=label5;
    //    self.PhoneNo.leftViewMode=UITextFieldViewModeAlways;
    //    self.PhoneNo.delegate=self;
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark TextView Delegate


-(void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.backgroundColor=[UIColor colorWithRed:(182.0/255.0) green:(160.0/255.0) blue:(215.0/255.0) alpha:1.0];
    if ([textView.text isEqual:@"    Blurb (140 Char. Max)"])
    {
        textView.text=@"     ";
    }
    
    
    textView.textColor=[UIColor whiteColor];
    self.Backgroundscroller.contentOffset=CGPointMake(0, 380);
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    textView.backgroundColor=[UIColor colorWithRed:(161.0/255.0) green:(143.0/255.0) blue:(189.0/255.0) alpha:1.0];
    
    DLog(@"length=%d",self.Comments.text.length);
    if (self.Comments.text.length<=5)
    {
        self.Comments.text=@"    Blurb (140 Char. Max)";
        self.Comments.textColor = [UIColor colorWithRed:(204.0/255.0) green:(195.0/255.0) blue:(219.0/255.0) alpha:1.0];
        
        
    }
    
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if (textView.text.length<=4)
    {
        
        textView.text=@"     ";
        
        
    }
    
    
    
    if ([text isEqualToString:@"\n"])
    {
        
        // [self.Password becomeFirstResponder];
        //        if (self.Comments.text.length==0)
        //        {
        //            self.Comments.text=@"       Blurb (140 Char. Max)";
        //            self.Comments.textColor = [UIColor lightGrayColor];
        //
        //
        //
        //        }
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
}


#pragma mark TextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.Username isFirstResponder])
    {
        
        if ([self.Username.text isEqual:@""])
        {
            self.Username.placeholder=@"Name";
            
            
        }
        
        [self.Emailid becomeFirstResponder];
        
        
        
    }
    else if ([self.Emailid isFirstResponder])
    {
        
        if ([Emailid.text isEqual:@""])
        {
            self.Emailid.placeholder=@"Williams Email";
            
            
        }
        [self.Password becomeFirstResponder];
    }
    
    else if ([self.Password isFirstResponder])
    {
        
        if ([Password.text isEqual:@""])
        {
            self.Password.placeholder=@"Password";
            
            
        }
        [self.Twittername becomeFirstResponder];
    }
    
    
    else if ([self.Twittername isFirstResponder])
    {
        if ([self.Twittername.text isEqual:@""])
        {
            self.Twittername.placeholder=@"Twitter Handle";
            
            
        }
        
        [self.PhoneNo becomeFirstResponder];
    }
    else if ([self.PhoneNo isFirstResponder])
    {
        
        if ([self.PhoneNo.text isEqual:@""])
        {
            self.PhoneNo.placeholder=@"Phone No";
            
            
            
        }
        
        
    }
    
    
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.backgroundColor=[UIColor colorWithRed:(182.0/255.0) green:(160.0/255.0) blue:(215.0/255.0) alpha:1.0];
    
    
    if (textField==self.Username) {
        Username.placeholder=@"";
        
        
        
        self.Backgroundscroller.contentOffset=CGPointMake(0, 170);
    }
    if (textField==self.Emailid) {
        
        Emailid.placeholder=@"";
        
        self.Backgroundscroller.contentOffset=CGPointMake(0, 170);
    }
    if (textField==self.Password) {
        self.Password.placeholder=@"";
        self.Backgroundscroller.contentOffset=CGPointMake(0, 230);
    }
    
    if (textField==self.Twittername) {
        self.Twittername.placeholder=@"";
        self.Backgroundscroller.contentOffset=CGPointMake(0, 310);
        self.Backgroundscroller.contentSize=CGSizeMake(0, 900);
    }
    if (textField==self.PhoneNo) {
        self.PhoneNo.placeholder=@"";
        self.Backgroundscroller.contentOffset=CGPointMake(0, 370);
        
    }
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.backgroundColor=[UIColor colorWithRed:(161.0/255.0) green:(143.0/255.0) blue:(189.0/255.0) alpha:1.0];
    
    if ([Username.text isEqual:@""])
    {
        self.Username.placeholder=@"Name";
        
    }
    if ([Password.text isEqual:@""])
    {
        self.Password.placeholder=@"Password";
        
    }
    
    
    if ([Emailid.text isEqual:@""])
    {
        self.Emailid.placeholder=@"Williams Email";
        
        
    }
    if ([self.Twittername.text isEqual:@""])
    {
        self.Twittername.placeholder=@"Twitter Handle";
        
        
    }
    
    if ([self.PhoneNo.text isEqual:@""])
    {
        self.PhoneNo.placeholder=@"Phone No";
        
        
    }
    
    
    [self.Username resignFirstResponder];
    [self.Emailid resignFirstResponder];
    [self.Twittername resignFirstResponder];
    [self.PhoneNo resignFirstResponder];
    [self.Password resignFirstResponder];
    
    
}


#pragma mark-
#pragma mark facebook login methods
-(IBAction)facebookLoginButtonClick:(id)sender
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    // [appDel addLoaderForViewController:self];
    [FBSession.activeSession closeAndClearTokenInformation];
    
    // [appDel setSocialType:@"facebook"];
    if (appDel.session.state != FBSessionStateCreated) {
        appDel.session = [[FBSession alloc] init];
    }
    if (FBSession.activeSession.isOpen) {
        
        [appDel populateUserDetails];
        
    }
    else
    {
        [appDel openSession];
    }
}




-(IBAction) registration
{
    
    [self.Username resignFirstResponder];
    [self.Emailid resignFirstResponder];
    [self.Password resignFirstResponder];
    self.Backgroundscroller.contentOffset=CGPointMake(0, 0);
    
    
    //  NSString *url=[[NSString stringWithFormat:@"%@",login_registration_req] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel addLoaderForViewController:self];
    registration_req =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString: registration_request]] ;
    
    // auto_login_req =  [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:@"http:www.ihealthu.com/program-challenge-mobile-app/services/getAllUserData?member_id=50073"]];
    [registration_req setDelegate:self];
    [registration_req setPostValue:self.Username.text forKey:@"username"];
    [registration_req setPostValue:self.Emailid.text forKey:@"emailid"];
    [registration_req setPostValue:self.Twittername.text forKey:@"tname"];
    [registration_req setPostValue:self.PhoneNo.text forKey:@"phoneno"];
    [registration_req setPostValue:self.Comments.text forKey:@"comments"];
    [registration_req setPostValue:self.Password.text forKey:@"password"];
    [registration_req startAsynchronous];
    
    
}



-(void)requestFinished:(ASIHTTPRequest *)request
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel removeLoader];
    
    if (request==registration_req)
    {
        
        NSString *response  =  [request responseString];
        DLog(@"response=%@",response);
        
        dict =   [response JSONValue];
        DLog(@"dict=%@",dict);
        
        NSString *status=[dict valueForKey:@"status"];
        DLog(@"status=%@",status);
        
        if ([status isEqualToString:@"e"]) {
            
            
            [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            
            if ([[dict valueForKey:@"alert"] isEqual:@"name"])
            {
                self.Username.backgroundColor=[UIColor colorWithRed:(54.0/255.0) green:(54.0/255.0) blue:(54.0/255.0) alpha:1.0];
            }
            
            if ([[dict valueForKey:@"alert"] isEqual:@"email"])
            {
                self.Emailid.backgroundColor=[UIColor colorWithRed:(54.0/255.0) green:(54.0/255.0) blue:(54.0/255.0) alpha:1.0];
            }
            if ([[dict valueForKey:@"alert"] isEqual:@"password"])
            {
                self.Password.backgroundColor=[UIColor colorWithRed:(54.0/255.0) green:(54.0/255.0) blue:(54.0/255.0) alpha:1.0];
            }
            if ([[dict valueForKey:@"alert"] isEqual:@"twitter"])
            {
                self.Twittername.backgroundColor=[UIColor colorWithRed:(54.0/255.0) green:(54.0/255.0) blue:(54.0/255.0) alpha:1.0];
            }
            if ([[dict valueForKey:@"alert"] isEqual:@"phone"])
            {
                self.PhoneNo.backgroundColor=[UIColor colorWithRed:(54.0/255.0) green:(54.0/255.0) blue:(54.0/255.0) alpha:1.0];
            }
            if ([[dict valueForKey:@"alert"] isEqual:@"blurb"])
            {
                self.Comments.backgroundColor=[UIColor colorWithRed:(54.0/255.0) green:(54.0/255.0) blue:(54.0/255.0) alpha:1.0];
            }
            
            
            // auto_login_req =  [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:@"http:www.ihealthu.com/program-challenge-mobile-app/services/getAllUserData?member_id=50073"]];
            
        }
        
        else if ([status isEqualToString:@"u"])
        {
            [self alertforVerificationCode];
            
            
        }
        else if ([status isEqualToString:@"s"])
        {
            
            AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
            appDel.userid=[dict valueForKey:@"userid"];
            
            [self homescreen];
        }
        
        else if (dict==nil)
        {
            
            [[[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            
        }
        
        
        
    }
    
    
    
    if (request==activation_code_req)
    {
        NSString *response  =  [request responseString];
        DLog(@"response=%@",response);
        NSMutableDictionary *dict1=[response JSONValue];
        NSString *status=[dict1 valueForKey:@"status"];
        if ([status isEqualToString:@"e"])
        {
            UIAlertView  *VerificationcodeAlerterror=  [[UIAlertView alloc]initWithTitle:alertTitle message:[dict1 valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            VerificationcodeAlerterror.tag=3;
            VerificationcodeAlerterror.delegate=self;
            [VerificationcodeAlerterror show];
            
        }
        
        else if  ([status isEqualToString:@"s"])
        {
            [self homescreen];
            
            
        }
        
        else if (dict==nil)
        {
            
            [[[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            
        }
    }
    
    
    if (request==facebookdata_post)
    {
        
        NSString *response  =  [request responseString];
        DLog(@"response=%@",response);
        dict=[response JSONValue];
        NSString *status=[dict valueForKey:@"status"];
        if ([status isEqualToString:@"e"])
        {
            [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            
        }
        
        else if  ([status isEqualToString:@"f"])
        {
            
            [self alertforEmailidPassword];
            
        }
        
        else if  ([status isEqualToString:@"u"])
        {
            [self alertforVerificationCode];
            
        }
        else if  ([status isEqualToString:@"r"])
        {
            [self alertforEmailidPasswordForFacebook];
            
        }
        
        else if  ([status isEqualToString:@"s"])
        {
            AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
            appDel.userid=[dict valueForKey:@"userid"];
            [self homescreen];
            
        }
        
        else if (dict==nil)
        {
            
            [[[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            
        }
    }
    
    if (request==facebook_email_password_post)
    {
        NSString *response  =  [request responseString];
        DLog(@"response=%@",response);
        dict=[response JSONValue];
        NSString *status=[dict valueForKey:@"status"];
        if ([status isEqualToString:@"e"])
        {
            UIAlertView  *EmailPasswordAlerterror=  [[UIAlertView alloc]initWithTitle:alertTitle message:[dict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            EmailPasswordAlerterror.tag=4;
            EmailPasswordAlerterror.delegate=self;
            [EmailPasswordAlerterror show];
        }
        
        else if ([status isEqualToString:@"u"])
        {
            
            [self alertforVerificationCode];
            
            
        }
        
        else if (dict==nil)
        {
            
            [[[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            
        }
    }
    
    if (request==login_req_facebook)
    {
        NSString *response  =  [request responseString];
        DLog(@"response=%@",response);
        
        dict =   [response JSONValue];
        DLog(@"dict=%@",dict);
        
        NSString *status=[dict valueForKey:@"status"];
        DLog(@"status=%@",status);
        
        
        if ([status isEqualToString:@"s"])
        {
            
            AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
            appDel.userid=[dict valueForKey:@"userid"];
            [self homescreen];
        }
        
        else  if ([status isEqualToString:@"e"])
        {
            
            UIAlertView  *EmailPasswordAlerterror=  [[UIAlertView alloc]initWithTitle:alertTitle message:[dict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            EmailPasswordAlerterror.tag=6;
            EmailPasswordAlerterror.delegate=self;
            [EmailPasswordAlerterror show];
            
        }
        
        else if (dict==nil)
        {
            
            [[[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            
        }
        
    }
    
    
    
}
-(void) alertforEmailidPasswordForFacebook
{
    [[NSNotificationCenter defaultCenter] removeObserver:nil name:@"AddLoader" object:nil];
    
       
    UIAlertView  *EmailAlert = [[UIAlertView alloc] initWithTitle:@"Please enter your Williams Email id and password."
                        message:@""
                    delegate:self
                    cancelButtonTitle:@"Ok"
                    otherButtonTitles:@"Cancel", nil];
    
    EmailAlert.tag=5;
    EmailAlert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [EmailAlert textFieldAtIndex:0].placeholder=@"Williams Email";
    [EmailAlert textFieldAtIndex:1].placeholder=@"Password";
    
    [EmailAlert show];
    
    
}
-(void) homescreen
{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.enterscreen=TRUE;
    
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"myhorizonselect"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"athleticsselect"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"campuseventselect"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"afterhoursselect"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"activityselect"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"diningselect"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"circlesselect"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"settingsselect"];
    
    appDel.userid=[dict valueForKey:@"userid"];
    DLog(@"userid=%@",appDel.userid);
    [[NSUserDefaults standardUserDefaults] setValue:appDel.userid forKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    MyHorizon *myhorizon=[[MyHorizon alloc] init];
    
    HomeScreen *homescreen=[[HomeScreen alloc] init];
    // homescreen = [[HomeScreen alloc] initWithNibName:@"HomeScreen" bundle:nil];
    //  DLog(@"session=%@", self.fbSession);
    
    // appDel.navController=[[UINavigationController alloc]initWithNibName:@"HomeScreen" bundle:nil];
    
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:[[self navigationController] viewControllers]];
    //   [viewControllers removeAllObjects];
    [viewControllers addObjectsFromArray:[NSArray arrayWithObjects:homescreen,myhorizon, nil]];
    
    [self.navigationController setViewControllers:viewControllers animated:YES];
    self.Username.text=@"";
    self.Emailid.text=@"";
    self.Password.text=@"";
    
}

-(void) alertforVerificationCode
{
    
    UIAlertView  *EmailAlert = [[UIAlertView alloc] initWithTitle:@"Please Check your email id for code."message:@""delegate:self cancelButtonTitle:@"Ok"
                                                otherButtonTitles:@"Cancel", nil];
    EmailAlert.tag=1;
    EmailAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [EmailAlert textFieldAtIndex:0].placeholder=@"Enter Code";
    // NSString *userid=  [dict valueForKey:@"userid"];
    // DLog(@"userid=%@",userid);
   

    [EmailAlert show];
    
    
}

-(void) alertforEmailidPassword
{
    
    UIAlertView  *EmailAlert = [[UIAlertView alloc] initWithTitle:@"Please enter your Williams Email id and Desired password." message:@"" delegate:self
                                                cancelButtonTitle:@"Ok"
                                                otherButtonTitles:@"Cancel", nil];
    EmailAlert.tag=2;
    EmailAlert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [EmailAlert textFieldAtIndex:0].placeholder=@"Williams Email";
    [EmailAlert textFieldAtIndex:1].placeholder=@"Password";

    [EmailAlert show];
    
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(alertView.tag==1)
    {
        if (buttonIndex==0)
        {
            DLog(@"userid=%@",[dict valueForKey:@"userid"]);
    //DLog(@"code=%@",CodeTextField.text);
            AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
            [appDel addLoaderForViewController:self];
            appDel.userid=[dict valueForKey:@"userid"];
            activation_code_req =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:validate_activation_code_req]] ;
            [activation_code_req  setDelegate:self];
            [activation_code_req  setPostValue:[dict valueForKey:@"userid"] forKey:@"user_id"];
            [activation_code_req  setPostValue:[alertView textFieldAtIndex:0].text forKey:@"login_code"];
            [activation_code_req  startAsynchronous];
            
        }
    }
    
    if(alertView.tag==2)
    {
        if (buttonIndex==0)
        {
            DLog(@"userid=%@",[dict valueForKey:@"userid"]);
           // DLog(@"Emailid=%@",EmailidField.text);
           // DLog(@"password=%@",PasswordField.text);
            AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
            [appDel addLoaderForViewController:self];
            
            facebook_email_password_post =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:facebook_emailpassword_post]] ;
            [facebook_email_password_post  setDelegate:self];
            [facebook_email_password_post setPostValue:[dict valueForKey:@"userid"] forKey:@"userid"];
            [facebook_email_password_post setPostValue:[alertView textFieldAtIndex:0].text forKey:@"emailid"];
            [facebook_email_password_post setPostValue:[alertView textFieldAtIndex:1].text forKey:@"password"];
            [facebook_email_password_post  startAsynchronous];
            
        }
        
    }
    
    
    if(alertView.tag==3)
    {
        
        [self alertforVerificationCode];
        
    }
    
    if(alertView.tag==4)
    {
        
        // [self alertforEmailidPassword];
        UIAlertView  *EmailAlert = [[UIAlertView alloc] initWithTitle:@"Please enter your Williams Email id and Desired password." message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        
        EmailAlert.tag=2;
        EmailAlert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        [EmailAlert textFieldAtIndex:0].placeholder=@"Williams Email";
        [EmailAlert textFieldAtIndex:1].placeholder=@"Password";
        //[EmailAlert textFieldAtIndex:0].text=EmailidField.text;
       // [EmailAlert textFieldAtIndex:1].text=PasswordField.text;
        
        [EmailAlert show];
    }
    
    if (alertView.tag==5)
    {
        if (buttonIndex==0)
        {
            DLog(@"userid=%@",[dict valueForKey:@"userid"]);
           // DLog(@"Emailid=%@",EmailidField.text);
           // DLog(@"password=%@",PasswordField.text);
            AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
            [appDel addLoaderForViewController:self];
            login_req_facebook =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString: login_request]] ;
            [login_req_facebook setPostValue:[alertView textFieldAtIndex:0].text forKey:@"emailid"];
            [login_req_facebook setPostValue:[alertView textFieldAtIndex:1].text forKey:@"password"];
            DLog(@"dt=%@",appDel.devicetoken);
            [login_req_facebook setPostValue:appDel.devicetoken forKey:@"device_token"];
            [login_req_facebook setDelegate:self];
            [login_req_facebook startAsynchronous];
        }
        
    }
    
    if(alertView.tag==6)
    {
        
        // [self alertforEmailidPassword];
        UIAlertView  *EmailAlert = [[UIAlertView alloc] initWithTitle:@"Please enter your Williams Email id and password." message:@"" delegate:self
                cancelButtonTitle:@"Ok"
                    otherButtonTitles:@"Cancel", nil];
        
        EmailAlert.tag=5;
        EmailAlert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        [EmailAlert textFieldAtIndex:0].placeholder=@"Williams Email";
        [EmailAlert textFieldAtIndex:1].placeholder=@"Password";
    
        [EmailAlert show];
    }
    
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    [[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    // NSString *response  =  [request responseString];
    // DLog(@"response=%@",response);
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel removeLoader];
    
    
}

- (void)viewDidUnload
{
    [self setUsername:nil];
    [self setEmailid:nil];
    [self setPassword:nil];
    [self setBackgroundscroller:nil];
    [self setTwittername:nil];
    [self setPhoneNo:nil];
    [self setComments:nil];
    [self setHeaderTitle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




- (void)viewWillDisappear:(BOOL)animated
{
	
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
