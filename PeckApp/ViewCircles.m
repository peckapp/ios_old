//
//  ViewCircles.m
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 6/7/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "ViewCircles.h"

@interface ViewCircles ()

@end

@implementation ViewCircles
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

#pragma mark alertview delegates


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    
    if (alertView.tag==1)
    {
        if (buttonIndex==0)
        {
            if (appDel.activityOpen)
            {
                [self.navigationController popViewControllerAnimated:YES];
                appDel.activityOpen=FALSE;
            }
            
            
        }
        
    }
    
}

# pragma mark title ReadMore

-(IBAction) readmoreTitle:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    
    
    self.headerView.frame=CGRectMake(self.headerView.frame.origin.x, self.headerView.frame.origin.y, self.headerView.frame.size.width, self.headerView.frame.size.height+titleSize.height-20);
    
    
    self.circletitle.frame=CGRectMake(self.circletitle.frame.origin.x,self.circletitle.frame.origin.y+5, self.circletitle.frame.size.width, titleSize.height);
    
    
    self.circleImageView.frame=CGRectMake(self.circleImageView.frame.origin.x, self.headerView.frame.origin.y+self.headerView.frame.size.height, self.circleImageView.frame.size.width, self.circleImageView.frame.size.height);
    
    self.profileImageView.frame=CGRectMake(self.profileImageView.frame.origin.x, self.circleImageView.frame.origin.y+self.circleImageView.frame.size.height, self.profileImageView.frame.size.width, self.profileImageView.frame.size.height);
    
    self.tableview.frame=CGRectMake(self.tableview.frame.origin.x, self.profileImageView.frame.origin.y+self.profileImageView.frame.size.height, self.tableview.frame.size.width, self.tableview.frame.size.height-(titleSize.height-10));

    //   CGRect deviceDimension = [[UIScreen mainScreen] bounds];
    

    [self.readmoreTitleButton removeFromSuperview];
    
    
    [UIView commitAnimations];

}


-(IBAction) addMemberscircle:(id)sender
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    AddCircleMembers *addcirclemembers=[[AddCircleMembers alloc] initWithNibName:@"AddCircleMembers" bundle:nil];
    appDel.enterFromCircle=TRUE;
    [self presentViewController:addcirclemembers animated:YES completion:nil];
}



