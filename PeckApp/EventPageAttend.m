//
//  EventPageAttend.m
//  PeckApp
//
//  Created by SRM Techsol Pvt. Ltd. on 5/8/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "EventPageAttend.h"



@implementation EventPageAttend


@synthesize attendEventBtn,eventcount,dateAndTime,username,profileImage,eventTitle,commentTextView,headerView,eventImage;
const int numberOfSharedItems = 5;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark editEvent
-(IBAction) editEvents:(id)sender
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.attendevent=TRUE;
     
    EditEventPage *editEventPage=[[EditEventPage alloc] initWithNibName:@"EditEventPage" bundle:nil];
    [self.navigationController pushViewController:editEventPage animated:YES];


}


#pragma mark eventAttendMembers


-(IBAction) eventAttendingMembers:(id)sender
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.enterFromEvent=TRUE;
    EventAttendingList *eventattendinglist=[[EventAttendingList alloc] initWithNibName:@"EventAttendingList" bundle:nil];
    [self presentViewController:eventattendinglist animated:YES completion:nil];
   // [self presentModalViewController:eventattendinglist animated:YES];
    
}

# pragma mark ReadMoreTitle

-(IBAction) readmoreTitle:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    
    
    self.headerView.frame=CGRectMake(self.headerView.frame.origin.x, self.headerView.frame.origin.y, self.headerView.frame.size.width, self.headerView.frame.size.height+titleSize.height-20);
    
    
    self.eventTitle.frame=CGRectMake(self.eventTitle.frame.origin.x,self.eventTitle.frame.origin.y, self.eventTitle.frame.size.width, titleSize.height);
    
    
    self.Backgroundscroller.frame=CGRectMake(self.Backgroundscroller.frame.origin.x, self.headerView.frame.origin.y+self.headerView.frame.size.height, self.Backgroundscroller.frame.size.width, self.Backgroundscroller.frame.size.height);
    
    //   CGRect deviceDimension = [[UIScreen mainScreen] bounds];
    
    self.Backgroundscroller.scrollEnabled=YES;
    self.Backgroundscroller.contentSize=CGSizeMake(0, self.Backgroundscroller.contentSize.height+titleSize.height);
    
    //self.readmoreTitleButton.hidden=YES;
    [self.readmoreTitleButton removeFromSuperview];
    
    
    [UIView commitAnimations];
}


#pragma mark readmoredate

-(IBAction) readmoredate:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    
    [self shiftondateclick];
    [UIView commitAnimations];
    
    
}

