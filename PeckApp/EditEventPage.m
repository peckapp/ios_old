//
//  EditEventPage.m
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 7/1/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "EditEventPage.h"
#import "AppDelegate.h"

@implementation EditEventPage
@synthesize locationTextField,commentTextView,listoflocation,eventdetails;
const int numberOfSharedItemsinEditEvent = 5;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

# pragma mark update event

-(IBAction)deleteevent:(id)sender

{
       
    UIAlertView  *DeleteAlert = [[UIAlertView alloc] initWithTitle:alertTitle message:@"Are you sure you want to delete this event?" delegate:self cancelButtonTitle:@"Ok"otherButtonTitles:@"Cancel",nil];
    DeleteAlert.tag=1;
    DeleteAlert.delegate=self;
      [DeleteAlert show];
   
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        
        if (buttonIndex==0)
        {
            
            AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
            
            [appDel addLoaderForViewController:self];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *uid = [defaults valueForKey:@"userid"];
            
            
            deleteevents=  [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:deleteEvent]] ;
            DLog(@"eid=%@",appDel.eventid);
            [deleteevents setDelegate:self];
            [deleteevents setPostValue:uid forKey:@"userid"];
            [deleteevents setPostValue:appDel.eventid forKey:@"eventid"];
            [deleteevents startAsynchronous];
            
            
        }
        

    }
}
# pragma mark update event

-(IBAction)updateevent:(id)sender
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    
    
    if (self.eventTitle.text.length<=80)
    {
       
            [self.commentTextView resignFirstResponder];
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults valueForKey:@"userid"];
  
      updateevents=  [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:editEvent]] ;
    [updateevents setDelegate:self];
    [updateevents setPostValue:uid forKey:@"userid"];
    [updateevents setPostValue:appDel.eventid forKey:@"eventid"];
        DLog(@"ename=%@",self.eventTitle.text);
    [updateevents setPostValue:[self.eventTitle.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]forKey:@"event_name"];
        if (self.eventImage.image!=[UIImage imageNamed:@"bg_image.png"])
        {
            NSData *imageData = UIImageJPEGRepresentation(self.eventImage.image, 0.1);
            
            NSString *image = [imageData base64EncodedString];
            
            [updateevents setPostValue:image forKey:@"event_picture"];
        }
   
    [updateevents setPostValue:self.locationTextField.text forKey:@"event_location"];
    [updateevents setPostValue:appDel.listcircle forKey:@"event_members"];
    [updateevents setPostValue:self.timeButton.titleLabel.text forKey:@"event_time"];
    [updateevents setPostValue:self.weekButton.titleLabel.text forKey:@"event_day"];
    [updateevents setPostValue:self.dateButton.titleLabel.text forKey:@"event_date"];
        if (![self.commentTextView.text isEqual:@"Enter something describing your event. Keep it brief."])
        {
           [updateevents setPostValue:self.commentTextView.text forKey:@"event_description"];
        }
  
    [updateevents setPostValue:self.eventCategoryButton.titleLabel.text forKey:@"event_type"];
    [updateevents startAsynchronous];
     [appDel addLoaderForViewController:self];
        
    }
    else
    {
    
   [[[UIAlertView alloc]initWithTitle:alertTitle message:@"You can not enter more than 80 characters for Title" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }
    
}




# pragma mark ReadMore

-(IBAction) readmore
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    
    
    
     self.updateEvent.frame=CGRectMake( self.updateEvent.frame.origin.x,  self.updateEvent.frame.origin.y+myStringSize.height-35, self.updateEvent.frame.size.width, self.updateEvent.frame.size.height);
    
    self.commentTextView.frame=CGRectMake(self.commentTextView.frame.origin.x,  self.commentTextView.frame.origin.y, self.commentTextView.frame.size.width, myStringSize.height+15);
    
    //CGRect deviceDimension = [[UIScreen mainScreen] bounds];
   
    self.Backgroundscroller.contentSize=CGSizeMake(0, self.Backgroundscroller.contentSize.height-35+myStringSize.height);
    self.Backgroundscroller.scrollEnabled=YES;
    [self.readmorebuttonview removeFromSuperview];
    self.readmorebuttonview=nil;
    
    [UIView commitAnimations];
}




