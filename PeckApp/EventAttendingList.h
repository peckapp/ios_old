//
//  ViewCircles.h
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 6/7/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservices.h"
#import "AppDelegate.h"
#import "ViewProfile.h"
#import "PullTableViewFooter.h"


@interface EventAttendingList : UIViewController<UITableViewDelegate,UITableViewDataSource,PullTableViewFooterDelegate>
{
    ASIFormDataRequest *listofevents;
    NSMutableArray  *eventcount;
    NSInteger  startindex;
}


@property (strong, nonatomic) IBOutlet UILabel *eventtitle;
@property (strong, nonatomic) IBOutlet UIImageView *circleImage;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *ProfileName;
@property (strong, nonatomic) IBOutlet PullTableViewFooter *tableview;
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;

-(IBAction) closeEventAttending:(id)sender;



@end
