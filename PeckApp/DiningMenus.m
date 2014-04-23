//
//  DiningMenus.m
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 7/25/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import "DiningMenus.h"

@implementation DiningMenus
@synthesize tableview,headerView,eventcount,homescreen;
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
   // [self presentModalViewController:events animated:YES];
    
    
}

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    
    self.HeaderTitle.font = [UIFont boldSystemFontOfSize:self.HeaderTitle.font.pointSize];
    DLog(@"ES=%d",appDel.enterscreen);
    homescreen =[[HomeScreen alloc] initWithNibName:@"HomeScreen" bundle:nil];
        eventcount = [[NSMutableArray alloc] init];
        
       
        
        [appDel addLoaderForViewController:self];
        self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        // self.tableview.hidden=YES;
        listofevents =   [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:diningMenus]] ;
        [listofevents setDelegate:self];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *uid = [defaults valueForKey:@"userid"];
        [listofevents setPostValue:uid forKey:@"userid"];
        [listofevents setPostValue:appDel.diningid forKey:@"diningid"];
        //  [listofevents setPostValue:@"0" forKey:@"start_limit"];
        [listofevents  startAsynchronous];
        
        
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
        
        listofevents=nil;
        NSString *response  =  [[request responseString] stringByReplacingOccurrencesOfString:@"&#x27;" withString:@"'"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&rsquo;" withString:@"'"];
        response  =  [response stringByReplacingOccurrencesOfString:@"\u2019" withString:@"'"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&ntilde;" withString:@"n"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&eacute;" withString:@"e"];
        response  =  [response stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        
        DLog(@"response=%@",response);
        NSMutableDictionary *dict=[response JSONValue];
         dict = [dict dictionaryByReplacingNullsWithStrings];
        DLog(@"status=%@",[dict objectForKey:@"status"]);
        DLog(@"dict=%@",dict);
        //   [eventcount removeAllObjects];
        //    DLog(@"id=%@",[dict valueForKey:[NSString stringWithFormat:@"%d",i]]);
        appDel.appdownloadlink=[dict valueForKey:@"downloadlink"];
      /*  if ([[NSString stringWithFormat:@"%d",[[dict valueForKey:@"notification_count"] intValue]]isEqual:@"0"])
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
        
        self.diningTitle.text=[dict objectForKey:@"diningplace_title"];
        DLog(@"link=%@",appDel.appdownloadlink);
       // DLog(@"nc=%@",appDel.activtynotificationcount);
        if ([[dict objectForKey:@"status"] isEqual:@"s"])
        {
            
            
            if ([[dict objectForKey:@"result"] isKindOfClass:[NSMutableArray class]]|| [[dict objectForKey:@"result"] isKindOfClass:[NSArray class]]) {
                self.eventcount=[dict objectForKey:@"result"];
            }
            else
            {
                [self.eventcount removeAllObjects];
            }
            
            DLog(@"dining=%@",eventcount);
            DLog(@"diningcount=%d",eventcount.count);
            
        
            
            
            self.tableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
            [self.tableview reloadData];
            
            
            
        }
        
        else if ([[dict objectForKey:@"status"] isEqualToString:@"e"])
        {
            self.tableview.hidden=NO;
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:alertTitle message:[dict objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            alert.tag=1;
            
            
        }
        
        else if (dict==nil)
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:alertTitle message:DatabaseError delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            alert.tag=1;
            appDel.erroralert=DatabaseError;
                       
        }
        
        
    }
    [appDel removeLoader];
    
    
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    listofevents=nil;
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:alertTitle message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    alert.tag=1;
    
   // NSString *response  =  [request responseString];
  //  DLog(@"response=%@",response);
    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
    appDel.erroralert=@"Network is not Reachable";
    [appDel removeLoader];
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
    self.tableview.hidden=NO;
    
    
    
}

#pragma mark alertview delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        if (buttonIndex==0)
        {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    }
    
}

- (IBAction)closeDiningMenus:(id)sender
{

    if (listofevents==nil)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }


}



- (void)viewDidUnload
{
    [self setTableview:nil];
    [self setHeaderView:nil];
    [self setHeaderTitle:nil];
    [self setDiningTopView:nil];
    [self setDiningTopViewLabel:nil];
    [self setDiningTitle:nil];
    [self setDiningTitle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    
    
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 13, 220, 50)];
    nameLabel.numberOfLines=0;
    nameLabel.backgroundColor=[UIColor clearColor];
    [nameLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:15.0]];
    nameLabel.text=[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row] objectForKey:@"menu"];
    
    //[nameLabel sizeToFit];
    //  nameLabel.textAlignment=UITextAlignmentLeft;
    nameLabel.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1] ;
    [cell.contentView addSubview:nameLabel];
    
    
  /*  if ([[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"small"]isEqual:@""] && [[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"large"]isEqual:@""] )
    {
        UILabel * combo= [[UILabel alloc] initWithFrame:CGRectMake(50+220, 35, 60, 10)];
        combo.backgroundColor=[UIColor clearColor];
        [combo setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0]];
        combo.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1];
        combo.text=[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"combo"];
    }
    
    else if ([[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"large"]isEqual:@""] && [[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"combo"]isEqual:@""] )
    {
        UILabel * small = [[UILabel alloc] initWithFrame:CGRectMake(50+220, 35, 60, 10)];
        small.backgroundColor=[UIColor clearColor];
        [small setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0]];
        small.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1];
        small.text=[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"small"];
        [cell.contentView addSubview:small];
    }
    
    else if ([[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"small"]isEqual:@""] && [[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"combo"]isEqual:@""] )
    {
        UILabel * large= [[UILabel alloc] initWithFrame:CGRectMake(50+220, 35, 60, 10)];
        large.backgroundColor=[UIColor clearColor];
        [large setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0]];
        large.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1];
        large.text=[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"large"];
        [cell.contentView addSubview:large];
    }
  else  if ([[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"small"]isEqual:@""])
    {
        
        UILabel * large= [[UILabel alloc] initWithFrame:CGRectMake(50+220, 20, 60, 10)];
        large.backgroundColor=[UIColor clearColor];
        [large setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0]];
        large.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1];
        large.text=[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"large"];
        [cell.contentView addSubview:large];
    
        
        UILabel * combo= [[UILabel alloc] initWithFrame:CGRectMake(50+220, 45, 60, 10)];
        combo.backgroundColor=[UIColor clearColor];
        [combo setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0]];
        combo.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1];
        combo.text=[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"combo"];
    
    }
   else  if ([[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"large"]isEqual:@""])
  {
      
      UILabel * large= [[UILabel alloc] initWithFrame:CGRectMake(50+220, 20, 60, 10)];
      large.backgroundColor=[UIColor clearColor];
      [large setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0]];
      large.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1];
      large.text=[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"small"];
      [cell.contentView addSubview:large];
      
      
      UILabel * combo= [[UILabel alloc] initWithFrame:CGRectMake(50+220, 45, 60, 10)];
      combo.backgroundColor=[UIColor clearColor];
      [combo setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0]];
      combo.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1];
      combo.text=[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"combo"];
      
  }
    
   else  if ([[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"combo"]isEqual:@""])
   {
       
       UILabel * large= [[UILabel alloc] initWithFrame:CGRectMake(50+220, 20, 60, 10)];
       large.backgroundColor=[UIColor clearColor];
       [large setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0]];
       large.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1];
       large.text=[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"small"];
       [cell.contentView addSubview:large];
       
       
       UILabel * combo= [[UILabel alloc] initWithFrame:CGRectMake(50+220, 45, 60, 10)];
       combo.backgroundColor=[UIColor clearColor];
       [combo setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0]];
       combo.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1];
       combo.text=[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"large"];
       
   }
*/
    
    
    
    UILabel * small = [[UILabel alloc] initWithFrame:CGRectMake(50+220, 15, 60, 14)];
    small.backgroundColor=[UIColor clearColor];
    [small setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0]];
    small.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1];
    small.text=[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"small"];
    [cell.contentView addSubview:small];
    
    UILabel * large= [[UILabel alloc] initWithFrame:CGRectMake(50+220, 32, 60, 14)];
    large.backgroundColor=[UIColor clearColor];
    [large setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0]];
    large.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1];
    large.text=[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"large"];
    [cell.contentView addSubview:large];
    
    UILabel * combo= [[UILabel alloc] initWithFrame:CGRectMake(50+219, 50, 60, 14)];
    combo.backgroundColor=[UIColor clearColor];
    [combo setFont:[UIFont fontWithName:@"Lato-Regular" size:13.0]];
    combo.textColor=[UIColor colorWithRed:(79/255.0) green:(79/255.0) blue:(79/255.0) alpha:1];
    combo.text=[[[[eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"]objectAtIndex:indexPath.row]objectForKey:@"combo"];
    [cell.contentView addSubview:combo];
 

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
        
        UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0,320,20)];
        tempLabel.backgroundColor=[UIColor clearColor];
        tempLabel.textColor = [UIColor whiteColor]; //here you can change the text color of header.
        tempLabel.textAlignment= NSTextAlignmentCenter;
        tempLabel.font = [UIFont fontWithName:@"Lato-Regular" size:15];
        tempLabel.font = [UIFont boldSystemFontOfSize:15];
        
        tempLabel.text=  [[[eventcount objectAtIndex:section] objectForKey:@"section_details"] objectForKey:@"section_name"];
        
        [tempView addSubview:tempLabel];
        
       
        
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
//    AppDelegate *appDel=(AppDelegate *) [UIApplication sharedApplication].delegate;
//    
//    DLog(@"index=%@",[[[[self.eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"] objectAtIndex:indexPath.row]objectForKey:@"id"]);
//    appDel.diningid=[[[[self.eventcount objectAtIndex:indexPath.section] objectForKey:@"section_description"] objectAtIndex:indexPath.row]objectForKey:@"id"];
//    DiningMenus *diningmenus=[[DiningMenus alloc] initWithNibName:@"DiningMenus" bundle:nil];
//    [self.navigationController pushViewController:diningmenus animated:YES];
}


@end
