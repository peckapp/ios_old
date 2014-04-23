//
//  Activity.m
//  PeckApp
//
//  Created by SRM Techsol Pvt. Ltd. on 5/7/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "Activity.h"

@implementation Activity
@synthesize homescreen,headerView,tableview,menuOpen,eventcount;
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
      self.HeaderTitle.font = [UIFont boldSystemFontOfSize:self.HeaderTitle.font.pointSize];
    if (appDel.enterscreen)
    {
         eventcount = [[NSMutableArray alloc] init];
        [self initialload];
        [appDel addLoaderForViewController:self];
        startindex=0;
        appDel.siactivity=0;
        
        self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        // self.tableview.hidden=YES;
        listofevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:ActivityList]] ;
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
        NSData  *data= [defaults valueForKey:@"eventcountactivity"];
        NSMutableArray *object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        //[defaults synchronize];
        
        eventcount = [[NSMutableArray alloc] initWithArray:object];
        startindex=appDel.siactivity;
        
        if (eventcount.count==0)
        {
            self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:alertTitle message:appDel.erroralert delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            alert.tag=1;

        }
        
        else
        {
            self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            self.tableview.contentOffset=CGPointMake(0, appDel.activityscrollercontent);
        }
    }
    
}

-(void) initialload
{
   // AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    
    homescreen =[[HomeScreen alloc] initWithNibName:@"HomeScreen" bundle:nil];
    [self addChildViewController:homescreen];
    [self.view addSubview:homescreen.view];
    homescreen.NotificationCount.hidden=YES;
    homescreen.view.hidden=YES;
    self.tableview = [[PullTableViewFooter alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height-50) style:UITableViewStylePlain];// autorelease];
    self.tableview.pullDelegate =self;
    self.tableview.backgroundColor =[UIColor whiteColor] ;
    [self.view addSubview:tableview];
    
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
       self.tableview.showsVerticalScrollIndicator=NO;
    self.imageDownloadingQueue = [[NSOperationQueue alloc] init];
    self.imageDownloadingQueue.maxConcurrentOperationCount = 4; // many servers limit how many concurrent requests they'll accept from a device, so make sure to set this accordingly
    
    self.imageCache = [[NSCache alloc] init];
    
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    
    [self loadMoreDataToTable];
}

