//
//  ForumPage.m
//  PeckApp
//
//  Created by STPLINC. on 5/13/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "AthleticForumPage.h"
#import <QuartzCore/QuartzCore.h>
@interface AthleticForumPage()

@end

@implementation AthleticForumPage
@synthesize tableview,eventcount,footerView,forumComment,forumCommentView,imageCache,imageDownloadingQueue,eventTitle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
     self.nocommentImage.hidden=YES;
    self.forumComment.layer.cornerRadius=0;
    if (appDel.enterFromForum) {
        [appDel addLoaderForViewController:self];
        self.forumComment.delegate=self;
       // self.readmoreTitleButton.hidden=YES;
       // self.tableview.tableFooterView = self.footerView;
         [self.view bringSubviewToFront:forumCommentView];
        UILabel *label1 =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        label1.backgroundColor = [UIColor clearColor];
        self.forumComment.leftView=label1;
        self.forumComment.leftViewMode=UITextFieldViewModeAlways;
        
        [self initialload];
        eventcount = [[NSMutableArray alloc] init];
        self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        self.tableview.hidden=YES;
        listofevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:displayAthleticsForumComments]] ;
        [listofevents setDelegate:self];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *uid = [defaults valueForKey:@"userid"];
        [listofevents setPostValue:uid forKey:@"userid"];
        [listofevents setPostValue:appDel.eventid forKey:@"eventid"];
        [listofevents setPostValue:appDel.redirectfrom forKey:@"redirect_from"];
        [listofevents setPostValue:appDel.logid forKey:@"log_id"];
        [listofevents setPostValue:@"0" forKey:@"start_limit"];
        DLog(@"eid=%@",appDel.eventid);
        DLog(@"uid=%@",uid);
        [listofevents  startAsynchronous];
        self.imageDownloadingQueue = [[NSOperationQueue alloc] init];
        self.imageDownloadingQueue.maxConcurrentOperationCount = 4; // many servers limit how many concurrent requests they'll accept from a device, so make sure to set this accordingly
        
        self.imageCache = [[NSCache alloc] init];
        
    }
    
}
-(void) viewDidDisappear:(BOOL)animated
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.enterFromForum=FALSE;
}
-(void) initialload
{
   self.tableview = [[PullTableViewFooter alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height-105) style:UITableViewStylePlain];
    
      self.tableview.pullDelegate =self;
    self.tableview.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:tableview];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
      self.tableview.showsVerticalScrollIndicator=NO;
   
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    
    [self loadMoreDataToTable];
}

-(void) loadMoreDataToTable
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    savestartindex=startindex;
    startindex=startindex+Size;
    listofevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:displayAthleticsForumComments]] ;
    
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

# pragma mark title ReadMore

-(IBAction) readmoreTitle:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    
    //self.eventTitle.textAlignment=UITextAlignmentLeft;
    
    self.headerView.frame=CGRectMake(self.headerView.frame.origin.x, self.headerView.frame.origin.y, self.headerView.frame.size.width, titleSize.height+28);
    self.eventTitle.frame=CGRectMake(self.eventTitle.frame.origin.x,0, self.eventTitle.frame.size.width, titleSize.height+28);
    
    self.tableview.frame=CGRectMake(self.tableview.frame.origin.x,titleSize.height+28, self.tableview.frame.size.width, self.tableview.frame.size.height-titleSize.height+28);
    
     self.nocommentImage.frame=CGRectMake(self.nocommentImage.frame.origin.x,self.nocommentImage.frame.origin.y+titleSize.height-28, self.nocommentImage.frame.size.width, self.nocommentImage.frame.size.height);
    
    [self.readmoreTitleButton removeFromSuperview];
    
    [self.view bringSubviewToFront:forumCommentView];
    
    [UIView commitAnimations];
}



