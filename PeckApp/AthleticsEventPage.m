//
//  AthleticsEventPage.m
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 6/5/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "AthleticsEventPage.h"


@implementation AthleticsEventPage

@synthesize attendEventBtn,eventcount,eventTitle,headerView;
const int numberofSharedItems = 5;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma eventAttendMembers


-(IBAction) eventAttendingMembers:(id)sender
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.enterFromEvent=TRUE;
    EventAttendingList *eventattendinglist=[[EventAttendingList alloc] initWithNibName:@"EventAttendingList" bundle:nil];
    [self presentViewController:eventattendinglist animated:YES completion:nil];
    //[self presentModalViewController:eventattendinglist animated:YES];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    
    self.attendEventBtn.layer.cornerRadius=2.0;
     self.opponentLabel.font = [UIFont boldSystemFontOfSize:self.opponentLabel.font.pointSize];
    self.williamsLabel.font = [UIFont boldSystemFontOfSize:self.williamsLabel.font.pointSize];
          if (appDel.attendevent==TRUE)
    {
        for(UIView *subviews in [self.view subviews])
        {
            subviews.hidden=YES;
            self.headerView.hidden=NO;
            
        }
         self.Backgroundscroller.scrollEnabled=NO;
       // self.readmoreTitleButton.hidden=YES;
        [appDel addLoaderForViewController:self];
        DLog(@"eventid=%@",appDel.eventid);
        athleticdetails=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:singleAthleticsEventView]];
        [athleticdetails setDelegate:self];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *uid = [defaults valueForKey:@"userid"];
        [athleticdetails setPostValue:appDel.eventid forKey:@"eventid"];
        [athleticdetails setPostValue:uid forKey:@"userid"];
    [athleticdetails setPostValue:appDel.redirectfrom forKey:@"redirect_from"];
         [athleticdetails setPostValue:appDel.logid forKey:@"log_id"];
        [athleticdetails  startAsynchronous];
        self.universityScore.layer.cornerRadius=16.0;
        self.universityScore.layer.borderWidth=1.0;
        self.universityScore.layer.borderColor=[UIColor colorWithRed:(214.0/255.0) green:(214.0/255.0) blue:(214.0/255.0) alpha:1].CGColor ;
        
        self.opponentScore.layer.cornerRadius=16.0;
        self.opponentScore.layer.borderWidth=1.0;
        self.opponentScore.layer.borderColor=[UIColor colorWithRed:(214.0/255.0) green:(214.0/255.0) blue:(214.0/255.0) alpha:1].CGColor ;
        
         self.InandFinalTitle.layer.cornerRadius=15.0;
        self.InandFinalTitle.layer.borderWidth=1.0;
        self.InandFinalTitle.layer.borderColor=[UIColor colorWithRed:(214.0/255.0) green:(214.0/255.0) blue:(214.0/255.0) alpha:1].CGColor ;
       
    self.readmorebuttonview.frame=CGRectMake(self.readmorebuttonview.frame.origin.x, self.commentTextView.frame.origin.y+self.commentTextView.frame.size.height/2-6, self.readmorebuttonview.frame.size.width, self.readmorebuttonview.frame.size.height);
        
        self.readmoreButton.titleLabel.font= [UIFont italicSystemFontOfSize:self.readmoreButton.titleLabel.font.pointSize];

        
    }
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.attendevent=FALSE;
    appDel.enterscreen=FALSE;
}

# pragma mark ReadMoreTitle

-(IBAction) readmoreTitle:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    self.Backgroundscroller.scrollEnabled=YES;
    //self.eventTitle.textAlignment=UITextAlignmentLeft;
    
    self.headerView.frame=CGRectMake(self.headerView.frame.origin.x, self.headerView.frame.origin.y, self.headerView.frame.size.width, titleSize.height+28);
    self.eventTitle.frame=CGRectMake(self.eventTitle.frame.origin.x,0, self.eventTitle.frame.size.width, titleSize.height+28);
    
    self.Backgroundscroller.frame=CGRectMake(self.Backgroundscroller.frame.origin.x, self.headerView.frame.origin.y+self.headerView.frame.size.height, self.Backgroundscroller.frame.size.width, self.Backgroundscroller.frame.size.height);
    
    //  CGRect deviceDimension = [[UIScreen mainScreen] bounds];
        self.Backgroundscroller.scrollEnabled=YES;
    self.Backgroundscroller.contentSize=CGSizeMake(0, self.Backgroundscroller.contentSize.height+titleSize.height);
    
    
    [self.readmoreTitleButton removeFromSuperview];
    
    
    [UIView commitAnimations];
}

