//
//  Feedback.m
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 9/23/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "Feedback.h"

@interface Feedback ()

@end

@implementation Feedback

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(void) viewWillAppear:(BOOL)animated{
    
    
    homescreen =[[HomeScreen alloc] initWithNibName:@"HomeScreen" bundle:nil];
    [self addChildViewController:homescreen];
    [self.view addSubview:homescreen.view];
    self.HeaderTitle.font = [UIFont boldSystemFontOfSize:self.HeaderTitle.font.pointSize];
      homescreen.view.hidden=YES;
    
}
-(void) viewDidDisappear:(BOOL)animated
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.menu=FALSE;
    
    
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



- (IBAction)closeFeedback:(id)sender
{
    [self.commentTextView resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.1];
    
    if(menuOpen) {
        
        frame.origin.x = -(320-70);
        [self shiftview];
        [self.view bringSubviewToFront:self.backGroundView];
        [self.view bringSubviewToFront:self.headerView];
        
        [menuclickbutton removeFromSuperview];
        menuOpen = NO;
    }
    else
    {
        
        
        
        frame.origin.x = 320-70;
        homescreen.view.hidden=NO;
        menuclickbutton=[UIButton buttonWithType:UIButtonTypeCustom];
       
            menuclickbutton.frame=CGRectMake(0,0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-self.headerView.frame.size.height);

       
        
        [menuclickbutton addTarget:self action:@selector(closeFeedback:) forControlEvents:UIControlEventTouchUpInside];
        [self.backGroundView addSubview:menuclickbutton];

        //  _bannerView.hidden=YES;
        [self shiftview];
        menuOpen = YES;
        
        
    }
    
    frame = self.view.frame;
    [UIView commitAnimations];
    
}


-(void) shiftview
{
    
    self.backGroundView.frame = CGRectMake(self.backGroundView.frame.origin.x+frame.origin.x, self.backGroundView.frame.origin.y, self.backGroundView.frame.size.width, self.backGroundView.frame.size.height);
    
    self.headerView.frame=CGRectMake(self.headerView.frame.origin.x+frame.origin.x, self.headerView.frame.origin.y, self.headerView.frame.size.width, self.headerView.frame.size.height);
    
    
    
}




-(IBAction) submitFeedback:(id)sender
{
    UIApplication *application= [UIApplication sharedApplication];
    application.statusBarHidden=NO;
    [self.commentTextView resignFirstResponder];
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
   
    
    if (![self.commentTextView.text isEqual:@"Please enter your Feedback."])
    {
         [appDel addLoaderForViewController:self];
     feedback =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:submitfeedback]] ;
    feedback.delegate=self;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults valueForKey:@"userid"];
    [feedback setPostValue:uid forKey:@"userid"];
    [feedback setPostValue:self.commentTextView.text forKey:@"feedbackcomment"];
    [feedback  startAsynchronous];
        
    }
    
    else
    {
        
    [[[UIAlertView alloc] initWithTitle:alertTitle message:@"Please enter your Feedback." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];

    }
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    if (request==feedback)
    {
        
        //  NSString *s=@"{"id": 55,"departments": 62 Center Events,"subscription_status":yes"};
        feedback=nil;
        NSString *response  =  [request responseString];
        DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
        dict = [dict dictionaryByReplacingNullsWithStrings];
        NSString *status=[dict valueForKey:@"status"];
        
        if([status isEqualToString:@"s"])
        {
        [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
              self.commentTextView.text=@"Please enter your Feedback.";
        self.commentTextView.textColor = [UIColor colorWithRed:(73.0/255.0) green:(73.0/255.0) blue:(73.0/255.0) alpha:1.0];
        }
        
        if([status isEqualToString:@"e"])
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
     feedback=nil;
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel removeLoader];
    
}



#pragma mark TextView Delegate


-(void)textViewDidBeginEditing:(UITextView *)textView
{
    singleTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGesture)];
    [self.view addGestureRecognizer:singleTap];
    
    if ([self.commentTextView.text isEqual:@"Please enter your Feedback."])
    {
        self.commentTextView.text=@"";
        self.commentTextView.textColor=[UIColor blackColor];
        
        
    }
    
    
    self.backGroundView.contentOffset=CGPointMake(0, 140);
  
}

- (IBAction)singleTapGesture
{
    
    [self.commentTextView resignFirstResponder];
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
  
    [self.view removeGestureRecognizer:singleTap];
    if (textView.text.length==0)
    {
        textView.textColor=[UIColor lightGrayColor];
        textView.text=@"Please enter your Feedback.";
         self.commentTextView.textColor=[UIColor colorWithRed:(73.0/255.0) green:(73.0/255.0) blue:(73.0/255.0) alpha:1.0];
    }
    
     self.backGroundView.contentOffset=CGPointMake(0, 0);
    
    
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    
    return YES;
}




- (void)viewDidUnload {
    [self setCommentTextView:nil];
    [self setHeaderTitle:nil];
    [self setHeaderView:nil];
    [self setBackGroundView:nil];
    [super viewDidUnload];
}
@end
