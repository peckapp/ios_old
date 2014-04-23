//
//  HomeScreen.m
//  PeckApp
//
//  Created by SRM Techsol Pvt. Ltd. on 5/3/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "HomeScreen.h"



@implementation HomeScreen
@synthesize myhorizon,NotificationCount;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) otherButtons:(NSInteger) tag
{
    if (tag==0) {
        
        self.myhorizon.backgroundColor=[UIColor darkGrayColor];
        self.athletics.backgroundColor=[UIColor clearColor];
        self.campusEvents.backgroundColor=[UIColor clearColor];
        self.afterHours.backgroundColor=[UIColor clearColor];
        self.activity.backgroundColor=[UIColor clearColor];
        self.dining.backgroundColor=[UIColor clearColor];
        self.circles.backgroundColor=[UIColor clearColor];
        self.feedback.backgroundColor=[UIColor clearColor];
        self.settings.backgroundColor=[UIColor clearColor];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"myhorizonselect"];
         [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"athleticsselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"campuseventselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"afterhoursselect"];
          [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"activityselect"];
          [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"diningselect"];
          [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"circlesselect"];
         [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"feedbackselect"];
          [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"settingsselect"];

    }
    if (tag==1) {
        
        self.myhorizon.backgroundColor=[UIColor clearColor];
        self.athletics.backgroundColor=[UIColor darkGrayColor];
        self.campusEvents.backgroundColor=[UIColor clearColor];
        self.afterHours.backgroundColor=[UIColor clearColor];
        self.activity.backgroundColor=[UIColor clearColor];
        self.dining.backgroundColor=[UIColor clearColor];
        self.circles.backgroundColor=[UIColor clearColor];
        self.feedback.backgroundColor=[UIColor clearColor];
        self.settings.backgroundColor=[UIColor clearColor];

        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"myhorizonselect"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"athleticsselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"campuseventselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"afterhoursselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"activityselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"diningselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"circlesselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"feedbackselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"settingsselect"];

    }
    
    if (tag==2) {
        
        self.myhorizon.backgroundColor=[UIColor clearColor];
        self.athletics.backgroundColor=[UIColor clearColor];
        self.campusEvents.backgroundColor=[UIColor darkGrayColor];
        self.afterHours.backgroundColor=[UIColor clearColor];
        self.activity.backgroundColor=[UIColor clearColor];
        self.dining.backgroundColor=[UIColor clearColor];
        self.circles.backgroundColor=[UIColor clearColor];
         self.feedback.backgroundColor=[UIColor clearColor];
        self.settings.backgroundColor=[UIColor clearColor];

        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"myhorizonselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"athleticsselect"];
      [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"campuseventselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"afterhoursselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"activityselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"diningselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"circlesselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"feedbackselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"settingsselect"];

    }
    
    if (tag==3) {
        
        self.myhorizon.backgroundColor=[UIColor clearColor];
        self.athletics.backgroundColor=[UIColor clearColor];
        self.campusEvents.backgroundColor=[UIColor clearColor];
        self.afterHours.backgroundColor=[UIColor darkGrayColor];
        self.activity.backgroundColor=[UIColor clearColor];
        self.dining.backgroundColor=[UIColor clearColor];
        self.circles.backgroundColor=[UIColor clearColor];
         self.feedback.backgroundColor=[UIColor clearColor];
        self.settings.backgroundColor=[UIColor clearColor];

        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"myhorizonselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"athleticsselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"campuseventselect"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"afterhoursselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"activityselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"diningselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"circlesselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"feedbackselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"settingsselect"];
        
    }
    
    if (tag==4) {
        
        self.myhorizon.backgroundColor=[UIColor clearColor];
        self.athletics.backgroundColor=[UIColor clearColor];
        self.campusEvents.backgroundColor=[UIColor clearColor];
        self.afterHours.backgroundColor=[UIColor clearColor];
        self.activity.backgroundColor=[UIColor darkGrayColor];
        self.dining.backgroundColor=[UIColor clearColor];
        self.circles.backgroundColor=[UIColor clearColor];
         self.feedback.backgroundColor=[UIColor clearColor];
        self.settings.backgroundColor=[UIColor clearColor];

        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"myhorizonselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"athleticsselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"campuseventselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"afterhoursselect"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"activityselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"diningselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"circlesselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"feedbackselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"settingsselect"];
        
    }
    if (tag==5) {
        
        self.myhorizon.backgroundColor=[UIColor clearColor];
        self.athletics.backgroundColor=[UIColor clearColor];
        self.campusEvents.backgroundColor=[UIColor clearColor];
        self.afterHours.backgroundColor=[UIColor clearColor];
        self.activity.backgroundColor=[UIColor clearColor];
        self.dining.backgroundColor=[UIColor darkGrayColor];
        self.circles.backgroundColor=[UIColor clearColor];
         self.feedback.backgroundColor=[UIColor clearColor];
        self.settings.backgroundColor=[UIColor clearColor];

        
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"myhorizonselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"athleticsselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"campuseventselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"afterhoursselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"activityselect"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"diningselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"circlesselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"feedbackselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"settingsselect"];
        

        
    }
    
    if (tag==6) {
        
        self.myhorizon.backgroundColor=[UIColor clearColor];
        self.athletics.backgroundColor=[UIColor clearColor];
        self.campusEvents.backgroundColor=[UIColor clearColor];
        self.afterHours.backgroundColor=[UIColor clearColor];
        self.activity.backgroundColor=[UIColor clearColor];
        self.dining.backgroundColor=[UIColor clearColor];
        self.circles.backgroundColor=[UIColor darkGrayColor];
         self.feedback.backgroundColor=[UIColor clearColor];
        self.settings.backgroundColor=[UIColor clearColor];

        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"myhorizonselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"athleticsselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"campuseventselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"afterhoursselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"activityselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"diningselect"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"circlesselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"feedbackselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"settingsselect"];
        
    }
    
    if (tag==7) {
        
        self.myhorizon.backgroundColor=[UIColor clearColor];
        self.athletics.backgroundColor=[UIColor clearColor];
        self.campusEvents.backgroundColor=[UIColor clearColor];
        self.afterHours.backgroundColor=[UIColor clearColor];
        self.activity.backgroundColor=[UIColor clearColor];
        self.dining.backgroundColor=[UIColor clearColor];
        self.circles.backgroundColor=[UIColor clearColor];
         self.feedback.backgroundColor=[UIColor darkGrayColor];
        self.settings.backgroundColor=[UIColor clearColor];

        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"myhorizonselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"athleticsselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"campuseventselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"afterhoursselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"activityselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"diningselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"circlesselect"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"feedbackselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"settingsselect"];
        
    }
    
    if (tag==8) {
        
        self.myhorizon.backgroundColor=[UIColor clearColor];
        self.athletics.backgroundColor=[UIColor clearColor];
        self.campusEvents.backgroundColor=[UIColor clearColor];
        self.afterHours.backgroundColor=[UIColor clearColor];
        self.activity.backgroundColor=[UIColor clearColor];
        self.dining.backgroundColor=[UIColor clearColor];
        self.circles.backgroundColor=[UIColor clearColor];
        self.feedback.backgroundColor=[UIColor clearColor];
        self.settings.backgroundColor=[UIColor darkGrayColor];
        
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"myhorizonselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"athleticsselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"campuseventselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"afterhoursselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"activityselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"diningselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"circlesselect"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"feedbackselect"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"settingsselect"];
        
    }
    
    
    [[NSUserDefaults standardUserDefaults] synchronize];

   


}