- (void)viewWillAppear:(BOOL)animated
{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
     self.eventTitle.autocapitalizationType=UITextAutocapitalizationTypeWords;
    self.commentTextView.layer.cornerRadius=0;
    self.TimeandDateTitleView.hidden=YES;
    self.updateEvent.layer.cornerRadius=2.0;
    self.locationTextField.layer.cornerRadius=0;
    self.Backgroundscroller.scrollEnabled=NO;
    self.tableview.showsVerticalScrollIndicator=YES;
    CGRect deviceDimension = [[UIScreen mainScreen] bounds];
    self.readmoreButton.titleLabel.font= [UIFont italicSystemFontOfSize:self.readmoreButton.titleLabel.font.pointSize];
    if (deviceDimension.size.height > 480.0f)
    {
        self.updateEvent.frame=CGRectMake(self.updateEvent.frame.origin.x, deviceDimension.size.height-117-50, self.updateEvent.frame.size.width, self.updateEvent.frame.size.height);

    }
    else
    {
        self.updateEvent.frame=CGRectMake(self.updateEvent.frame.origin.x, deviceDimension.size.height-117, self.updateEvent.frame.size.width, self.updateEvent.frame.size.height);
    }
    if (appDel.circlecount==0)
    {
        [self.inviteFriendsButton setTitle:@"Invite Friends" forState:UIControlStateNormal];
    }
    
    else
    {
        DLog(@"count=%d",appDel.circlecount);
        [self.inviteFriendsButton setTitle:[NSString stringWithFormat: @"%d  Friends Added", appDel.circlecount] forState:UIControlStateNormal];
      //  self.inviteFriendsButton.titleLabel.textColor=[UIColor blackColor];
        
    }
    
    if (appDel.attendevent)
    {
        for(UIView *subviews in [self.view subviews])
        {
            subviews.hidden=YES;
          
            // self.TimeandDateTitleView.hidden=YES;
            self.headerView.hidden=NO;
              self.eventTitle.hidden=YES;
            
        }
        [appDel addLoaderForViewController:self];
        eventcount = [[NSMutableArray alloc] init];
        self.tableview.hidden=YES;
        //self.readmorebuttonview.hidden=YES;
        [self makeTimePickerview];
        [self makeDatePickerview];
        timePicker.hidden=YES;
        datePicker.hidden=YES;
       
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         NSString *uid = [defaults valueForKey:@"userid"];
        
    
        locationList = [[NSMutableArray alloc] init];
        [self.locationTextField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
       
        DLog(@"eventid=%@",appDel.eventid);
        eventdetails =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:singleCampusEventView]] ;
        [eventdetails setDelegate:self];
        [eventdetails setPostValue:appDel.eventid forKey:@"eventid"];
        [eventdetails setPostValue:uid forKey:@"userid"];
        [eventdetails  startAsynchronous];
        
        
                self.imageDownloadingQueue = [[NSOperationQueue alloc] init];
        self.imageDownloadingQueue.maxConcurrentOperationCount = 4; // many servers limit how many concurrent requests they'll accept from a device, so make sure to set this accordingly
        
        self.imageCache = [[NSCache alloc] init];

        //        viewprofile =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:fbuserprofile_details]] ;
        //        [viewprofile setDelegate:self];
        //        [viewprofile setPostValue:uid forKey:@"userid"];
        //        [viewprofile  startAsynchronous];
        
    }
    
    
    // Do any additional setup after loading the view from its nib.
}


-(void) viewDidDisappear:(BOOL)animated
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.enterscreen=FALSE;
    appDel.attendevent=FALSE;
    
    //  [homescreen.view removeFromSuperview];
    // [homescreen removeFromParentViewController];
}


-(void) textDidChange:(id)sender
{
    
    self.locationTextField = (UITextField *) sender;
    
    locationList=tableArray;
   NSMutableArray  *filterarray=[[NSMutableArray alloc]init];
    //    [filterarray removeAllObjects];
    // NSArray *filterContacts = [[NSArray alloc]init];
    NSString *match=self.locationTextField.text;
    match = [match lowercaseString];
    
    
    for(int i=0; i<[locationList count]; i++){
        
//       NSMutableArray  *filterarray=[[NSMutableArray alloc]init];
        NSString *match=self.locationTextField.text;
        match = [match lowercaseString];
        NSString *department = [[locationList objectAtIndex:i] valueForKey:@"event_location"];
        department = [department lowercaseString];
        NSRange range = [department rangeOfString:match options:NSCaseInsensitiveSearch];
        if (range.location==0) {
            [filterarray addObject:[locationList objectAtIndex:i]];
        }
        
        
    }
    
    locationList=filterarray;
    if (locationList.count==0)
    {
        self.tableview.hidden=YES;
        [self.view addGestureRecognizer:singleTap];
        
    }
    
    if (locationList.count>0)
    {
        self.tableview.hidden=NO;
        [self.view removeGestureRecognizer:singleTap];
        DLog(@"lcount123=%d",locationList.count);
        
    }
    
    if ([self.locationTextField.text isEqual:@""])
    {
        self.locationTextField.placeholder=@"Location";
    }

   
    [self.tableview reloadData];
    
}


