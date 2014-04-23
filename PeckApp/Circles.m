//
//  Circles.m
//  PeckApp
//
//  Created by SRM Techsol Pvt. Ltd. on 5/7/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "Circles.h"

@implementation Circles
@synthesize headerView,tableview,findPersonOrGroup,menuOpen,eventcount;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) viewWillAppear:(BOOL)animated
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    self.HeaderTitle.font = [UIFont boldSystemFontOfSize:self.HeaderTitle.font.pointSize];
    if (appDel.enterscreen)
    {
        eventcount = [[NSMutableArray alloc] init];
        [self initialload];
        [appDel addLoaderForViewController:self];
        self.tableview.hidden=YES;
        listofevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:mycircleListing]] ;
        [listofevents setDelegate:self];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *uid = [defaults valueForKey:@"userid"];
        [listofevents setPostValue:uid forKey:@"userid"];
        // [listofevents setPostValue:@"0" forKey:@"start_limit"];
        [listofevents  startAsynchronous];
        
    }
    
    else if (appDel.menu)
    {
        [self initialload];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray  *eventcountnew= [defaults valueForKey:@"eventcountcircles"];
        [defaults synchronize];
        eventcount = [[NSMutableArray alloc] initWithArray:eventcountnew];
        tableArray=[[NSMutableArray alloc] initWithArray:eventcount];
        startindex=eventcount.count;
        if (eventcount.count==0)
        {
            self.tableview.scrollEnabled=NO;
             self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
            [[[UIAlertView alloc]initWithTitle:alertTitle message:appDel.erroralert delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            
        }
        
        else
        {
             self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            self.tableview.contentOffset=CGPointMake(0, appDel.circlesscrollercontent);
        }
    }
    
    
    
    
}

-(void) initialload
{
    //AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    
    homescreen =[[HomeScreen alloc] initWithNibName:@"HomeScreen" bundle:nil];
    [self addChildViewController:homescreen];
    homescreen.view.hidden=YES;
    [self.view addSubview:homescreen.view];
  //  homescreen.NotificationCount.hidden=YES;
  //   homescreen.NotificationCount.text=appDel.activtynotificationcount;
    
    
    //    self.tableview = [[PullTableView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100) style:UITableViewStylePlain];// autorelease];
    //    self.tableview.pullDelegate =self;
    //    self.tableview.backgroundColor =[UIColor colorWithRed:(73.0/255.0) green:(73.0/255.0) blue:(73.0/255.0) alpha:1.0];
    //    [self.view addSubview:tableview];
    //
    //    self.tableview.dataSource = self;
    //    self.tableview.delegate = self;
    //self.tableview.pullDelegate =self;
    
    self.imageDownloadingQueue = [[NSOperationQueue alloc] init];
    self.imageDownloadingQueue.maxConcurrentOperationCount = 4; // many servers limit how many concurrent requests they'll accept from a device, so make sure to set this accordingly
    
    self.imageCache = [[NSCache alloc] init];
    [findPersonOrGroup addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
}


- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    
    [self loadMoreDataToTable];
}

-(void) loadMoreDataToTable
{
    savestartindex=startindex;
    startindex=startindex+Size;
    listofevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:mycircleListing]] ;
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
    appDel.enterscreen=FALSE;
    appDel.enterFromCircle=FALSE;
    appDel.menu=FALSE;
    [self.findPersonOrGroup resignFirstResponder];
    // [homescreen.view removeFromSuperview];
    //[homescreen removeFromParentViewController];
    
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    if (request==listofevents)
    {
        NSString *response  =  [request responseString];
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
            
            
            
            // [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"eventcountofmyhorizon"];
            //  [[NSUserDefaults standardUserDefaults]synchronize];
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
            
            NSSortDescriptor *sorter = [[NSSortDescriptor alloc]
                                        initWithKey:@"circle_name"
                                        ascending:YES
                                        selector:@selector(localizedCaseInsensitiveCompare:)];
            NSArray *sortDescriptors = [NSArray arrayWithObject: sorter];
            [eventcount sortUsingDescriptors:sortDescriptors];
            DLog(@"array=%@",eventcount);
            tableArray=[[NSMutableArray alloc] initWithArray:eventcount];
            DLog(@"displayarray=%@",tableArray);
            
            [[NSUserDefaults standardUserDefaults] setValue:eventcount forKey:@"eventcountcircles"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            DLog(@"department=%@",eventcount);
            DLog(@"department=%@",[[eventcount objectAtIndex:0] objectForKey:@"event_title"]);
            DLog(@"department=%@",[[eventcount objectAtIndex:0] objectForKey:@"event_image_url"]);
            
            DLog(@"departmentcount=%d",eventcount.count);
            
            //  DLog(@"count=%d",dict.count);
            // NSMutableArray  *deparmentcount = [dict objectForKey:@"id"];
            
            // NSLog(@"ob1=%@",deparmentcount);
            //  deparmentcount=[[dict objectForKey:@"d"] objectForKey:@"id"];
            
            if (eventcount.count>0)
            {
                 self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            }
            [self.tableview reloadData];
            self.tableview.hidden=NO;
            
            
            
        }
        
        if ([[dict objectForKey:@"status"] isEqual:@"e"])
        {
            startindex=savestartindex;
            self.tableview.hidden=NO;
            [self.tableview reloadData];
            if (eventcount.count==0)
            {
                self.tableview.scrollEnabled=NO;
                
                [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                
                appDel.erroralert=[dict objectForKey:@"message"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"eventcountcircles"];
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
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            if (eventcount.count==0)
            {
                alert.tag=1;
            }
            appDel.enterscreen=TRUE;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"eventcountcircles"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
        
        //  self.tableview.pullTableIsLoadingMore = NO;
        
    }
    
    
    if (request==deletecircle)
    {
        deletecircle=nil;
        NSString *response  =  [request responseString];
        DLog(@"response=%@",response);
    
        NSMutableDictionary *dict=[response JSONValue];
        DLog(@"status=%@", [dict objectForKey:@"status"]);
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
        
                [eventcount removeObjectAtIndex:circleindexpath.row];
                [self.tableview reloadData];
                [[NSUserDefaults standardUserDefaults] setValue:eventcount forKey:@"eventcountcircles"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                if (eventcount.count==0)
                {
                    
                    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
                    appDel.erroralert=@"There are no Circles in your list.";
                    [[[UIAlertView alloc]initWithTitle:alertTitle message:appDel.erroralert delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
                    
                
                
            }
            
            //  [self.navigationController popViewControllerAnimated:YES];
            /*  CampusEventsViewController *events=[[CampusEventsViewController alloc]initWithNibName:@"CampusEventsViewController" bundle:nil];
             [[self navigationController]pushViewController:events animated:YES];
             */
            
        }
        
        else  if ([[dict objectForKey:@"status"] isEqual:@"e"])
        {
            [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            
        }
        
    }
    
    
    
    [appDel removeLoader];
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    
  //  NSString *response  =  [request responseString];
  //  DLog(@"response=%@",response);
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.erroralert=@"Network is not Reachable";
    [appDel removeLoader];
    if (eventcount.count==0)
    {
        alert.tag=1;
        
    }
    appDel.enterscreen=TRUE;
    self.tableview.hidden=NO;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"eventcountcircles"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
}

#pragma mark alertview delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1)
    {
        if (buttonIndex==0)
        {
            
            [self circlesClosed:nil];
            
        }
        
    }
    
}



#pragma TextField Delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.findPersonOrGroup.placeholder=@"";
    singleTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGesture:)];
    [self.view addGestureRecognizer:singleTap];
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.view removeGestureRecognizer:singleTap];
    
    if ([self.findPersonOrGroup.text isEqual:@""])
    {
        self.findPersonOrGroup.placeholder=@"Find a Circle";
    }
    
    
}