-(void) shiftondateclick
{

    if (linesindate>1)
    {
        self.dateAndTime.frame=CGRectMake( self.dateAndTime.frame.origin.x,  self.dateAndTime.frame.origin.y-2, self.dateAndTime.frame.size.width, self.dateAndTime.frame.size.height);
        
        [self.dateAndTime sizeToFit];
        
        linesindate= (self.dateAndTime.frame.origin.y+self.dateAndTime.frame.size.height+8-(self.firstlineview.frame.origin.y+self.firstlineview.frame.size.height));
        
        self.Backgroundscroller.scrollEnabled=YES;
    }
    else
    {
        linesindate=0;
        
    }
    
    
//   self.dateAndTime.frame=CGRectMake(self.dateAndTime.frame.origin.x,  self.dateAndTime.frame.origin.y, self.dateAndTime.frame.size.width, self.dateAndTime.frame.size.height+(linesindate));
    
    
 self.locationimage.frame=CGRectMake( self.locationimage.frame.origin.x,  self.locationimage.frame.origin.y+(linesindate), self.locationimage.frame.size.width, self.locationimage.frame.size.height);
    
    
    self.eventLocation.frame=CGRectMake( self.eventLocation.frame.origin.x,  self.eventLocation.frame.origin.y+(linesindate), self.eventLocation.frame.size.width, self.eventLocation.frame.size.height);
    
    self.locationbutton.frame=CGRectMake(self.locationbutton.frame.origin.x, self.locationbutton.frame.origin.y+(linesindate), self.locationbutton.frame.size.width, self.locationbutton.frame.size.height);
    
    
    self.attendmemberimage.frame=CGRectMake( self.attendmemberimage.frame.origin.x,  self.attendmemberimage.frame.origin.y+(linesindate), self.attendmemberimage.frame.size.width, self.attendmemberimage.frame.size.height);
    
    self.attendingmembersbutton.frame=CGRectMake( self.attendingmembersbutton.frame.origin.x,  self.attendingmembersbutton.frame.origin.y+(linesindate), self.attendingmembersbutton.frame.size.width, self.attendingmembersbutton.frame.size.height);
    
    self.eventAttending.frame=CGRectMake( self.eventAttending.frame.origin.x,  self.eventAttending.frame.origin.y+(linesindate), self.eventAttending.frame.size.width, self.eventAttending.frame.size.height);
    
    self.departmentimage.frame=CGRectMake(self.departmentimage.frame.origin.x,  self.departmentimage.frame.origin.y+(linesindate), self.departmentimage.frame.size.width, self.departmentimage.frame.size.height);
    
      self.departmentbutton.frame=CGRectMake(self.departmentbutton.frame.origin.x,  self.departmentbutton.frame.origin.y+(linesindate), self.departmentbutton.frame.size.width, self.departmentbutton.frame.size.height);
    
    self.username.frame=CGRectMake( self.username.frame.origin.x,  self.username.frame.origin.y+(linesindate), self.username.frame.size.width, self.username.frame.size.height);
    
    
    self.firstlineview.frame=CGRectMake( self.firstlineview.frame.origin.x,  self.firstlineview.frame.origin.y+(linesindate), self.firstlineview.frame.size.width, self.firstlineview.frame.size.height);
    
    self.secondlineview.frame=CGRectMake( self.secondlineview.frame.origin.x,  self.secondlineview.frame.origin.y+(linesindate), self.secondlineview.frame.size.width, self.secondlineview.frame.size.height);
    
    self.thirdlineview.frame=CGRectMake( self.thirdlineview.frame.origin.x,  self.thirdlineview.frame.origin.y+(linesindate), self.thirdlineview.frame.size.width, self.thirdlineview.frame.size.height);
    self.lastlineview.frame=CGRectMake( self.lastlineview.frame.origin.x,  self.lastlineview.frame.origin.y+(linesindate), self.lastlineview.frame.size.width, self.lastlineview.frame.size.height);
    
    self.attendEventBtn.frame=CGRectMake( self.attendEventBtn.frame.origin.x,  self.attendEventBtn.frame.origin.y+(linesindate), self.attendEventBtn.frame.size.width, self.attendEventBtn.frame.size.height);
    
    self.shareButton.frame=CGRectMake( self.shareButton.frame.origin.x,  self.shareButton.frame.origin.y+(linesindate), self.shareButton.frame.size.width, self.shareButton.frame.size.height);
    
    self.updateEvent.frame=CGRectMake( self.updateEvent.frame.origin.x,  self.updateEvent.frame.origin.y+(linesindate), self.updateEvent.frame.size.width, self.updateEvent.frame.size.height);
    
    self.commentTextView.frame=CGRectMake(self.commentTextView.frame.origin.x,  self.commentTextView.frame.origin.y+(linesindate), self.commentTextView.frame.size.width, self.commentTextView.frame.size.height);
    self.readmorebuttonview.frame=CGRectMake(self.readmorebuttonview.frame.origin.x,  self.readmorebuttonview.frame.origin.y+(linesindate), self.readmorebuttonview.frame.size.width, self.readmorebuttonview.frame.size.height);
    
    [self.datebutton removeFromSuperview];

 
    
  self.Backgroundscroller.contentSize=CGSizeMake(0, self.Backgroundscroller.contentSize.height+(linesindate));
    
}

# pragma mark Readmorelocation

-(IBAction) readmorelocation:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];

    [self shiftonlocationclick];
    
    [UIView commitAnimations];

    
}