# pragma mark ImageTaking

-(IBAction)selectPicture
{
    [self.eventTitle resignFirstResponder];
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
            
            self.eventImage.image=[UIImage imageNamed:@"bg_image.png"];
            
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
    
    self.eventImage.image= [self imageresize:image];
    picker.delegate=nil;
    picker=nil;
   [CATransaction setDisableActions:YES];
  [self  dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [self  dismissViewControllerAnimated:YES completion:nil];
    picker.delegate=nil;
    picker=nil;
    [CATransaction setDisableActions:YES];
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



-(void)requestFinished:(ASIHTTPRequest *)request
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
   
    
    if (request==listoflocation)
    {
        listoflocation=nil;
         [CATransaction setDisableActions:YES];
        
        NSString *response =[[request responseString] stringByReplacingOccurrencesOfString:@"&#x27;" withString:@"'"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&rsquo;" withString:@"'"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&ntilde;" withString:@"n"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&eacute;" withString:@"e"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
        dict = [dict dictionaryByReplacingNullsWithStrings];
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
            self.TimeandDateTitleView.hidden=NO;
            
            DLog(@"response=%@",response);
            NSMutableDictionary *dict=[response JSONValue];
            DLog(@"status=%@",[dict objectForKey:@"status"]);
            
            for (int i=0; i<=dict.count; i++)
            {
                
                if ([dict valueForKey:[NSString stringWithFormat:@"%d",i]]!=nil) {
                    [locationList addObject:[dict valueForKey:[NSString stringWithFormat:@"%d",i]]];
                }
                
                else if ([dict valueForKey:[NSString stringWithFormat:@"%d",i]]==nil)
                {
                    
                    [locationList removeObject:[dict valueForKey:[NSString stringWithFormat:@"%d",i]]];
                    
                    
                }
                
            }
            
            NSSortDescriptor *sorter = [[NSSortDescriptor alloc]
                                        initWithKey:@"event_location"
                                        ascending:YES
                                        selector:@selector(localizedCaseInsensitiveCompare:)];
            NSArray *sortDescriptors = [NSArray arrayWithObject: sorter];
            [locationList sortUsingDescriptors:sortDescriptors];
            DLog(@"array=%@",locationList);
            DLog(@"lcount=%d",locationList.count);
        tableArray=[[NSMutableArray alloc] initWithArray:locationList];
            for(UIView *subviews in [self.view subviews])
            {
                subviews.hidden=NO;
                self.eventTitle.hidden=NO;
            }
            
        }
        else if ([[dict objectForKey:@"status"] isEqual:@"e"])
        {
            
        [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        
        }
      [appDel removeLoader];     
    }
    if (request==eventdetails)
    {
        eventdetails=nil;
        [CATransaction setDisableActions:YES];
        NSString *response  =  [request responseString];
        DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
        dict = [dict dictionaryByReplacingNullsWithStrings];
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
            self.TimeandDateTitleView.hidden=NO;
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *uid = [defaults valueForKey:@"userid"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
           
        listoflocation =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:LocationList]] ;
            [listoflocation setPostValue:uid forKey:@"userid"];
            [listoflocation setDelegate:self];
            [listoflocation startAsynchronous];
    
         });
            
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
            
         categoryserial=[[[eventcount objectAtIndex:0] valueForKey:@"category_serial"] integerValue];
            DLog(@"CS=%d",categoryserial);
            
            [self makeCategoryPickerview];
            eventCategoryPicker.hidden=YES;
            
            
            
        int characters = [[[eventcount objectAtIndex:0] valueForKey:@"event_description"]  length];
        DLog(@"chars=%d",characters);
    UITextView *imaginaryTextview=[[UITextView alloc] initWithFrame:CGRectMake(0, 0, 275, 52)];
    imaginaryTextview.text=[[eventcount objectAtIndex:0] valueForKey:@"event_description"];
    imaginaryTextview.font=[UIFont fontWithName:@"Lato-Regular" size:16.0];
    [self.view addSubview:imaginaryTextview];
    myStringSize=imaginaryTextview.contentSize;
    [imaginaryTextview removeFromSuperview];
    self.commentTextView.text=[[eventcount objectAtIndex:0] valueForKey:@"event_description"];
    
    
     if (characters<62)
    {
        self.commentTextView.frame=CGRectMake(self.commentTextView.frame.origin.x, self.commentTextView.frame.origin.y, 275, 52);
         self.readmorebuttonview.hidden=YES;
        self.readmorebuttonview=nil;
    }
    
    else
    {
        self.readmorebuttonview.hidden=NO;
    
    }
        
        
           
   if (![[[eventcount objectAtIndex:0] valueForKey:@"onlytime"]isEqual:@""])
            {
                self.titleTime.text=[[eventcount objectAtIndex:0] valueForKey:@"onlytime"];
                
            }
            else
            {
                self.titleTime.text=@"N/A";
                
            }
            
            if (![[[eventcount objectAtIndex:0] valueForKey:@"invite_friends"]isEqual:@""])
            {
           
            appDel.circlecount=[[[eventcount objectAtIndex:0] valueForKey:@"invite_friends"] intValue];
                if (appDel.circlecount==0)
                {
                    [self.inviteFriendsButton setTitle:@"Invite Friends" forState:UIControlStateNormal];
                }
                else
                {
                
                 [self.inviteFriendsButton setTitle:[NSString stringWithFormat: @"%@  Friends Added",[[eventcount objectAtIndex:0] valueForKey:@"invite_friends"]] forState:UIControlStateNormal];
                
                }
                
             DLog(@"circlecount = %d",appDel.circlecount);
            }
            else
            {
                
                
            }

  

       if (![[[eventcount objectAtIndex:0] valueForKey:@"onlydate"] isEqual:@""])
            {
                
           self.eventDateTitleLabel.text=[[eventcount objectAtIndex:0] valueForKey:@"onlydate"];
                
            }
       
    if (![[[eventcount objectAtIndex:0] valueForKey:@"event_time"] isEqual:@""]) {
       
         [self.timeButton setTitle:[[eventcount objectAtIndex:0] valueForKey:@"event_time"] forState:UIControlStateNormal];
          [self.timeButton.titleLabel sizeToFit];
    }

    if (![[[eventcount objectAtIndex:0] valueForKey:@"event_day"] isEqual:@""]) {
        
    [self.weekButton setTitle:[[eventcount objectAtIndex:0] valueForKey:@"event_day"] forState:UIControlStateNormal];
         [self.weekButton.titleLabel sizeToFit];
       }

            
            
   if (![[[eventcount objectAtIndex:0] valueForKey:@"event_date"] isEqual:@""])
   {
     
    [self.dateButton setTitle:[[eventcount objectAtIndex:0] valueForKey:@"event_date"] forState:UIControlStateNormal];
      
          [self.dateButton.titleLabel sizeToFit];
     }
            
           
    if (![[[eventcount objectAtIndex:0] valueForKey:@"event_location"] isEqual:@""]) {
                
        self.locationTextField.text=[[eventcount objectAtIndex:0] valueForKey:@"event_location"];
        self.locationTextField.text=[[eventcount objectAtIndex:0] valueForKey:@"event_location"];

            }
     if (![[[eventcount objectAtIndex:0] valueForKey:@"event_department"] isEqual:@""]) {
        
         
         [self.eventCategoryButton setTitle:[[eventcount objectAtIndex:0] valueForKey:@"event_department"] forState:UIControlStateNormal];
                
            }
            
        

    if (![[[eventcount objectAtIndex:0] valueForKey:@"hoster"] isEqual:@""]) {
    self.username.text=[[eventcount objectAtIndex:0] valueForKey:@"hoster"];
          self.titleUsername.text=[[eventcount objectAtIndex:0] valueForKey:@"hoster"];
     }
    
    else
    {
        self.username.text=@"N/A";
        self.titleUsername.text=@"N/A";
        
    }
   if (![[[eventcount objectAtIndex:0] valueForKey:@"event_description"] isEqual:@""]) {
    self.commentTextView.text=[[eventcount objectAtIndex:0] valueForKey:@"event_description"];
    
        }

  
  if ([[eventcount objectAtIndex:0] valueForKey:@"event_title"]!=[NSNull null])
  {
  self.eventTitle.text=[[eventcount objectAtIndex:0] valueForKey:@"event_title"];


      CGSize maximumSize = CGSizeMake(170, 9999);
// UIFont *myFont = [UIFont fontWithName:@"System Bold" size:18];
  // titleSize = [[[eventcount objectAtIndex:0] valueForKey:@"event_title"] sizeWithFont:self.eventTitle.font constrainedToSize:maximumSize lineBreakMode:self.eventTitle.lineBreakMode];

        titleSize=[self.eventTitle.text sizeWithFont:self.eventTitle.font];

      DLog(@"title width=%f",titleSize.width);
       DLog(@"title height=%f",titleSize.height);

    int lines = [self.eventTitle.text sizeWithFont:self.eventTitle.font constrainedToSize:maximumSize
        lineBreakMode:NSLineBreakByWordWrapping].height /self.eventTitle.font.pointSize;

          DLog(@"lines=%d",lines);

            if (lines<=1)
            {
                [self.readmoreTitleButton removeFromSuperview];
                
            }
             
  }
            NSString *imageurl= [[eventcount objectAtIndex:0] valueForKey:@"event_image_url"];
            
            imageurl = [imageurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if (![imageurl isEqual:@""])
            {
               
            UIImage *cachedImage = [self.imageCache objectForKey:imageurl];
            if (cachedImage)
            {
                self.eventImage.image = cachedImage;
            }
            else
            {
                // you'll want to initialize the image with some blank image as a placeholder
                UIActivityIndicatorView *eventimageloading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
                eventimageloading.center = CGPointMake(self.eventImage.frame.size.width/2, self.eventImage.frame.size.height/2);
                eventimageloading.alpha = 1.0;
                eventimageloading.hidesWhenStopped = YES;
                [eventimageloading startAnimating];
                [self.eventImage addSubview:eventimageloading];
                self.EventImageButton.userInteractionEnabled=NO;
                
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
                            self.eventImage.image = i;
                            [eventimageloading removeFromSuperview];
                            [eventimageloading stopAnimating];
                              self.EventImageButton.userInteractionEnabled=YES;
                        }];
                    }
                   
                }];
                
            }
                
            }

     }

        else  if ([[dict objectForKey:@"status"] isEqual:@"e"])
        {
            [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            [appDel removeLoader];
        }
        
        else if (dict==nil)
        {
            
            [[[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            [appDel removeLoader];
            
        }

        //   [activityIndicator stopAnimating];
        //  [activityIndicator removeFromSuperview];
         
    }
    
    if (request==updateevents)
    {
        updateevents=nil;
        NSString *response  =  [request responseString];
        DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
            if (listoflocation==nil && eventdetails==nil && deleteevents==nil && updateevents==nil)
            {

            AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
              appDel.attendevent=TRUE;
                appDel.attendeventpage=TRUE;
             appDel.circlecount=0;
                
                NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
                
                [viewControllers removeLastObject];
                  [viewControllers removeLastObject];
                 EventPageAttend *ep=[[EventPageAttend alloc] initWithNibName:@"EventPageAttend" bundle:nil];
                [viewControllers addObject:ep];
                CATransition* transition = [CATransition animation];
                [transition setType:kCATransitionPush];
                [transition setSubtype:kCATransitionFromLeft];
                
                [self.navigationController.view.layer
                 addAnimation:transition forKey:kCATransition];
            
         [self.navigationController setViewControllers:viewControllers animated:NO];
                
            }
        }
        
        else  if ([[dict objectForKey:@"status"] isEqual:@"e"])
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
    
    if (request==deleteevents)
    {
        deleteevents=nil;
        NSString *response  =  [request responseString];
        DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
             
            
            if (listoflocation==nil && eventdetails==nil && deleteevents==nil && updateevents==nil)

            {
                AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
                appDel.enterscreen=TRUE;
                appDel.circlecount=0;
                NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:[appDel.navController viewControllers]];
                
                [viewControllers removeLastObject];
                [viewControllers removeLastObject];
                
                DLog(@"array=%@",viewControllers);
        [appDel.navController setViewControllers:viewControllers animated:YES];
                
            }

              //  [self.navigationController popViewControllerAnimated:YES];
          /*  CampusEventsViewController *events=[[CampusEventsViewController alloc]initWithNibName:@"CampusEventsViewController" bundle:nil];
        [[self navigationController]pushViewController:events animated:YES];
           */
            
        }
        
        else  if ([[dict objectForKey:@"status"] isEqual:@"e"])
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
    [CATransaction setDisableActions:YES];

    [[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
   // NSString *response  =  [request responseString];
   // DLog(@"response=%@",response);
   
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel removeLoader];
    
    
}

# pragma mark tableview methods

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
    DLog(@"count=%d",locationList.count);
    return locationList.count;
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
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 220, 20)];
    nameLabel.backgroundColor=[UIColor clearColor];
    nameLabel.text=[[locationList objectAtIndex:indexPath.row] objectForKey:@"event_location"];
    DLog(@"TEXT=%@",nameLabel.text);
    [nameLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:15.0]];
    nameLabel.numberOfLines=0;
    
    nameLabel.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1] ;
    [cell.contentView addSubview:nameLabel];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
    self.locationTextField.text=[[locationList objectAtIndex:indexPath.row] objectForKey:@"event_location"];
      [self singleTapGestureForTable];
   // self.locationTextField.textColor=[UIColor blackColor];
}


