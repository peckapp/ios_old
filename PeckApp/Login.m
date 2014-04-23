//
//  Login.m
//  PeckApp
//
//  Created by STPLINC. on 5/21/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "Login.h"
#import "Webservices.h"

@implementation Login


@synthesize Emailid;
@synthesize Password;
@synthesize Backgroundscroller;
@synthesize login_req,activation_code_req,facebookdata_post;
@synthesize dict;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Forgot Password

-(IBAction)forgotPasswordClick:(id)sender

{
       
    UIAlertView  *EmailAlert = [[UIAlertView alloc] initWithTitle:@"Please enter your Williams Email id." message:@""delegate:self
                                                cancelButtonTitle:@"Ok"
                                                otherButtonTitles:@"Cancel", nil];
    EmailAlert.tag=7;
    EmailAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [EmailAlert textFieldAtIndex:0].placeholder=@"Williams Email";
    [EmailAlert show];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    singleTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGesture:)];
    [self.Backgroundscroller addGestureRecognizer:singleTap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addloader:) name:@"AddLoader" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(facebookLoginServerRequest:) name:@"FacebookUserDetails" object:nil];
    
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



- (IBAction)singleTapGesture:(UITextField *) textField{
    
    if ([Emailid.text isEqual:@""])
    {
        self.Emailid.placeholder=@"Williams Email";
        
        
    }
    if ([Password.text isEqual:@""])
    {
        self.Password.placeholder=@"Password";
        
    }
    [self.Emailid resignFirstResponder];
    [self.Password resignFirstResponder];
    
    self.Backgroundscroller.contentOffset=CGPointMake(0, 0);
    
}



-(IBAction)closeLogin:(id)sender{
    
    [self.Backgroundscroller removeGestureRecognizer:singleTap];
    [self.navigationController popViewControllerAnimated:YES];
    
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationBar.hidden=YES;
    self.Backgroundscroller.delegate=self;
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
    // [self.Emailid setValue:[UIColor colorWithRed:(204.0/255.0) green:(195.0/255.0) blue:(219.0/255.0) alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    
    //self.Backgroundscroller.contentSize=CGSizeMake(0, 610);
    
    //    UILabel *label1 =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 12, 10)];
    //    label1.backgroundColor = [UIColor clearColor];
    //    self.Emailid.leftView=label1;
    //    self.Emailid.leftViewMode=UITextFieldViewModeAlways;
    //    self.Emailid.delegate=self;
    //
    //    UILabel *label2 =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 12, 10)];
    //    label2.backgroundColor = [UIColor clearColor];
    //    self.Password.leftView=label2;
    //    self.Password.leftViewMode=UITextFieldViewModeAlways;
    //    self.Password.delegate=self;
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

#pragma mark TextField Delegate



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.Emailid isFirstResponder])
    {
        //singleTap.enabled=YES;
        [self.Password becomeFirstResponder];
    }
    else
        self.Backgroundscroller.contentOffset=CGPointMake(0, 0);
    [textField resignFirstResponder];
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.backgroundColor=[UIColor colorWithRed:(182.0/255.0) green:(160.0/255.0) blue:(215.0/255.0) alpha:1.0];
    
    
    if (textField==self.Emailid) {
        self.Backgroundscroller.contentOffset=CGPointMake(0, 160);
        self.Emailid.placeholder=@"";
    }
    if (textField==self.Password) {
        self.Backgroundscroller.contentOffset=CGPointMake(0, 160);
        self.Password.placeholder=@"";
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.backgroundColor=[UIColor colorWithRed:(161.0/255.0) green:(143.0/255.0) blue:(189.0/255.0) alpha:1.0];
    if ([Emailid.text isEqual:@""])
    {
        self.Emailid.placeholder=@"Williams Email";
        
        
    }
    
    
    if ([Password.text isEqual:@""])
    {
        self.Password.placeholder=@"Password";
        
    }
    
    
    
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




-(IBAction) login
{
    
    
    [self.Emailid resignFirstResponder];
    [self.Password resignFirstResponder];
    self.Backgroundscroller.contentOffset=CGPointMake(0, 0);
    
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel addLoaderForViewController:self];
    login_req =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString: login_request]] ;
    
    [login_req setDelegate:self];
    [login_req setPostValue:self.Emailid.text forKey:@"emailid"];
    [login_req setPostValue:self.Password.text forKey:@"password"];
    DLog(@"Dt=%@",appDel.devicetoken);
    [login_req setPostValue:appDel.devicetoken forKey:@"device_token"];
    [login_req startAsynchronous];
    
    
}