- (IBAction)singleTapGesture:(UITextField *) textField{
    
    [self.findPersonOrGroup resignFirstResponder];
    
    
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    [self.findPersonOrGroup resignFirstResponder];
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void) textDidChange:(id)sender
{
    
    findPersonOrGroup = (UITextField *) sender;
    if (findPersonOrGroup.text.length==0)
    {
        eventcount=tableArray;
        
    }
    else
    {
        eventcount=tableArray;
        NSMutableArray *filterarray=[[NSMutableArray alloc]init];
        //    [filterarray removeAllObjects];
        // NSArray *filterContacts = [[NSArray alloc]init];
        NSString *match=self.findPersonOrGroup.text;
        match = [match lowercaseString];
        
        
        for(int i=0; i<[eventcount count]; i++){
            
            // NSMutableArray *filterarray=[[NSMutableArray alloc]init];
            NSString *match=self.findPersonOrGroup.text;
            match = [match lowercaseString];
            NSString *department = [[eventcount objectAtIndex:i] valueForKey:@"circle_name"];
            department = [department lowercaseString];
              NSRange range = [department rangeOfString:match options:NSCaseInsensitiveSearch];
            ///addressRange=[address rangeOfString:match options:NSCaseInsensitiveSearch];
            if (range.location==0)
            {
                [filterarray addObject:[eventcount objectAtIndex:i]];
            }
            
            
            
            
        }
        
        eventcount=filterarray;
        
    }
    
    if ([self.findPersonOrGroup.text isEqual:@""])
    {
        self.findPersonOrGroup.placeholder=@"Find a Circle";
    }
    
    [self.tableview reloadData];
    
}



