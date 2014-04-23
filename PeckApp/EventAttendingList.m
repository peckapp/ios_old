//
//  ViewCircles.m
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 6/7/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "EventAttendingList.h"

@interface EventAttendingList ()

@end

@implementation EventAttendingList
@synthesize tableview,ProfileName,circleImage,profileImage;
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




-(IBAction) closeEventAttending:(id)sender
{
   [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(void) viewWillAppear:(BOOL)animated
{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    DLog(@"eid=%@",appDel.eventid);
    DLog(@"edep=%@",appDel.eventdepartment);
     self.eventtitle.font = [UIFont boldSystemFontOfSize:self.eventtitle.font.pointSize];
    if (appDel.enterFromEvent) {
        if ([appDel.eventdepartment isEqual:@"athletics"])
        {
            listofevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:AthleticEventAttendingMemberList]] ;
        }
        else
        {
            listofevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:EventAttendingMemberList]] ;
        }
        
        [listofevents setDelegate:self];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *uid = [defaults valueForKey:@"userid"];
        [listofevents setPostValue:uid forKey:@"userid"];
        [listofevents setPostValue:appDel.eventid forKey:@"eventid"];
        [listofevents setPostValue:@"0" forKey:@"start_limit"];
        
        [listofevents  startAsynchronous];
        eventcount = [[NSMutableArray alloc] init];
        
        self.tableview = [[PullTableViewFooter alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width,  self.view.bounds.size.height-50) style:UITableViewStylePlain];// autorelease];
        self.tableview.pullDelegate =self;
        self.tableview.backgroundColor =[UIColor whiteColor];
        [self.view addSubview:tableview];
        self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        self.tableview.dataSource = self;
        self.tableview.delegate = self;
        self.tableview.pullDelegate =self;
        [appDel addLoaderForViewController:self];
        self.imageDownloadingQueue = [[NSOperationQueue alloc] init];
        self.imageDownloadingQueue.maxConcurrentOperationCount = 4; // many servers limit how many concurrent requests they'll accept from a device, so make sure to set this accordingly
        
        self.imageCache = [[NSCache alloc] init];
        

    }
    
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.enterFromEvent=FALSE;
}


- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    
    [self loadMoreDataToTable];
}

-(void) loadMoreDataToTable
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    startindex=startindex+Size;
    if ([appDel.eventdepartment isEqual:@"athletics"]) {
        listofevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:AthleticEventAttendingMemberList]] ;
    }
    else  {
        listofevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:EventAttendingMemberList]] ;
    }
    [listofevents setDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults valueForKey:@"userid"];
    [listofevents setPostValue:uid forKey:@"userid"];
    [listofevents setPostValue:appDel.eventid forKey:@"eventid"];
    
    NSString *nextindex = [NSString stringWithFormat:@"%d", (int)startindex];
    
    DLog(@"nextindex=%@", nextindex);
    [listofevents setPostValue:nextindex forKey:@"start_limit"];
    [listofevents  startAsynchronous];
    
}



-(void) viewDidDisappear:(BOOL)animated
{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.enterFromCircle=FALSE;
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    if (request==listofevents)
    {
        
        NSString *response  =  [[request responseString] stringByReplacingOccurrencesOfString:@"&#x27;" withString:@"'"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&rsquo;" withString:@"'"];
        
        DLog(@"response=%@",response);
        
        DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
         dict = [dict dictionaryByReplacingNullsWithStrings];
        
       // self.eventtitle.text=[dict objectForKey:@"event_title"];
        
        
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
                                            initWithKey:@"username"
                                            ascending:YES
                                            selector:@selector(localizedCaseInsensitiveCompare:)];
                NSArray *sortDescriptors = [NSArray arrayWithObject: sorter];
                [eventcount sortUsingDescriptors:sortDescriptors];
                DLog(@"array=%@",eventcount);
                
                
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
               self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
                [self.tableview reloadData];
                
                   self.tableview.pullTableIsLoadingMore = NO;
            
            
        }
        
      else  if ([[dict objectForKey:@"status"] isEqual:@"e"])
        {
            self.tableview.pullTableIsLoadingMore = NO;
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
        
    }
    [appDel removeLoader];
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    [[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
   // NSString *response  =  [request responseString];
   // DLog(@"response=%@",response);
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel removeLoader];
    self.tableview.pullTableIsLoadingMore = NO;
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
            
            [self dismissViewControllerAnimated:NO completion:nil];
            
        }
        
    }
    
}




#pragma mark Tableview Delegates

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return eventcount.count;
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
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50+20+5, 30-10, 200, 20)];
       nameLabel.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1] ;
    nameLabel.text=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"username"];
    
    [nameLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:18.0]];
    nameLabel.numberOfLines=0;

    [cell.contentView addSubview:nameLabel];
    //
    //    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 37, 200, 20)];
    //    nameLabel.backgroundColor=[UIColor clearColor];
    //    nameLabel.text=@"Carrier Services";
    //    [nameLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0]];
    //    nameLabel.textColor=[UIColor whiteColor];
    //    [cell.contentView addSubview:nameLabel];
    
    UIImageView *typeImage = [[UIImageView alloc]initWithFrame:CGRectMake(27, 23-7, 30, 30)];
    // typeImage.frame=CGRectMake(10, 23, 30, 30);
    //  [typeImage setImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"circles.png"]]];
    
    
    NSString *imageurl=  [[eventcount objectAtIndex:indexPath.row] objectForKey:@"member_image"];
    UIImage *cachedImage = [self.imageCache objectForKey:imageurl];
    
    if ([imageurl isEqualToString:@""])
    {
        typeImage.image = [UIImage imageNamed:@"noimage.png"];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.profileid=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"user_id"];
    //appDel.enterFromCircle=TRUE;
    DLog(@"pid=%@",appDel.profileid);
    //[appDel addLoaderForViewController:self];
    appDel.enterscreen=TRUE;
    ViewProfile *profile=[[ViewProfile alloc] initWithNibName:@"ViewProfile" bundle:nil];
    [self presentViewController:profile animated:YES completion:nil];
    //[self presentModalViewController:profile animated:YES];
    
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setProfileName:nil];
    [self setProfileImage:nil];
    [self setCircleImage:nil];
    [self setEventtitle:nil];
    [super viewDidUnload];
}
@end