# pragma mark TimePicker View Methods

-(void) makeTimePickerview
{
    
    timePicker = [[UIDatePicker alloc] init];
    timePicker.frame=CGRectMake(self.timeButton.frame.origin.x, self.timeButton.frame.origin.y+self.timeButton.frame.size.height, 192, 216);
    timePicker.datePickerMode = UIDatePickerModeTime;
    
    [timePicker addTarget:self action:@selector(TimepickerChanged:)forControlEvents:UIControlEventValueChanged];
    [self.Backgroundscroller addSubview:timePicker];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    timetofill = [outputFormatter stringFromDate:[NSDate date]];
    // self.timeButton.titleLabel.numberOfLines=0;
    [self.timeButton.titleLabel sizeToFit];
    DLog(@"timefill=%@",timetofill);
   // [self.timeButton setTitle:timetofill forState:UIControlStateNormal];
    
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame: CGRectMake(0, 0, 192,30)];
    toolbar.barStyle = UIBarStyleBlackOpaque;
    //  toolbar.backgroundColor=[UIColor lightGrayColor];
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle: @"Done" style: UIBarButtonItemStyleBordered target: self action: @selector(donePressedTime)];
    UIBarButtonItem* flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolbar.items = [NSArray arrayWithObjects:flexibleSpace, doneButton, nil];
    
    [timePicker addSubview: toolbar];
    
    
}
- (void)TimepickerChanged:(id)sender
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    
    timetofill = [outputFormatter stringFromDate:[sender date]];
    // self.timeButton.titleLabel.numberOfLines=0;
    [self.timeButton.titleLabel sizeToFit];
    [self.timeButton setTitle:timetofill forState:UIControlStateNormal];
    self.eventDateTitleLabel.text=timetofill;
    DLog(@"TIME=%@",timetofill);
}