-(void) shiftonlocationclick
{
   
    
       if (linesinlocation>1)
    {
        self.eventLocation.frame=CGRectMake( self.eventLocation.frame.origin.x,  self.eventLocation.frame.origin.y-2, self.eventLocation.frame.size.width, self.eventLocation.frame.size.height);
        
        [self.eventLocation sizeToFit];

         linesinlocation= (self.eventLocation.frame.origin.y+self.eventLocation.frame.size.height+10-(self.secondlineview.frame.origin.y+self.secondlineview.frame.size.height));
        
          self.Backgroundscroller.scrollEnabled=YES;
    }
    else
    {
        linesinlocation=0;
    
    }
   
    //self.locationimage.frame=CGRectMake( self.locationimage.frame.origin.x,  self.locationimage.frame.origin.y+1.5*(linesinlocation-1), self.locationimage.frame.size.width, self.locationimage.frame.size.height);
    
    self.attendmemberimage.frame=CGRectMake( self.attendmemberimage.frame.origin.x,  self.attendmemberimage.frame.origin.y+(linesinlocation), self.attendmemberimage.frame.size.width, self.attendmemberimage.frame.size.height);
    
    self.attendingmembersbutton.frame=CGRectMake( self.attendingmembersbutton.frame.origin.x,  self.attendingmembersbutton.frame.origin.y+(linesinlocation), self.attendingmembersbutton.frame.size.width, self.attendingmembersbutton.frame.size.height);
    
    self.eventAttending.frame=CGRectMake( self.eventAttending.frame.origin.x,  self.eventAttending.frame.origin.y+(linesinlocation), self.eventAttending.frame.size.width, self.eventAttending.frame.size.height);
    
    self.departmentimage.frame=CGRectMake(self.departmentimage.frame.origin.x,  self.departmentimage.frame.origin.y+(linesinlocation), self.departmentimage.frame.size.width, self.departmentimage.frame.size.height);
    
    self.departmentbutton.frame=CGRectMake(self.departmentbutton.frame.origin.x,  self.departmentbutton.frame.origin.y+(linesinlocation), self.departmentbutton.frame.size.width, self.departmentbutton.frame.size.height);

    
    self.username.frame=CGRectMake( self.username.frame.origin.x,  self.username.frame.origin.y+(linesinlocation), self.username.frame.size.width, self.username.frame.size.height);
    
    self.secondlineview.frame=CGRectMake( self.secondlineview.frame.origin.x,  self.secondlineview.frame.origin.y+(linesinlocation), self.secondlineview.frame.size.width, self.secondlineview.frame.size.height);
    
    self.thirdlineview.frame=CGRectMake( self.thirdlineview.frame.origin.x,  self.thirdlineview.frame.origin.y+(linesinlocation), self.thirdlineview.frame.size.width, self.thirdlineview.frame.size.height);
    self.lastlineview.frame=CGRectMake( self.lastlineview.frame.origin.x,  self.lastlineview.frame.origin.y+(linesinlocation), self.lastlineview.frame.size.width, self.lastlineview.frame.size.height);
    
    self.attendEventBtn.frame=CGRectMake( self.attendEventBtn.frame.origin.x,  self.attendEventBtn.frame.origin.y+(linesinlocation), self.attendEventBtn.frame.size.width, self.attendEventBtn.frame.size.height);
    
    self.shareButton.frame=CGRectMake( self.shareButton.frame.origin.x,  self.shareButton.frame.origin.y+(linesinlocation), self.shareButton.frame.size.width, self.shareButton.frame.size.height);
    
    self.updateEvent.frame=CGRectMake( self.updateEvent.frame.origin.x,  self.updateEvent.frame.origin.y+(linesinlocation), self.updateEvent.frame.size.width, self.updateEvent.frame.size.height);
    
    self.commentTextView.frame=CGRectMake(self.commentTextView.frame.origin.x,  self.commentTextView.frame.origin.y+(linesinlocation), self.commentTextView.frame.size.width, self.commentTextView.frame.size.height);
    self.readmorebuttonview.frame=CGRectMake(self.readmorebuttonview.frame.origin.x,  self.readmorebuttonview.frame.origin.y+(linesinlocation), self.readmorebuttonview.frame.size.width, self.readmorebuttonview.frame.size.height);
    
    [self.locationbutton removeFromSuperview];
    
  
    self.Backgroundscroller.contentSize=CGSizeMake(0, self.Backgroundscroller.contentSize.height+(linesinlocation));
    
}

#pragma mark readmoredepartment

-(IBAction) readmoredepartment:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    
    [self shiftondepartmentclick];
    [UIView commitAnimations];
    
    
}
-(void) shiftondepartmentclick
{
    if (linesindepartment>1)
    {
        self.username.frame=CGRectMake( self.username.frame.origin.x,  self.username.frame.origin.y-3, self.username.frame.size.width, self.username.frame.size.height);
        
        [self.username sizeToFit];
        
         linesindepartment= (self.username.frame.origin.y+self.username.frame.size.height+10-(self.lastlineview.frame.origin.y+self.lastlineview.frame.size.height));
        
         self.Backgroundscroller.scrollEnabled=YES;
    }
    else
    {
    
        linesindepartment=0;
    
    }
   

    
  //  self.username.frame=CGRectMake( self.username.frame.origin.x,  self.username.frame.origin.y, self.username.frame.size.width, self.username.frame.size.height+linesindepartment);
    
    
    self.lastlineview.frame=CGRectMake( self.lastlineview.frame.origin.x,  self.lastlineview.frame.origin.y+linesindepartment, self.lastlineview.frame.size.width, self.lastlineview.frame.size.height);
    
    self.attendEventBtn.frame=CGRectMake( self.attendEventBtn.frame.origin.x,  self.attendEventBtn.frame.origin.y+linesindepartment, self.attendEventBtn.frame.size.width, self.attendEventBtn.frame.size.height);
    
    self.shareButton.frame=CGRectMake( self.shareButton.frame.origin.x,  self.shareButton.frame.origin.y+linesindepartment, self.shareButton.frame.size.width, self.shareButton.frame.size.height);
    
    self.updateEvent.frame=CGRectMake( self.updateEvent.frame.origin.x,  self.updateEvent.frame.origin.y+linesindepartment, self.updateEvent.frame.size.width, self.updateEvent.frame.size.height);
    
    self.commentTextView.frame=CGRectMake(self.commentTextView.frame.origin.x,  self.commentTextView.frame.origin.y+linesindepartment, self.commentTextView.frame.size.width, self.commentTextView.frame.size.height);
    self.readmorebuttonview.frame=CGRectMake(self.readmorebuttonview.frame.origin.x,  self.readmorebuttonview.frame.origin.y+linesindepartment, self.readmorebuttonview.frame.size.width, self.readmorebuttonview.frame.size.height);
    
    [self.departmentbutton removeFromSuperview];
    
   
    
    self.Backgroundscroller.contentSize=CGSizeMake(0, self.Backgroundscroller.contentSize.height+linesindepartment);
    
    
}


