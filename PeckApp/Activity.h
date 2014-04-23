//
//  Activity.h
//  PeckApp
//
//  Created by SRM Techsol Pvt. Ltd. on 5/7/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableViewFooter.h"
#import "EventPageAttend.h"
#import "AthleticsEventPage.h"
#import "ForumPage.h"
#import "AthleticForumPage.h"

#import "HomeScreen.h"
@class HomeScreen;

@interface Activity : UIViewController<UITableViewDelegate,UITableViewDataSource,PullTableViewFooterDelegate>
{

    HomeScreen *homescreen;
    CGRect frame;
     BOOL menuOpen;
    ASIFormDataRequest *subscribeevents;
    NSIndexPath *buttonindexpath;
    NSString *newstatus;
    NSString *oldstatus;
    UIActivityIndicatorView *activityIndicator;
    ASIFormDataRequest *listofevents;
    NSMutableArray  *eventcount;
     NSInteger startindex;
     NSInteger savestartindex;
    UIButton *menuclickbutton;
    UIButton *checkbuttoninside;
    UIButton *checkbutton;
}
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property(assign) BOOL menuOpen;
@property (strong, nonatomic)  NSMutableArray  *eventcount; 
@property (strong, nonatomic)  PullTableViewFooter *tableview;
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;

@property (strong, nonatomic)  HomeScreen *homescreen;
@property (strong, nonatomic) IBOutlet UIView *headerView;

- (IBAction)closeActivity:(id)sender;

@end
