//
//  Athletics.h
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 5/28/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AthleticsEventPage.h"
#import "HomeScreen.h"
#import "PullTableView.h"



@class HomeScreen;

    
@interface Athletics : UIViewController<PullTableViewDelegate,UITableViewDelegate, UITableViewDataSource>
{

    HomeScreen *homescreen;
    CGRect frame;
    BOOL menuOpen;
    ASIFormDataRequest *listofevents;
    ASIFormDataRequest *subscribeevents;
    NSMutableArray  *eventcount;
    UIActivityIndicatorView *activityIndicator;
    NSIndexPath *buttonindexpath;
    NSString *newstatus;
    NSString *oldstatus;
    NSInteger startindex;
     NSInteger savestartindex;
    ASIFormDataRequest *previousevents;
    NSInteger previousindex;
    NSInteger savepreviousindex;
    UIButton *menuclickbutton;

}
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (assign) BOOL menuOpen;
@property (strong,nonatomic)  UIActivityIndicatorView *activityIndicator;
@property (strong,nonatomic) NSString *newstatus;
@property (strong,nonatomic)  NSString *oldstatus;
@property (strong,nonatomic) NSIndexPath *buttonindexpath;
@property (strong, nonatomic)  NSMutableArray  *eventcount;
@property (strong, nonatomic)  PullTableView *tableview;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic) NSInteger startindex;
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;

-(IBAction) createAthletics:(id)sender;
-(IBAction) athleticsButtonClosed:(id)sender;

@end