-(IBAction) timePicker:(id)sender
{
     [self.eventTitle resignFirstResponder];
    self.locationTextField.userInteractionEnabled=NO;
    if (!selectPicker)
    {
        timePicker.hidden=NO;
        selectPicker=TRUE;
    }
    
}

- (void)donePressedTime
{
    timePicker.hidden=YES;
    selectPicker=FALSE;
     self.locationTextField.userInteractionEnabled=YES;
    [self.timeButton.titleLabel sizeToFit];
    [self.timeButton setTitle:timetofill forState:UIControlStateNormal];
   // self.timeButton.titleLabel.textColor=[UIColor blackColor];
}

# pragma mark EventCategoryPicker View Methods

- (IBAction)eventListPicker:(id)sender

{
    if (!selectPicker) {
        eventCategoryPicker.hidden=NO;
        selectPicker=TRUE;
    }
}



-(void) makeCategoryPickerview
{
    eventCategoryPicker=[[UIPickerView alloc] init];
    eventCategoryPicker.frame=CGRectMake(self.eventCategoryButton.frame.origin.x, self.eventCategoryButton.frame.origin.y, 256, 0);
    
    eventCategoryPicker.dataSource=self;
    eventCategoryPicker.delegate=self;
    eventCategoryPicker.showsSelectionIndicator=YES;
    
    [self.Backgroundscroller addSubview:eventCategoryPicker];
    
    if (categoryserial==0)
    {
         eventcategory=@"After Hours";
    }
    else if (categoryserial==1)
    {
        eventcategory=@"Campus Events";
    
    }
    
    //[self.weekButton setTitle:dayName forState:UIControlStateNormal];
    
    eventList = [[NSMutableArray alloc] init];
   
        [eventList addObject:@"After Hours"];
        [eventList addObject:@"Campus Events"];
    
    // [eventList  addObject:@"Athletics"];
    
    
    [self.eventCategoryButton.titleLabel sizeToFit];
   // [self.eventCategoryButton setTitle:@"Campus Events" forState:UIControlStateNormal];
    
    DLog(@"CATEGORY SERIAL=%d",categoryserial);
    [eventCategoryPicker selectRow:categoryserial inComponent:0 animated:NO];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame: CGRectMake(0, 0, 256,30)];
    toolbar.barStyle = UIBarStyleBlackOpaque;
    //  toolbar.backgroundColor=[UIColor lightGrayColor];
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle: @"Done" style: UIBarButtonItemStyleBordered target: self action: @selector(donePressedEventCategory)];
    UIBarButtonItem* flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolbar.items = [NSArray arrayWithObjects:flexibleSpace, doneButton, nil];
    
    [eventCategoryPicker addSubview: toolbar];
    
    // mlabel.text= [arrayNo objectAtIndex:[pickerView selectedRowInComponent:0]];
    
}