# pragma mark ReadMoreDescription

-(IBAction) readmore:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
  
   
    self.attendEventBtn.frame=CGRectMake( self.attendEventBtn.frame.origin.x,  self.attendEventBtn.frame.origin.y+myStringSize.height-40, self.attendEventBtn.frame.size.width, self.attendEventBtn.frame.size.height);
      
       self.shareButton.frame=CGRectMake( self.shareButton.frame.origin.x,  self.shareButton.frame.origin.y+myStringSize.height-40, self.shareButton.frame.size.width, self.shareButton.frame.size.height);
    
     self.updateEvent.frame=CGRectMake( self.updateEvent.frame.origin.x,  self.updateEvent.frame.origin.y+myStringSize.height-40, self.updateEvent.frame.size.width, self.updateEvent.frame.size.height);
   
        self.commentTextView.frame=CGRectMake(self.commentTextView.frame.origin.x,  self.commentTextView.frame.origin.y, self.commentTextView.frame.size.width+50, myStringSize.height+15);

    
      
    
  //  self.commentTextView.userInteractionEnabled=YES;
  
     //CGRect deviceDimension = [[UIScreen mainScreen] bounds];
    
    self.Backgroundscroller.contentSize=CGSizeMake(0, self.Backgroundscroller.contentSize.height-40+myStringSize.height);
    self.Backgroundscroller.scrollEnabled=YES;
    
     self.readmorebuttonview.hidden=YES;
    //[self.readmorebuttonview removeFromSuperview];
    
    [UIView commitAnimations];
}


-(void)viewWillAppear:(BOOL)animated
{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    
   
    if (appDel.attendevent==TRUE)
    {
         for(UIView *subviews in [self.view subviews])
         {
             subviews.hidden=YES;
            // self.TimeandDateTitleView.hidden=YES;
             self.headerView.hidden=NO;
         
         }
        self.Backgroundscroller.scrollEnabled=NO;
        //[self.Backgroundscroller setContentOffset:CGPointMake(0,0) animated:YES];
        self.attendEventBtn.layer.cornerRadius=2.0;
        
          
    /*    self.commentTextView.frame=CGRectMake(self.commentTextView.frame.origin.x, self.commentTextView.frame.origin.y, 240, 52);
        CGRect deviceDimension = [[UIScreen mainScreen] bounds];
        

        self.updateEvent.frame=CGRectMake(self.updateEvent.frame.origin.x, deviceDimension.size.height-122, self.updateEvent.frame.size.width, self.updateEvent.frame.size.height);
        
        self.attendEventBtn.frame=CGRectMake( self.attendEventBtn.frame.origin.x, deviceDimension.size.height-122, self.attendEventBtn.frame.size.width, self.attendEventBtn.frame.size.height);
        
        self.shareButton.frame=CGRectMake( self.shareButton.frame.origin.x, deviceDimension.size.height-122, self.shareButton.frame.size.width, self.shareButton.frame.size.height);
        
        */
       self.readmorebuttonview.frame=CGRectMake(self.readmorebuttonview.frame.origin.x, self.commentTextView.frame.origin.y+self.commentTextView.frame.size.height/2-6, self.readmorebuttonview.frame.size.width, self.readmorebuttonview.frame.size.height);
     self.readmoreButton.titleLabel.font= [UIFont italicSystemFontOfSize:self.readmoreButton.titleLabel.font.pointSize];
    
       // self.readmoreTitleButton.hidden=YES;
       // self.readmorebuttonview.hidden=YES;
        [appDel addLoaderForViewController:self];
        DLog(@"eventid=%@",appDel.eventid);
        eventdetails =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:singleCampusEventView]] ;
        [eventdetails setDelegate:self];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *uid = [defaults valueForKey:@"userid"];
        [eventdetails setPostValue:appDel.eventid forKey:@"eventid"];
        [eventdetails setPostValue:uid forKey:@"userid"];
        [eventdetails setPostValue:appDel.redirectfrom forKey:@"redirect_from"];
        [eventdetails setPostValue:appDel.logid forKey:@"log_id"];
        DLog(@"lid=%@",appDel.logid);
        [eventdetails  startAsynchronous];
        self.imageDownloadingQueue = [[NSOperationQueue alloc] init];
        self.imageDownloadingQueue.maxConcurrentOperationCount = 4; // many servers limit how many concurrent requests they'll accept from a device, so make sure to set this accordingly
        
        self.imageCache = [[NSCache alloc] init];

    }
    
}
-(void) viewDidDisappear:(BOOL)animated
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.attendevent=FALSE;
    appDel.enterscreen=FALSE;
}