-(void)requestFinished:(ASIHTTPRequest *)request
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    if (request==listofevents)
    {
        
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
        DLog(@"title=%@",[dict objectForKey:@"event_title"]);
        
        
         self.eventTitle.text=[dict objectForKey:@"event_title"];
        
        CGSize maximumSize = CGSizeMake(170, 9999);
        // UIFont *myFont = [UIFont fontWithName:@"System Bold" size:18];
        // UIFont *myFont = [UIFont fontWithName:@"System Bold" size:18];
        titleSize = [[dict objectForKey:@"event_title"] sizeWithFont:self.eventTitle.font constrainedToSize:maximumSize lineBreakMode:self.eventTitle.lineBreakMode];
        
        
        
        DLog(@"title width=%f",titleSize.width);
        DLog(@"title height=%f",titleSize.height);
        DLog(@"et=%@",[dict objectForKey:@"event_title"]);
        
        int lines = [[dict objectForKey:@"event_title"] sizeWithFont:self.eventTitle.font constrainedToSize:maximumSize
                lineBreakMode:self.eventTitle.lineBreakMode].height /self.eventTitle.font.pointSize;
        
        
        DLog(@"lines=%d",lines);
        
        if (lines<=1)
        {
            [self.readmoreTitleButton removeFromSuperview];
            
        }
       
        //   [eventcount removeAllObjects];
        //    DLog(@"id=%@",[dict valueForKey:[NSString stringWithFormat:@"%d",i]]);

        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
           
            
           
                
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

                
                DLog(@"department=%@",eventcount);
                DLog(@"department=%@",[[eventcount objectAtIndex:0] objectForKey:@"event_title"]);
                DLog(@"department=%@",[[eventcount objectAtIndex:0] objectForKey:@"event_image_url"]);
                
                DLog(@"departmentcount=%d",eventcount.count);
           

                //  DLog(@"count=%d",dict.count);
                // NSMutableArray  *deparmentcount = [dict objectForKey:@"id"];
                
                // NSLog(@"ob1=%@",deparmentcount);
                //  deparmentcount=[[dict objectForKey:@"d"] objectForKey:@"id"];
                
            
            
            self.tableview.hidden=NO;
            self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            [self.tableview reloadData];
            self.tableview.pullTableIsLoadingMore = NO;
            self.forumComment.text=@"";
            self.forumComment.placeholder=@"Type something";
            
        }
        else if ([[dict objectForKey:@"status"] isEqualToString:@"e"])
        {
            self.eventTitle.text=[dict objectForKey:@"event_title"];
            startindex=savestartindex;
            self.tableview.hidden=NO;
            [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            
        }
        else if ([[dict objectForKey:@"status"] isEqualToString:@"n"])
        {
            startindex=0;
            self.eventTitle.text=[dict objectForKey:@"event_title"];
            self.nocommentImage.hidden=NO;
            
        }
        else if (dict==nil)
        {
            
            [[[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            [appDel removeLoader];
            
        }
        
        self.tableview.pullTableIsLoadingMore = NO;
        [appDel removeLoader];
    }
    
    if (request==postcomments)
    {
        
        
        NSString *response  =  [request responseString];
        DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
            
            [eventcount removeAllObjects];
            listofevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:displayAthleticsForumComments]] ;
            [listofevents setDelegate:self];
            startindex=0;
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSString *uid = [defaults valueForKey:@"userid"];
            [listofevents setPostValue:uid forKey:@"userid"];
            [listofevents setPostValue:appDel.eventid forKey:@"eventid"];
            NSString *nextindex = [NSString stringWithFormat:@"%d", (int)startindex];
            [listofevents setPostValue:nextindex forKey:@"start_limit"];
            DLog(@"eid=%@",appDel.eventid);
            DLog(@"uid=%@",uid);
            [listofevents  startAsynchronous];
            
        }
        else  if ([[dict objectForKey:@"status"] isEqual:@"e"])
        {
            [appDel removeLoader];
            [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            [appDel removeLoader];
            
        }
    }
    
    
    
}


