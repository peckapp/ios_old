//
//  CreateEventViewController.m
//  PeckApp
//
//  Created by STPL MAC on 4/23/13.
//  Copyright (c) 2013 stpl. All rights reserved.
//

#import "CreateEventViewController.h"
#import "AppDelegate.h"

@implementation CreateEventViewController
@synthesize locationTextField,commentTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    self.EventTitle.autocapitalizationType=UITextAutocapitalizationTypeWords;
    
    commentTextView.layer.cornerRadius=0;
    self.locationTextField.layer.cornerRadius=0;
    self.tableview.showsVerticalScrollIndicator=YES;

    if (appDel.circlecount==0)
    {
        [self.inviteFriendsButton setTitle:@"Invite Friends" forState:UIControlStateNormal];
            appDel.listcircle=@"";
    }
    
    else
    {
        
        [self.inviteFriendsButton setTitle:[NSString stringWithFormat: @"%d %@", (int)appDel.circlecount, @" Friends Added "] forState:UIControlStateNormal];
    self.inviteFriendsButton.titleLabel.textColor=[UIColor colorWithRed:(73.0/255.0) green:(73.0/255.0) blue:(73.0/255.0) alpha:1.0];
        
    }
    appDel.eventid=@"";
    if (appDel.attendevent)
    {
        [appDel addLoaderForViewController:self];
    
        commentTextView.font=[UIFont fontWithName:@"Lato-Regular" size:16.0];
        [self makeTimePickerview];
        [self makeDatePickerview];
        [self makeCategoryPickerview];
        timePicker.hidden=YES;
        datePicker.hidden=YES;
        eventCategoryPicker.hidden=YES;
        self.tableview.hidden=YES;
      //  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     //   NSString *uid = [defaults valueForKey:@"userid"];
        
        locationList = [[NSMutableArray alloc] init];
        [self.locationTextField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
        listoflocation =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:LocationList]] ;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *uid = [defaults valueForKey:@"userid"];
        [listoflocation setPostValue:uid forKey:@"userid"];
        [listoflocation setDelegate:self];
        [listoflocation startAsynchronous];
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
        
        
        for(int i=0; i<[locationList count]; i++)
        {
            
            // NSMutableArray *filterarray=[[NSMutableArray alloc]init];
            NSString *match=self.locationTextField.text;
            match = [match lowercaseString];
            NSString *department = [[locationList objectAtIndex:i] valueForKey:@"event_location"];
            department = [department lowercaseString];
            NSRange range = [department rangeOfString:match options:NSCaseInsensitiveSearch];
            ///addressRange=[address rangeOfString:match options:NSCaseInsensitiveSearch];
            if (range.location==0) {
                [filterarray addObject:[locationList objectAtIndex:i]];
            }
            
            
        }
        
        locationList=filterarray;
    DLog(@"newarray=%@",locationList);
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
    [self.EventTitle resignFirstResponder];
    
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
      
    
        //[imagePicker viewWillAppear:YES];
        
            
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


# pragma mark create Event