-(void)requestFinished:(ASIHTTPRequest *)request
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    if (request==eventdetails)
    {
        
        eventdetails=nil;
        NSString *response  =  [[request responseString] stringByReplacingOccurrencesOfString:@"&#x27;" withString:@"'"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&rsquo;" withString:@"'"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&ntilde;" withString:@"n"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&eacute;" withString:@"e"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        response  =  [response stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
   
        DLog(@"response=%@",response);
        
        NSMutableDictionary *dict;
        dict=[[NSMutableDictionary alloc] init];
        dict=[response JSONValue];
        dict = [dict dictionaryByReplacingNullsWithStrings];
        
        DLog(@"status=%@",[dict objectForKey:@"status"]);
        DLog(@"dictionary count=%d",dict.count);
          appDel.appdownloadlink=[dict valueForKey:@"downloadlink"];
      
        //   [eventcount removeAllObjects];
        //    DLog(@"id=%@",[dict valueForKey:[NSString stringWithFormat:@"%d",i]]);
        
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
          
            for(UIView *subviews in [self.view subviews])
            {
                subviews.hidden=NO;
                // self.TimeandDateTitleView.hidden=NO;
                
            }
            
            eventcount = [[NSMutableArray alloc] init];
            
            
            
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
            
            
            
            //                DLog(@"department=%@",eventcount);
            //                DLog(@"department=%@",[[eventcount objectAtIndex:0] objectForKey:@"event_title"]);
            //                DLog(@"department=%@",[[eventcount objectAtIndex:0] objectForKey:@"event_image_url"]);
            //
            //                DLog(@"departmentcount=%d",eventcount.count);
            //
            
            
            
            //  DLog(@"imageurl=%@",[[eventcount objectAtIndex:0] valueForKey:@"event_bigimage_url"]);
            
            
            appDel.eventdepartment=[[eventcount objectAtIndex:0] valueForKey:@"event_department"];
            self.eventTitle.text=[[eventcount objectAtIndex:0] valueForKey:@"event_title"];
            CGSize maximumSize = CGSizeMake(170, 9999);
            // UIFont *myFont = [UIFont fontWithName:@"System Bold" size:18];
            titleSize = [[[eventcount objectAtIndex:0] valueForKey:@"event_title"] sizeWithFont:self.eventTitle.font constrainedToSize:maximumSize lineBreakMode:self.eventTitle.lineBreakMode];
            
            //int chars=[[[eventcount objectAtIndex:0] valueForKey:@"event_title"] length];
            
            DLog(@"title width=%f",titleSize.width);
            DLog(@"title height=%f",titleSize.height);
            
            int lines = [[[eventcount objectAtIndex:0] valueForKey:@"event_title"] sizeWithFont:self.eventTitle.font constrainedToSize:maximumSize
                                                                                  lineBreakMode:self.eventTitle.lineBreakMode].height /self.eventTitle.font.pointSize;
            
            DLog(@"lines=%d",lines);
            
            if (lines<=1)
            {
                //self.readmoreTitleButton.hidden=YES;
                [self.readmoreTitleButton removeFromSuperview];
                
            }
            
        }
        
        
        if ([[[eventcount objectAtIndex:0] objectForKey:@"eventof"] isEqual:@"others"])
        {
            self.updateEvent.hidden=YES;
            self.attendEventBtn.frame=CGRectMake(30, self.attendEventBtn.frame.origin.y, self.attendEventBtn.frame.size.width, self.attendEventBtn.frame.size.height);
            self.shareButton.frame=CGRectMake(240,self.shareButton.frame.origin.y, self.shareButton.frame.size.width, self.shareButton.frame.size.height);
        }
        
        
        
        if (![[[eventcount objectAtIndex:0] valueForKey:@"event_format_date"]isEqual:@""])
        {
            self.dateAndTime.text=[[eventcount objectAtIndex:0] valueForKey:@"event_format_date"];
            
        }
        else
        {
            self.dateAndTime.text=@"N/A";
        }
        linesindate = [self.dateAndTime.text sizeWithFont:[UIFont fontWithName:@"Lato-Regular" size:16.0] constrainedToSize:CGSizeMake(276, 9999)
                                            lineBreakMode:NSLineBreakByWordWrapping].height /[UIFont fontWithName:@"Lato-Regular" size:16.0].pointSize;
        
        DLog(@"linesindate=%d",linesindate);
        
        // [self.dateAndTime sizeToFit];
        
        
        if (![[[eventcount objectAtIndex:0] valueForKey:@"event_location"]isEqual:@""]) {
            self.eventLocation.text=[[eventcount objectAtIndex:0] valueForKey:@"event_location"];
            
        }
        else
        {
            self.eventLocation.text=@"N/A";
            
        }
        linesinlocation = [self.eventLocation.text sizeWithFont:[UIFont fontWithName:@"Lato-Regular" size:16.0] constrainedToSize:CGSizeMake(276, 9999)
                                                  lineBreakMode:NSLineBreakByWordWrapping].height /[UIFont fontWithName:@"Lato-Regular" size:16.0].pointSize;
        
        DLog(@"linesinlocation=%d",linesinlocation);
        
        //[self.eventLocation sizeToFit];
        
        if (![[[eventcount objectAtIndex:0] valueForKey:@"num_attending"]isEqual:@""]) {
            self.eventAttending.text=[NSString stringWithFormat:@"%@ Attending",[[eventcount objectAtIndex:0] valueForKey:@"num_attending"]];
            
        }
        else {
            
            self.eventAttending.text=@"N/A";
        }
        // [self.eventAttending sizeToFit];
        if ([[[eventcount objectAtIndex:0] valueForKey:@"subscription_status"]isEqual:@"yes"]) {
            //self.attendEventBtn.hidden=YES;
            [self.attendEventBtn setTitle:@"Attending" forState:UIControlStateNormal];
            //self.attendEventBtn.userInteractionEnabled=NO;
            self.attendEventBtn.backgroundColor=[UIColor colorWithRed:(199/255.0) green:(199/255.0) blue:(199/255.0) alpha:1] ;
            //        self.shareButton.frame=CGRectMake(self.view.frame.size.width/2-self.shareButton.frame.size.width/2, self.shareButton.frame.origin.y, self.shareButton.frame.size.width, self.shareButton.frame.size.height);
            
        }
        
        
        
        // ReadMore Size Adjustment
        
        //int characters = [[[eventcount objectAtIndex:0] valueForKey:@"event_description"]  length];
        
        
        UITextView *imaginaryTextview=[[UITextView alloc] initWithFrame:CGRectMake(0, 0, 290, 52)];
        imaginaryTextview.text=[[eventcount objectAtIndex:0] valueForKey:@"event_description"];
        imaginaryTextview.font=[UIFont fontWithName:@"Lato-Regular" size:16.0];
        imaginaryTextview.text=[[eventcount objectAtIndex:0] valueForKey:@"event_description"];
      //  int charactersnew = [imaginaryTextview.text length];
        [self.view addSubview:imaginaryTextview];
        myStringSize=imaginaryTextview.contentSize;
        [imaginaryTextview removeFromSuperview];
        self.commentTextView.text=[[eventcount objectAtIndex:0] valueForKey:@"event_description"];
        
        int descriptionchars=[[[eventcount objectAtIndex:0] valueForKey:@"event_description"] length];
        
      //  DLog(@"chars=%d",charactersnew);
        DLog(@"descriptionchars=%d",descriptionchars);
        
        DLog(@"strheight=%f",myStringSize.height);
       // int linesnew = [imaginaryTextview.text sizeWithFont:imaginaryTextview.font constrainedToSize:imaginaryTextview.frame.size lineBreakMode:NSLineBreakByWordWrapping].height /imaginaryTextview.font.pointSize;
       // DLog(@"linesnew=%d",linesnew);
        
        if (descriptionchars<62)
        {
            self.readmorebuttonview.hidden=YES;
            
            self.commentTextView.frame=CGRectMake(self.commentTextView.frame.origin.x, self.commentTextView.frame.origin.y, 290, 52);
            // [self.readmorebuttonview removeFromSuperview];
            
        }
        else
        {
            self.readmorebuttonview.hidden=NO;
            
        }
        
        
        
        
        if (![[[eventcount objectAtIndex:0] valueForKey:@"hoster"]isEqual:@""])
        {
            self.username.text=[[eventcount objectAtIndex:0] valueForKey:@"hoster"];
            
        }
        else
        {
            
            self.username.text=@"N/A";
            
        }
        
        linesindepartment = [self.username.text sizeWithFont:[UIFont fontWithName:@"Lato-Regular" size:16.0] constrainedToSize:CGSizeMake(276, 9999)
                                               lineBreakMode:NSLineBreakByWordWrapping].height /[UIFont fontWithName:@"Lato-Regular" size:16.0].pointSize;
        
        DLog(@"linesindepartment=%d",linesindepartment);
        
        
        [appDel removeLoader];
        
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
                        }];
                        
                    }
                    
                    [eventimageloading removeFromSuperview];
                    [eventimageloading stopAnimating];
                    
                    
                }];
            }
        
        }

        
         if ([[dict objectForKey:@"status"] isEqualToString:@"e"])
        {
            
      UIAlertView *alert = [[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            alert.tag=1;
            [appDel removeLoader];
        }
        
        if (dict==nil)
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            if (eventcount.count==0)
            {
                alert.tag=1;
            }
            [appDel removeLoader];

           
        }
        
               
             }
    
    
    if (request==subscribeevents)
    {
         subscribeevents=nil;
        if ([self.attendEventBtn.titleLabel.text isEqual:@"Attend"]) {
           
        self.eventAttending.text=[NSString stringWithFormat:@"%d Attending",([self.eventAttending.text intValue]+1)];
            [self.attendEventBtn setTitle:@"Attending" forState:UIControlStateNormal];
            self.attendEventBtn.backgroundColor=[UIColor colorWithRed:(199/255.0) green:(199/255.0) blue:(199/255.0) alpha:1] ;
        }
        
        else if ([self.attendEventBtn.titleLabel.text isEqual:@"Attending"])
        {
        self.eventAttending.text=[NSString stringWithFormat:@"%d Attending",([self.eventAttending.text intValue]-1)];
            [self.attendEventBtn setTitle:@"Attend" forState:UIControlStateNormal];
            self.attendEventBtn.backgroundColor=[UIColor colorWithRed:(142/255.0) green:(118/255.0) blue:(178/255.0) alpha:1] ;
            
        }
       [appDel removeLoader];
    }
    
   


}




