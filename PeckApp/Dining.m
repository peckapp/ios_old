//
//  Dining.m
//  PeckApp
//
//  Created by SRM Techsol Pvt. Ltd. on 5/9/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "Dining.h"

@implementation Dining
@synthesize tableview,headerView,eventcount,homescreen,menuOpen;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



# pragma Create Dining

-(IBAction) createDining:(id)sender{

    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.attendevent=TRUE;
    CreateEventViewController *events=[[CreateEventViewController alloc]initWithNibName:@"CreateEventViewController" bundle:nil];
    
    [self presentViewController:events animated:YES completion:nil];
    //[self presentModalViewController:events animated:YES];


}

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    
    self.HeaderTitle.font = [UIFont boldSystemFontOfSize:self.HeaderTitle.font.pointSize];
    DLog(@"ES=%d",appDel.enterscreen);
    if (appDel.enterscreen)
    {
         eventcount = [[NSMutableArray alloc] init];

        [self initialload];
         
        [appDel addLoaderForViewController:self];
        self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        self.tableview.hidden=YES;
        listofevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:DiningSectionWise]] ;
        [listofevents setDelegate:self];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *uid = [defaults valueForKey:@"userid"];
        [listofevents setPostValue:uid forKey:@"userid"];
      //  [listofevents setPostValue:@"0" forKey:@"start_limit"];
        [listofevents  startAsynchronous];
        
        
    }
    
    else if (appDel.menu)
    {
        [self initialload];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray  *eventcountnew= [defaults valueForKey:@"eventcountdining"];
        [defaults synchronize];
        eventcount = [[NSMutableArray alloc] initWithArray:eventcountnew];
        //   DLog(@"ec=%@",eventcount);
        if (eventcount.count==0)
        {
             self.tableview.scrollEnabled=NO;
            self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
           [[[UIAlertView alloc]initWithTitle:alertTitle message:appDel.erroralert delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }
        
        else
        {
            self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            self.tableview.contentOffset=CGPointMake(0, appDel.diningscrollercontent);
          
        }
    }
    
    
}

-(void) initialload
{
    //AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    homescreen =[[HomeScreen alloc] initWithNibName:@"HomeScreen" bundle:nil];
    [self addChildViewController:homescreen];
    [self.view addSubview:homescreen.view];
   // homescreen.NotificationCount.text=appDel.activtynotificationcount;
   // homescreen.NotificationCount.hidden=YES;
    // homescreen.NotificationCount.text=@"10";
    
    homescreen.view.hidden=YES;
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
     
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.enterscreen=FALSE;
    appDel.menu=FALSE;
    
    
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    if (request==listofevents)
    {
       
        NSString *response  =  [[request responseString] stringByReplacingOccurrencesOfString:@"&#x27;" withString:@"'"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&rsquo;" withString:@"'"];
        response  =  [response stringByReplacingOccurrencesOfString:@"\u2019" withString:@"'"];
         response  =  [response stringByReplacingOccurrencesOfString:@"≈" withString:@"'"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&ntilde;" withString:@"n"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&eacute;" withString:@"e"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        response  =  [response stringByReplacingOccurrencesOfString:@"&ndash;" withString:@"-"];

        DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
         dict = [dict dictionaryByReplacingNullsWithStrings];
        DLog(@"status=%@",[dict objectForKey:@"status"]);
        DLog(@"dict=%@",dict);
        //   [eventcount removeAllObjects];
        //    DLog(@"id=%@",[dict valueForKey:[NSString stringWithFormat:@"%d",i]]);
        appDel.appdownloadlink=[dict valueForKey:@"downloadlink"];
       /* if ([[NSString stringWithFormat:@"%d",[[dict valueForKey:@"notification_count"] intValue]]isEqual:@"0"])
        {
            homescreen.NotificationCount.hidden=YES;
            appDel.activtynotificationcount=[NSString stringWithFormat:@"%d",[[dict valueForKey:@"notification_count"] intValue]];
            
            
        }
        
        else
        {
            homescreen.NotificationCount.hidden=NO;
            homescreen.NotificationCount.text=[NSString stringWithFormat:@"%d",[[dict valueForKey:@"notification_count"] intValue]];
            CGSize maximumSize = CGSizeMake(99999, 20);
            CGSize  notificationSize =[homescreen.NotificationCount.text sizeWithFont:homescreen.NotificationCount.font constrainedToSize:maximumSize lineBreakMode:homescreen.NotificationCount.lineBreakMode];
            homescreen.NotificationCount.frame=CGRectMake(homescreen.NotificationCount.frame.origin.x, homescreen.NotificationCount.frame.origin.y,notificationSize.width+10, homescreen.NotificationCount.frame.size.height);
            appDel.activtynotificationcount=[NSString stringWithFormat:@"%d",[[dict valueForKey:@"notification_count"] intValue]];
            
        }
        */
        
        DLog(@"link=%@",appDel.appdownloadlink);
        DLog(@"nc=%@",appDel.activtynotificationcount);
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
            
                       
            if ([[dict objectForKey:@"result"] isKindOfClass:[NSMutableArray class]]|| [[dict objectForKey:@"result"] isKindOfClass:[NSArray class]])
            {
                self.eventcount=[dict objectForKey:@"result"];
            }
            else
            {
                [self.eventcount removeAllObjects];
            }
            
            
            DLog(@"dining=%@",eventcount);
            DLog(@"diningcount=%d",eventcount.count);
                       
            
                  
            [[NSUserDefaults standardUserDefaults] setValue:eventcount forKey:@"eventcountdining"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            [self.tableview reloadData];
            
            self.tableview.hidden=NO;
            
        }
        
        else if ([[dict objectForKey:@"status"] isEqualToString:@"e"])
        {
            self.tableview.hidden=NO;
            
            if (eventcount.count==0)
            {
                 self.tableview.scrollEnabled=NO;
                  [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"eventcountdining"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
            else
            {
                
        [[[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                
            }
            
            
        }
        
        else if (dict==nil)
        {
        
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            if (eventcount.count==0)
            {
                alert.tag=1;
            }
             appDel.enterscreen=TRUE;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"eventcountdining"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
        
    }
    [appDel removeLoader];
    
    
}

 -(void)requestFailed:(ASIHTTPRequest *)request
  {
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    
    
    //NSString *response  =  [request responseString];
    //DLog(@"response=%@",response);
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
     appDel.erroralert=@"Network is not Reachable";
    [appDel removeLoader];
      if (eventcount.count==0)
      {
          alert.tag=1;
         
      }
      
    appDel.enterscreen=TRUE;
    self.tableview.hidden=NO;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"eventcountdining"];
    [[NSUserDefaults standardUserDefaults]synchronize];
   
    
}

#pragma mark alertview delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1)
    {
        if (buttonIndex==0)
        {
            [self closeDining:nil];
            
        }
        
    }
    
}


- (void)viewDidUnload
{
    [self setTableview:nil];
    [self setHeaderView:nil];
    [self setHeaderTitle:nil];
    [self setDiningTopView:nil];
    [self setDiningTopViewLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)closeDining:(id)sender{

    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.1];
    
    if(menuOpen) {
        
        frame.origin.x = -(320-70);
        [self shiftview];
        [self.view bringSubviewToFront:tableview];
        [self.view bringSubviewToFront:headerView];
        // _bannerView.hidden=NO;
        self.tableview.scrollEnabled=YES;
        [menuclickbutton removeFromSuperview];
        menuOpen = NO;
    }
    else
    {
        appDel.diningscrollercontent=self.tableview.contentOffset.y;
        frame.origin.x = 320-70;
        homescreen.view.hidden=NO;
        menuclickbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        if (self.tableview.contentSize.height<=[[UIScreen mainScreen] bounds].size.height-self.headerView.frame.size.height)
        {
            menuclickbutton.frame=CGRectMake(0,0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-self.headerView.frame.size.height);
        }
        else
        {
            menuclickbutton.frame=CGRectMake(0,0, [[UIScreen mainScreen] bounds].size.width,  self.tableview.contentSize.height);
            
        }
        
        [menuclickbutton addTarget:self action:@selector(closeDining:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableview addSubview:menuclickbutton];
        self.tableview.scrollEnabled=NO;
        //  _bannerView.hidden=YES;
        [self shiftview];
        menuOpen = YES;
        
        
    }
    
    frame = self.view.frame;
    [UIView commitAnimations];
    
  
}

-(void) shiftview
{
    
    self.tableview.frame = CGRectMake(self.tableview.frame.origin.x+frame.origin.x, self.tableview.frame.origin.y, self.tableview.frame.size.width, self.tableview.frame.size.height);
    
    self.headerView.frame=CGRectMake(self.headerView.frame.origin.x+frame.origin.x, self.headerView.frame.origin.y, self.headerView.frame.size.width, self.headerView.frame.size.height);
    
    
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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (eventcount.count!=0)
    {
        DLog(@"eventcount=%d",eventcount.count);
          return [self.eventcount count];

    }
      return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self.eventcount objectAtIndex:section] objectForKey:@"section_description"] count];
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
    
  
       
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 280, 40)];
    nameLabel.numberOfLines=0;
    nameLabel.backgroundColor=[UIColor clearColor];
    [nameLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:15.0]];
    nameLabel.text=[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row] objectForKey:@"placestoeat"];
    
    //[nameLabel sizeToFit];
    //  nameLabel.textAlignment=UITextAlignmentLeft;
    nameLabel.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1] ;
    [cell.contentView addSubview:nameLabel];
    
    
    
    UILabel * nameLabelbelow = [[UILabel alloc] initWithFrame:CGRectMake(50, 40, 280, 20)];
    nameLabelbelow.backgroundColor=[UIColor clearColor];
    [nameLabelbelow setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0]];
    nameLabelbelow.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1];
    nameLabelbelow.text=[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"placestoeat_details"];
    [cell.contentView addSubview:nameLabelbelow];
    
    UIImageView *typeImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 23, 30, 30)];
    typeImage.backgroundColor=[UIColor colorWithRed:(106/255.0)   green:(13/255.0) blue:(168/255.0) alpha:1.0] ;
    [cell.contentView addSubview:typeImage];
    UILabel *name=[[UILabel alloc] init];
    name.frame=typeImage.frame;
    // name.center = CGPointMake(typeImage.frame.size.width/2, typeImage.frame.size.height/2);
    // name.numberOfLines=0;
    name.textAlignment=NSTextAlignmentCenter;;
    name.backgroundColor=[UIColor clearColor];
    [name setFont:[UIFont fontWithName:@"Times New Roman" size:24.5]];
    name.textColor=[UIColor whiteColor] ;
    name.text=[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"first_char"];
    [cell.contentView addSubview:name];
    

    
    return cell;
    
    }


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
       
    // NSString *key = nil;
    if (eventcount.count!=0)
    {
        UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,0,320,20)];
        tempView.backgroundColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1] ;
        
        UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(130,0,190,20)];
        tempLabel.backgroundColor=[UIColor clearColor];
        tempLabel.textColor = [UIColor whiteColor]; //here you can change the text color of header.
        tempLabel.textAlignment= NSTextAlignmentLeft;
        tempLabel.font = [UIFont fontWithName:@"Lato-Regular" size:15];
        tempLabel.font = [UIFont boldSystemFontOfSize:15];

        tempLabel.text=  [[[eventcount objectAtIndex:section] objectForKey:@"section_details"] objectForKey:@"section_name"];

        [tempView addSubview:tempLabel];
        
        UIImageView *dinigImage =[[UIImageView alloc]initWithFrame:CGRectMake(105, 0, 20, 20)];
        if ([[[[eventcount objectAtIndex:section] objectForKey:@"section_details"] objectForKey:@"section_name"] isEqual:@"Breakfast"])
        {
            dinigImage.image=[UIImage imageNamed:@"breakfast.png"];
        }
        
        if ([[[[eventcount objectAtIndex:section] objectForKey:@"section_details"] objectForKey:@"section_name"] isEqual:@"Lunch"])
        {
            dinigImage.image=[UIImage imageNamed:@"Lunch.png"];
        }
        
        if ([[[[eventcount objectAtIndex:section] objectForKey:@"section_details"] objectForKey:@"section_name"] isEqual:@"Dinner"])
        {
            dinigImage.image=[UIImage imageNamed:@"Dinner.png"];
        }
        
        if ([[[[eventcount objectAtIndex:section] objectForKey:@"section_details"] objectForKey:@"section_name"] isEqual:@"Late Night"])
        {
            dinigImage.image=[UIImage imageNamed:@"Late Night.png"];
            
        }

        [tempView addSubview:dinigImage];
        
        return tempView;
    }
   


    // tempLabel.text=[NSString stringWithFormat:@"%@", key];
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;

    DLog(@"index=%@",[[[[self.eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"] objectAtIndex:indexPath.row]objectForKey:@"id"]);
    appDel.diningid=[[[[self.eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"] objectAtIndex:indexPath.row]objectForKey:@"id"];
    DiningMenus *diningmenus=[[DiningMenus alloc] initWithNibName:@"DiningMenus" bundle:nil];
    [self.navigationController pushViewController:diningmenus animated:YES];
}


@end
