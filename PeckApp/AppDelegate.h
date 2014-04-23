//
//  AppDelegate.h
//  PeckApp
//
//  Created by SRM Techsol Pvt. Ltd. on 5/3/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplashScreenViewController.h"
#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "HomeScreen.h"



@class ViewController,SplashScreenViewController,HttpConnectionHelper,HomeScreen,
GatewayClient,CampusEventsViewController;

@protocol HomeScreenDelgate


-(void) changeLabelInfo;
-(void) switchtopecks;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
     UIView *MainView;
    NSString *userid;
   
   
}

@property (strong, nonatomic) NSDictionary *notificationinfo;
@property (strong, nonatomic) id delegate;
@property (strong, nonatomic) UIView *MainView;
@property (strong, nonatomic) UIView *presentView;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SplashScreenViewController *splashController;
@property (strong, nonatomic) FBSession *session;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) CampusEventsViewController *events;
@property (nonatomic,retain) HttpConnectionHelper * connectionHelper;
@property (strong, nonatomic) UINavigationController *navController;
@property(nonatomic,strong) NSString *devicetoken;
@property(nonatomic,strong) NSString *logid;
@property(nonatomic,strong) NSString *erroralert;
@property(nonatomic,strong) NSString *fbSession;
@property(nonatomic,strong) NSString *imageurl;
@property(nonatomic,strong) NSString *userid;
@property(nonatomic,strong) NSString *appdownloadlink;
@property(nonatomic,strong) NSString *profileid;
@property(nonatomic,strong) NSString *circleid;
@property(nonatomic,strong) NSString *commenttext;
@property(nonatomic,strong) NSString *listcircle;
@property(nonatomic,strong) NSString *activtynotificationcount;
@property(nonatomic,strong) NSString *redirectfrom;
@property(nonatomic,strong) NSString *diningid;
@property(nonatomic,strong) NSString *adlink;
@property(nonatomic) NSInteger circlecount;
@property(nonatomic) NSInteger simyhorizon;
@property(nonatomic) NSInteger pimyhorizon;
@property(nonatomic) NSInteger sicampusevent;
@property(nonatomic) NSInteger picampusevent;
@property(nonatomic) NSInteger siathletics;
@property(nonatomic) NSInteger piathletics;
@property(nonatomic) NSInteger siafterhours;
@property(nonatomic) NSInteger piafterhours;
@property(nonatomic) NSInteger siactivity;
@property(nonatomic,strong) UIImage *fbimage;
@property(nonatomic,strong) NSString *fid;
@property(nonatomic,strong)   UIActivityViewController *activityView;
@property (assign) BOOL notificationstatus;
@property (assign) BOOL firsttimenotification;
@property (assign) CGFloat menuscrollercontent;
@property (assign) CGFloat myhorizonscrollercontent;
@property (assign) CGFloat athleticsscrollercontent;
@property (assign) CGFloat campusscrollercontent;
@property (assign) CGFloat afterhoursscrollercontent;
@property (assign) CGFloat activityscrollercontent;
@property (assign) CGFloat diningscrollercontent;
@property (assign) CGFloat circlesscrollercontent;
@property (assign) CGFloat settingsscrollercontent;
@property (assign) BOOL menu;
@property (assign) BOOL activityOpen;
@property (assign) BOOL enterscreen;
@property (assign) BOOL attendevent;
@property (assign) BOOL enterFromCircle;
@property (assign) BOOL enterFromEvent;
@property (assign) BOOL enterFromForum;
@property (assign) BOOL attendeventpage;
@property (assign) BOOL receivenotification;

@property(nonatomic, strong) NSString *sId;
@property(nonatomic, strong) NSString *eventid;
@property(nonatomic, strong) NSString *eventdepartment;


-(void) homescreen;
-(void)hideSplashScreen;
-(void)removeLoader;

-(void)addLoaderForViewController:(UIViewController*)presentController;
- (void)openSession;

- (void)populateUserDetails;
-(void)logoutFacebook;
- (void)transitionToViewController:(UIView *)view
                    withTransition:(UIViewAnimationOptions)transition;
@end