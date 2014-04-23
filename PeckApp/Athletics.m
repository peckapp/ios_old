//
//  Athletics.m
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 5/28/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

//
//  CampusEventsViewController.m
//  PeckApp
//
//  Created by STPL MAC on 4/25/13.
//  Copyright (c) 2013 stpl. All rights reserved.
//

#import "Athletics.h"
#import "CreateEventViewController.h"
#import "EventPageAttend.h"
@implementation Athletics
@synthesize tableview,headerView,newstatus,oldstatus,buttonindexpath,eventcount,activityIndicator,startindex,menuOpen;

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
      homescreen =[[HomeScreen alloc] initWithNibName:@"HomeScreen" bundle:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark CreateAthletics
-(IBAction) createAthletics:(id)sender
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.attendevent=TRUE;

    CreateEventViewController *events=[[CreateEventViewController alloc]initWithNibName:@"CreateEventViewController" bundle:nil];
    [self presentViewController:events animated:YES completion:nil];
    //[self presentModalViewController:events animated:YES];
}

-(IBAction) athleticsButtonClosed:(id)sender
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    
    if(menuOpen)
    {
        
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
        appDel.athleticsscrollercontent=self.tableview.contentOffset.y;
        frame.origin.x = 320-70;
        homescreen.view.hidden=NO;
        menuclickbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        menuclickbutton.frame=CGRectMake(0,0, [[UIScreen mainScreen] bounds].size.width,  self.tableview.contentSize.height);
        [menuclickbutton addTarget:self action:@selector(athleticsButtonClosed:) forControlEvents:UIControlEventTouchUpInside];
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
-(void)viewWillAppear:(BOOL)animated
{

    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
      self.HeaderTitle.font = [UIFont boldSystemFontOfSize:self.HeaderTitle.font.pointSize];
    if (appDel.enterscreen)
    {
         eventcount = [[NSMutableArray alloc] init];
        [self initialload];
        [appDel addLoaderForViewController:self];
         startindex=0;
        previousindex=0;
        appDel.siathletics=0;
        appDel.piathletics=0;
        
        self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
       // self.tableview.hidden=YES;
        listofevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:athleticsEvents]] ;
        [listofevents setDelegate:self];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *uid = [defaults valueForKey:@"userid"];
        [listofevents setPostValue:uid forKey:@"userid"];
        [listofevents setPostValue:@"0" forKey:@"start_limit"];
        [listofevents  startAsynchronous];
        
        
    }
    
    else if (appDel.menu)
    {
        [self initialload];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData  *data= [defaults valueForKey:@"eventcountathletics"];
        NSMutableArray *object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        eventcount = [[NSMutableArray alloc] initWithArray:object];
        startindex=appDel.siathletics;
        previousindex=appDel.piathletics;

        if (eventcount.count==0)
        {
             self.tableview.scrollEnabled=NO;
             self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
           [[[UIAlertView alloc]initWithTitle:alertTitle message:appDel.erroralert delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }
        
        else
        {
            self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            self.tableview.contentOffset=CGPointMake(0, appDel.athleticsscrollercontent);
        }
                
    }
    
  }

-(void) initialload
{
    //AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    
    homescreen =[[HomeScreen alloc] initWithNibName:@"HomeScreen" bundle:nil];
    [self addChildViewController:homescreen];
    [self.view addSubview:homescreen.view];
    //   homescreen.NotificationCount.hidden=YES;
   // homescreen.NotificationCount.text=appDel.activtynotificationcount;
     homescreen.view.hidden=YES;
    self.tableview = [[PullTableView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height-50) style:UITableViewStylePlain];// autorelease];
    self.tableview.pullDelegate =self;
    self.tableview.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:tableview];
   
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.pullDelegate =self;
    self.tableview.showsVerticalScrollIndicator=NO;
 
    self.imageDownloadingQueue = [[NSOperationQueue alloc] init];
    self.imageDownloadingQueue.maxConcurrentOperationCount = 4; // many servers limit how many concurrent requests they'll accept from a device, so make sure to set this accordingly
    
    self.imageCache = [[NSCache alloc] init];
       
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.enterscreen=FALSE;
    appDel.menu=FALSE;
    // [homescreen.view removeFromSuperview];
    // [homescreen removeFromParentViewController];
    
    
}

- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView
{
    [self refreshdMoreDataToTable];
}

-(void) refreshdMoreDataToTable
{
    savepreviousindex=previousindex;
    //startindex=startindex+Size;
    previousevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:previousAthleticsEvents]] ;
    [previousevents setDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults valueForKey:@"userid"];
    [previousevents setPostValue:uid forKey:@"userid"];
    
    NSString *nextindex = [NSString stringWithFormat:@"%d", (int)previousindex];
    
    DLog(@"nextindex=%@", nextindex);
    [previousevents setPostValue:nextindex forKey:@"start_limit"];
    [previousevents  startAsynchronous];
    
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
 
      [self loadMoreDataToTable];
}

-(void) loadMoreDataToTable
{
    savestartindex=startindex;
   //startindex=startindex+Size;
    listofevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:athleticsEvents]] ;
    [listofevents setDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults valueForKey:@"userid"];
    [listofevents setPostValue:uid forKey:@"userid"];
  
    NSString *nextindex = [NSString stringWithFormat:@"%d", (int)startindex];

    DLog(@"nextindex=%@", nextindex);
    [listofevents setPostValue:nextindex forKey:@"start_limit"];
    [listofevents  startAsynchronous];
     
     

}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    if (request==listofevents)
    {
        listofevents=nil;
        NSString *response  =  [[request responseString] stringByReplacingOccurrencesOfString:@"&#x27;" withString:@"'"];
        response  = [response stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&rsquo;" withString:@"'"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&ntilde;" withString:@"n"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&eacute;" withString:@"e"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        response  =  [response stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
        
        DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
        dict = [dict dictionaryByReplacingNullsWithStrings];
        DLog(@"status=%@",[dict objectForKey:@"status"]);
        DLog(@"dictionary count=%d",dict.count);
        
                
    
        //   [eventcount removeAllObjects];
        //    DLog(@"id=%@",[dict valueForKey:[NSString stringWithFormat:@"%d",i]]);
    /*    if ([[NSString stringWithFormat:@"%d",[[dict valueForKey:@"notification_count"] intValue]]isEqual:@"0"])
        {
            homescreen.NotificationCount.hidden=YES;
            appDel.activtynotificationcount=[NSString stringWithFormat:@"%d",[[dict valueForKey:@"notification_count"] intValue]];
        }
        
        else
        {
            homescreen.NotificationCount.hidden=NO;
            homescreen.NotificationCount.text=[NSString stringWithFormat:@"%d",[[dict valueForKey:@"notification_count"] intValue]];
            CGSize maximumSize = CGSizeMake(99999, 20);
            CGSize  notificationSize =[homescreen.NotificationCount.text sizeWithFont:homescreen.NotificationCount.font constrainedToSize:maximumSize lineBreakMode:homescreen.NotificationCount.lineBreakMode];
            homescreen.NotificationCount.frame=CGRectMake(homescreen.NotificationCount.frame.origin.x, homescreen.NotificationCount.frame.origin.y,notificationSize.width+10, homescreen.NotificationCount.frame.size.height);
            appDel.activtynotificationcount=[NSString stringWithFormat:@"%d",[[dict valueForKey:@"notification_count"] intValue]];
            
        }
        */
        DLog(@"status=%@",[dict valueForKey:@"status"]);
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
            
            startindex=[[dict valueForKey:@"startlimit"] intValue];
            appDel.siathletics=startindex;

            
            // [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"eventcount"];
            // [[NSUserDefaults standardUserDefaults]synchronize];
            
        
            
            for (int i=0; i<=dict.count; i++)
            {
                
                
                if ([dict valueForKey:[NSString stringWithFormat:@"%d",i]]!=nil) {
                    [eventcount addObject:[dict valueForKey:[NSString stringWithFormat:@"%d",i]]];
                }
                
                else if ([dict valueForKey:[NSString stringWithFormat:@"%d",i]]==nil)
                {
                    
                    [eventcount removeObject:[dict valueForKey:[NSString stringWithFormat:@"%d",i]]];
                    
                    
                    
                }
                
            }
            
                
            
            NSData *yourArrayAsData = [NSKeyedArchiver archivedDataWithRootObject:eventcount];
            [[NSUserDefaults standardUserDefaults] setObject:yourArrayAsData forKey:@"eventcountathletics"];
            [[NSUserDefaults standardUserDefaults] synchronize];
           
            
            DLog(@"department=%@",eventcount);
            DLog(@"department=%@",[[eventcount objectAtIndex:0] objectForKey:@"event_title"]);
        
            DLog(@"departmentcount=%d",eventcount.count);
            
            //  DLog(@"count=%d",dict.count);
            // NSMutableArray  *deparmentcount = [dict objectForKey:@"id"];
            
            // NSLog(@"ob1=%@",deparmentcount);
            //  deparmentcount=[[dict objectForKey:@"d"] objectForKey:@"id"];
            
            
            
            self.tableview.hidden=NO;
            self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            [self.tableview reloadData];
            if (eventcount.count>0)
            {
                [appDel removeLoader];
            }
            
        }
        else if ([[dict objectForKey:@"status"] isEqualToString:@"e"])
        {
            self.tableview.hidden=NO;
            
            startindex=savestartindex;
            appDel.siathletics=startindex;
            
            if (eventcount.count==0)
            {
                [self refreshdMoreDataToTable];
               
            }
            else
            {
                
                [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                [appDel removeLoader];
                
            }
            
            
        }
        
        else if (dict==nil)
        {
            startindex=savestartindex;
             appDel.siathletics=startindex;
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            if (eventcount.count==0)
            {
                alert.tag=1;
            }
            appDel.erroralert=DatabaseError;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"eventcountathletics"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [appDel removeLoader];
            
        }
        
        self.tableview.pullTableIsLoadingMore = NO;
    }
    
    if (request==previousevents)
    {
        previousevents=nil;
        NSString *response  =  [[request responseString] stringByReplacingOccurrencesOfString:@"&#x27;" withString:@"'"];
        response  = [response stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&rsquo;" withString:@"'"];
        
        DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
        dict = [dict dictionaryByReplacingNullsWithStrings];
        
     
        
        DLog(@"status=%@",[dict objectForKey:@"status"]);
        DLog(@"dictionary count=%d",dict.count);
        //   [eventcount removeAllObjects];
        //    DLog(@"id=%@",[dict valueForKey:[NSString stringWithFormat:@"%d",i]]);
    /*    if ([[NSString stringWithFormat:@"%d",[[dict valueForKey:@"notification_count"] intValue]]isEqual:@"0"])
        {
            homescreen.NotificationCount.hidden=YES;
            appDel.activtynotificationcount=[NSString stringWithFormat:@"%d",[[dict valueForKey:@"notification_count"] intValue]];
        }
        
        else
        {
            homescreen.NotificationCount.hidden=NO;
            homescreen.NotificationCount.text=[NSString stringWithFormat:@"%d",[[dict valueForKey:@"notification_count"] intValue]];
            CGSize maximumSize = CGSizeMake(99999, 20);
            CGSize  notificationSize =[homescreen.NotificationCount.text sizeWithFont:homescreen.NotificationCount.font constrainedToSize:maximumSize lineBreakMode:homescreen.NotificationCount.lineBreakMode];
            homescreen.NotificationCount.frame=CGRectMake(homescreen.NotificationCount.frame.origin.x, homescreen.NotificationCount.frame.origin.y,notificationSize.width+10, homescreen.NotificationCount.frame.size.height);
            appDel.activtynotificationcount=[NSString stringWithFormat:@"%d",[[dict valueForKey:@"notification_count"] intValue]];
            
        }
      */        
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
            previousindex=[[dict objectForKey:@"previousindex"] integerValue];
            appDel.piathletics=previousindex;

            for (int i=0; i<=dict.count; i++)
            {
                
                if ([dict valueForKey:[NSString stringWithFormat:@"%d",i]]!=nil)
                {
                    [eventcount insertObject:[dict valueForKey:[NSString stringWithFormat:@"%d",i]] atIndex:0];
                    
                }
                
                else if ([dict valueForKey:[NSString stringWithFormat:@"%d",i]]==nil)
                {
                    
                    [eventcount removeObject:[dict valueForKey:[NSString stringWithFormat:@"%d",i]]];
                    
                    
                }
                
            }
            NSData *yourArrayAsData = [NSKeyedArchiver archivedDataWithRootObject:eventcount];
            [[NSUserDefaults standardUserDefaults] setObject:yourArrayAsData forKey:@"eventcountathletics"];
            [[NSUserDefaults standardUserDefaults] synchronize];

            self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            [self.tableview reloadData];
            [appDel removeLoader];
            DLog(@"eccount=%d",eventcount.count);
        }
        
        else if ([[dict objectForKey:@"status"] isEqual:@"e"])
        {
            
            self.tableview.hidden=NO;
            
            previousindex=savepreviousindex;
            appDel.piathletics=previousindex;

            if (eventcount.count==0)
            {
                self.tableview.scrollEnabled=NO;
            [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                
                appDel.erroralert=[dict objectForKey:@"message"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"eventcountathletics"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
            else
            {
                
                [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                
            }
            
        }
        
        else if (dict==nil)
        {
            previousindex=savepreviousindex;
            appDel.piathletics=previousindex;
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            if (eventcount.count==0)
            {
                alert.tag=1;
            }
            appDel.erroralert=DatabaseError;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"eventcountathletics"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
        [appDel removeLoader];
        self.tableview.pullTableIsRefreshing=NO;
    }
    
    if (request==subscribeevents)
    {
        subscribeevents=nil;
        NSString *response  =  [request responseString];
        
        DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
        DLog(@"status=%@",[dict objectForKey:@"status"]);
        if ([[dict objectForKey:@"status"] isEqualToString:@"s"])
        {
            // [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"eventcount"];
            //  [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            DLog(@"subscription=%@",[dict objectForKey:@"subscribe"]);
            DLog(@"buttonindex=%d",buttonindexpath.row);
            
        DLog(@"subscription=%@",[[eventcount objectAtIndex:buttonindexpath.row] objectForKey:@"subscription_status"]);
            
            NSData *yourArrayAsData = [NSKeyedArchiver archivedDataWithRootObject:eventcount];
            [[NSUserDefaults standardUserDefaults] setObject:yourArrayAsData forKey:@"eventcountathletics"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self.tableview reloadData];
            [activityIndicator removeFromSuperview];
            [activityIndicator stopAnimating];
            
            
            
        }
        
        else if ([[dict objectForKey:@"status"] isEqualToString:@"e"])
        {
            
            [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            
        }
        
        
        [appDel removeLoader];
    }
    
    
}


-(void)requestFailed:(ASIHTTPRequest *)request
{
    
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"eventcountathletics"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    

    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
      appDel.erroralert=@"Network is not Reachable";
    if (eventcount.count==0)
    {
        alert.tag=1;
        
    }
    appDel.enterscreen=TRUE;
    [appDel removeLoader];
   
    self.tableview.hidden=NO;
      self.tableview.pullTableIsLoadingMore = NO;
     self.tableview.pullTableIsRefreshing=NO;
    
    startindex=savestartindex;
    appDel.siathletics=startindex;
    
    previousindex=savepreviousindex;
    appDel.piathletics=previousindex;
    
    if (request==subscribeevents)
    {
        NSMutableDictionary *new=[[NSMutableDictionary alloc] initWithDictionary:[eventcount objectAtIndex:buttonindexpath.row]];
        [new setValue:oldstatus forKey:@"subscription_status"];
        [eventcount setObject:new atIndexedSubscript:buttonindexpath.row];
        [activityIndicator stopAnimating];
        [activityIndicator removeFromSuperview];
        

    }
    
    listofevents=nil;
    subscribeevents=nil;
    previousevents=nil;
  
}

#pragma mark alertview delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        if (buttonIndex==0)
        {
            
            [self athleticsButtonClosed:nil];
            
        }
        
    }
    
}


#pragma mark -
#pragma mark Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[[eventcount objectAtIndex:indexPath.row] objectForKey:@"date_subheading"] isEqual:@""])
    {
        return 85;
    }
    else
    {
        return 105;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return eventcount.count;
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
    
    
    
    if (eventcount!=nil) {
        
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 10, 200+30, 20)];
        
        
        nameLabel.backgroundColor=[UIColor clearColor];
        [nameLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:15.0]];
        nameLabel.numberOfLines=0;
        // [nameLabel sizeToFit];
        //  nameLabel.textAlignment=UITextAlignmentLeft;
        nameLabel.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1] ;
        
        nameLabel.text=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"game_title"] ;
        
        [cell.contentView addSubview:nameLabel];
        
        UIButton *checkbuttoninside=[UIButton buttonWithType:UIButtonTypeCustom];
        checkbuttoninside.frame=CGRectMake(285, 30, 30, 30);
        [cell.contentView addSubview:checkbuttoninside];
        
        UIButton *checkbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        checkbutton.frame=CGRectMake(278, 19, 42, 50);
        checkbutton.tag=15;
        [checkbutton addTarget:self action:@selector(subscription:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:checkbutton];
        
        
        UIImageView *clockImage = [[UIImageView alloc]initWithFrame:CGRectMake(40, 30, 25, 25)];
        clockImage.image=[UIImage imageNamed:@"timenew.png"];
        [cell.contentView addSubview:clockImage];
        
        UIImageView *homeImage = [[UIImageView alloc]initWithFrame:CGRectMake(40, 52, 25, 25)];
        homeImage.image=[UIImage imageNamed:@"location.png"];
        [cell.contentView addSubview:homeImage];
        
        
        UILabel *clocktime = [[UILabel alloc] initWithFrame:CGRectMake(67, 25, 200+12, 20+15)];
        
        clocktime.backgroundColor=[UIColor clearColor];
        clocktime.text=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"onlytime"] ;
        
        [clocktime setFont:[UIFont fontWithName:@"Lato-Regular" size:15.0]];
        clocktime.numberOfLines=0;
        // [nameLabel sizeToFit];
        //  nameLabel.textAlignment=UITextAlignmentLeft;
        clocktime.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1] ;
        [cell.contentView addSubview:clocktime];
        
        UILabel *hoster = [[UILabel alloc] initWithFrame:CGRectMake(67,45+2, 200+12, 20+15)];
        
        
        hoster.backgroundColor=[UIColor clearColor];
        hoster.text=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"event_location"] ;
        
        [hoster setFont:[UIFont fontWithName:@"Lato-Regular" size:15.0]];
        //hoster.numberOfLines=0;
        // [nameLabel sizeToFit];
        //  nameLabel.textAlignment=UITextAlignmentLeft;
        hoster.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1] ;
        [cell.contentView addSubview:hoster];
        
        
        
        NSString *subscription_status=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"subscription_status"];
        if ([subscription_status isEqualToString:@"yes"]) {
            
            [checkbuttoninside setImage:[UIImage imageNamed:@"check1.png"] forState:UIControlStateNormal];
            
        }
        else if ([subscription_status isEqualToString:@"no"])
        {
            [checkbuttoninside setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
            
        }
        UIImageView *typeImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 30, 30, 23)];
         typeImage.image = [UIImage imageNamed:@"athleticsnew.png"];
        [cell.contentView addSubview:typeImage];
        

        if (![[[eventcount objectAtIndex:indexPath.row] objectForKey:@"date_subheading"] isEqual:@""])
        {
            UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,0,320,20)];
            tempView.backgroundColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1] ;
            
            UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0,320,20)];
            tempLabel.backgroundColor=[UIColor clearColor];
            tempLabel.textColor = [UIColor whiteColor]; //here you can change the text color of header.
            tempLabel.textAlignment= NSTextAlignmentCenter;
            tempLabel.font = [UIFont fontWithName:@"Lato-Regular" size:15];
            tempLabel.font = [UIFont boldSystemFontOfSize:15];
            tempLabel.text=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"date_subheading"];
            [tempView addSubview:tempLabel];
            [cell.contentView addSubview:tempView];
            
            
            nameLabel.frame=CGRectMake(45, 30, 230, 20);
            checkbuttoninside.frame=CGRectMake(285, 50, 30, 30);
            checkbutton.frame=CGRectMake(278, 39, 42, 50);
            typeImage.frame=CGRectMake(5, 50, 30, 23);
            
            
            clockImage.frame=CGRectMake(40, 50, 25, 25);
            homeImage.frame= CGRectMake(40, 72, 25, 25);
            clocktime.frame= CGRectMake(67, 45, 200+12, 20+15);
            hoster.frame=CGRectMake(67,67, 200+12, 20+15);
            
            
        }
        
    }
    return cell;
}





