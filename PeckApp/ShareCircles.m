//
//  CreateCircle.m
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 5/22/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "inviteFriends.h"

@interface inviteFriends ()

@end

@implementation ShareCircles
@synthesize imageCache,imageDownloadingQueue,eventcount,findPersonOrGroup,listofevents,tableview,activity;
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
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)closeShareCircle:(id)sender
{
      
    [self.activity activityDidFinish:YES];

    

}
-(IBAction) shareCircles:(id)sender
{
    
    [self.findPersonOrGroup resignFirstResponder];
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [self.findPersonOrGroup resignFirstResponder];
    tickCircleCount=[[NSMutableArray alloc] init];
    // DLog(@"ec=%@",eventcount);
    for (int i=0; i<saveeventcount.count; i++)
    {
        status= [[saveeventcount objectAtIndex:i] objectForKey:@"status"];
        if ([status isEqualToString:@"yes"])
        {
            [tickCircleCount addObject:[[saveeventcount objectAtIndex:i] objectForKey:@"displaypost"]];
            
        }
    }
    // appDel.circlecount=tickCircleCount.count;
    appDel.listcircle = [tickCircleCount componentsJoinedByString:@","];
    DLog(@"list=%@", appDel.listcircle);
    [appDel addLoaderForViewController:self];
    
    shareeventcircle=   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:ShareCircleSubmit]] ;
    [shareeventcircle setDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults valueForKey:@"userid"];
    [shareeventcircle setPostValue:uid forKey:@"userid"];
    [shareeventcircle setPostValue:appDel.eventid forKey:@"eventid"];
   // DLog(@"eid=%@",appDel.eventid);
    [shareeventcircle setPostValue:appDel.listcircle forKey:@"circle_members"];
    DLog(@"dep=%@",appDel.eventdepartment);
    [shareeventcircle setPostValue:appDel.eventdepartment forKey:@"type"];
    [shareeventcircle  startAsynchronous];

 
    
}


-(void) viewWillAppear:(BOOL)animated
{
   
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
     
      self.HeaderTitle.font = [UIFont boldSystemFontOfSize:self.HeaderTitle.font.pointSize];
    if (appDel.enterFromCircle) {
        
          [appDel addLoaderForViewController:self];
        listofevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:ShareCircleListing]] ;
        [listofevents setDelegate:self];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *uid = [defaults valueForKey:@"userid"];
        [listofevents setPostValue:uid forKey:@"userid"];
        [listofevents setPostValue:appDel.eventdepartment forKey:@"type"];
         [listofevents setPostValue:appDel.eventid forKey:@"eventid"];
        DLog(@"uid=%@",uid);
        //[listofevents setPostValue:@"0" forKey:@"start_limit"];
        [listofevents  startAsynchronous];
        eventcount=[[NSMutableArray alloc] init];
        saveeventcount=[[NSMutableArray alloc] init];
        //self.tableview = [[PullTableView alloc] initWithFrame:CGRectMake(0, 98, self.view.bounds.size.width,  self.view.bounds.size.height-98) style:UITableViewStylePlain];// autorelease];
        //self.tableview.pullDelegate =self;
       // self.tableview.backgroundColor =[UIColor colorWithRed:(73.0/255.0) green:(73.0/255.0) blue:(73.0/255.0) alpha:1.0];
        
       // [self.view addSubview:tableview];
        self.tableview.dataSource = self;
        self.tableview.delegate = self;
       // self.tableview.pullDelegate =self;
     
        
        self.imageDownloadingQueue = [[NSOperationQueue alloc] init];
        self.imageDownloadingQueue.maxConcurrentOperationCount = 4; // many servers limit how many concurrent requests they'll accept from a device, so make sure to set this accordingly
        
        self.imageCache = [[NSCache alloc] init];
        [findPersonOrGroup addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        
    }
    
    
}

//- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
//{
//    
//    [self loadMoreDataToTable];
//}
//
//-(void) loadMoreDataToTable
//{
//    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
//    savestartindex=startindex;
//    startindex=startindex+Size;
//    listofevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:allcircleListing]] ;
//    [listofevents setDelegate:self];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *uid = [defaults valueForKey:@"userid"];
//    [listofevents setPostValue:uid forKey:@"userid"];
//    
//    NSString *nextindex = [NSString stringWithFormat:@"%d", (int)startindex];
//    
//    DLog(@"nextindex=%@", nextindex);
//    [listofevents setPostValue:nextindex forKey:@"start_limit"];
//    [listofevents  startAsynchronous];
//    
//}



-(void) viewDidDisappear:(BOOL)animated
{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.enterFromCircle=FALSE;
}

-(void) viewWillDisappear:(BOOL)animated
{
    
    [self.findPersonOrGroup resignFirstResponder];
    
    
}

