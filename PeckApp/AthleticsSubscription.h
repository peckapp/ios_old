//
//  AthleticsSubscription.h
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 5/23/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface AthleticsSubscription : UIViewController
{
    ASIFormDataRequest *listofdepartments;
    ASIFormDataRequest *subscribedepartments;
    NSMutableArray  *deparmentcount;
    NSMutableArray *tableArray;
    UIImageView *checkImage;
    NSString *userid;
    NSString *gameid;
    UIActivityIndicatorView *activityIndicator;
    UITapGestureRecognizer  *singleTap;
    NSIndexPath *buttonindexpath;
    NSString *newstatus;
    NSString *oldstatus;

}
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (strong, nonatomic) IBOutlet UIButton *backButton;

@property (strong,nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong,nonatomic) NSIndexPath *buttonindexpath;
@property (strong,nonatomic) NSString *newstatus;
@property (strong,nonatomic) NSString *oldstatus;

@property (strong,nonatomic)  NSMutableArray  *deparmentcount;

@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) IBOutlet UITextField *findTeam;

- (IBAction)closeAthleticSubscription:(id)sender;

@end
