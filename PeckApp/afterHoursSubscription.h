//
//  afterHoursSubscription.h
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 6/25/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface afterHoursSubscription : UIViewController
{
    ASIFormDataRequest *listofdepartments;
    ASIFormDataRequest *subscribedepartments;
    NSMutableArray  *deparmentcount;
    UIImageView *checkImage;
    NSString *userid;
    NSString *departmentid;
    UIActivityIndicatorView *activityIndicator;
    UITapGestureRecognizer  *singleTap;
    NSIndexPath *buttonindexpath;
    NSString *newstatus;
    NSString   *oldstatus;
    NSMutableArray *tableArray;
    NSMutableArray *filterArray;
    
}
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong,nonatomic)  UIActivityIndicatorView *activityIndicator;
@property (strong,nonatomic) NSIndexPath *buttonindexpath;
@property(strong,nonatomic) NSString *newstatus;
@property(strong,nonatomic) NSString   *oldstatus;
@property (strong, nonatomic)  NSMutableArray  *deparmentcount;
@property (strong, nonatomic) IBOutlet UITextField *findDepartmenttextfield;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)closeafterHoursSubscription:(id)sender;


@end