-(void) loadMoreDataToTable
{
    savestartindex=startindex;
   // startindex=startindex+Size;
    listofevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:ActivityList]] ;
    [listofevents setDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults valueForKey:@"userid"];
    [listofevents setPostValue:uid forKey:@"userid"];
    
    NSString *nextindex = [NSString stringWithFormat:@"%d", (int)startindex];
    
    DLog(@"nextindex=%@", nextindex);
    [listofevents setPostValue:nextindex forKey:@"start_limit"];
    [listofevents  startAsynchronous];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.menu=FALSE;
    appDel.enterscreen=FALSE;
    //  [homescreen.view removeFromSuperview];
    // [homescreen removeFromParentViewController];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    if (request==listofevents)
    {
        listofevents=nil;
        NSString *response  =  [[request responseString] stringByReplacingOccurrencesOfString:@"&#x27;" withString:@"'"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
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
            
            startindex=[[dict valueForKey:@"startlimit"] intValue];
            appDel.siactivity=startindex;
            

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
            [[NSUserDefaults standardUserDefaults] setObject:yourArrayAsData forKey:@"eventcountactivity"];
            [[NSUserDefaults standardUserDefaults] synchronize];
                
                DLog(@"department=%@",eventcount);
                DLog(@"department=%@",[[eventcount objectAtIndex:0] objectForKey:@"event_title"]);
                DLog(@"department=%@",[[eventcount objectAtIndex:0] objectForKey:@"event_image_url"]);
                
                DLog(@"departmentcount=%d",eventcount.count);
                
                //  DLog(@"count=%d",dict.count);
                // NSMutableArray  *deparmentcount = [dict objectForKey:@"id"];
                
                // NSLog(@"ob1=%@",deparmentcount);
                //  deparmentcount=[[dict objectForKey:@"d"] objectForKey:@"id"];
                
            
            
            
            self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            [self.tableview reloadData];
            self.tableview.hidden=NO;
        
        }
        else if ([[dict objectForKey:@"status"] isEqualToString:@"e"])
        {
            startindex=savestartindex;
             appDel.siactivity=startindex;
            
             self.tableview.hidden=NO;
            
            if (eventcount.count==0)
            {
                 self.tableview.scrollEnabled=NO;
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
                alert.tag=1;
                appDel.erroralert=[dict objectForKey:@"message"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"eventcountactivity"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
            else
            {
                
                 [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            }
            
            
        }
        
        else if (dict==nil)
        {
             startindex=savestartindex;
            appDel.siactivity=startindex;
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            if (eventcount.count==0)
            {
                alert.tag=1;
            }
            appDel.enterscreen=TRUE;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"eventcountactivity"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
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
                [[NSUserDefaults standardUserDefaults] setObject:yourArrayAsData forKey:@"eventcountactivity"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [self.tableview reloadData];
                [activityIndicator removeFromSuperview];
                [activityIndicator stopAnimating];
                
            }
            
            else if ([[dict objectForKey:@"status"] isEqualToString:@"e"])
            {
                
                [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                
            }

        }
        [appDel removeLoader];
        self.tableview.pullTableIsLoadingMore = NO;
    
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
   
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
   
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"eventcountactivity"];
    [[NSUserDefaults standardUserDefaults]synchronize];
   // NSString *response  =  [request responseString];
   // DLog(@"response=%@",response);
    
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
    
      startindex=savestartindex;
     appDel.siactivity=startindex;
    
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

}


#pragma mark alertview delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        if (buttonIndex==0)
        {
            
            [self closeActivity:nil];
            
        }
        
    }
    
}


- (IBAction)closeActivity:(id)sender
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
    
        appDel.activityscrollercontent=self.tableview.contentOffset.y;
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
        
        [menuclickbutton addTarget:self action:@selector(closeActivity:) forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark -
#pragma mark Table view data source

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    // To "clear" the footer view
    return [UIView new];
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return eventcount.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
   	for(UIView *customView in [cell.contentView subviews]){
        [customView removeFromSuperview];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
    if ([[[eventcount objectAtIndex:indexPath.row] objectForKey:@"read_status"] isEqual:@"yes"])
    {
        cell.contentView.backgroundColor=[UIColor colorWithRed:(240.0/255.0) green:(240.0/255.0) blue:(240.0/255.0) alpha:1] ;
        
    }
    
    else
    {
        cell.contentView.backgroundColor=[UIColor whiteColor] ;
    }

                
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 200+20, 20+20)];
        
        
        nameLabel.backgroundColor=[UIColor clearColor];
        
        [nameLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:15.0]];
        nameLabel.numberOfLines=0;
        // [nameLabel sizeToFit];
        //  nameLabel.textAlignment=UITextAlignmentLeft;
        nameLabel.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1] ;

        
        nameLabel.text=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"new_default_message"] ;
            
        [cell.contentView addSubview:nameLabel];
        
        UIImageView *typeImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 23, 30, 30)];
        [cell.contentView addSubview:typeImage];
        
               
        if ([[[eventcount objectAtIndex:indexPath.row] objectForKey:@"display_subscribe"] isEqual:@"yes"])
        {
            checkbuttoninside =[[UIButton alloc] init];
            checkbuttoninside=[UIButton buttonWithType:UIButtonTypeCustom];
            checkbuttoninside.frame=CGRectMake(280, 23, 30, 30);
            //  checkbuttoninside.center = CGPointMake(checkbutton.frame.size.width/2, checkbutton.frame.size.height/2);
            //  [checkbuttoninside addTarget:self action:@selector(subscription:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:checkbuttoninside];
            
            
            checkbutton =[[UIButton alloc] init];
            checkbutton=[UIButton buttonWithType:UIButtonTypeCustom];
            checkbutton.frame=CGRectMake(255, 2, 70, 70);
            checkbutton.tag=15;
            [checkbutton addTarget:self action:@selector(subscription:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:checkbutton];

            NSString *subscription_status=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"subscription_status"];
            if ([subscription_status isEqualToString:@"yes"])
            {
                
                [checkbuttoninside setImage:[UIImage imageNamed:@"check1.png"] forState:UIControlStateNormal];
                

    
            }
            else if ([subscription_status isEqualToString:@"no"])
            {
            [checkbuttoninside setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
                
            }
        }
       
        
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
        
            nameLabel.frame=CGRectMake(50, 30, 220, 40);
            typeImage.frame=CGRectMake(10, 33, 30, 30);
            if ([[[eventcount objectAtIndex:indexPath.row] objectForKey:@"display_subscribe"] isEqual:@"yes"])
            {
            checkbuttoninside.frame=CGRectMake(280, 33, 30, 30);
            checkbutton.frame=CGRectMake(255, 12, 70, 70);
            }
        
        }
        
        NSString *imageurl=  [[eventcount objectAtIndex:indexPath.row] objectForKey:@"sender_profile_image_url"];
        UIImage *cachedImage = [self.imageCache objectForKey:imageurl];
        if ([imageurl isEqual:@""])
        {
            typeImage.image = [UIImage imageNamed:@"activity_listing.png"];
        }
        else
        {
            
            if (cachedImage)
            {
                typeImage.image = cachedImage;
            }
            else
            {
                // you'll want to initialize the image with some blank image as a placeholder
                UIActivityIndicatorView *eventimageloading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
                eventimageloading.center = CGPointMake(typeImage.frame.size.width/2, typeImage.frame.size.height/2);
                eventimageloading.alpha = 1.0;
                eventimageloading.hidesWhenStopped = YES;
                [eventimageloading startAnimating];
                
                typeImage.image = [UIImage imageNamed:@"activity_listing.png"];
                [typeImage addSubview:eventimageloading];
                
                // now download in the image in the background
                
                [self.imageDownloadingQueue addOperationWithBlock:^{
                    
                    NSURL *imageUrl   = [NSURL URLWithString:imageurl];
                    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
                    UIImage *image    = nil;
                    if (imageData)
                        image = [UIImage imageWithData:imageData];
                    
                    if (image)
                    {
                        // add the image to your cache
                        
                        [self.imageCache setObject:image forKey:imageurl];
                        
                        // finally, update the user interface in the main queue
                        
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            // make sure the cell is still visible
                            
                            UITableViewCell *updateCell = [tableView cellForRowAtIndexPath:indexPath];
                            if (updateCell)
                                typeImage.image = image;
                        
                        }];
                    }
                    [eventimageloading removeFromSuperview];
                    [eventimageloading stopAnimating];

                }];
            }
            
            
        }
        
    
       return cell;
}


