//
//  Setting.m
//  PeckApp
//
//  Created by SRM Techsol Pvt. Ltd. on 5/7/13.
//  Copyright (c) 2013 stpl. All rights reserved.
//

#import "Setting.h"
#import "Profile.h"

@implementation Setting
@synthesize tableview,headerView,menuOpen;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    homescreen =[[HomeScreen alloc] initWithNibName:@"HomeScreen" bundle:nil];
    [self addChildViewController:homescreen];
    [self.view addSubview:homescreen.view];
      self.HeaderTitle.font = [UIFont boldSystemFontOfSize:self.HeaderTitle.font.pointSize];
    self.tableview.contentOffset=CGPointMake(0, appDel.settingsscrollercontent);
    //AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
   
    homescreen.view.hidden=YES;
   /* if ([appDel.activtynotificationcount isEqual:@"0"])
    {
        homescreen.NotificationCount.hidden=YES;
    }
    
    else
    {
        CGSize maximumSize = CGSizeMake(99999, 20);
        CGSize  notificationSize =[appDel.activtynotificationcount sizeWithFont:homescreen.NotificationCount.font constrainedToSize:maximumSize lineBreakMode:homescreen.NotificationCount.lineBreakMode];
        homescreen.NotificationCount.frame=CGRectMake(homescreen.NotificationCount.frame.origin.x, homescreen.NotificationCount.frame.origin.y,notificationSize.width+10, homescreen.NotificationCount.frame.size.height);
        homescreen.NotificationCount.text=appDel.activtynotificationcount;

    
    }
    */
}
-(void) viewDidDisappear:(BOOL)animated
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.menu=FALSE;
      
    
    
}



- (IBAction)closeSetting:(id)sender
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
   
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.1];
    
    if(menuOpen) {
        
        frame.origin.x = -(320-70);
        [self shiftview];
        [self.view bringSubviewToFront:tableview];
        [self.view bringSubviewToFront:headerView];
        // _bannerView.hidden=NO;
        self.tableview.scrollEnabled=YES;
        [menuclickbutton removeFromSuperview];
        menuOpen = NO;
    }
    else
    {
         appDel.settingsscrollercontent=self.tableview.contentOffset.y;
        frame.origin.x = 320-70;
        homescreen.view.hidden=NO;
        menuclickbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        if (self.tableview.contentSize.height<=[[UIScreen mainScreen] bounds].size.height-self.headerView.frame.size.height)
        {
            menuclickbutton.frame=CGRectMake(0,0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-self.headerView.frame.size.height);
        }
        else
        {
            menuclickbutton.frame=CGRectMake(0,0, [[UIScreen mainScreen] bounds].size.width,  self.tableview.contentSize.height);
            
        }
        
        [menuclickbutton addTarget:self action:@selector(closeSetting:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableview addSubview:menuclickbutton];
        self.tableview.scrollEnabled=NO;
        //  _bannerView.hidden=YES;
        [self shiftview];
        menuOpen = YES;
        
        
    }
    
    frame = self.view.frame;
    [UIView commitAnimations];
    
}
      

-(void) shiftview
{
    
    self.tableview.frame = CGRectMake(self.tableview.frame.origin.x+frame.origin.x, self.tableview.frame.origin.y, self.tableview.frame.size.width, self.tableview.frame.size.height);
    
    self.headerView.frame=CGRectMake(self.headerView.frame.origin.x+frame.origin.x, self.headerView.frame.origin.y, self.headerView.frame.size.width, self.headerView.frame.size.height);
    
    
    
}



- (IBAction)logout
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel addLoaderForViewController:self];
   
    if (appDel.fbSession!=nil) {
        [FBSession.activeSession closeAndClearTokenInformation];
        [appDel logoutFacebook];
    }
    facebookuser_logout =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:facebook_logout]] ;
    [facebookuser_logout  setDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults valueForKey:@"userid"];
    [facebookuser_logout setPostValue:uid forKey:@"userid"];
    DLog(@"device token=%@",appDel.devicetoken);
     [facebookuser_logout setPostValue:appDel.devicetoken forKey:@"device_token"];
    [facebookuser_logout  startAsynchronous];


}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    if (request==facebookuser_logout)
    {
        
      //  NSString *s=@"{"id": 55,"departments": 62 Center Events,"subscription_status":yes"};

        NSString *response  =  [request responseString];
        DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
        dict = [dict dictionaryByReplacingNullsWithStrings];
        NSString *status=[dict valueForKey:@"status"];
       
        if([status isEqualToString:@"l"])
        {
            [homescreen.view removeFromSuperview];
            [homescreen removeFromParentViewController];
            [self resetDefaults];
            [UIApplication sharedApplication].applicationIconBadgeNumber=0;
            appDel.activtynotificationcount=@"0";
            appDel.firsttimenotification=FALSE;
        [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
        
        else if (dict==nil)
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
                       
        }

    }
    
       
    [appDel removeLoader];
    
    
   }

