//
//  AthleticsSubscription.m
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 5/23/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "AthleticsSubscription.h"

@interface AthleticsSubscription ()

@end

@implementation AthleticsSubscription
@synthesize deparmentcount,tableview,findTeam,buttonindexpath,newstatus,oldstatus,activityIndicator;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    //self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
  
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel addLoaderForViewController:self];
    self.findTeam.autocorrectionType=FALSE;
    self.findTeam.autocapitalizationType=UITextAutocapitalizationTypeNone;
      self.HeaderTitle.font = [UIFont boldSystemFontOfSize:self.HeaderTitle.font.pointSize];
    
   // DLog(@"useridprofile=%@",appDel.userid);
    listofdepartments =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:allAthleticsTeamdetails]] ;
    [listofdepartments setDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults valueForKey:@"userid"];
    [listofdepartments setPostValue:uid forKey:@"userid"];
    [listofdepartments  startAsynchronous];
    [findTeam addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}



-(void) viewWillDisappear:(BOOL)animated
{
    
    
    [self.findTeam resignFirstResponder];
    
    
}


- (IBAction)closeAthleticSubscription:(id)sender
{
     if (subscribedepartments==nil)
     {
  [self.navigationController popViewControllerAnimated:YES];
     }
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    if (request==listofdepartments)
    {
        
        NSString *response  =  [[request responseString] stringByReplacingOccurrencesOfString:@"&#x27;" withString:@"'"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&rsquo;" withString:@"'"];
        
        DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
         dict = [dict dictionaryByReplacingNullsWithStrings];
        DLog(@"status=%@",[dict objectForKey:@"status"]);
        userid=[dict objectForKey:@"userid"];
        DLog(@"dictionary count=%d",dict.count);
        
        //    DLog(@"id=%@",[dict valueForKey:[NSString stringWithFormat:@"%d",i]]);
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
              
            deparmentcount = [[NSMutableArray alloc] init];
            for (int i=0; i<=dict.count; i++)
            {
                // deparmentcount = [[NSMutableArray alloc] initWithObjects:[dict valueForKey:[NSString stringWithFormat:@"%d",i]], nil];
                if ([dict valueForKey:[NSString stringWithFormat:@"%d",i]]!=nil) {
                    [deparmentcount addObject:[dict valueForKey:[NSString stringWithFormat:@"%d",i]]];
                }
                
                else
                {
                    [deparmentcount removeObject:[dict valueForKey:[NSString stringWithFormat:@"%d",i]]];
                    
                }
                
            }
        
                  tableArray=[[NSMutableArray alloc] initWithArray:deparmentcount];
            
           // DLog(@"department=%@",deparmentcount);
           // DLog(@"department=%@",[[deparmentcount objectAtIndex:0] objectForKey:@"departments"]);
           // DLog(@"did=%@",[[deparmentcount objectAtIndex:0] objectForKey:@"id"]);
          //  DLog(@"departmentcount=%d",deparmentcount.count);
            
            //  DLog(@"count=%d",dict.count);
            // NSMutableArray  *deparmentcount = [dict objectForKey:@"id"];
            
            // NSLog(@"ob1=%@",deparmentcount);
            //  deparmentcount=[[dict objectForKey:@"d"] objectForKey:@"id"];
            self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            [self.tableview reloadData];
            
           }
         else if ([[dict objectForKey:@"status"] isEqualToString:@"e"])
           {
            
            [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            
            }
        
         else if (dict==nil)
         {
             
             [[[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
             
         }
        
        [appDel removeLoader];
   
        
    }
    
    if (request==subscribedepartments)
    {
          subscribedepartments=nil;
        NSString *response  =  [request responseString];
        
        DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
         self.findTeam.userInteractionEnabled=YES;
        DLog(@"status=%@",[dict objectForKey:@"status"]);
        if ([[dict objectForKey:@"status"] isEqualToString:@"s"])
        {
            
            
            DLog(@"subscription=%@",[dict objectForKey:@"subscribe"]);
            DLog(@"buttonindex=%d",buttonindexpath.row);
        
            DLog(@"subscription=%@",[[deparmentcount objectAtIndex:buttonindexpath.row] objectForKey:@"subscription_status"]);
           
            [self.tableview reloadData];
            
            [activityIndicator removeFromSuperview];
            [activityIndicator stopAnimating];
           // self.backButton.userInteractionEnabled=YES;
         
        }
        
        else if ([[dict objectForKey:@"status"] isEqualToString:@"e"])
        {
            
            [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
           // self.backButton.userInteractionEnabled=YES;
            
        }
        
        
       
    }
    
    
    
    
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    [[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    subscribedepartments=nil;
    
     self.findTeam.userInteractionEnabled=YES;
    //NSString *response  =  [request responseString];
   // DLog(@"response=%@",response);
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDel removeLoader];
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
    [[deparmentcount objectAtIndex:buttonindexpath.row] setValue:oldstatus forKey:@"subscription_status"];
    
    
}


# pragma Search

-(void) textDidChange:(id)sender
{
    
    findTeam = (UITextField *) sender;
    if (findTeam.text.length==0)
    {
        deparmentcount=tableArray;
        
    }
    else{
    
    // [self.deparmentcount removeAllObjects];
    // self.filteredCVData = [[NSMutableArray alloc] init];
    deparmentcount=tableArray;
    NSMutableArray *filterarray=[[NSMutableArray alloc]init];
    //    [filterarray removeAllObjects];
    // NSArray *filterContacts = [[NSArray alloc]init];
    NSString *match=self.findTeam.text;
    match = [match lowercaseString];
    
    
    for(int i=0; i<[deparmentcount count]; i++){
        
        // NSMutableArray *filterarray=[[NSMutableArray alloc]init];
        NSString *match=self.findTeam.text;
        match = [match lowercaseString];
        NSString *department = [NSString stringWithFormat:@"%@%@%@",[[deparmentcount objectAtIndex:i] objectForKey:@"gender"],@"'s ",[[deparmentcount objectAtIndex:i] objectForKey:@"game_title"]];
              department = [department lowercaseString];
        NSRange range = [department rangeOfString:match options:NSCaseInsensitiveSearch];

        NSString *departmentofgames = [NSString stringWithFormat:@"%@",[[deparmentcount objectAtIndex:i] objectForKey:@"game_title"]];
        departmentofgames = [departmentofgames lowercaseString];
        NSRange departmentRange = [departmentofgames rangeOfString:match options:NSCaseInsensitiveSearch];
       

        ///addressRange=[address rangeOfString:match options:NSCaseInsensitiveSearch];
        if (range.location==0|| departmentRange.location==0) {
            [filterarray addObject:[deparmentcount objectAtIndex:i]];
        }
        
        
        
        
    }
    
    deparmentcount=filterarray;
    
    }
    
    if ([self.findTeam.text isEqual:@""])
    {
        self.findTeam.placeholder=@"Find a Team";
    }
    

    [self.tableview reloadData];
    
}



-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.findTeam.placeholder=@"";
    singleTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGesture:)];
    [self.tableview addGestureRecognizer:singleTap];
    
}

- (IBAction)singleTapGesture:(UITextField *) textField{
    
    [self.findTeam resignFirstResponder];
    
    if ([self.findTeam.text isEqual:@""])
    {
        self.findTeam.placeholder=@"Find a Team";
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.tableview removeGestureRecognizer:singleTap];
    
    
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return deparmentcount.count;
    
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
    
    
    
    if (deparmentcount!=nil)
    {
        
        UIButton *checkbuttoninside = [UIButton buttonWithType:UIButtonTypeCustom];
        checkbuttoninside.frame=CGRectMake(270, 15, 30, 30);
        //  checkbuttoninside.center = CGPointMake(checkbutton.frame.size.width/2, checkbutton.frame.size.height/2);
        //  [checkbuttoninside addTarget:self action:@selector(subscription:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:checkbuttoninside];
        
        
        UIButton *checkbutton =[UIButton buttonWithType:UIButtonTypeCustom];
        checkbutton.frame=CGRectMake(245, -6, 70, 70);
        [checkbutton addTarget:self action:@selector(subscription:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:checkbutton];
        
        
        NSString *subscription_status=[[deparmentcount objectAtIndex:indexPath.row] objectForKey:@"subscription_status"];
        if ([subscription_status isEqualToString:@"yes"]) {
            
            [checkbuttoninside setImage:[UIImage imageNamed:@"check1.png"] forState:UIControlStateNormal];
            
        }
        else if ([subscription_status isEqualToString:@"no"])
        {
            [checkbuttoninside setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
            
        }
        
        
        
 UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 210, 40)];
        nameLabel.backgroundColor=[UIColor clearColor];
    nameLabel.text=[NSString stringWithFormat:@"%@%@%@",[[deparmentcount objectAtIndex:indexPath.row] objectForKey:@"gender"],@"'s ",[[deparmentcount objectAtIndex:indexPath.row] objectForKey:@"game_title"]];

        
        [nameLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:15.0]];
        nameLabel.numberOfLines=0;
       // [nameLabel sizeToFit];
        nameLabel.textAlignment=NSTextAlignmentLeft;
        nameLabel.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1] ;
        [cell.contentView addSubview:nameLabel];
        
    }
    
    
    //
    //    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 37, 200, 20)];
    //    nameLabel.backgroundColor=[UIColor clearColor];
    //    nameLabel.text=@"Carrier Services";
    //    [nameLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0]];
    //    nameLabel.textColor=[UIColor whiteColor];
    //    [cell.contentView addSubview:nameLabel];
    
    
    
    return cell;

}
- (void) subscription:(UIButton *) button
{
    UITableViewCell *cell = (UITableViewCell *)[[button superview] superview];
    buttonindexpath=[self.tableview indexPathForCell:cell];
    
   oldstatus=[[deparmentcount objectAtIndex:buttonindexpath.row] objectForKey:@"subscription_status"];
   gameid=[[deparmentcount objectAtIndex:buttonindexpath.row] objectForKey:@"id"];
    DLog(@"rowcount=%d",buttonindexpath.row);
  self.findTeam.userInteractionEnabled=NO;
    
    
    if ([oldstatus isEqualToString:@"yes"]) {
        newstatus=@"no";
        //   [checkImage setImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"uncheck.png"]]];
        
    }
    else if ([oldstatus isEqualToString:@"no"])
    {    newstatus=@"yes";
        //  [checkImage setImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"check1.png"]]];
    }
      
      [[deparmentcount objectAtIndex:buttonindexpath.row] setValue:newstatus forKey:@"subscription_status"];
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.frame=CGRectMake(button.frame.size.width/2-3, button.frame.size.height/2-6, 15, 15);
    [button addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    DLog(@"useridprofile=%@",userid);
    DLog(@"departmentid=%@",gameid);
    DLog(@"newstatus=%@",newstatus);
    subscribedepartments =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:subscribeAthletics]] ;
    [subscribedepartments setDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults valueForKey:@"userid"];
    [subscribedepartments setPostValue:uid forKey:@"userid"];
    [subscribedepartments setPostValue:gameid forKey:@"gameid"];
    [subscribedepartments setPostValue:newstatus forKey:@"subscribe"];
    [subscribedepartments  startAsynchronous];
    
     
    
}




