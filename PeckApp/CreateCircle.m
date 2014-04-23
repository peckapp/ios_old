//
//  CreateCircle.m
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 5/22/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "CreateCircle.h"

@interface CreateCircle ()

@end

@implementation CreateCircle
@synthesize imageCache,imageDownloadingQueue,eventcount,findPersonOrGroup,listofevents,circleName,buttonBgImage,tableview;
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

- (IBAction)closeCreateCircle:(id)sender
{
    if (listofevents==nil && addnewcircle==nil)
    {
         [self dismissViewControllerAnimated:YES completion:nil];
   // [self dismissModalViewControllerAnimated:YES];
    
    }
    
}



# pragma mark ImageTaking

-(IBAction)selectPicture
{
    [self.circleName resignFirstResponder];
    //const NSInteger imgResolution=500;
    
    [ActionSheet showActionSheet:@"":[[NSArray alloc] initWithObjects:@"Camera",@"Photo Roll",@"Remove Picture",@"Cancel",nil]  :self.view : ^(NSInteger buttonIndex) {
        
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate=self;
        bool isPickImage = false;
        
        if(buttonIndex == 0)
        {
            
            if( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])
            {
                
                
                [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
                 imagePicker.cameraDevice= UIImagePickerControllerCameraDeviceRear;
                isPickImage=TRUE;
                
            }
            else if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]==false)
            {
                
                [[[UIAlertView alloc]initWithTitle:alertTitle message:@"Camera not available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                
            }
            
        }
        
        else if(buttonIndex == 1)
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.allowsEditing=YES;
            isPickImage=TRUE;
            
        }
        else if(buttonIndex == 2)
        {
            
            self.buttonImageView.image=[UIImage imageNamed:@"bg_image.png"];
            
        }
        
        
        if (isPickImage)
        {
            
            [imagePicker setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
            [self presentViewController:imagePicker animated:YES completion:nil];
            [imagePicker viewWillAppear:YES];
        }
        
    }];
}


# pragma mark Image Picker Methods

-(void)imagePickerController:(UIImagePickerController *)picker
      didFinishPickingImage : (UIImage *)image
                 editingInfo:(NSDictionary *)editingInfo
{
    
    self.buttonImageView.image= [self imageresize:image];
    picker.delegate=nil;
    picker=nil;
   [CATransaction setDisableActions:YES];
    [self  dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    picker.delegate=nil;
    picker=nil;
  [CATransaction setDisableActions:YES];
 [self  dismissViewControllerAnimated:YES completion:nil];
    
}

-(UIImage *) imageresize:(UIImage *) image
{
    if (image!=nil) {
        CGSize newSize = CGSizeMake(320, 240);  //whaterver size
        UIGraphicsBeginImageContext(newSize);
        [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    return image;
}



# pragma mark createcircle

- (IBAction)submitCircle:(id)sender
{
  AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel addLoaderForViewController:self];
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
  
     NSString *string = [tickCircleCount componentsJoinedByString:@","];
    DLog(@"list=%@",string);
   
    NSData *imageData = UIImageJPEGRepresentation(self.buttonImageView.image, 0.1);
      
    
    NSString *image = [imageData base64EncodedString];
    
   // imageData = imageData
  
    addnewcircle =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:AddNewCircle]] ;
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults valueForKey:@"userid"];
    [addnewcircle setPostValue:uid forKey:@"userid"];
     [addnewcircle setPostValue:[self.circleName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  forKey:@"circle_name"];
    [addnewcircle setPostValue:string forKey:@"circle_members"];
    
    if (self.buttonImageView.image!=[UIImage imageNamed:@"bg_image.png"])
    {
          [addnewcircle setPostValue:image forKey:@"circle_picture"];
    }
     [addnewcircle setDelegate:self];
    [addnewcircle  startAsynchronous];
    [self.circleName resignFirstResponder];
    

}


-(void) viewWillAppear:(BOOL)animated
{

     AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
  self.circleName.autocapitalizationType=UITextAutocapitalizationTypeWords;
    if (appDel.enterFromCircle) {
        
        for(UIView *subviews in [self.view subviews])
        {
            subviews.hidden=YES;
            // self.TimeandDateTitleView.hidden=YES;
            self.headerView.hidden=NO;
            
        }
        
         eventcount = [[NSMutableArray alloc] init];
        saveeventcount = [[NSMutableArray alloc] init];
        listofevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:addnewCircleListing]] ;
        [listofevents setDelegate:self];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *uid = [defaults valueForKey:@"userid"];
        DLog(@"userid=%@",uid);
        [listofevents setPostValue:uid forKey:@"userid"];
        [listofevents setPostValue:@"create_circle" forKey:@"type"];
        [listofevents setPostValue:@"0" forKey:@"start_limit"];
        [listofevents  startAsynchronous];
    
        
