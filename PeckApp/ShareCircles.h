//
//  inviteFriends.h
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 5/29/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

//
//  CreateCircle.h
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 5/22/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "AppDelegate.h"
#import "ViewProfile.h"

@class circleActivity;
@interface ShareCircles : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    ASIFormDataRequest *listofevents;
    ASIFormDataRequest *shareeventcircle;
    NSMutableArray  *eventcount;
    UITapGestureRecognizer  *singleTap;
    NSMutableArray * tableArray;
    UIActivityIndicatorView *activityIndicator;
    NSIndexPath *buttonindexpath;
    NSString *status;
    NSString *departmentid;
    NSMutableArray *tickCircleCount;
    NSInteger startindex;
    NSInteger savestartindex;
    NSMutableArray *saveeventcount;
    circleActivity *activity;
}
@property (strong, nonatomic) circleActivity *activity;
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) ASIFormDataRequest *listofevents;
@property (strong, nonatomic) NSMutableArray  *eventcount;
@property (strong, nonatomic) IBOutlet UITextField *findPersonOrGroup;
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;

- (IBAction)closeShareCircle:(id)sender;
-(IBAction) shareCircles:(id)sender;
@end