-(IBAction)myHorizonClicked:(id)sender
{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    
    MyHorizon *myHorizon=[[MyHorizon alloc]initWithNibName:@"MyHorizon" bundle:nil];
    appDel.menuscrollercontent=self.Backgroundscroller.contentOffset.y;
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"myhorizonselect"])
    {
        
        myHorizon.menuOpen=NO;
        appDel.menu=TRUE;
        [[self navigationController]pushViewController:myHorizon animated:NO];
        
    }
    
    else
    {
        self.myhorizon.tag=0;
        [self otherButtons:self.myhorizon.tag];
        appDel.enterscreen=TRUE;
        [[self navigationController]pushViewController:myHorizon animated:NO];
    }
    
}


-(IBAction)atheleticsClicked:(id)sender{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
      Athletics *atheletic=[[Athletics alloc]initWithNibName:@"Athletics" bundle:nil];
    appDel.menuscrollercontent=self.Backgroundscroller.contentOffset.y;
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"athleticsselect"])
    {
        atheletic.menuOpen=NO;
        appDel.menu=TRUE;
        [[self navigationController]pushViewController:atheletic animated:NO];
        
    }
    else{
    
    self.athletics.tag=1;
    [self otherButtons:self.athletics.tag];
     appDel.enterscreen=TRUE;
    [[self navigationController]pushViewController:atheletic animated:NO];
        
    }
    
}