- (void) subscription:(UIButton *) button
{
    UITableViewCell *cell = (UITableViewCell *)[[button superview] superview];
    buttonindexpath=[self.tableview indexPathForCell:cell];
    
    oldstatus=[[eventcount objectAtIndex:buttonindexpath.row] objectForKey:@"subscription_status"];
  NSString *eventid=[[eventcount objectAtIndex:buttonindexpath.row] objectForKey:@"id"];
    DLog(@"rowcount=%d",buttonindexpath.row);
    

    if ([oldstatus isEqualToString:@"yes"]) {
        newstatus=@"no";
        //   [checkImage setImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"uncheck.png"]]];
        
    }
    else if ([oldstatus isEqualToString:@"no"])
    {    newstatus=@"yes";
        //  [checkImage setImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"check1.png"]]];
    }
    
    NSMutableDictionary *new=[[NSMutableDictionary alloc] initWithDictionary:[eventcount objectAtIndex:buttonindexpath.row]];
    [new setValue:newstatus forKey:@"subscription_status"];
    [eventcount setObject:new atIndexedSubscript:buttonindexpath.row];

    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.frame=CGRectMake(button.frame.size.width/2-6, button.frame.size.height/2-6, 15, 15);
    [button addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
 //   DLog(@"useridprofile=%@",userid);
    DLog(@"eventid=%@",eventid);
    DLog(@"newstatus=%@",newstatus);
    subscribeevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:subscribeAthleticsEvents]] ;
    [subscribeevents setDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults valueForKey:@"userid"];
     DLog(@"userid=%@",uid);
    [subscribeevents setPostValue:uid forKey:@"userid"];
    [subscribeevents setPostValue:eventid forKey:@"eventid"];
    [subscribeevents setPostValue:newstatus forKey:@"subscribe"];
    [subscribeevents  startAsynchronous];
    
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (listofevents==nil && subscribeevents==nil && previousevents==nil)
    {

    NSString  *eventid=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"id"];
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.eventid=eventid;
    appDel.attendevent=TRUE;
     appDel.redirectfrom=@"";
     appDel.logid=@"";
    //[appDel addLoaderForViewController:self];
    DLog(@"eventid=%@",eventid);
    AthleticsEventPage *eventpageatend=[[AthleticsEventPage alloc] initWithNibName:@"AthleticsEventPage" bundle:nil];
    [self.navigationController pushViewController:eventpageatend animated:YES];
        
    }
}


- (void)viewDidUnload {
    [self setHeaderView:nil];
    [self setTableview:nil];
    [self setHeaderTitle:nil];
    [super viewDidUnload];
}
@end