//        self.tableview = [[PullTableView alloc] initWithFrame:CGRectMake(0, 234, self.view.bounds.size.width,  self.view.bounds.size.height-234) style:UITableViewStylePlain];// autorelease];
//        self.tableview.pullDelegate =self;
//        self.tableview.backgroundColor =[UIColor colorWithRed:(73.0/255.0) green:(73.0/255.0) blue:(73.0/255.0) alpha:1.0];
//        
//        [self.view addSubview:tableview];
       // self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        self.tableview.dataSource = self;
        self.tableview.delegate = self;
       // self.tableview.pullDelegate =self;
        [appDel addLoaderForViewController:self];
        
     
        
        self.imageDownloadingQueue = [[NSOperationQueue alloc] init];
        self.imageDownloadingQueue.maxConcurrentOperationCount = 4; // many servers limit how many concurrent requests they'll accept from a device, so make sure to set this accordingly
        
        self.imageCache = [[NSCache alloc] init];
        [findPersonOrGroup addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        
    }
 
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    
    [self loadMoreDataToTable];
}

-(void) loadMoreDataToTable
{
    savestartindex=startindex;
    startindex=startindex+Size;
    listofevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:allcircleListing]] ;
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
    appDel.enterFromCircle=FALSE;
    appDel.enterscreen=FALSE;
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
    
    if (eventcount.count==0)
    {
        self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    
    else
    {
        
        self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        
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
    self.buttonBgImage.userInteractionEnabled=NO;
    if (textField==findPersonOrGroup) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-150.0,
                                     self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];

    }
    
      
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.view removeGestureRecognizer:singleTap];
       self.buttonBgImage.userInteractionEnabled=YES;
    if (textField==findPersonOrGroup)
    {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view .frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+150.0,self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
        if ([self.findPersonOrGroup.text isEqual:@""])
        {
            self.findPersonOrGroup.placeholder=@"Find a person or group";
        }
    
    }
    
    if (textField==circleName)
    {
        if ([self.circleName.text isEqual:@""])
        {
            self.circleName.placeholder=@"Create New Circle";
        }
    }
    
}



-(IBAction)singleTapGesture:(UITextField *) textField
{
    
    [self.findPersonOrGroup resignFirstResponder];
    [self.circleName resignFirstResponder];
    
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
        listofevents=nil;
         [CATransaction setDisableActions:YES];
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
                                            initWithKey:@"final_name"
                                            ascending:YES
                                            selector:@selector(localizedCaseInsensitiveCompare:)];
            NSArray *sortDescriptors = [NSArray arrayWithObject: sorter];
                [eventcount sortUsingDescriptors:sortDescriptors];
                DLog(@"array=%@",eventcount);
                
                saveeventcount = eventcount;

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
            
        
      else  if ([[dict objectForKey:@"status"] isEqual:@"e"])
        {
            startindex=savestartindex;
            [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            
        }
        
        else if (dict==nil)
        {
            
            [[[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            [appDel removeLoader];
            
        }
        //self.tableview.pullTableIsLoadingMore = NO;
        [appDel removeLoader];
       
    }
    
    if (request==addnewcircle)
    {
        addnewcircle=nil;
          NSString *response  =  [request responseString];
        
        NSMutableDictionary *dict=[response JSONValue];
        
       // DLog(@"response=%@",response);

        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
            if (listofevents==nil && addnewcircle==nil)
            {
                AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
                appDel.enterscreen=TRUE;
                  [self dismissViewControllerAnimated:YES completion:nil];

            }
            
        }
    else if ([[dict objectForKey:@"status"] isEqual:@"e"])
    {
        [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        [appDel removeLoader];
    }
        
    else if (dict==nil)
    {
        
        [[[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
         [appDel removeLoader];
    }
        
    }
    
    
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    listofevents=nil;
    addnewcircle=nil;
    [CATransaction setDisableActions:YES];
    [[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
  //  NSString *response  =  [request responseString];
  //  DLog(@"response=%@",response);
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel removeLoader];
      //self.tableview.pullTableIsLoadingMore = NO;
    startindex=savestartindex;
    //  [activityIndicator stopAnimating];
    //  [activityIndicator removeFromSuperview];
    //  [[eventcount objectAtIndex:buttonindexpath.row] setValue:oldstatus forKey:@"subscription_status"];
    
}


-(IBAction)campusEventsButtonClosed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
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





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
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
    
    UIImageView *typeImage = [[UIImageView alloc]initWithFrame:CGRectMake(23, 23-7, 30, 30)];
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
       // [self presentModalViewController:profile animated:YES];
    
    }
    DLog(@"circleid=%@",appDel.circleid);
    
}


- (void)viewDidUnload
{
    [self setFindPersonOrGroup:nil];
    [self setTableview:nil];
 
    [self setCircleName:nil];
    [self setButtonBgImage:nil];
    [self setTableview:nil];
    [self setHeaderView:nil];
    [self setButtonImageView:nil];
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
