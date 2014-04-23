//
//  CampusEventsViewController.h
//  PeckApp
//
//  Created by STPL MAC on 4/25/13.
//  Copyright (c) 2013 stpl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "PullTableView.h"
#import "EditEventPage.h"

@class HomeScreen;
@interface CampusEventsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,PullTableViewDelegate>
{
    ASIFormDataRequest *listofevents;
    ASIFormDataRequest *subscribeevents;
     ASIFormDataRequest *previousevents;
    NSMutableArray  *eventcount;
     NSString *userid;
     CGRect frame;
     BOOL menuOpen;
    HomeScreen   *homescreen;
    UIActivityIndicatorView *activityIndicator;
    NSIndexPath *buttonindexpath;
      NSString *newstatus;
    NSString   *oldstatus;
    NSInteger startindex;
    NSInteger previousindex;
    NSInteger savestartindex;
    NSInteger savepreviousindex;
    UIButton *menuclickbutton;
}

@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property(assign) BOOL menuOpen;
@property(strong,nonatomic) UIActivityIndicatorView *activityIndicator;
@property(strong,nonatomic) NSString *newstatus;
@property(strong,nonatomic) NSString   *oldstatus;
@property(strong,nonatomic)   NSMutableArray  * eventcount;
@property (strong, nonatomic)   NSIndexPath *buttonindexpath;
@property (strong, nonatomic)   HomeScreen   *homescreen;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIButton *campusEvent;
@property (strong, nonatomic)  PullTableView *tableview;
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;


-(IBAction)campusEventsButtonClicked:(id)sender;
-(IBAction)campusEventsButtonClosed:(id)sender;
@end