- (void)resetDefaults
{
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict)
    {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
    
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    [[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
  //  NSString *response  =  [request responseString];
   // DLog(@"response=%@",response);
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel removeLoader];
    
    
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
}
# pragma mark tableview methods

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,0,320,20)];
    tempView.backgroundColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1] ;
    
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0,320,20)];
    tempLabel.backgroundColor=[UIColor clearColor];
    tempLabel.textColor = [UIColor whiteColor]; //here you can change the text color of header.
    tempLabel.textAlignment=NSTextAlignmentCenter;
    tempLabel.font = [UIFont fontWithName:@"Lato-Regular" size:15];
    tempLabel.font = [UIFont boldSystemFontOfSize:15];
    
    // NSString *key = nil;
    if (section==0)
    {
        tempLabel.text=@"";
    }
    if (section==1)
    {
        tempLabel.text=@"Subscribed Lists";
    }
    
    
    // tempLabel.text=[NSString stringWithFormat:@"%@", key];
    [tempView addSubview:tempLabel];
    return tempView;
}

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    // To "clear" the footer view
    return [UIView new];
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    else{
         return 20;
    }
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
   	}
   	for(UIView *customView in [cell.contentView subviews]){
        [customView removeFromSuperview];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *checkImage = [[UIImageView alloc]initWithFrame:CGRectMake(270,22, 11, 16)];
   
        [checkImage setImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"rightArrow.png"]]];
    
    [cell.contentView addSubview:checkImage];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 200, 40)];
    nameLabel.backgroundColor=[UIColor clearColor];
    if (indexPath.section==0)
      {
        if (indexPath.row==0)
        {
            nameLabel.text=@"About Us";
            
        }
          
        if (indexPath.row==1)
        {
            nameLabel.text=@"Profile";
            
        }
          
        if (indexPath.row==2)
        {
              nameLabel.text=@"Change Password";
              
        }
        if (indexPath.row==3)
        {
            nameLabel.text=@"Notifications";
            
        }

    }
    if (indexPath.section==1) {
              
      if (indexPath.row==0)
      {
           
            nameLabel.text=@"Athletic Teams";
            
       }
        if (indexPath.row==1)
        {
           
          nameLabel.text=@"Departments";
        }
        if (indexPath.row==2) {
            
            nameLabel.text=@"Student Groups";
            
        }
        if (indexPath.row==3) {
            
           nameLabel.text=@"Logout";
            
       }

    }
    
    
     if (indexPath.section==2) {
    if (indexPath.row==0)
    {
        
        nameLabel.text=@"Logout";
    }
     }
    nameLabel.font=[nameLabel.font fontWithSize:18];
    nameLabel.numberOfLines=0;
   
    
   // nameLabel.font=[UIFont fo]
    nameLabel.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1] ;
    [cell.contentView addSubview:nameLabel];
    //
    //    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 37, 200, 20)];
    //    nameLabel.backgroundColor=[UIColor clearColor];
    //    nameLabel.text=@"Carrier Services";
    //    [nameLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0]];
    //    nameLabel.textColor=[UIColor whiteColor];
    //    [cell.contentView addSubview:nameLabel];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
 
    if (indexPath.section==0)
   {
     
       if (indexPath.row==0)
       {

         AboutUs *aboutus=[[AboutUs alloc] initWithNibName:@"AboutUs" bundle:nil];
           [self.navigationController pushViewController:aboutus animated:YES];
       
    }
      
    if (indexPath.row==1)
    {
        appDel.enterscreen=TRUE;
        Profile *profile=[[Profile alloc] initWithNibName:@"Profile" bundle:nil];
        [self.navigationController pushViewController:profile animated:YES];
        
    }
       
    if (indexPath.row==2)
       {
        
           appDel.enterscreen=TRUE;
        ChangePassword *profile=[[ChangePassword alloc] initWithNibName:@"ChangePassword" bundle:nil];
        [self.navigationController pushViewController:profile animated:YES];
           
       }
       
    if (indexPath.row==3)
       {
           Notification *notification=[[Notification alloc] initWithNibName:@"Notification" bundle:nil];
        [self.navigationController pushViewController:notification animated:YES];
           
       }
   
       
   }
    
else if (indexPath.section==1) {
    
    if (indexPath.row==0)
    {
        AthleticsSubscription *athleticsubscription=[[AthleticsSubscription alloc] initWithNibName:@"AthleticsSubscription" bundle:nil];
        [self.navigationController pushViewController:athleticsubscription animated:YES];
        
    }
    
    if (indexPath.row==1)
    {
        CampusEventSubscription *campuseventsubscription=[[CampusEventSubscription alloc] initWithNibName:@"CampusEventSubscription" bundle:nil];
        [self.navigationController pushViewController:campuseventsubscription animated:YES];

    }
    
    if (indexPath.row==2)
    {
        afterHoursSubscription *afterhourssubscription=[[afterHoursSubscription alloc] initWithNibName:@"afterHoursSubscription" bundle:nil];
        [self.navigationController pushViewController:afterhourssubscription animated:YES];
        
    }

     if (indexPath.row==3)
    {
        [self logout];
    }
    }
}



- (void)viewDidUnload
{
    
 
    [self setHeaderView:nil];
    [self setTableview:nil];
    [self setHeaderTitle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
