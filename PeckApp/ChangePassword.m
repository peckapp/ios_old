//
//  ChangePassword.m
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 9/13/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "ChangePassword.h"

@interface ChangePassword ()

@end

@implementation ChangePassword

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    singleTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGesture:)];
    [self.view addGestureRecognizer:singleTap];
    self.HeaderTitle.font = [UIFont boldSystemFontOfSize:self.HeaderTitle.font.pointSize];


}

-(IBAction)changepasswordsubmission:(id)sender
{
    UIApplication *application= [UIApplication sharedApplication];
    [self shiftview:0.0];
    application.statusBarHidden=NO;
    [self.confirmpassword resignFirstResponder];
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel addLoaderForViewController:self];
   
    changepassword =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:changeuserpassword]] ;
    changepassword.delegate=self;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults valueForKey:@"userid"];
    [changepassword setPostValue:uid forKey:@"userid"];
    [changepassword setPostValue:self.oldpassword.text forKey:@"op"];
    [changepassword setPostValue:self.newpassword.text forKey:@"np"];
    [changepassword setPostValue:self.confirmpassword.text forKey:@"cp"];
    [changepassword  startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    
    if (request==changepassword)
    
    {
        NSString *response  =  [request responseString];
        NSMutableDictionary  *dict =   [response JSONValue];
      
      if ([[dict valueForKey:@"status"] isEqual:@"s"])
        {
    [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            
            self.oldpassword.text=@"";
            self.newpassword.text=@"";
            self.confirmpassword.text=@"";

            self.oldpassword.placeholder=@"Old Password";
            self.newpassword.placeholder=@"New Password";
            self.confirmpassword.placeholder=@"Confirm Password";
        }
        
      else if ([[dict valueForKey:@"status"] isEqual:@"e"])
      {
       [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
       
      }
        
      else if (dict==nil)
      {
          
          [[[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
          
      }
    
    }
    
    [appDel removeLoader];

}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    [[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel removeLoader];
    
}


-(IBAction)closeChangePassword:(id)sender
{
    [self.view removeGestureRecognizer:singleTap];
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)singleTapGesture:(UITextField *) textField
{
    
      [self shiftview:0.0];
    [self.oldpassword resignFirstResponder];
    [self.newpassword resignFirstResponder];
    [self.confirmpassword resignFirstResponder];
    [self movefromtextfields];
    
}




#pragma mark TextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.oldpassword isFirstResponder])
    {
        if ([self.oldpassword.text isEqual:@""])
        {
        self.oldpassword.placeholder=@"Old Password";
            
        }
        
        [self.newpassword becomeFirstResponder];
       

    }
    
   else  if ([self.newpassword isFirstResponder])
    {
        if ([self.newpassword.text isEqual:@""])
        {
            self.newpassword.placeholder=@"New Password";
            
        }
        [self.confirmpassword becomeFirstResponder];
    }
    else
    {
        if ([self.confirmpassword.text isEqual:@""])
        {
            self.confirmpassword.placeholder=@"Confirm Password";
            
        }

         [self.confirmpassword resignFirstResponder];
         [self shiftview:0.0];
        
    }
   
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //textField.backgroundColor=[UIColor colorWithRed:(182.0/255.0) green:(160.0/255.0) blue:(215.0/255.0) alpha:1.0];
    
   textField.placeholder=@"";
    UIApplication *application= [UIApplication sharedApplication];
    
    application.statusBarHidden=YES;

    if (textField==self.oldpassword)
    {
        [self shiftview:-90.0];
    }
   else if (textField==self.newpassword)
    {
         [self shiftview:-160.0];
    }
    else if (textField==self.confirmpassword)
    {
         [self shiftview:-210.0];
    }

}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
   // textField.backgroundColor=[UIColor colorWithRed:(161.0/255.0) green:(143.0/255.0) blue:(189.0/255.0) alpha:1.0];
    
    UIApplication *application= [UIApplication sharedApplication];
    
    application.statusBarHidden=NO;
    
    [self movefromtextfields];

      
}

-(void) movefromtextfields
{
    if ([self.oldpassword.text isEqual:@""])
    {
        self.oldpassword.placeholder=@"Old Password";
         [self.oldpassword resignFirstResponder];
        
    }
    
    
    if ([self.newpassword.text isEqual:@""])
    {
        self.newpassword.placeholder=@"New Password";
         [self.newpassword resignFirstResponder];
        
    }
    
    
    
    if ([self.confirmpassword.text isEqual:@""])
    {
        self.confirmpassword.placeholder=@"Confirm Password";
         [self.confirmpassword resignFirstResponder];
    }
    
}

-(void) shiftview:(CGFloat) shiftheight
{
    
[UIView beginAnimations:nil context:NULL];
[UIView setAnimationDelegate:self];
[UIView setAnimationBeginsFromCurrentState:YES];
self.view .frame = CGRectMake(self.view.frame.origin.x, shiftheight,self.view.frame.size.width, self.view.frame.size.height);
[UIView commitAnimations];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setOldpassword:nil];
    [self setNewpassword:nil];
    [self setConfirmpassword:nil];
    [self setHeaderTitle:nil];
    [super viewDidUnload];
}
@end
