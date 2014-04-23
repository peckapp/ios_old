//
//  Notification.m
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 7/11/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "Notification.h"

@interface Notification ()

@end

@implementation Notification

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)closeNotification:(id)sender
{
    if (submitnotification==nil)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    

}

-(IBAction)switchPressed:(id)sender
{
   
     AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    self.Switch.userInteractionEnabled=NO;
     notificationloading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    notificationloading.center = CGPointMake(self.Switch.frame.size.width/2, self.Switch.frame.size.height/2);
    notificationloading.alpha = 1.0;
    notificationloading.hidesWhenStopped = YES;
    [self.Switch addSubview:notificationloading];
    [notificationloading startAnimating];
    
    
    submitnotification =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:PostNotificationStatus]] ;
    [submitnotification setDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults valueForKey:@"userid"];
    [submitnotification setPostValue:uid forKey:@"userid"];
    if (self.Switch.on)
    {
       
        appDel.notificationstatus=TRUE;
        [submitnotification setPostValue:@"yes" forKey:@"subscribe"];
       
    }
    else
    {
       appDel.notificationstatus=FALSE;
     [submitnotification setPostValue:@"no" forKey:@"subscribe"];
    }

     [submitnotification startAsynchronous];
    
}

/*-(IBAction)notificationSubmit:(id)sender
{
     AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel addLoaderForViewController:self];
    submitnotification =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:PostNotificationStatus]] ;
    [submitnotification setDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults valueForKey:@"userid"];
    [submitnotification setPostValue:uid forKey:@"userid"];
    if (self.Switch.on) {
         [submitnotification setPostValue:@"yes" forKey:@"subscribe"];
    }
    else{
     [submitnotification setPostValue:@"no" forKey:@"subscribe"];
    }
    [submitnotification startAsynchronous];

}
*/
-(void)requestFinished:(ASIHTTPRequest *)request
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    NSString *response  =  [request responseString];
    NSMutableDictionary *dict=[response JSONValue];
    dict = [dict dictionaryByReplacingNullsWithStrings];
    
    if (request==getnotification)
    {
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
            for(UIView *subviews in [self.view subviews])
            {
                subviews.hidden=NO;
                
            }
        
            if ([[dict objectForKey:@"notification_status"] isEqual:@"yes"])
            {
                self.Switch.on=TRUE;
            }
            else{
            
                self.Switch.on=FALSE;
            
            }
        }
        
        else if ([[dict objectForKey:@"status"] isEqualToString:@"e"])
        {
            [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            
        }
        
        else if (dict==nil)
        {
            
            [[[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            
        }

        
        [appDel removeLoader];
    }

    
    
    if (request==submitnotification)
    {
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
            submitnotification=nil;
        [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];

        }
        
        else if ([[dict objectForKey:@"status"] isEqualToString:@"e"])
        {
            [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];

        }
          self.Switch.userInteractionEnabled=YES;
         [notificationloading stopAnimating];
         [notificationloading removeFromSuperview];
    }
    
}


-(void)requestFailed:(ASIHTTPRequest *)request
{
    submitnotification=nil;
    [[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
   // NSString *response  =  [request responseString];
   // DLog(@"response=%@",response);
    submitnotification=nil;
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.erroralert=@"Network is not Reachable";
    [appDel removeLoader];
    self.Switch.userInteractionEnabled=YES;
    [notificationloading stopAnimating];
    [notificationloading removeFromSuperview];
  
}




- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    for(UIView *subviews in [self.view subviews])
    {
        subviews.hidden=YES;
        self.headerView.hidden=NO;
    }
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel addLoaderForViewController:self];
    self.HeaderTitle.font = [UIFont boldSystemFontOfSize:self.HeaderTitle.font.pointSize];
    getnotification =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:GetNotificationStatus]] ;
    [getnotification setDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults valueForKey:@"userid"];
    [getnotification setPostValue:uid forKey:@"userid"];
    [getnotification startAsynchronous];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setHeaderTitle:nil];
    [self setSwitch:nil];
    [self setHeaderView:nil];
    [super viewDidUnload];
}
@end