- (void) subscription:(UIButton *) button
{
    UITableViewCell *cell = (UITableViewCell *)[[button superview] superview];
    buttonindexpath=[self.tableview indexPathForCell:cell];
    
    oldstatus=[[eventcount objectAtIndex:buttonindexpath.row] objectForKey:@"subscription_status"];
    NSString *eventid=[[eventcount objectAtIndex:buttonindexpath.row] objectForKey:@"event_id"];
    
    
    DLog(@"rowcount=%d",buttonindexpath.row);
    
    
    //  [button setImage:nil forState:UIControlStateNormal];
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
    // DLog(@"dictionary=%@",[eventcount objectAtIndex:buttonindexpath.row]);
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.frame=CGRectMake(button.frame.size.width/2-2, button.frame.size.height/2-6, 15, 15);
    [button addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    //[activityIndicator setCenter:CGPointMake(button.frame.size.width/2, button.frame.size.height/2)];
    [button addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    
    subscribeevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:followMyHorizon]] ;
    [subscribeevents setDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults valueForKey:@"userid"];
    DLog(@"useridprofile=%@",uid);
    DLog(@"eventid=%@",eventid);
    DLog(@"newstatus=%@",newstatus);
    [subscribeevents setPostValue:uid forKey:@"userid"];
    [subscribeevents setPostValue:eventid forKey:@"eventid"];
    [subscribeevents setPostValue:newstatus forKey:@"subscribe"];
     [subscribeevents setPostValue:[[eventcount objectAtIndex:buttonindexpath.row] objectForKey:@"activity_type"] forKey:@"category"];
    [subscribeevents  startAsynchronous];

       
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (listofevents==nil && subscribeevents==nil)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.contentView.backgroundColor=[UIColor colorWithRed:(240.0/255.0) green:(240.0/255.0) blue:(240.0/255.0) alpha:1] ;
        
        NSMutableDictionary *new=[eventcount objectAtIndex:indexPath.row];
        [new setValue:@"yes" forKey:@"read_status"];
        [eventcount setObject:new atIndexedSubscript:indexPath.row];
        
        NSData *yourArrayAsData = [NSKeyedArchiver archivedDataWithRootObject:eventcount];
        [[NSUserDefaults standardUserDefaults] setObject:yourArrayAsData forKey:@"eventcountactivity"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    NSString  *event=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"open_to"];
     NSString  *eventid=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"open_with"];
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.eventid=eventid;
   appDel.logid=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"log_id"];
    appDel.redirectfrom=@"redirectfrom";
    appDel.activityOpen=TRUE;
    if ([event isEqual:@"campusevents"])
    {
         appDel.attendevent=TRUE;
    EventPageAttend *eventpageattend=[[EventPageAttend alloc] initWithNibName:@"EventPageAttend" bundle:nil];
        [self.navigationController pushViewController:eventpageattend animated:YES];
    }
    
    else if ([event isEqual:@"athletics"])
    {
         appDel.attendevent=TRUE;
        AthleticsEventPage *eventpageattend=[[AthleticsEventPage alloc] initWithNibName:@"AthleticsEventPage" bundle:nil];
        [self.navigationController pushViewController:eventpageattend animated:YES];
    }
    
    else if ([event isEqual:@"campusforum"])
    {
        AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
        appDel.enterFromForum=TRUE;
        
        ForumPage *forumpage=[[ForumPage alloc]initWithNibName:@"ForumPage" bundle:nil];
        [[self navigationController]pushViewController:forumpage animated:YES];

    }
    
    else if ([event isEqual:@"athleticforum"])
    {
        appDel.enterFromForum=TRUE;
        
        AthleticForumPage *forumpage=[[AthleticForumPage alloc]initWithNibName:@"AthleticForumPage" bundle:nil];
        [[self navigationController]pushViewController:forumpage animated:YES];
        
    }
    
    else if ([event isEqual:@"circles"])
    {
        appDel.circleid=eventid;
        appDel.enterFromCircle=TRUE;
        ViewCircles *viewcircles=[[ViewCircles alloc] initWithNibName:@"ViewCircles" bundle:nil];
    [[self navigationController]pushViewController:viewcircles animated:YES];

        //[self presentModalViewController:viewcircles animated:YES];
    }

    }
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
    //  homescreen =[[HomeScreen alloc] initWithNibName:@"HomeScreen" bundle:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTableview:nil];
   
    [self setHeaderView:nil];
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