-(void)requestFailed:(ASIHTTPRequest *)request
{
    eventdetails=nil;
    subscribeevents=nil;
    [[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    eventdetails=nil;
   // NSString *response  =  [request responseString];
   // DLog(@"response=%@",response);
    

    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel removeLoader];
    
}

#pragma mark alertview delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        if (buttonIndex==0)
        {
            
            AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
            
            if (!appDel.activityOpen)
            {
                appDel.enterscreen=TRUE;
            }
            
            [self.navigationController popViewControllerAnimated:YES];
            appDel.activityOpen=FALSE;

            
        }
        
    }
    
}




//-(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width
//{
//    float oldWidth = sourceImage.size.width;
//    float scaleFactor = i_width / oldWidth;
//    
//    float newHeight = sourceImage.size.height * scaleFactor;
//    float newWidth = oldWidth * scaleFactor;
//    
//    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
//    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;
//}
- (UIImage *)imageWithImage:(UIImage *)image scaledToMaxWidth:(CGFloat)width maxHeight:(CGFloat)height {
    CGFloat oldWidth = image.size.width;
    CGFloat oldHeight = image.size.height;
    
    CGFloat scaleFactor;
    
    if (oldWidth > oldHeight) {
        scaleFactor = width / oldWidth;
    } else {
        scaleFactor = height / oldHeight;
    }
    
    CGFloat newHeight = oldHeight * scaleFactor;
    CGFloat newWidth = oldWidth * scaleFactor;
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    
    return [self imageWithImage:image scaledToSize:newSize];
}
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)size {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}





