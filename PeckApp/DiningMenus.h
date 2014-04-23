//
//  DiningMenus.h
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 7/25/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "DiningMenus.h"
#import "AppDelegate.h"
#import "HomeScreen.h"
@interface DiningMenus :UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    BOOL *menuOpen;
    ASIFormDataRequest *listofevents;
    ASIFormDataRequest *subscribeevents;
    HomeScreen *homescreen;
   
    UIActivityIndicatorView *activityIndicator;
    NSIndexPath *buttonindexpath;
    NSString *newstatus;
    NSString *oldstatus;
    NSMutableArray  *eventcount;
    
}

@property (strong, nonatomic) IBOutlet UILabel *diningTitle;
 @property (strong, nonatomic)  HomeScreen *homescreen;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UILabel *diningTopViewLabel;
@property (strong, nonatomic) IBOutlet UIView *diningTopView;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property(strong,nonatomic)  NSMutableArray  *eventcount;
@property (strong, nonatomic) IBOutlet UIView *headerView;

- (IBAction)closeDiningMenus:(id)sender;

@end