-(IBAction)campusEventsButtonClicked:(id)sender
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    CampusEventsViewController *events=[[CampusEventsViewController alloc]initWithNibName:@"CampusEventsViewController" bundle:nil];
    appDel.menuscrollercontent=self.Backgroundscroller.contentOffset.y;
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"campuseventselect"])
    {
        events.menuOpen=NO;
        appDel.menu=TRUE;
        [[self navigationController]pushViewController:events animated:NO];

    }
    else
    {
        self.campusEvents.tag=2;
        [self otherButtons:self.campusEvents.tag];
        appDel.enterscreen=TRUE;
        [[self navigationController]pushViewController:events animated:NO];
        
    }

}

-(IBAction)afterHoursClicked:(id)sender
{
   
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
  afterHours *afterhours=[[afterHours alloc]initWithNibName:@"afterHours" bundle:nil];
   
    appDel.menuscrollercontent=self.Backgroundscroller.contentOffset.y;
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"afterhoursselect"])
    {
        afterhours.menuOpen=NO;
        appDel.menu=TRUE;
       [[self navigationController]pushViewController:afterhours animated:NO];
        
    }
    else
    {
        self.afterHours.tag=3;
        [self otherButtons:self.afterHours.tag];
        appDel.enterscreen=TRUE;
        [[self navigationController]pushViewController:afterhours animated:NO];
        
    }

    
}

-(IBAction)activityClicked:(id)sender{

    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    Activity *activity=[[Activity alloc]initWithNibName:@"Activity" bundle:nil];
    appDel.menuscrollercontent=self.Backgroundscroller.contentOffset.y;
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    appDel.activtynotificationcount=@"0";
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"activityselect"])
    {
        activity.menuOpen=NO;
        appDel.menu=TRUE;
        [[self navigationController]pushViewController:activity animated:NO];
        
    }
    else
    {
        self.activity.tag=4;
        [self otherButtons:self.activity.tag];
        appDel.enterscreen=TRUE;
        [[self navigationController]pushViewController:activity animated:NO];
        
    }
    
}


-(IBAction)diningClicked:(id)sender{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    Dining *dining=[[Dining alloc]initWithNibName:@"Dining" bundle:nil];
    appDel.menuscrollercontent=self.Backgroundscroller.contentOffset.y;
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"diningselect"])
    {
        dining.menuOpen=NO;
        appDel.menu=TRUE;
        [[self navigationController]pushViewController:dining animated:NO];
        
    }
    else
    {
        self.dining.tag=5;
        [self otherButtons:self.dining.tag];
        appDel.enterscreen=TRUE;
      [[self navigationController]pushViewController:dining animated:NO];
        
    }

    
}
-(IBAction)circleClicked:(id)sender{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    Circles *circle=[[Circles alloc]initWithNibName:@"Circles" bundle:nil];
       appDel.menuscrollercontent=self.Backgroundscroller.contentOffset.y;
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"circlesselect"])
    {
        circle.menuOpen=NO;
        appDel.menu=TRUE;
        [[self navigationController]pushViewController:circle animated:NO];
        
    }
    else{
        
        self.circles.tag=6;
        [self otherButtons:self.circles.tag];
        appDel.enterscreen=TRUE;
        [[self navigationController]pushViewController:circle animated:NO];
        
    }

    
    
}


- (IBAction)openFeedback:(id)sender
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    self.feedback.tag=7;
    [self otherButtons:self.feedback.tag];
     appDel.menuscrollercontent=self.Backgroundscroller.contentOffset.y;
    Feedback *feedback=[[Feedback alloc] initWithNibName:@"Feedback" bundle:nil];
     [[self navigationController]pushViewController:feedback animated:NO];
    
}


-(IBAction)settingClicked:(id)sender{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.menuscrollercontent=self.Backgroundscroller.contentOffset.y;
    self.settings.tag=8;
    [self otherButtons:self.settings.tag];
    Setting *setting=[[Setting alloc]initWithNibName:@"Setting" bundle:nil];
    [[self navigationController]pushViewController:setting animated:NO];
    
    
}






- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"myhorizonselect"])
    {
       
        self.myhorizon.backgroundColor=[UIColor darkGrayColor];
    }
    
  else  if([[NSUserDefaults standardUserDefaults] boolForKey:@"athleticsselect"]) {
    
        self.athletics.backgroundColor=[UIColor darkGrayColor];
    }

  else  if([[NSUserDefaults standardUserDefaults] boolForKey:@"campuseventselect"]) {
      self.campusEvents.backgroundColor=[UIColor darkGrayColor];
  }

  else  if([[NSUserDefaults standardUserDefaults] boolForKey:@"afterhoursselect"]) {
      self.afterHours.backgroundColor=[UIColor darkGrayColor];
  }
  else  if([[NSUserDefaults standardUserDefaults] boolForKey:@"activityselect"]) {
      self.activity.backgroundColor=[UIColor darkGrayColor];
  }
  else  if([[NSUserDefaults standardUserDefaults] boolForKey:@"diningselect"]) {
      self.dining.backgroundColor=[UIColor darkGrayColor];
  }
  else  if([[NSUserDefaults standardUserDefaults] boolForKey:@"circlesselect"]) {
      self.circles.backgroundColor=[UIColor darkGrayColor];
  }
  else  if([[NSUserDefaults standardUserDefaults] boolForKey:@"feedbackselect"]) {
      self.feedback.backgroundColor=[UIColor darkGrayColor];
  }
  else  if([[NSUserDefaults standardUserDefaults] boolForKey:@"settingsselect"]) {
      self.settings.backgroundColor=[UIColor darkGrayColor];
  }

    