//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//
//  NSString   *subscription_status=[[deparmentcount objectAtIndex:indexPath.row] objectForKey:@"subscription_status"];
//      departmentid=[[deparmentcount objectAtIndex:indexPath.row] objectForKey:@"id"];
//    NSLog(@"rowcount=%d",indexPath.row);
//
//
//
//
//    if ([subscription_status isEqualToString:@"yes"]) {
//        newstatus=@"no";
//    //   [checkImage setImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"uncheck.png"]]];
//
//    }
//    else if ([subscription_status isEqualToString:@"no"])
//    {    newstatus=@"yes";
//      //  [checkImage setImage:[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"check1.png"]]];
//    }
//
//    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
//    [appDel addLoaderForViewController:self];
//
//    DLog(@"useridprofile=%@",userid);
//     DLog(@"departmentid=%@",departmentid);
//     DLog(@"newstatus=%@",newstatus);
//    subscribedepartments =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:subscribetoDeparment]] ;
//    [subscribedepartments setDelegate:self];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *uid = [defaults valueForKey:@"userid"];
//    [subscribedepartments setPostValue:uid forKey:@"userid"];
//    [subscribedepartments setPostValue:departmentid forKey:@"departmentid"];
//    [subscribedepartments setPostValue:newstatus forKey:@"subscribe"];
//    [subscribedepartments  startAsynchronous];
//
//
//}



- (void)viewDidUnload
{
   [self setFindTeam:nil];
    [self setTableview:nil];
    [self setBackButton:nil];
    [self setHeaderTitle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