- (void)donePressedEventCategory
{
    [self.eventCategoryButton setTitle:eventcategory forState:UIControlStateNormal];
    eventCategoryPicker.hidden=YES;
    selectPicker=FALSE;

    //self.eventCategoryButton.titleLabel.textColor=[UIColor blackColor];
    
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self.view removeGestureRecognizer:singleTap];
    [self.locationTextField resignFirstResponder];
       
    if (pickerView==eventCategoryPicker)
    {
        [self.eventCategoryButton.titleLabel sizeToFit];
        eventcategory=[eventList objectAtIndex:row];
        [self.eventCategoryButton setTitle:eventcategory forState:UIControlStateNormal];
        // self.eventCategoryButton.titleLabel.textColor=[UIColor blackColor];
    }
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
   if (pickerView==eventCategoryPicker)
    {
        return [eventList count];
        
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    
    if (pickerView==eventCategoryPicker)
    {
        return [eventList objectAtIndex:row];
        
    }
    return 0;
}

# pragma mark Week Action

- (IBAction)weekPicker:(id)sender
{
     [self.eventTitle resignFirstResponder];
     self.locationTextField.userInteractionEnabled=NO;
    if (!selectPicker)
    {
        datePicker.hidden=NO;
        selectPicker=TRUE;
    }
    
    
}