# pragma mark title ReadMoreOpponent

-(IBAction) readmoreOpponent:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    //  CGFloat opponentlabelheight=self.opponentLabel.frame.origin.y;
    
    
    
    self.opponentLabel.frame=CGRectMake(self.opponentLabel.frame.origin.x,self.opponentLabel.frame.origin.y, self.opponentLabel.frame.size.width, self.opponentLabel.frame.size.height+40*(linesinopponent-1));
    
    self.williamsLabel.frame=CGRectMake(self.williamsLabel.frame.origin.x,self.williamsLabel.frame.origin.y, self.williamsLabel.frame.size.width, self.williamsLabel.frame.size.height);
    
    for(UIView *subviews in [self.Backgroundscroller subviews])
    {
        if (subviews!=self.allDescriptionView)
        {
            subviews.frame=CGRectMake(subviews.frame.origin.x, subviews.frame.origin.y+40*(linesinopponent-1), subviews.frame.size.width, subviews.frame.size.height);
            
        }
        
    }
    if (linesinopponent>1)
    {
        self.Backgroundscroller.scrollEnabled=YES;
    }
    self.Backgroundscroller.contentSize=CGSizeMake(0, self.Backgroundscroller.contentSize.height+40*(linesinopponent-1));
    [self.readmoreOpponentButton removeFromSuperview];
    
    [UIView commitAnimations];
}



#pragma mark ReadMoreDescription

-(IBAction) readmore:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    self.Backgroundscroller.scrollEnabled=YES;
    
    self.attendEventBtn.frame=CGRectMake( self.attendEventBtn.frame.origin.x,  self.attendEventBtn.frame.origin.y+myStringSize.height-55, self.attendEventBtn.frame.size.width, self.attendEventBtn.frame.size.height);
    
    self.shareButton.frame=CGRectMake( self.shareButton.frame.origin.x,  self.shareButton.frame.origin.y+myStringSize.height-55, self.shareButton.frame.size.width, self.shareButton.frame.size.height);
    
    self.commentTextView.frame=CGRectMake(self.commentTextView.frame.origin.x,  self.commentTextView.frame.origin.y, self.commentTextView.frame.size.width+50, myStringSize.height);
    
    // self.commentTextView.userInteractionEnabled=YES;
    
    self.Backgroundscroller.contentSize=CGSizeMake(0, self.Backgroundscroller.contentSize.height-55+myStringSize.height);
    
    [self.readmorebuttonview removeFromSuperview];
    
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

    
    self.username.frame=CGRectMake( self.username.frame.origin.x,  self.username.frame.origin.y+(linesindate), self.username.frame.size.width, self.username.frame.size.height);
    
    
    self.firstlineview.frame=CGRectMake(self.firstlineview.frame.origin.x,  self.firstlineview.frame.origin.y+(linesindate), self.firstlineview.frame.size.width, self.firstlineview.frame.size.height);
    
    self.secondlineview.frame=CGRectMake( self.secondlineview.frame.origin.x,  self.secondlineview.frame.origin.y+(linesindate), self.secondlineview.frame.size.width, self.secondlineview.frame.size.height);
    
    self.thirdlineview.frame=CGRectMake( self.thirdlineview.frame.origin.x,  self.thirdlineview.frame.origin.y+(linesindate), self.thirdlineview.frame.size.width, self.thirdlineview.frame.size.height);
    self.lastlineview.frame=CGRectMake( self.lastlineview.frame.origin.x,  self.lastlineview.frame.origin.y+(linesindate), self.lastlineview.frame.size.width, self.lastlineview.frame.size.height);
    
    self.attendEventBtn.frame=CGRectMake( self.attendEventBtn.frame.origin.x,  self.attendEventBtn.frame.origin.y+(linesindate), self.attendEventBtn.frame.size.width, self.attendEventBtn.frame.size.height);
    
    self.shareButton.frame=CGRectMake( self.shareButton.frame.origin.x,  self.shareButton.frame.origin.y+(linesindate), self.shareButton.frame.size.width, self.shareButton.frame.size.height);
    
    
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
    