-(IBAction)EventsPageButtonClosed:(id)sender
{
 if(eventdetails==nil && subscribeevents==nil)
     {
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
  
         
         if (appDel.activityOpen)
         {
              [self.navigationController popViewControllerAnimated:YES];
             appDel.activityOpen=FALSE;

         }
         
        else
         {
         
        if (appDel.attendeventpage==FALSE)
         {
             
           [self.navigationController popViewControllerAnimated:YES];
                    
         }
         else
         {
         
             appDel.enterscreen=TRUE;
             appDel.attendeventpage=FALSE;
          [self.navigationController popViewControllerAnimated:YES];
         
         }
            

         }

    
    }
}
-(IBAction)attendEvent:(id)sender
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel addLoaderForViewController:self];
    appDel.attendeventpage=TRUE;
    subscribeevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:subscribetoCampusEvents]] ;
    [subscribeevents setDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults valueForKey:@"userid"];
    DLog(@"useridprofile=%@",uid);
    DLog(@"eventid=%@",appDel.eventid);
    // DLog(@"newstatus=%@",newstatus);
    [subscribeevents setPostValue:uid forKey:@"userid"];
    [subscribeevents setPostValue:appDel.eventid forKey:@"eventid"];
 
    
   if ([self.attendEventBtn.titleLabel.text isEqual:@"Attend"])
    {
           [subscribeevents setPostValue:@"yes" forKey:@"subscribe"];
      
    }
    
    else if ([self.attendEventBtn.titleLabel.text isEqual:@"Attending"])
    {
           [subscribeevents setPostValue:@"no" forKey:@"subscribe"];
       
        
    }
    
    [subscribeevents  startAsynchronous];
    
    
  //  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(EventsPageClosed:) userInfo:nil repeats:NO];

}
-(void) EventsPageClosed
{
    
    //AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
  
   // [self.navigationController popViewControllerAnimated:YES];
    
}

# pragma ForumPageOpen
-(IBAction)forumPageOpen:(id)sender
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.enterFromForum=TRUE;
    appDel.redirectfrom=@"";
     appDel.logid=@"";
    ForumPage *forumpage=[[ForumPage alloc]initWithNibName:@"ForumPage" bundle:nil];
    [[self navigationController]pushViewController:forumpage animated:YES];


}

#pragma mark Share

-(IBAction)share:(id)sender
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.attendevent=FALSE;
    NSMutableArray *shareItems = [NSMutableArray new];
    
    while ([shareItems count] < numberOfSharedItems)
        [shareItems addObject: self];
   
    circleActivity  *ca = [[circleActivity alloc]init];

    UIActivityViewController *shareController =[[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:[NSArray arrayWithObject:ca]];
    
    [shareController setValue:self.eventTitle.text forKey:@"subject"];
    self.view.userInteractionEnabled=NO;
   shareController.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                         UIActivityTypeAssignToContact,UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeSaveToCameraRoll,UIActivityTypePrint];
    
    
    shareController.completionHandler = ^(NSString *activityType, BOOL completed)
    {
        self.view.userInteractionEnabled=YES;
                   
    };
   
 [self presentViewController:shareController animated:YES completion:nil];
   
}