# pragma mark DatePicker View Methods

-(void) makeDatePickerview
{
    
    datePicker = [[UIDatePicker alloc] init];
  datePicker.frame=CGRectMake(self.timeButton.frame.origin.x, self.dateButton.frame.origin.y+self.dateButton.frame.size.height, 268, 216);
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [datePicker addTarget:self action:@selector(DatepickerChanged:) forControlEvents:UIControlEventValueChanged];
    [self.Backgroundscroller addSubview:datePicker];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"MMM  d, YYYY"];
    datetofill = [outputFormatter stringFromDate:[NSDate date]];
    //self.dateButton.titleLabel.numberOfLines=0;
    [self.dateButton.titleLabel sizeToFit];
    DLog(@"timefill=%@",timetofill);
   //  datetofill = [outputFormatter stringFromDate:[NSDate date]];
   // [self.dateButton setTitle:timetofill forState:UIControlStateNormal];
    
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame: CGRectMake(0, 0, 268,30)];
    toolbar.barStyle = UIBarStyleBlackOpaque;
    //  toolbar.backgroundColor=[UIColor lightGrayColor];
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle: @"Done" style: UIBarButtonItemStyleBordered target: self action: @selector(donePressedDate)];
    UIBarButtonItem* flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolbar.items = [NSArray arrayWithObjects:flexibleSpace, doneButton, nil];
    
    [datePicker addSubview: toolbar];
    
    
}
- (void) DatepickerChanged:(id)sender
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"MMM  d, YYYY"];
    
    datetofill = [outputFormatter stringFromDate:[sender date]];
    // self.dateButton.titleLabel.numberOfLines=0;
    [self getDayAccordingToDate];
    [self.dateButton.titleLabel sizeToFit];
    [self.dateButton setTitle:datetofill forState:UIControlStateNormal];
    // self.dateButton.titleLabel.textColor=[UIColor blackColor];
    DLog(@"TIME=%@",datetofill);
}





-(IBAction) datePicker:(id)sender
{
    [self.eventTitle resignFirstResponder];
     self.locationTextField.userInteractionEnabled=NO;
    if (!selectPicker)
    {
        datePicker.hidden=NO;
        selectPicker=TRUE;
    }
    
}



- (void)donePressedDate
{
    datePicker.hidden=YES;
    selectPicker=FALSE;
     self.locationTextField.userInteractionEnabled=YES;
    [self getDayAccordingToDate];
    self.weekButton.titleLabel.textColor=[UIColor colorWithRed:(73.0/255.0) green:(73.0/255.0) blue:(73.0/255.0) alpha:1.0];
    [self.dateButton setTitle:datetofill forState:UIControlStateNormal];
    self.dateButton.titleLabel.textColor=[UIColor colorWithRed:(73.0/255.0) green:(73.0/255.0) blue:(73.0/255.0) alpha:1.0];
    
}

-(void) getDayAccordingToDate
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, yyy"];
    NSDate *date = [formatter dateFromString:datetofill];
    //DLog(@"%@", [formatter stringFromDate:date]);
    
    NSDateFormatter *weekDay = [[NSDateFormatter alloc] init];
    [weekDay setDateFormat:@"EEEE"];
    
    NSDateFormatter *calMonth = [[NSDateFormatter alloc] init];
    [calMonth setDateFormat:@"MMMM"];
    
    // DLog(@"%@ %i %@ %i", [weekDay stringFromDate:date], day, [calMonth stringFromDate:date], year );
    daytofill=[weekDay stringFromDate:date];
    [self.weekButton setTitle:daytofill forState:UIControlStateNormal];
    
    
}



# pragma mark inviteFriends