//    self.departmentbutton.frame=CGRectMake(self.departmentbutton.frame.origin.x,  self.departmentbutton.frame.origin.y+(linesinlocation), self.departmentbutton.frame.size.width, self.departmentbutton.frame.size.height);

    
    self.username.frame=CGRectMake( self.username.frame.origin.x,  self.username.frame.origin.y+(linesinlocation), self.username.frame.size.width, self.username.frame.size.height);
    
    self.secondlineview.frame=CGRectMake( self.secondlineview.frame.origin.x,  self.secondlineview.frame.origin.y+(linesinlocation), self.secondlineview.frame.size.width, self.secondlineview.frame.size.height);
    
    self.thirdlineview.frame=CGRectMake( self.thirdlineview.frame.origin.x,  self.thirdlineview.frame.origin.y+(linesinlocation), self.thirdlineview.frame.size.width, self.thirdlineview.frame.size.height);
    self.lastlineview.frame=CGRectMake( self.lastlineview.frame.origin.x,  self.lastlineview.frame.origin.y+(linesinlocation), self.lastlineview.frame.size.width, self.lastlineview.frame.size.height);
    
    self.attendEventBtn.frame=CGRectMake( self.attendEventBtn.frame.origin.x,  self.attendEventBtn.frame.origin.y+(linesinlocation), self.attendEventBtn.frame.size.width, self.attendEventBtn.frame.size.height);
    
    self.shareButton.frame=CGRectMake( self.shareButton.frame.origin.x,  self.shareButton.frame.origin.y+(linesinlocation), self.shareButton.frame.size.width, self.shareButton.frame.size.height);
    
    
    self.commentTextView.frame=CGRectMake(self.commentTextView.frame.origin.x,  self.commentTextView.frame.origin.y+(linesinlocation), self.commentTextView.frame.size.width, self.commentTextView.frame.size.height);
    self.readmorebuttonview.frame=CGRectMake(self.readmorebuttonview.frame.origin.x,  self.readmorebuttonview.frame.origin.y+(linesinlocation), self.readmorebuttonview.frame.size.width, self.readmorebuttonview.frame.size.height);
    
    [self.locationbutton removeFromSuperview];
    
    
    self.Backgroundscroller.contentSize=CGSizeMake(0, self.Backgroundscroller.contentSize.height+(linesinlocation));
    
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    if (request==athleticdetails)
    {
        athleticdetails=nil;
        NSString *response  =  [[request responseString] stringByReplacingOccurrencesOfString:@"&#x27;" withString:@"'"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
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
         appDel.appdownloadlink=[dict valueForKey:@"downloadlink"];
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
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
                
                    DLog(@"athleticevent=%@",eventcount);
                               //DLog(@"index0=%@",[[eventcount objectAtIndex:0] objectForKey:@"event_title"]);
            
            
            appDel.eventdepartment=[[eventcount objectAtIndex:0] valueForKey:@"event_department"];
          /*  CGSize maximumSizeopponent = CGSizeMake(190, 9999);
            int linesopponent = [[[eventcount objectAtIndex:0] valueForKey:@"opponent_team"] sizeWithFont:self.eventTitle.font constrainedToSize:maximumSizeopponent
                                                                                            lineBreakMode:UILineBreakModeWordWrap].height /self.opponentLabel.font.pointSize;
            
            DLog(@"lines=%d",linesopponent);*/
           self.opponentLabel.text=[[eventcount objectAtIndex:0] valueForKey:@"opponent_team"];
                linesinopponent= [[[eventcount objectAtIndex:0] valueForKey:@"opponent_team"] sizeWithFont:self.opponentLabel.font constrainedToSize:CGSizeMake(210, 9999)lineBreakMode:NSLineBreakByWordWrapping].height /self.opponentLabel.font.pointSize;
            
            DLog(@"linesinopponent=%d",linesinopponent);
            //int chars=[[[eventcount objectAtIndex:0] valueForKey:@"event_title"] length];
            
            DLog(@"title width=%f",titleSize.width);
            DLog(@"title height=%f",titleSize.height);
        
        
            
        /*  NSString *opponentlabellenght=[[eventcount objectAtIndex:0] valueForKey:@"opponent_team"];
            DLog(@"len=%d",opponentlabellenght.length);
            if (opponentlabellenght.length>12)
            {
                self.opponentLabel.frame=CGRectMake(self.opponentLabel.frame.origin.x, 70, self.opponentLabel.frame.size.width+10, 68);
            }
            
       */
        
            if ([[[eventcount objectAtIndex:0] valueForKey:@"match_screen"] isEqual:@"final"])
            {
                CGFloat adjust=20;
            self.opponentScore.frame=CGRectMake(self.opponentScore.frame.origin.x, self.opponentScore.frame.origin.y+adjust, self.opponentScore.frame.size.width, self.opponentScore.frame.size.height);
                
            self.universityScore.frame=CGRectMake(self.universityScore.frame.origin.x, self.universityScore.frame.origin.y+adjust, self.universityScore.frame.size.width, self.universityScore.frame.size.height);
                            
            self.opponentLabel.frame=CGRectMake(self.opponentLabel.frame.origin.x, self.opponentLabel.frame.origin.y+adjust, self.opponentLabel.frame.size.width, self.opponentLabel.frame.size.height);
                
                 self.opponentLabel.textColor=[UIColor blackColor];
              self.readmoreOpponentButton.frame=CGRectMake(self.readmoreOpponentButton.frame.origin.x, self.readmoreOpponentButton.frame.origin.y+adjust, self.readmoreOpponentButton.frame.size.width
                                                           , self.readmoreOpponentButton.frame.size.height);
                
              self.williamsLabel.frame=CGRectMake(self.williamsLabel.frame.origin.x, self.williamsLabel.frame.origin.y+adjust, self.williamsLabel.frame.size.width, self.williamsLabel.frame.size.height);
                self.williamsLabel.textColor=[UIColor blackColor];
 
                
                
            self.InandFinalTitle.text=[[eventcount objectAtIndex:0] valueForKey:@"match_status"];
            }
            
            else
            {
            
                self.InandFinalTitle.hidden=YES;
            
            }
            
            
            for(UIView *subviews in [self.view subviews])
            {
                subviews.hidden=NO;
                
            }
                     
        self.eventTitle.text=[[eventcount objectAtIndex:0] valueForKey:@"game_title"];
                CGSize maximumSize = CGSizeMake(170, 9999);
                // UIFont *myFont = [UIFont fontWithName:@"System Bold" size:18];
                titleSize = [[[eventcount objectAtIndex:0] valueForKey:@"game_title"] sizeWithFont:self.eventTitle.font constrainedToSize:maximumSize lineBreakMode:self.eventTitle.lineBreakMode];
                
                
                
                DLog(@"title width=%f",titleSize.width);
                DLog(@"title height=%f",titleSize.height);
                
                int lines = [[[eventcount objectAtIndex:0] valueForKey:@"game_title"] sizeWithFont:self.eventTitle.font constrainedToSize:maximumSize
                lineBreakMode:self.eventTitle.lineBreakMode].height /self.eventTitle.font.pointSize;
                
                DLog(@"lines=%d",lines);
            
            if (lines<=1)
            {
                [self.readmoreTitleButton removeFromSuperview];
                
            }
            

            
        if (![[[eventcount objectAtIndex:0] valueForKey:@"university_team_score"]isEqual:@""])
                {
                    self.universityScore.text=[[eventcount objectAtIndex:0] valueForKey:@"university_team_score"];
                }
                
                else{
                    self.universityScore.text=@"N/A";
                    
                }
                
                
                if (![[[eventcount objectAtIndex:0] valueForKey:@"opponent_team_score"]isEqual:@""])
                {
                    self.opponentScore.text=[[eventcount objectAtIndex:0] valueForKey:@"opponent_team_score"];
                }
                
                else{
                    self.opponentScore.text=@"N/A";
                    
                }

                
                
        if (![[[eventcount objectAtIndex:0] valueForKey:@"event_format_date"]isEqual:@""])
             {
             self.dateAndTime.text=[[eventcount objectAtIndex:0] valueForKey:@"event_format_date"];
              }
                
            else{
                 self.dateAndTime.text=@"N/A";
        
                }
            linesindate = [self.dateAndTime.text sizeWithFont:[UIFont fontWithName:@"Lato-Regular" size:16.0] constrainedToSize:CGSizeMake(276, 9999)lineBreakMode:NSLineBreakByWordWrapping].height /[UIFont fontWithName:@"Lato-Regular" size:16.0].pointSize;
            
            DLog(@"linesindate=%d",linesindate);
                
                if (![[[eventcount objectAtIndex:0] valueForKey:@"location"] isEqual:@""]) {
                      self.eventLocation.text=[[eventcount objectAtIndex:0] valueForKey:@"location"];
                }
                else
                {
                
                self.eventLocation.text=@"N/A";
                
                }
            
            linesinlocation = [self.eventLocation.text sizeWithFont:[UIFont fontWithName:@"Lato-Regular" size:16.0] constrainedToSize:CGSizeMake(276, 9999)lineBreakMode:NSLineBreakByWordWrapping].height /[UIFont fontWithName:@"Lato-Regular" size:16.0].pointSize;
            
            DLog(@"linesinlocation=%d",linesinlocation);

                
                if (![[[eventcount objectAtIndex:0] valueForKey:@"num_attending"] isEqual:@""])
                {
                    self.eventAttending.text=[[eventcount objectAtIndex:0] valueForKey:@"num_attending"];
                }
                else {
                    
                    self.eventAttending.text=@"N/A";
                    
                }
                if ([[[eventcount objectAtIndex:0] valueForKey:@"subscription_status"]isEqual:@"yes"]) {
                    //self.attendEventBtn.hidden=YES;
                    [self.attendEventBtn setTitle:@"Attending" forState:UIControlStateNormal];
                    //self.attendEventBtn.userInteractionEnabled=NO;
                    self.attendEventBtn.backgroundColor=[UIColor colorWithRed:(199/255.0) green:(199/255.0) blue:(199/255.0) alpha:1] ;
                    //        self.shareButton.frame=CGRectMake(self.view.frame.size.width/2-self.shareButton.frame.size.width/2, self.shareButton.frame.origin.y, self.shareButton.frame.size.width, self.shareButton.frame.size.height);
                    
                    
                }


            // ReadMore Size Adjustment
            if ([[eventcount objectAtIndex:0] valueForKey:@"event_description"]!=[NSNull null])
            {
               // int characters = [[[eventcount objectAtIndex:0] valueForKey:@"event_description"]  length];
              //  DLog(@"chars=%d",characters);
                
                UITextView *imaginaryTextview=[[UITextView alloc] initWithFrame:CGRectMake(0, 0, 290, 52)];
                imaginaryTextview.text=[[eventcount objectAtIndex:0] valueForKey:@"event_description"];
                imaginaryTextview.font=[UIFont fontWithName:@"Lato-Regular" size:16.0];
                [self.view addSubview:imaginaryTextview];
                myStringSize=imaginaryTextview.contentSize;
                [imaginaryTextview removeFromSuperview];
                self.commentTextView.text=[[eventcount objectAtIndex:0] valueForKey:@"event_description"];
                
                
                int descriptionchars=[[[eventcount objectAtIndex:0] valueForKey:@"event_description"] length];
                
                DLog(@"descriptionchars=%d",descriptionchars);
                
                DLog(@"strheight=%f",myStringSize.height);
                //int linesnew = [imaginaryTextview.text sizeWithFont:imaginaryTextview.font constrainedToSize:imaginaryTextview.frame.size lineBreakMode:NSLineBreakByWordWrapping].height /imaginaryTextview.font.pointSize;
              //  DLog(@"linesnew=%d",linesnew);
                
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
                
            }
            

            
              //  UIFont *font = [UIFont systemFontOfSize:16.0];
//                CGSize size = [self.commentTextView.text
//                               sizeWithFont:font
//                               constrainedToSize:self.commentTextView.frame.size
//                               lineBreakMode:UILineBreakModeWordWrap];
                
                             
                if ([[[eventcount objectAtIndex:0] valueForKey:@"hoster"]isEqual:@""])
                {
                    self.username.text=@"N/A";
                }
                else
                {
                    
                    self.username.text=[[eventcount objectAtIndex:0] valueForKey:@"hoster"];
                    
                }

                
//                NSString *imageurlprofile= [[eventcount objectAtIndex:0] valueForKey:@"profile_image"];
//                imageurlprofile = [imageurlprofile stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                NSData *imageDataProfile = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageurlprofile]];
//                if (imageDataProfile!=nil) {
//                    self.profileImage.image=[UIImage imageWithData:imageDataProfile];
//                    self.profileImage.layer.cornerRadius=20.0;
//                    self.profileImage.layer.borderColor=[UIColor blackColor].CGColor;
//                    self.profileImage.layer.borderWidth=1.0;
//                    self.profileImage.layer.masksToBounds = YES;
//                    
//                }
            
            
            
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
    }
    
   
     [appDel removeLoader];

}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    [[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    athleticdetails=nil;
    subscribeevents=nil;
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


#pragma mark Share

-(IBAction)share:(id)sender
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.attendevent=FALSE;
    NSMutableArray *shareItems = [NSMutableArray new];
    
    while ([shareItems count] < numberofSharedItems)
        [shareItems addObject: self];
    
    circleActivity  *ca = [[circleActivity alloc]init];
    
    UIActivityViewController *shareController =[[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:[NSArray arrayWithObject:ca]];
    
     [shareController setValue:self.eventTitle.text forKey:@"subject"];
    shareController.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                              UIActivityTypeAssignToContact,UIActivityTypeCopyToPasteboard,
                                              UIActivityTypeSaveToCameraRoll,UIActivityTypePrint];
     self.view.userInteractionEnabled=NO;
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
    if (shareController == activityViewController && itemNo < numberofSharedItems - 1)
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
    if (shareController == activityViewController && itemNo < numberofSharedItems - 1)
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
            case 3: return nil;
            case 4: return nil;
            default: return nil;
        }
}