# pragma TextField Delegates

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
            NSString *department = [[eventcount objectAtIndex:i] valueForKey:@"final_name"];
            department = [department lowercaseString];
            NSRange range = [department rangeOfString:match options:NSCaseInsensitiveSearch];
        if (range.location==0) {
                [filterarray addObject:[eventcount objectAtIndex:i]];
            }
            
        
        }
        
        eventcount=filterarray;
        
    }
    
    if ([self.findPersonOrGroup.text isEqual:@""])
    {
        self.findPersonOrGroup.placeholder=@"Find a person or group";
    }
    
    [self.tableview reloadData];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    textField.placeholder=@"";
    singleTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGesture:)];
    [self.view addGestureRecognizer:singleTap];
    

    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.view removeGestureRecognizer:singleTap];
    
        if ([self.findPersonOrGroup.text isEqual:@""])
        {
            self.findPersonOrGroup.placeholder=@"Find a person or group";
        }
    
}



-(IBAction)singleTapGesture:(UITextField *) textField
{
    
    [self.findPersonOrGroup resignFirstResponder];

    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
                                        initWithKey:@"final_name"
                                        ascending:YES
                                        selector:@selector(localizedCaseInsensitiveCompare:)];
            NSArray *sortDescriptors = [NSArray arrayWithObject: sorter];
            [eventcount sortUsingDescriptors:sortDescriptors];
            DLog(@"array=%@",eventcount);
             saveeventcount=eventcount;
            tableArray=[[NSMutableArray alloc] initWithArray:eventcount];
            DLog(@"displayarray=%@",tableArray);
            
            // [[NSUserDefaults standardUserDefaults] setValue:eventcount forKey:@"eventcountofmyhorizon"];
            //  [[NSUserDefaults standardUserDefaults] synchronize];
            
            DLog(@"department=%@",eventcount);
            DLog(@"department=%@",[[eventcount objectAtIndex:0] objectForKey:@"event_title"]);
            DLog(@"department=%@",[[eventcount objectAtIndex:0] objectForKey:@"event_image_url"]);
            
            DLog(@"departmentcount=%d",eventcount.count);
            
            //  DLog(@"count=%d",dict.count);
            // NSMutableArray  *deparmentcount = [dict objectForKey:@"id"];
            
            // NSLog(@"ob1=%@",deparmentcount);
            //  deparmentcount=[[dict objectForKey:@"d"] objectForKey:@"id"];
             //self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            [self.tableview reloadData];
           
    
        }
        
        
        if ([[dict objectForKey:@"status"] isEqual:@"e"])
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            alert.tag=1;
        }
        
        else if (dict==nil)
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            if (eventcount.count==0)
            {
                alert.tag=1;
            }
        }
         //self.tableview.pullTableIsLoadingMore=NO;
        [appDel removeLoader];
    }
    
    
    if (request==shareeventcircle)
    {
        NSString *response  =  [request responseString];
        
        DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
        DLog(@"status=%@",[dict objectForKey:@"status"]);
        
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
            
          [self.activity activityDidFinish:YES];
        }
        else if ([[dict objectForKey:@"status"] isEqual:@"e"])
        {
            [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];

        }
       [appDel removeLoader];   
    }
    
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    [[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
   // NSString *response  =  [request responseString];
    // http://install.diawi.com/VdYZfRDLog(@"response=%@",response);
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel removeLoader];
   
    //self.tableview.pullTableIsLoadingMore=NO;
    //  [activityIndicator stopAnimating];
    //  [activityIndicator removeFromSuperview];
    //  [[eventcount objectAtIndex:buttonindexpath.row] setValue:oldstatus forKey:@"subscription_status"];
    
}

#pragma mark alertview delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        if (buttonIndex==0)
        {
            
          [self dismissViewControllerAnimated:YES completion:nil];
            
        }
        
    }
    
}