-(IBAction)inviteFriends:(id)sender
{
    UIApplication *application= [UIApplication sharedApplication];
    application.statusBarHidden=NO;
   // self.view.frame = CGRectMake(0, 20,320,568);
    [self singleTapGesture];
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.enterFromCircle=TRUE;
    
    inviteFriends *invitefriends=[[inviteFriends alloc] initWithNibName:@"inviteFriends" bundle:nil];
     [self presentViewController:invitefriends animated:YES completion:nil];
  //  [self presentModalViewController:invitefriends animated:YES];
    
    
}



#pragma mark TextView Delegate


-(void)textViewDidBeginEditing:(UITextView *)textView
{
    singleTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGesture)];
      self.commentTextView.textColor=[UIColor colorWithRed:(73.0/255.0) green:(73.0/255.0) blue:(73.0/255.0) alpha:1] ;
    self.commentTextView.scrollEnabled=YES;
    [self.view addGestureRecognizer:singleTap];
    
    if ([self.commentTextView.text isEqual:@"Enter something describing your event. Keep it brief."])
    {
        self.commentTextView.text=@"";
        
        
    }
    
   
    if (self.readmorebuttonview!=nil)
    {
        [self readmore];
    }
    
    //textView.text=@"";
   // textView.textColor=[UIColor blackColor];
    self.Backgroundscroller.contentOffset=CGPointMake(0, 250);
    self.Backgroundscroller.contentSize=CGSizeMake(0,  self.Backgroundscroller.contentSize.height+150);
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    UIApplication *application= [UIApplication sharedApplication];
    [self.view removeGestureRecognizer:singleTap];
    application.statusBarHidden=NO;
    if (textView.text.length==0) {
        textView.textColor=[UIColor lightGrayColor];
        textView.text=@"Enter something describing your event. Keep it brief.";
    }
   self.Backgroundscroller.contentOffset=CGPointMake(0, 0);
    self.Backgroundscroller.contentSize=CGSizeMake(0,  self.Backgroundscroller.contentSize.height-150);

    
    
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
-(IBAction)closeevent:(id)sender{
    
    if (listoflocation==nil && eventdetails==nil && deleteevents==nil && updateevents==nil)
    {
        AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
        
        appDel.circlecount=0;
        [self.navigationController popViewControllerAnimated:YES];

    }
      
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    textField.placeholder=@"";
    singleTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGesture)];
    [self.view addGestureRecognizer:singleTap];
    
    self.buttonBgImage.userInteractionEnabled=NO;
    self.updateEvent.userInteractionEnabled=NO;
    
    if (textField==self.locationTextField)
    {
       
         self.Backgroundscroller.contentOffset=CGPointMake(0, 170);
         self.Backgroundscroller.contentSize=CGSizeMake(0,  self.Backgroundscroller.contentSize.height+70);
    }
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    self.buttonBgImage.userInteractionEnabled=YES;
    self.updateEvent.userInteractionEnabled=YES;
    
    [textField resignFirstResponder];
    [self.view removeGestureRecognizer:singleTap];
    
    if (textField==self.eventTitle)
    {
        if (textField.text.length==0)
        {
            self.eventTitle.placeholder=@"Event Name";
        }
        
    }
    if (textField==self.locationTextField)
    {
        if (textField.text.length!=0) {
            self.locationTextField.textColor=[UIColor colorWithRed:(73.0/255.0) green:(73.0/255.0) blue:(73.0/255.0) alpha:1.0];
        }
        else
        {
                self.locationTextField.placeholder=@"Location";
        
        }
        self.Backgroundscroller.contentOffset=CGPointMake(0, 0);
        self.Backgroundscroller.contentSize=CGSizeMake(0,  self.Backgroundscroller.contentSize.height-70);

    }
    
    
}


- (IBAction)singleTapGesture
{
    
    [self.commentTextView resignFirstResponder];
    [self.eventTitle resignFirstResponder];
    [self singleTapGestureForTable];
    if (self.locationTextField.text.length==0)
    {
     self.locationTextField.placeholder=@"Location";
        
    }
}
- (IBAction) singleTapGestureForTable
{
    [self.locationTextField resignFirstResponder];
    self.tableview.hidden=YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.tableview.hidden=YES;
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setEventImage:nil];
    [self setTimeButton:nil];
    [self setWeekButton:nil];
    [self setDateButton:nil];
    [self setReadmoreButton:nil];
    [self setLocationTextField:nil];
    [self setProfileImage:nil];
    [self setProfileName:nil];
    [self setInviteFriendsButton:nil];
    [self setEventCategoryButton:nil];
    [self setTitleUsername:nil];
    [self setTitleUsername:nil];
    [self setTitleUsername:nil];
    [self setUsername:nil];
    [self setEventTitle:nil];
    [self setEventDateTitleLabel:nil];
    [self setUpdateEvent:nil];
    [self setEventImageButton:nil];
    [super viewDidUnload];
}

@end