-(void)requestFailed:(ASIHTTPRequest *)request
{
    [[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
   // NSString *response  =  [request responseString];
  //  DLog(@"response=%@",response);
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel removeLoader];
    self.tableview.hidden=NO;
    self.tableview.pullTableIsLoadingMore = NO;
   startindex=savestartindex;
    
}



-(IBAction) writeComment:(id)sender
{

    [self.forumComment becomeFirstResponder];
    
}

- (IBAction)keyboardhidden:(id)sender{
    
    
    
    [self.forumComment resignFirstResponder];
    if (forumComment.text.length<=80) {
        AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
        [appDel addLoaderForViewController:self];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        postcomments =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:addAthleticsForumComments]] ;
        [postcomments setDelegate:self];
        
        NSString *uid = [defaults valueForKey:@"userid"];
        [postcomments setPostValue:uid forKey:@"userid"];
        [postcomments setPostValue:appDel.eventid forKey:@"eventid"];
        [postcomments setPostValue:self.forumComment.text forKey:@"comment"];
        DLog(@"eid=%@",appDel.eventid);
        DLog(@"uid=%@",uid);
        DLog(@"comment=%@",self.forumComment.text);
        [postcomments  startAsynchronous];
      
    }
    else if (forumComment.text.length==0)
    {
        
        [[[UIAlertView alloc]initWithTitle:alertTitle message:@"You can not enter blank Comment" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        
        
    }
    
    else
    {
        [[[UIAlertView alloc]initWithTitle:alertTitle message:@"You can not post more than 80 Characters" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        
    }
    
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
    return 75;
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
    
    if (eventcount!=nil)
    {
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 18, 200+60, 20+20)];
        
        
        nameLabel.backgroundColor=[UIColor clearColor];
        nameLabel.text=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"comment_posted"];
        
        [nameLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:15.0]];
        nameLabel.numberOfLines=0;
       // [nameLabel sizeToFit];
        //  nameLabel.textAlignment=UITextAlignmentLeft;
        nameLabel.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1] ;
        [cell.contentView addSubview:nameLabel];
        
        UIImageView *typeImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 23, 30, 30)];
        typeImage.layer.cornerRadius=15.0;
        typeImage.layer.masksToBounds = YES;
        typeImage.layer.borderColor=[UIColor lightGrayColor].CGColor;
        typeImage.layer.borderWidth=1.0;
        [cell.contentView addSubview:typeImage];
        
        
        NSString *imageurl=  [[eventcount objectAtIndex:indexPath.row] objectForKey:@"forum_profile_image"];
        if ([imageurl isEqual:@""]) {
            typeImage.image = [UIImage imageNamed:@"w.png"];
        }
        
        else
        {
        
        UIImage *cachedImage = [self.imageCache objectForKey:imageurl];
        
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
            
            typeImage.image = [UIImage imageNamed:@"athleticsnew.png"];
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
            
    }
    return cell;
}


#pragma mark TextView Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self keyboardhidden:nil];
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self.view removeGestureRecognizer:singleTap];
    if ([textField.text isEqual:@""])
    {
        textField.placeholder=@"Type something";
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.view bringSubviewToFront:forumCommentView];
    self.forumCommentView .frame = CGRectMake(self.forumCommentView.frame.origin.x,self.forumCommentView.frame.origin.y+215.0,self.forumCommentView.frame.size.width, self.forumCommentView.frame.size.height);
    [UIView commitAnimations];
    
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    singleTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGesture:)];
    [self.view addGestureRecognizer:singleTap];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.view bringSubviewToFront:forumCommentView];
    self.forumCommentView.frame = CGRectMake(self.forumCommentView.frame.origin.x, self.forumCommentView.frame.origin.y-215.0,
                                             self.forumCommentView.frame.size.width, self.forumCommentView.frame.size.height);
    [UIView commitAnimations];
}

- (IBAction)singleTapGesture:(UITextField *) textField{
    
    [self.forumComment resignFirstResponder];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >= MaxCharacterLength && range.length == 0)
    {
    	return NO; // return NO to not change text
        [[[UIAlertView alloc]initWithTitle:alertTitle message:@"You can not enter more than 105 characters" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        
    }
    else
    {
        return YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.profileid=[[eventcount objectAtIndex:indexPath.row] objectForKey:@"postedby_userid"];
    //appDel.enterFromCircle=TRUE;
    DLog(@"pid=%@",appDel.profileid);
    //[appDel addLoaderForViewController:self];
      appDel.enterscreen=TRUE;
    ViewProfile *profile=[[ViewProfile alloc] initWithNibName:@"ViewProfile" bundle:nil];
    [self presentViewController:profile animated:YES completion:nil];
    //[self presentModalViewController:profile animated:YES];
    
    
    DLog(@"circleid=%@",appDel.circleid);
    
}

-(IBAction)forumPageClosed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setForumCommentView:nil];
    [self setForumComment:nil];
    [self setTableview:nil];
    [self setFooterView:nil];
    [self setEventTitle:nil];
    [self setReadmoreTitleButton:nil];
    [self setHeaderView:nil];
    [self setNocommentImage:nil];
    [super viewDidUnload];
}
@end