-(IBAction)atheleticsEventsClosed:(id)sender
{
    if(athleticdetails==nil && subscribeevents==nil)
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

-(IBAction)forumPageOpen:(id)sender
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.enterFromForum=TRUE;
    appDel.redirectfrom=@"";
     appDel.logid=@"";
   AthleticForumPage *forumpage=[[AthleticForumPage alloc]initWithNibName:@"AthleticForumPage" bundle:nil];
    [[self navigationController]pushViewController:forumpage animated:YES];
    
    
}

-(IBAction)attendEvent:(id)sender
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel addLoaderForViewController:self];
    appDel.attendeventpage=TRUE;
    subscribeevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:subscribeAthleticsEvents]] ;
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


   // [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(atheleticsClosed:) userInfo:nil repeats:NO];
    
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
    //    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    //    if (app.attendevent)
    //    {
    //        self.attendEventBtn.hidden=YES;
    //    }
    //    else{
    //        self.attendEventBtn.hidden=NO;
    //
    //    }
    // Do any additional setup after loading the view from its nib.
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
- (void)viewDidUnload
{
    [self setAttendEventBtn:nil];
    [self setHeaderView:nil];
    [self setEventTitle:nil];
    [self setCommentTextView:nil];
    [self setUniversityScore:nil];
    [self setOpponentScore:nil];
    [self setShareButton:nil];
    [self setBackgroundscroller:nil];
    [self setReadmoreTitleButton:nil];
    [self setReadmorebuttonview:nil];
    [self setOpponentLabel:nil];
    [self setWilliamsLabel:nil];
    [self setInandFinalTitle:nil];
    [self setReadmoreOpponentButton:nil];
    [self setAllDescriptionView:nil];
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
    [self setDatebutton:nil];
    [self setReadmoreButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)readmoreButton:(id)sender {
}
@end