-(id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController
{
    static UIActivityViewController *shareController;
    static int itemNo;
    if (shareController == activityViewController && itemNo < numberOfSharedItems - 1)
        itemNo++;
    else {
        itemNo = 0;
        shareController = activityViewController;
    }
    
    switch (itemNo) {
        case 0: return @""; // intro in email
        case 1: return @""; // email text
        case 2: return @""; // link
        case 3: return @""; // picture
        case 4: return @""; // extra text (via in twitter, signature in email)
        default: return nil;
    }
}




-(id)activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(NSString *)activityType
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;

    // the number of item to share
    static UIActivityViewController *shareController;
    static int itemNo;
    if (shareController == activityViewController && itemNo < numberOfSharedItems - 1)
        itemNo++;
    else {
        itemNo = 0;
        shareController = activityViewController;
    }
   
       newShareText=[NSString stringWithFormat:@"You are invited to \"%@\" on %@. Check it out on Peck! %@",self.eventTitle.text,self.dateAndTime.text,appDel.appdownloadlink];
         DLog(@"len=%d",newShareText.length);
    NSString *twittertext;
    if (newShareText.length>140) {
       twittertext=[NSString stringWithFormat:@"You are invited to \"%@\". Check it out on Peck! %@",self.eventTitle.text,appDel.appdownloadlink];
        
        if (twittertext.length>140)
        {
        twittertext=[NSString stringWithFormat:@"Check it out on Peck! %@",appDel.appdownloadlink];

        }
    }
    else
    {
    
        twittertext=newShareText;
    
     }

    if ([activityType isEqualToString: UIActivityTypePostToTwitter])
        switch (itemNo) {
            case 0: return nil;
            case 1: return twittertext; // you can change text for twitter, I add $ to stock symbol inside shareText here, e.g. Hashtags can be added too
            case 2: nil;
            case 3: return nil; // no picture
            case 4: return nil;
            default: return nil;
        }

  
    
    else if ([activityType isEqualToString:@"ShareCircle"])
    {
        switch (itemNo) {
                
            default: return nil;
        }
       
    }
    else // Facebook or something else in the future
        switch (itemNo) {
            case 0: return nil;
            case 1: return newShareText;
            case 2: return nil;
               
            case 3:
                if (self.eventImage.image!=[UIImage imageNamed:@"bg_image.png"])
            {
                return self.eventImage.image;
            }

            case 4: return nil;
            default: return nil;
        }
}

-(void) setCircleContent
{

    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.enterFromCircle=true;
    ShareCircles *sharecircles=[[ShareCircles alloc] initWithNibName:@"ShareCircles" bundle:nil];
    
    // [self presentModalViewController:sharecircles animated:YES];
    [self presentViewController:sharecircles animated:YES completion:nil];


}


- (BOOL) setMFMailFieldAsFirstResponder:(UIView*)view mfMailField:(NSString*)field{
    for (UIView *subview in view.subviews) {
        
        NSString *className = [NSString stringWithFormat:@"%@", [subview class]];
        if ([className isEqualToString:field])
        {
            //Found the sub view we need to set as first responder
            [subview becomeFirstResponder];
            return YES;
        }
        
        if ([subview.subviews count] > 0) {
            if ([self setMFMailFieldAsFirstResponder:subview mfMailField:field]){
                //Field was found and made first responder in a subview
                return YES;
            }
        }
    }
    
    //field not found in this view.
    return NO;
}
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
     [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark TextView Delegate

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    
    UIApplication *application= [UIApplication sharedApplication];
    
    application.statusBarHidden=NO;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view .frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+165.0,self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
   
    
    UIApplication *application= [UIApplication sharedApplication];
    
    application.statusBarHidden=YES;


    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-165.0,
                                 self.view.frame.size.width, self.view.frame.size.height);
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

- (void)viewDidUnload
{
    [self setAttendEventBtn:nil];
    [self setCommentTextView:nil];
    [self setEventImage:nil];
    [self setDateAndTime:nil];
    [self setEventLocation:nil];
    [self setEventAttending:nil];
    [self setUsername:nil];
    [self setProfileImage:nil];
    [self setHeaderView:nil];
    [self setEventTitle:nil];
    [self setShareButton:nil];
    [self setBackgroundscroller:nil];
    [self setReadmoreButton:nil];
    [self setReadmoreTitleButton:nil];
    [self setReadmorebuttonview:nil];
    [self setUpdateEvent:nil];
    [self setLastlineview:nil];
    [self setFirstlineview:nil];
    [self setSecondlineview:nil];
    [self setThirdlineview:nil];
    [self setClockimage:nil];
    [self setLocationimage:nil];
    [self setAttendmemberimage:nil];
    [self setDepartmentimage:nil];
    [self setAttendingmembersbutton:nil];
    [self setLocationbutton:nil];
    [self setDepartmentbutton:nil];
    [self setDatebutton:nil];
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