-(IBAction) closeViewCircle:(id)sender
{
    if (listofevents==nil && deletecircle==nil)
    {
        
        BOOL modalPresent = (BOOL)(self.presentingViewController);
        
        if (modalPresent)
        {
          [self dismissViewControllerAnimated:YES completion:nil];
        }

        else
        {
    
        [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
}


-(void) viewWillAppear:(BOOL)animated
{
 AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
      //self.circletitle.font = [UIFont boldSystemFontOfSize:self.circletitle.font.pointSize];
    if (appDel.enterFromCircle) {
        
        eventcount = [[NSMutableArray alloc] init];
        self.addNewmembersButton.hidden=YES;
        listofevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:viewSingleCircle]] ;
        [listofevents setDelegate:self];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *uid = [defaults valueForKey:@"userid"];
        [listofevents setPostValue:uid forKey:@"userid"];
        [listofevents setPostValue:appDel.circleid forKey:@"cid"];
        [listofevents setPostValue:appDel.redirectfrom forKey:@"redirect_from"];
        [listofevents setPostValue:appDel.logid forKey:@"log_id"];
        [listofevents  startAsynchronous];
//          
//    self.tableview = [[PullTableViewFooter alloc] initWithFrame:CGRectMake(0, 226, self.view.bounds.size.width,  self.view.bounds.size.height-226) style:UITableViewStylePlain];\
//            self.tableview.pullDelegate =self;
//            self.tableview.backgroundColor =[UIColor colorWithRed:(73.0/255.0) green:(73.0/255.0) blue:(73.0/255.0) alpha:1.0];
//            [self.view addSubview:tableview];
//            self.tableview.dataSource = self;
//            self.tableview.delegate = self;
//            self.tableview.pullDelegate =self;
           self.tableview.showsVerticalScrollIndicator=NO;
          for(UIView *subviews in [self.view subviews])
          {
            subviews.hidden=YES;
            // self.TimeandDateTitleView.hidden=YES;
            self.headerView.hidden=NO;
            
           }

            [appDel addLoaderForViewController:self];
            self.imageDownloadingQueue = [[NSOperationQueue alloc] init];
            self.imageDownloadingQueue.maxConcurrentOperationCount = 4; // many servers limit how many concurrent requests they'll accept from a device, so make sure to set this accordingly
            
            self.imageCache = [[NSCache alloc] init];
            
        }


    
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
        listofevents=nil;
        NSString *response  =  [request responseString];
        
        DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
        dict = [dict dictionaryByReplacingNullsWithStrings];
        
        if ([[dict objectForKey:@"circleof"] isEqual:@"self"])
        {
            selfcircle=TRUE;
            self.addNewmembersButton.hidden=NO;
        }
        else
        {
            self.circletitle.frame=CGRectMake(self.circletitle.frame.origin.x+5, self.circletitle.frame.origin.y, self.circletitle.frame.size.width,  self.circletitle.frame.size.height);
            
        }
        
        DLog(@"dict=%@",dict);
       
             CGSize maximumSize = CGSizeMake(160, 9999);
            
            titleSize = [[dict objectForKey:@"circle_name"] sizeWithFont: self.circletitle.font constrainedToSize:maximumSize lineBreakMode: self.circletitle.lineBreakMode];
            
            //int chars=[[[eventcount objectAtIndex:0] valueForKey:@"event_title"] length];
            
            DLog(@"title width=%f",titleSize.width);
            DLog(@"title height=%f",titleSize.height);
            
            int lines = [[dict objectForKey:@"circle_name"] sizeWithFont:self.circletitle.font constrainedToSize:maximumSize
            lineBreakMode:NSLineBreakByWordWrapping].height /self.circletitle.font.pointSize;
            
            DLog(@"lines=%d",lines);
            
            if (lines<=1)
            {
                [self.readmoreTitleButton removeFromSuperview];
                
            }
            self.circletitle.text=[dict objectForKey:@"circle_name"];
           
             self.ProfileName.text=[dict objectForKey:@"username"];
       
        NSString *imageurlprofile= [dict objectForKey:@"profile_image"];
        
        imageurlprofile = [imageurlprofile stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSData *imageDataProfile = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageurlprofile]];
          if (imageDataProfile!=nil) {
            
            self.profileImage.layer.cornerRadius=20.0;
            self.profileImage.layer.borderColor=[UIColor lightGrayColor].CGColor;
            self.profileImage.layer.borderWidth=1.0;
            self.profileImage.layer.masksToBounds = YES;
            self.profileImage.image=[UIImage imageWithData:imageDataProfile];
          }
          else{
              self.profileImage.image=[UIImage imageNamed:@"friends.png"];
           
          }
        NSString *imageurl= [dict objectForKey: @"circle_picture"];
        imageurl = [imageurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if (![imageurl isEqual:@""])
        {

        UIImage *cachedImage = [self.imageCache objectForKey:imageurl];
        
        
        if (cachedImage)
        {
            self.circleImage.image = cachedImage;
        }
        else
        {
            // you'll want to initialize the image with some blank image as a placeholder
            UIActivityIndicatorView *eventimageloading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            eventimageloading.center = CGPointMake(self.circleImage.frame.size.width/2, self.circleImage.frame.size.height/2);
            eventimageloading.alpha = 1.0;
            eventimageloading.hidesWhenStopped = YES;
            [eventimageloading startAnimating];
            [self.circleImage addSubview:eventimageloading];
            
            
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
                        
                        
                        UIImage  *i = [ImageHelper imageByScalingProportionallyToSize:CGSizeMake(image.size.width, image.size.height):image];
                        self.circleImage.image = i;
                    }];
                    
                }
                
                [eventimageloading removeFromSuperview];
                [eventimageloading stopAnimating];
                
                
            }];
            
        }
        
        }
        
        DLog(@"dictionary count=%d",dict.count);
        //   [eventcount removeAllObjects];
        //    DLog(@"id=%@",[dict valueForKey:[NSString stringWithFormat:@"%d",i]]);
       
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
            
            for(UIView *subviews in [self.view subviews])
            {
                subviews.hidden=NO;
                
            }
            
         
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
                //self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            
            if (eventcount.count>0)
            {
                self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            }
            
                [self.tableview reloadData];
                
                  [appDel removeLoader];
            
        }
        
      if ([[dict objectForKey:@"status"] isEqualToString:@"e"])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            alert.tag=1;
            [appDel removeLoader];
        }

        
        else if (dict==nil)
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            if (eventcount.count==0)
            {
                alert.tag=1;
            }
            [appDel removeLoader];
            
        }
         
        //self.tableview.pullTableIsLoadingMore = NO;
    }
    
    if (request==deletecircle)
    {
        deletecircle=nil;
        NSString *response  =  [request responseString];
        DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {

                [eventcount removeObjectAtIndex:circleindexpath.row];
                [self.tableview reloadData];
                
                
                if (eventcount.count==0)
                {
                
                     [[[UIAlertView alloc]initWithTitle:alertTitle message:@"There are no Members in this Circle." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
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
        
         [appDel removeLoader];
    }
    

    
  
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    listofevents=nil;
    [[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
   // NSString *response  =  [request responseString];
   // DLog(@"response=%@",response);
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel removeLoader];
   // self.tableview.pullTableIsLoadingMore = NO;
    //  [activityIndicator stopAnimating];
    //  [activityIndicator removeFromSuperview];
    //  [[eventcount objectAtIndex:buttonindexpath.row] setValue:oldstatus forKey:@"subscription_status"];
    
}





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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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
     cell.backgroundColor=[UIColor clearColor];
        
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50+20+5, 30-10, 200, 20)];
    nameLabel.backgroundColor=[UIColor clearColor];
    [nameLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:18.0]];
    nameLabel.numberOfLines=0;
   
    nameLabel.text=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"username"];
    
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
    if (listofevents==nil)
    {
        AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
        appDel.profileid=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"memberid"];
        //appDel.enterFromCircle=TRUE;
        DLog(@"pid=%@",appDel.profileid);
        //[appDel addLoaderForViewController:self];
        appDel.enterscreen=TRUE;
        ViewProfile *profile=[[ViewProfile alloc] initWithNibName:@"ViewProfile" bundle:nil];
        [self presentViewController:profile animated:YES completion:nil];
       // [self presentModalViewController:profile animated:YES];
        
        
        DLog(@"circleid=%@",appDel.circleid);
    }
    
  
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    if (selfcircle)
    {
        return YES;
    }
    
    else
    {
        return NO;
     
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //add code here for when you hit delete
       
     
            circleindexpath=indexPath;
          NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
          NSString *uid = [defaults valueForKey:@"userid"];
        

            AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
            [appDel addLoaderForViewController:self];
           
            deletecircle=  [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:deleteCircleMebers]] ;
            DLog(@"cid=%@",appDel.circleid);
            DLog(@"memid=%@",[[eventcount objectAtIndex:indexPath.row] objectForKey:@"memberid"]);
            [deletecircle setDelegate:self];
           [deletecircle setPostValue:uid forKey:@"loginuid"];
            [deletecircle setPostValue:[[eventcount objectAtIndex:indexPath.row] objectForKey:@"memberid"] forKey:@"userid"];
            [deletecircle setPostValue:appDel.circleid forKey:@"circleid"];
            [deletecircle startAsynchronous];
        
    }
    
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
    [self setCircletitle:nil];
    [self setHeaderView:nil];
    [self setCircleImageView:nil];
    [self setProfileImageView:nil];
    [self setReadmoreTitleButton:nil];
    [self setAddNewmembersButton:nil];
    [super viewDidUnload];
}
- (IBAction)readmoreTitleButton:(id)sender {
}
@end