// [self.myhorizon setImage:[UIImage imageNamed:@"2132.png"] forState:UIControlStateNormal];
    
    // self.Backgroundscroller.contentSize=CGSizeMake(0, 700);
    //self.Backgroundscroller.showsVerticalScrollIndicator=NO;
   //  [self.view addSubview:self.animatedView];
    //  [self.animatedView setFrame:CGRectMake(250.0f, 0.0f, 70.0f, 568.0f)];
       // Do any additional setup after loading the view from its nib.
}
-(void) viewWillAppear:(BOOL)animated
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.delegate = self;
    NotificationCount.layer.cornerRadius=3.0;
    //DLog(@"screen height=%f",[[UIScreen mainScreen] bounds].size.height);
    if ([[UIScreen mainScreen] bounds].size.height<=480.0)
    {
        self.Backgroundscroller.contentSize=CGSizeMake(0, [[UIScreen mainScreen] bounds].size.height+142);
        self.Backgroundscroller.contentOffset=CGPointMake(0, appDel.menuscrollercontent);

    }
    
     if ([appDel.activtynotificationcount isEqual:@"0"])
        {
            NotificationCount.hidden=YES;
            
        }
        
        else
            
        {
            NotificationCount.hidden=NO;
            NotificationCount.text=appDel.activtynotificationcount;
            CGSize maximumSize = CGSizeMake(137, 20);
            CGSize  notificationSize =[NotificationCount.text sizeWithFont:NotificationCount.font constrainedToSize:maximumSize lineBreakMode:NotificationCount.lineBreakMode];
            NotificationCount.frame=CGRectMake(NotificationCount.frame.origin.x,NotificationCount.frame.origin.y,notificationSize.width+10,NotificationCount.frame.size.height);
        
    }
        

  }

-(void) viewDidDisappear:(BOOL)animated
{

}

-(void) viewDidAppear:(BOOL)animated
{
    
}
- (void)viewDidUnload
{
    [self setAnimatedView:nil];
    [self setMyhorizon:nil];
    
    [self setBackgroundscroller:nil];
    [self setAthletics:nil];
    [self setCampusEvents:nil];
    [self setAfterHours:nil];
    [self setActivity:nil];
    [self setDining:nil];
    [self setCircles:nil];
    [self setSettings:nil];
    [self setMyHorizonLabel:nil];
    [self setNotificationCount:nil];
    [self setTestlabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark home screen delegate

-(void) changeLabelInfo
{
     AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    if ([appDel.activtynotificationcount isEqual:@"0"])
    {
        NotificationCount.hidden=YES;
        
    }
    
    else
        
    {
        NotificationCount.hidden=NO;
        NotificationCount.text=appDel.activtynotificationcount;
        CGSize maximumSize = CGSizeMake(137, 20);
        CGSize  notificationSize =[NotificationCount.text sizeWithFont:NotificationCount.font constrainedToSize:maximumSize lineBreakMode:NotificationCount.lineBreakMode];
        NotificationCount.frame=CGRectMake(NotificationCount.frame.origin.x,NotificationCount.frame.origin.y,notificationSize.width+10,NotificationCount.frame.size.height);
        
        
    }



}

-(void) switchtopecks
{
    //[UIApplication sharedApplication].applicationIconBadgeNumber=0;
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    Activity *activity=[[Activity alloc]initWithNibName:@"Activity" bundle:nil];
    
       self.activity.tag=4;
    [self otherButtons:self.activity.tag];
    appDel.activtynotificationcount=@"0";
 BOOL modalPresent = (BOOL)(self.presentedViewController);
    if (modalPresent)
    {
        [self dismissViewControllerAnimated:NO completion:nil];
         appDel.enterscreen=TRUE;
       [self.navigationController pushViewController:activity animated:YES];              
    }
    else
    {
         appDel.enterscreen=TRUE;
       [self.navigationController pushViewController:activity animated:YES];
        
    }
    
  }


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