#pragma mark -
#pragma mark Tableview Delegates

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    // To "clear" the footer view
    return [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(IBAction)campusEventsButtonClosed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section    {
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
     cell.backgroundColor=[UIColor clearColor];
    
    UIButton *checkbuttoninside =[UIButton buttonWithType:UIButtonTypeCustom];
    checkbuttoninside.frame=CGRectMake(270, 16, 30, 30);
    //  checkbuttoninside.center = CGPointMake(checkbutton.frame.size.width/2, checkbutton.frame.size.height/2);
    //  [checkbuttoninside addTarget:self action:@selector(subscription:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:checkbuttoninside];
    
    
    UIButton *checkbutton =[UIButton buttonWithType:UIButtonTypeCustom];
    checkbutton.frame=CGRectMake(245, 2-4, 70, 70);
    checkbutton.tag=15;
    [checkbutton addTarget:self action:@selector(subscription:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:checkbutton];
    
    NSString *subscription_status=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"status"];
    if ([subscription_status isEqualToString:@"yes"]) {
        
        [checkbuttoninside setImage:[UIImage imageNamed:@"check1.png"] forState:UIControlStateNormal];
        
    }
    else if ([subscription_status isEqualToString:@"no"])
    {
        [checkbuttoninside setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        
    }
    
    
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50+20+5, 30-10, 190, 20)];
    nameLabel.backgroundColor=[UIColor clearColor];
    nameLabel.text=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"final_name"];
    
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
    
    UIImageView *typeImage = [[UIImageView alloc]initWithFrame:CGRectMake(23, 16, 30, 30)];
    // typeImage.frame=CGRectMake(10, 23, 30, 30);
    //  [typeImage setImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"circles.png"]]];
    
    
    NSString *imageurl=  [[eventcount objectAtIndex:indexPath.row] objectForKey:@"display_image"];
    UIImage *cachedImage = [self.imageCache objectForKey:imageurl];
    
    if ([imageurl isEqualToString:@""]) {
        
        
        if (![[[eventcount objectAtIndex:indexPath.row] objectForKey:@"uid"] intValue]==0)
        {
            typeImage.image = [UIImage imageNamed:@"noimage.png"];
        }
        
        else
        {
            typeImage.image = [UIImage imageNamed:@"circles.png"];
        }
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
            
            typeImage.image = [UIImage imageNamed:@"noimage.png"];
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

- (void) subscription:(UIButton *) button
{
    UITableViewCell *cell = (UITableViewCell *)[[button superview] superview];
    buttonindexpath=[self.tableview indexPathForCell:cell];
    // button.tag=checkbuttoninside.tag;
    // checkbuttoninside=button;
    // checkbuttoninside.tag=buttonindexpath;
    status=[[eventcount objectAtIndex:buttonindexpath.row] objectForKey:@"status"];
    departmentid=[[eventcount objectAtIndex:buttonindexpath.row] objectForKey:@"id"];
    DLog(@"rowcount=%d",buttonindexpath.row);
    
    
    
    // self.backButton.userInteractionEnabled=NO;
    if ([status isEqualToString:@"yes"]) {
        status=@"no";
        
        [button setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        
        
    }
    else if ([status isEqualToString:@"no"])
    {
        status=@"yes";
        //   tickCircleCount addObject:<#(id)#>
        [button setImage:[UIImage imageNamed:@"check1.png"] forState:UIControlStateNormal];
    }
    
    [[eventcount objectAtIndex:buttonindexpath.row] setValue:status forKey:@"status"];
    [self.tableview reloadData];
    
    NSString *uid=  [[eventcount objectAtIndex:buttonindexpath.row] objectForKey:@"uid"];
    NSString *cid=  [[eventcount objectAtIndex:buttonindexpath.row] objectForKey:@"cid"];

    for (int i=0; i<saveeventcount.count; i++)
    {
        if ([uid isEqual:[[saveeventcount objectAtIndex:i] objectForKey:@"uid"]] && [cid isEqual:[[saveeventcount objectAtIndex:i] objectForKey:@"cid"]])
        {
            DLog(@"index=%d",i);
            [[saveeventcount objectAtIndex:i] setValue:status forKey:@"status"];
        }
    }
    DLog(@"ecSubcribe=%@",saveeventcount);
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    // appDel.enterFromCircle=TRUE;
    // appDel.enterFromViewCircle=TRUE;
    // appDel.attendevent=TRUE;
    //[appDel addLoaderForViewController:self];
    if ([[[eventcount objectAtIndex:indexPath.row] objectForKey:@"type"] isEqual:@"circle"]) {
        appDel.enterFromCircle=TRUE;
        appDel.circleid=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"cid"];
        ViewCircles *viewcircles=[[ViewCircles alloc] initWithNibName:@"ViewCircles" bundle:nil];
        [self presentViewController:viewcircles animated:YES completion:nil];
        //[self presentModalViewController:viewcircles animated:YES];
        
        
    }
    else  if ([[[eventcount objectAtIndex:indexPath.row] objectForKey:@"type"] isEqual:@"name"])
    {
        appDel.enterscreen=TRUE;
        appDel.profileid=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"uid"];
        ViewProfile *profile=[[ViewProfile alloc] initWithNibName:@"ViewProfile" bundle:nil];
         [self presentViewController:profile animated:YES completion:nil];
        //[self presentModalViewController:profile animated:YES];
        
    }
    DLog(@"circleid=%@",appDel.circleid);
    
}


- (void)viewDidUnload
{
    [self setFindPersonOrGroup:nil];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