-(void)requestFinished:(ASIHTTPRequest *)request
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel removeLoader];
    
    if (request==login_req) {
        
        NSString *response  =  [request responseString];
        DLog(@"response=%@",response);
        
        dict =   [response JSONValue];
        DLog(@"dict=%@",dict);
        
        NSString *status=[dict valueForKey:@"status"];
        DLog(@"status=%@",status);
        
        if ([status isEqualToString:@"e"]) {
            
            
            [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            
            if ([[dict valueForKey:@"alert"] isEqual:@"email"])
            {
                self.Emailid.backgroundColor=[UIColor colorWithRed:(54.0/255.0) green:(54.0/255.0) blue:(54.0/255.0) alpha:1.0];
            }
            if ([[dict valueForKey:@"alert"] isEqual:@"password"])
            {
                self.Password.backgroundColor=[UIColor colorWithRed:(54.0/255.0) green:(54.0/255.0) blue:(54.0/255.0) alpha:1.0];
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
            AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
            appDel.userid=[dict valueForKey:@"userid"];
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
        
        else  if ([status isEqualToString:@"e"]) {
            
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
    
    if (request==forgotpassword)
    {
        NSString *response  =  [request responseString];
        DLog(@"response=%@",response);
        
        dict =   [response JSONValue];
        DLog(@"dict=%@",dict);
        
                    
            [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        
        
         if (dict==nil)
        {
            
            [[[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            
        }
        
    }
    
    
    
}

-(void) homescreen
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.enterscreen=TRUE;
    appDel.firsttimenotification=TRUE;
    
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
    
    
    self.Emailid.text=@"";
    self.Password.text=@"";
    
}

-(void) alertforVerificationCode
{
    
    
    UIAlertView  *EmailAlert = [[UIAlertView alloc] initWithTitle:@"Please Check your Email id for Code."
        message:@"" delegate:self cancelButtonTitle:@"Ok"
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
    
    [[NSNotificationCenter defaultCenter] removeObserver:nil name:@"AddLoader" object:nil];
    
    
    UIAlertView  *EmailAlert = [[UIAlertView alloc] initWithTitle:@"Please enter your Williams Email id and Desired Password."
                                                          message:@""
                                                         delegate:self
                                                cancelButtonTitle:@"Ok"
                                                otherButtonTitles:@"Cancel", nil];
    EmailAlert.tag=2;
    //EmailAlert.frame.size.height=200;
    EmailAlert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [EmailAlert textFieldAtIndex:0].placeholder=@"Williams Email";
    [EmailAlert textFieldAtIndex:1].placeholder=@"Password";
    
    [EmailAlert show];
    
    
}

-(void) alertforEmailidPasswordForFacebook
{
    [[NSNotificationCenter defaultCenter] removeObserver:nil name:@"AddLoader" object:nil];
    
       
    UIAlertView  *EmailAlert = [[UIAlertView alloc] initWithTitle:@"Please enter your Williams Email id and Password."
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
            [activation_code_req setPostValue:appDel.devicetoken forKey:@"device_token"];
            [activation_code_req  startAsynchronous];
            
        }
    }
    
    if(alertView.tag==2)
    {
        if (buttonIndex==0)
        {
            DLog(@"userid=%@",[dict valueForKey:@"userid"]);
            //DLog(@"Emailid=%@",EmailidField.text);
           // DLog(@"password=%@",PasswordField.text);
            AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
            [appDel addLoaderForViewController:self];
            
            facebook_email_password_post =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:facebook_emailpassword_post]] ;
            [facebook_email_password_post  setDelegate:self];
            [facebook_email_password_post setPostValue:[dict valueForKey:@"userid"] forKey:@"userid"];
            [facebook_email_password_post  setPostValue:[alertView textFieldAtIndex:0].text forKey:@"emailid"];
            [facebook_email_password_post  setPostValue:[alertView textFieldAtIndex:1].text forKey:@"password"];
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
        UIAlertView  *EmailAlert = [[UIAlertView alloc] initWithTitle:@"Please enter your Williams Email id and Desired password." message:@""
                    delegate:self cancelButtonTitle:@"Ok"
                    otherButtonTitles:@"Cancel", nil];
        
        EmailAlert.tag=2;
        EmailAlert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        [EmailAlert textFieldAtIndex:0].placeholder=@"Williams Email";
        [EmailAlert textFieldAtIndex:1].placeholder=@"Password";
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
            [login_req_facebook setDelegate:self];
            [login_req_facebook startAsynchronous];
        }
        
    }
    
    if(alertView.tag==6)
    {
        
        // [self alertforEmailidPassword];
        UIAlertView  *EmailAlert = [[UIAlertView alloc] initWithTitle:@"Please enter your Williams Email id and password." message:@""
                        delegate:self
                    cancelButtonTitle:@"Ok"
                    otherButtonTitles:@"Cancel", nil];
        
        EmailAlert.tag=5;
        EmailAlert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        [EmailAlert textFieldAtIndex:0].placeholder=@"Williams Email";
        [EmailAlert textFieldAtIndex:1].placeholder=@"Password";
        [EmailAlert show];
    }
    
    if (alertView.tag==7)
    {
        if (buttonIndex==0)
        {
            
            
            AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
            [appDel addLoaderForViewController:self];
            forgotpassword =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString: forgotPassword]] ;
           // DLog(@"Emailid=%@",EmailidField.text);
            [forgotpassword setPostValue:[alertView textFieldAtIndex:0].text forKey:@"emailid"];
           // DLog(@"Emailid=%@",EmailidField.text);
            [forgotpassword setDelegate:self];
            [forgotpassword startAsynchronous];
        }
        
    }
    
    
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    [[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    //   NSString *response  =  [request responseString];
    //  DLog(@"response=%@",response);
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel removeLoader];
    
    
}

- (void)viewDidUnload
{
    
    [self setEmailid:nil];
    [self setPassword:nil];
    [self setBackgroundscroller:nil];
    [self setTitle:nil];
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