- (IBAction)createCircles:(id)sender
{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.enterFromCircle=TRUE;
    CreateCircle *circle=[[CreateCircle alloc]initWithNibName:@"CreateCircle" bundle:nil];
    [self presentViewController:circle animated:YES completion:nil];
    //[self presentModalViewController:circle animated:YES];
    
    
    
}



- (IBAction)closeCircles:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self dismissModalViewControllerAnimated:YES];
    
    
}

-(IBAction)circlesClosed:(id)sender
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [self.findPersonOrGroup resignFirstResponder];
    
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
        appDel.circlesscrollercontent=self.tableview.contentOffset.y;
        frame.origin.x = 320-70;
        homescreen.view.hidden=NO;
        menuclickbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        if (self.tableview.contentSize.height<=[[UIScreen mainScreen] bounds].size.height-self.headerView.frame.size.height-50)
        {
            menuclickbutton.frame=CGRectMake(0,0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-self.headerView.frame.size.height);
        }
        else
        {
            menuclickbutton.frame=CGRectMake(0,0, [[UIScreen mainScreen] bounds].size.width,  self.tableview.contentSize.height);
            
        }
        
        [menuclickbutton addTarget:self action:@selector(circlesClosed:) forControlEvents:UIControlEventTouchUpInside];
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
#pragma mark Tableview delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
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



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
   	}
   	for(UIView *customView in [cell.contentView subviews]){
        [customView removeFromSuperview];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50+20+5, 30-10, 200, 20)];
    nameLabel.backgroundColor=[UIColor clearColor];
    
        nameLabel.text=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"circle_name"];
        
    
    [nameLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:18.0]];
    nameLabel.numberOfLines=0;
    
    nameLabel.textColor=[UIColor whiteColor];
    [cell.contentView addSubview:nameLabel];
    //
    //    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 37, 200, 20)];
    //    nameLabel.backgroundColor=[UIColor clearColor];
    //    nameLabel.text=@"Carrier Services";
    //    [nameLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0]];
    //    nameLabel.textColor=[UIColor whiteColor];
    //    [cell.contentView addSubview:nameLabel];
    
    UIImageView *typeImage = [[UIImageView alloc]initWithFrame:CGRectMake(23, 23-7, 30, 30)];
    
    NSString *imageurl=  [[eventcount objectAtIndex:indexPath.row] objectForKey:@"circle_picture"];
    UIImage *cachedImage = [self.imageCache objectForKey:imageurl];
    if ([imageurl isEqualToString:@""])
    {
        
        typeImage.image = [UIImage imageNamed:@"circles1.png"];
    }
    else {
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
            
            typeImage.image = [UIImage imageNamed:@"circles1.png"];
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
    
    
    [cell.contentView addSubview:typeImage];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.circleid=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"cid"];
    appDel.enterFromCircle=TRUE;
    appDel.redirectfrom=@"";
    appDel.logid=@"";
    //[appDel addLoaderForViewController:self];
    DLog(@"circleid=%@",appDel.circleid);
    ViewCircles *viewcircles=[[ViewCircles alloc] initWithNibName:@"ViewCircles" bundle:nil];
    [self.navigationController pushViewController:viewcircles animated:YES];
    //[self presentModalViewController:viewcircles animated:YES];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //add code here for when you hit delete
        
            circleindexpath=indexPath;
            AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
            [appDel addLoaderForViewController:self];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *uid = [defaults valueForKey:@"userid"];

            deletecircle =  [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:deleteCircle]] ;
            [deletecircle setDelegate:self];
            [deletecircle setPostValue:uid forKey:@"userid"];
            [deletecircle setPostValue:[[eventcount objectAtIndex:indexPath.row] objectForKey:@"cid"] forKey:@"circleid"];
            [deletecircle startAsynchronous];
            
                
        
    }
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setFindPersonOrGroup:nil];
    [self setTableview:nil];
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
