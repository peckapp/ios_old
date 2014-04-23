//
//  MyHorizon.h
//  PeckApp
//
//  Created by SRM Techsol Pvt. Ltd. on 5/7/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeScreen.h"
#import "CampusEventsViewController.h"
#import "EventPageAttend.h"
#import "PullTableView.h"
@class HomeScreen;
@interface afterHours : UIViewController<PullTableViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    BOOL menuOpen;
    ASIFormDataRequest *listofevents;
    ASIFormDataRequest *subscribeevents;
    ASIFormDataRequest *previousevents;
    HomeScreen *homescreen;
    CGRect frame;
    UIActivityIndicatorView *activityIndicator;
    NSIndexPath *buttonindexpath;
    NSString *newstatus;
    NSString *oldstatus;
    NSMutableArray  *eventcount;
    NSInteger  startindex;
    NSInteger  savestartindex;
    NSInteger previousindex;
    NSInteger savepreviousindex;
    UIButton *menuclickbutton;
}
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (assign) BOOL menuOpen;
@property (strong,nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong,nonatomic) NSIndexPath *buttonindexpath;
@property(strong,nonatomic)  NSMutableArray  *eventcount;
@property(strong,nonatomic)  NSString *newstatus;
@property(strong,nonatomic)  NSString   *oldstatus;
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;
@property (strong, nonatomic)  HomeScreen *homescreen;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic)  PullTableView *tableview;



-(IBAction) createAfterHours:(id)sender;
- (IBAction)afterHoursClosed:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *date;
@end