-(IBAction)createevent:(id)sender
{
    for (UIView *view in [self.view subviews])
    {
        if([view  isKindOfClass:[UITextField class]])
        {
            UITextField *textField = (UITextField *)view;
            [textField resignFirstResponder];
        }
    
    }
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
   
    DLog(@"list=%@",appDel.listcircle);
    if (self.EventTitle.text.length<=80) {
         [appDel addLoaderForViewController:self];
    createnewevent =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:CreateNewEvent]] ;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults valueForKey:@"userid"];
    [createnewevent setPostValue:uid forKey:@"userid"];
        
    [createnewevent setPostValue:[self.EventTitle.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  forKey:@"event_name"];
    NSData *imageData = UIImageJPEGRepresentation(self.buttonImageView.image, 0.1);

    NSString *image = [imageData base64EncodedString];


    if (self.buttonImageView.image!=[UIImage imageNamed:@"bg_image.png"])
    {
        [createnewevent setPostValue:image forKey:@"event_picture"];
    }
    
    [createnewevent setPostValue:self.timeButton.titleLabel.text forKey:@"event_time"];
    [createnewevent setPostValue:self.weekButton.titleLabel.text forKey:@"event_day"];
     [createnewevent setPostValue:self.dateButton.titleLabel.text forKey:@"event_date"];
    [createnewevent setPostValue:self.locationTextField.text forKey:@"event_location"];
    [createnewevent setPostValue:appDel.listcircle forKey:@"event_members"];
    if (![self.commentTextView.text isEqual:@"Enter something describing your event. Keep it brief."])
        {
             [createnewevent setPostValue:self.commentTextView.text forKey:@"event_description"];
        }
   
     [createnewevent setPostValue:self.eventCategoryButton.titleLabel.text forKey:@"event_type"];
    [createnewevent setDelegate:self];
    [createnewevent startAsynchronous];
        
}
    else 
    {
        
        [[[UIAlertView alloc]initWithTitle:alertTitle message:@"You can not enter more than 80 characters for Title" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }
    

}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
       
 

    if (request==listoflocation)
    {
        [CATransaction setDisableActions:YES];
        NSString *response = [[request responseString] stringByReplacingOccurrencesOfString:@"&#x27;" withString:@"'"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&rsquo;" withString:@"'"];
        

        DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
         dict = [dict dictionaryByReplacingNullsWithStrings];
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
    
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
                
                
            }
            else if ([[dict objectForKey:@"status"] isEqual:@"e"])
            {
                
        [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                
            }
        
            else if (dict==nil)
            {
                
                [[[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                  
            }
        [appDel removeLoader];
    }
    if (request==createnewevent)
    {
        NSString *response  =  [request responseString];
        DLog(@"response=%@",response);
        
         NSMutableDictionary *dict=[response JSONValue];
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
        AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
            appDel.enterscreen=TRUE;
            appDel.circlecount=0;
           [self dismissViewControllerAnimated:YES completion:nil];
            
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
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [CATransaction setDisableActions:YES];

    [[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    [self.inviteFriendsButton setTitle:@"Invite Friends" forState:UIControlStateNormal];
    appDel.listcircle=@"";
    //NSString *response  =  [request responseString];
   // DLog(@"response=%@",response);
    [appDel removeLoader];
    
}


# pragma mark Tableviewdelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DLog(@"count=%d",locationList.count);
    return locationList.count;
}

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
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
    DLog(@"locationttext=%@",[[locationList objectAtIndex:indexPath.row] objectForKey:@"event_location"]);
     self.locationTextField.textColor=[UIColor colorWithRed:(73.0/255.0) green:(73.0/255.0) blue:(73.0/255.0) alpha:1.0];
     [self singleTapGestureForTable];
}


# pragma mark TimePicker View Methods

-(void) makeTimePickerview
{
    
    timePicker = [[UIDatePicker alloc] init];
    timePicker.frame=CGRectMake(self.timeButton.frame.origin.x, self.timeButton.frame.origin.y+self.timeButton.frame.size.height, 192, 216);
    timePicker.datePickerMode = UIDatePickerModeTime;
    
    [timePicker addTarget:self action:@selector(TimepickerChanged:)forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:timePicker];
    
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
    [self.timeButton setTitleColor:[UIColor colorWithRed:(73.0/255.0) green:(73.0/255.0) blue:(73.0/255.0) alpha:1.0]forState:UIControlStateNormal];
    DLog(@"TIME=%@",timetofill);
}





-(IBAction) timePicker:(id)sender
{
    [self.EventTitle resignFirstResponder];
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
    self.timeButton.titleLabel.textColor=[UIColor colorWithRed:(73.0/255.0) green:(73.0/255.0) blue:(73.0/255.0) alpha:1.0];
}

# pragma mark EventCategoryPicker View Methods

- (IBAction)eventListPicker:(id)sender

{
       [self.EventTitle resignFirstResponder];
    if (!selectPicker)
    {
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
    
    [self.view addSubview:eventCategoryPicker];
    
    //[self.weekButton setTitle:dayName forState:UIControlStateNormal];
    
    eventList = [[NSMutableArray alloc] init];
    [eventList addObject:@"After Hours"];
    //[eventList  addObject:@"Athletics"];
    [eventList addObject:@"Campus Events"];
    
    [self.eventCategoryButton.titleLabel sizeToFit];
    eventcategory=@"Campus Events";
    //[self.eventCategoryButton setTitle:@"Campus Events" forState:UIControlStateNormal];

  
    [eventCategoryPicker selectRow:1 inComponent:0 animated:NO];
    
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
     [self.eventCategoryButton setTitleColor:[UIColor colorWithRed:(73.0/255.0) green:(73.0/255.0) blue:(73.0/255.0) alpha:1.0]forState:UIControlStateNormal];
    eventCategoryPicker.hidden=YES;
    selectPicker=FALSE;

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
     [self.EventTitle resignFirstResponder];
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
    [self.view addSubview:datePicker];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"MMM  d, YYYY"];
    datetofill = [outputFormatter stringFromDate:[NSDate date]];
    
    //self.dateButton.titleLabel.numberOfLines=0;
    [self.dateButton.titleLabel sizeToFit];
    DLog(@"timefill=%@",timetofill);
    //[self.dateButton setTitle:timetofill forState:UIControlStateNormal];
    
    
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
       [self.EventTitle resignFirstResponder];
    self.locationTextField.userInteractionEnabled=NO;
    if (!selectPicker) {
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
    [self.weekButton setTitleColor:[UIColor colorWithRed:(73.0/255.0) green:(73.0/255.0) blue:(73.0/255.0) alpha:1.0]forState:UIControlStateNormal];
    
   [self.dateButton setTitle:datetofill forState:UIControlStateNormal];
    [self.dateButton setTitleColor:[UIColor colorWithRed:(73.0/255.0) green:(73.0/255.0) blue:(73.0/255.0) alpha:1.0]forState:UIControlStateNormal];

}

-(void) getDayAccordingToDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, yyy"];
    NSDate *date = [formatter dateFromString:datetofill];
   // DLog(@"%@", [formatter stringFromDate:date]);
    
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
    self.view.frame = CGRectMake(0, 20,320,568);
    [self singleTapGesture];
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.enterFromCircle=TRUE;
    
    inviteFriends *invitefriends=[[inviteFriends alloc] initWithNibName:@"inviteFriends" bundle:nil];
     [self presentViewController:invitefriends animated:YES completion:nil];
    //[self presentModalViewController:invitefriends animated:YES];
    

}



#pragma mark TextView Delegate


-(void)textViewDidBeginEditing:(UITextView *)textView
{
    singleTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGesture)];

      [self.view addGestureRecognizer:singleTap];
    if ([textView.text isEqual:@"Enter something describing your event. Keep it brief."]) {
        textView.text=@"";
    }
    
    textView.textColor=[UIColor colorWithRed:(73.0/255.0) green:(73.0/255.0) blue:(73.0/255.0) alpha:1.0];
    UIApplication *application= [UIApplication sharedApplication];
    
    application.statusBarHidden=YES;

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-215.0,self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    UIApplication *application= [UIApplication sharedApplication];
    [self.view removeGestureRecognizer:singleTap];
    application.statusBarHidden=NO;
    if (textView.text.length==0) {
         textView.textColor=[UIColor lightGrayColor];
        textView.text=@"Enter something describing your event. Keep it brief.";
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
 self.view .frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+215.0,self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
    
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

    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.circlecount=0;
    [self dismissViewControllerAnimated:YES completion:nil];
  //[self dismissModalViewControllerAnimated:YES];

}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{

    textField.placeholder=@"";
    singleTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGesture)];
    [self.view addGestureRecognizer:singleTap];
   
    self.buttonBgImage.userInteractionEnabled=NO;
    if (textField==self.locationTextField)
    {
    
        UIApplication *application= [UIApplication sharedApplication];
        
        application.statusBarHidden=YES;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-210.0,
                                     self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];

    }
    

}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
   
    self.buttonBgImage.userInteractionEnabled=YES;
    [textField resignFirstResponder];
       [self.view removeGestureRecognizer:singleTap];
    if (textField==self.EventTitle)
    {
        if (textField.text.length==0)
        {
          self.EventTitle.placeholder=@"Event Name";
        }
        
    }
     if (textField==self.locationTextField)
     {
         if (textField.text.length!=0)
         {
             self.locationTextField.textColor=[UIColor colorWithRed:(73.0/255.0) green:(73.0/255.0) blue:(73.0/255.0) alpha:1.0];
             
         }
         
         else
         {
            textField.placeholder=@"Location";
         
         }
                   
    UIApplication *application= [UIApplication sharedApplication];
         
         application.statusBarHidden=NO;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
         
    self.view .frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+210.0,self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];

     }
    
}


- (IBAction)singleTapGesture{
    
    [commentTextView resignFirstResponder];
    [self.EventTitle resignFirstResponder];
    [self singleTapGestureForTable];
    if (self.locationTextField.text.length==0) {
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
    [self setButtonBgImage:nil];
    [self setTimeButton:nil];
    [self setWeekButton:nil];
    [self setDateButton:nil];
    [self setLocationTextField:nil];
    [self setProfileImage:nil];
    [self setProfileName:nil];
    [self setInviteFriendsButton:nil];
    [self setEventCategoryButton:nil];
    [super viewDidUnload];
}
- (IBAction)week:(id)sender {
}
- (IBAction)dateButton:(id)sender {
}
- (IBAction)locationTextField:(id)sender {
}
@end
