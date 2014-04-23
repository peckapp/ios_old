//
//  Dining.h
//  PeckApp
//
//  Created by SRM Techsol Pvt. Ltd. on 5/9/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeScreen.h"
#import "CampusEventsViewController.h"
#import "EventPageAttend.h"
#import "CreateEventViewController.h"
#import "DiningMenus.h"
@class HomeScreen;
@interface Dining :UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    BOOL menuOpen;
    ASIFormDataRequest *listofevents;
    ASIFormDataRequest *subscribeevents;
    HomeScreen *homescreen;
    CGRect frame;
    NSIndexPath *buttonindexpath;
    NSString *newstatus;
    NSString *oldstatus;
    NSMutableArray  *eventcount;
    UIButton *menuclickbutton;
   
}
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UILabel *diningTopViewLabel;
@property (strong, nonatomic) IBOutlet UIView *diningTopView;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (assign) BOOL menuOpen;
@property(strong,nonatomic)  NSMutableArray  *eventcount;
@property (strong, nonatomic)  HomeScreen *homescreen;
@property (strong, nonatomic) IBOutlet UIView *headerView;

- (IBAction)closeDining:(id)sender;

-(IBAction) createDining:(id)sender;

@end
