//  AppDelegate.m
//  a1
//
//  Created by SRM Techsol Pvt. Ltd. on 5/3/13.
//  Copyright (c) 2013 STPL. All rights reserved.
// This Code is Developed by Viresh Kumar Sharma. Mob No. -> +917499243952

#import "AppDelegate.h"
#import "Flurry.h"
#import "HomeScreen.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize splashController = _splashController;
@synthesize navController=_navController;
@synthesize events=_events;
@synthesize sId,attendevent,enterscreen,commenttext,activityView,menu;
@synthesize connectionHelper,userid,imageurl,fbimage,fid,eventid,circleid,profileid,enterFromCircle,enterFromForum,listcircle,eventdepartment,circlecount,enterFromEvent,appdownloadlink,activtynotificationcount,redirectfrom,erroralert,notificationstatus,logid,activityOpen,diningid,attendeventpage,devicetoken,receivenotification,adlink,firsttimenotification,menuscrollercontent,myhorizonscrollercontent,campusscrollercontent,athleticsscrollercontent,afterhoursscrollercontent,activityscrollercontent,diningscrollercontent,circlesscrollercontent,settingsscrollercontent,simyhorizon,pimyhorizon,sicampusevent,picampusevent,siathletics,piathletics,siafterhours,piafterhours,siactivity;

@synthesize MainView,presentView;
@synthesize delegate,notificationinfo;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor colorWithRed:142.0/255.0 green:119.0/255.0 blue:178.0/255.0 alpha:0.5];
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleBlackTranslucent];

    // Override point for customization after application launch.
    [Flurry startSession:@"5V5M42MM3325QNGH29KP"];
    self.splashController = [[SplashScreenViewController alloc] initWithNibName:@"SplashScreenViewController" bundle:nil];
    [self.window addSubview:self.splashController.view];
    
     self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
     DLog(@"session=%@", self.fbSession);
   
    self.navController=[[UINavigationController alloc]initWithRootViewController:self.viewController];
    [application registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    application.applicationIconBadgeNumber=0;
  
    //application.applicationIconBadgeNumber;
   // self.navController.navigationBar.tintColor=[UIColor colorWithRed:143.0/255.0 green:121.0/255.0  blue:179.0/255.0  alpha:1.0];
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
   // DLog(@"HELLO");
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    if (application.applicationIconBadgeNumber>0)
    {
        enterscreen=TRUE;
        
    }
    activtynotificationcount=[NSString stringWithFormat:@"%d",application.applicationIconBadgeNumber];
    [delegate changeLabelInfo];
       /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	DLog(@"My token is: %@", deviceToken);
    
    /*ios_development-1.cer
     
     {
     "aps": {
     "alert" : "You got a new message!" ,
     "badge" : 5,
     "sound" : "beep.wav"},
     "acme1" : "bar",
     "acme2" : 42
     }
     
     */
    NSString *devicetoken_new = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    devicetoken_new = [devicetoken_new stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    devicetoken=devicetoken_new;
    
    DLog(@"My token is: %@", self.devicetoken);
    
    
}
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    if ([error code] == 3010) {
      //  NSLog(@"Push notifications don't work in the simulator!");
    } else {
      //  NSLog(@"didFailToRegisterForRemoteNotificationsWithError: %@", error);
    }
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userinfo
{
    
  // NSDictionary  *userinfo=[[NSDictionary alloc] init];
    DLog(@"user  info: %@",userinfo);

    notificationinfo=[[NSDictionary alloc] initWithDictionary:userinfo];
    application.applicationIconBadgeNumber=[[[userinfo objectForKey:@"aps"] objectForKey:@"badge"] integerValue];
        
        DLog(@"count=%d",[[[userinfo objectForKey:@"aps"] objectForKey:@"badge"] integerValue]);
        activtynotificationcount= [NSString stringWithFormat:@"%d",application.applicationIconBadgeNumber];
    
       
    DLog(@"activitycount=%@",activtynotificationcount);
    [delegate changeLabelInfo];
   UIAlertView * pushalert = [[UIAlertView alloc] initWithTitle:alertTitle message:[[userinfo objectForKey:@"aps"] objectForKey:@"alert"]  delegate:self cancelButtonTitle:@"View" otherButtonTitles:@"Cancel", nil];
    pushalert.tag=0;
    [pushalert show];
}


#pragma mark alertview delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 0)
    {
           
        
        if (buttonIndex == 0)
        {
         
            [UIApplication sharedApplication].applicationIconBadgeNumber=0;
                [delegate switchtopecks];
            
        }
        
        else if (buttonIndex==1)
            
        {
        
         enterscreen=TRUE;
            
            
        }

        
    }
    
    
    
    
}
- (BOOL)application: (UIApplication *)application
            openURL: (NSURL *)url
  sourceApplication: (NSString *)sourceApplication
         annotation: (id)annotation {

        return [FBSession.activeSession handleOpenURL:url];
  
    
}

#pragma mark facebook login methods
- (void)openSession
{
    NSArray *permissions =  [[NSArray alloc] initWithObjects:
                                                    @"email",
                                                    nil];
    //  [self addLoaderForViewController: self.login];
    [FBSession openActiveSessionWithReadPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                      [self sessionStateChanged:session state:state error:error];
                                      [self populateUserDetails];
                        self.fbSession = FBSession.activeSession.accessToken;
                  
                    
                                  }];
    
}
- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
   // [self addLoaderForViewController: self.login];
    switch (state)
    {
            
        case FBSessionStateOpen:
        {
          
            
        }
            break;
        case FBSessionStateClosed:{
            
        
        } break;
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
            
           
         
            break;
        default:
            
            break;
    }
    if (error)
    {
     
    }
}
#pragma mark facebook user info get methods
- (void)populateUserDetails
{
   // [self addLoaderForViewController:self.viewController];
    if (FBSession.activeSession.isOpen) {
        NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]init];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"AddLoader" object:nil userInfo: nil];
    //  [self addLoaderForViewController: self.viewController];
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
             
                 DLog(@"userData=%@",user);
                 //DLog(@"[user objectForKey:email]=%@",[user objectForKey:@"email"]);
             
                   DLog(@"userName=%@",user.name);
             [dictionary setObject:user.name forKey:@"fname"];
                 fid=user.id;
                // [dictionary setObject:user.id forKey:@"fid"];
                 DLog(@"userid=%@",user.id);
                imageurl =[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=normal",user.id];
                //  [dictionary setObject:imageurl forKey:@"fimageurl"];
                 
                DLog(@"imageurl=%@",imageurl);
                 NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageurl]];
                 fbimage = [UIImage imageWithData:data];
                 
//                  DLog(@"userImage=%@",image);
                   [dictionary setObject:self.fbSession forKey:@"ftoken"];
              //  [dictionary setObject:imageurl forKey:@"imageurl"];
                // [dictionary setObject:user.link forKey:@"url"];
                 [dictionary setObject:[user objectForKey:@"email"] forKey:@"femail"];
                 //[dictionary setObject:@"facebook" forKey:@"socialType"];
           
                 [[NSNotificationCenter defaultCenter]postNotificationName:@"FacebookUserDetails" object:nil userInfo:dictionary];
                 //self.userNameLabel.text = user.name;
                 //self.userProfileImage.profileID = user.id;
             }
             
             else
             {
                 //
                 DLog(@"error.description=%@",error.description);
                 [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Network is not Reachable" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                 [self removeLoader];
             }
         }];
    }
}
-(void)logoutFacebook
{

    [FBSession.activeSession closeAndClearTokenInformation];
}


#pragma mark loader
-(void)addLoaderForViewController:(UIViewController*)presentController{
    
    [self performSelectorOnMainThread:@selector(final:) withObject:presentController waitUntilDone:YES];
    
    
}

-(void)final:(UIViewController*)presentController
{
    MainView = [[UIView alloc] initWithFrame:CGRectMake(presentController.view.frame.origin.x, presentController.view.frame.origin.y, presentController.view.frame.size.width, presentController.view.frame.size.height)];

    MainView.userInteractionEnabled=NO;
    UIView *disabledView = [[UIView alloc] initWithFrame:CGRectMake(presentController.view.frame.size.width/2-25, presentController.view.frame.size.height/2-25, 50.0, 50.0)];
    disabledView.tag=2311;
    [disabledView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2]];
    
    //[disabledView setBackgroundColor:[UIColor redColor]];
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 25.0f, 25.0f)];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [activityIndicator setCenter:CGPointMake(disabledView.frame.size.width/2, disabledView.frame.size.height/2)];
    activityIndicator.alpha=1.0;
     [activityIndicator startAnimating];
    [disabledView addSubview:activityIndicator];
    [MainView addSubview:disabledView];
    presentView=presentController.view;
    [presentView addSubview:MainView];
    presentView.userInteractionEnabled=NO;

}

-(void)removeLoader
{
   
    presentView.userInteractionEnabled=YES;
    [MainView removeFromSuperview];
    MainView=nil;
    // [disabledView release];
    
}

-(void)hideSplashScreen
{
     [self.splashController.view removeFromSuperview];
    
      
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults valueForKey:@"userid"];
  
   
    DLog(@"uid=%@",uid);
    if (uid!=nil)
    {
        [self homescreen];
    }
    else
    {
        
      self.window.rootViewController = self.navController;
  
    }
}

-(void) homescreen
{
        
    MyHorizon *myhorizon=[[MyHorizon alloc] init];
    
    HomeScreen *homescreen=[[HomeScreen alloc] init];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"myhorizonselect"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"athleticsselect"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"campuseventselect"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"afterhoursselect"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"activityselect"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"diningselect"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"circlesselect"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"settingsselect"];
    
    enterscreen=TRUE;
    firsttimenotification=TRUE;
   
        
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:[_navController viewControllers]];
    //   [viewControllers removeAllObjects];
    [viewControllers addObjectsFromArray:[NSArray arrayWithObjects:homescreen,myhorizon, nil]];
    
    [_navController setViewControllers:viewControllers animated:YES];
    
    self.window.rootViewController = _navController;
    
    
}


- (void)transitionToViewController:(UIView *)view
                    withTransition:(UIViewAnimationOptions)transition
{
    [UIView transitionFromView:self.window.rootViewController.view
                        toView:view
                      duration:0.65f
                       options:transition
                    completion:^(BOOL finished){
                       // self.window.rootViewController = viewController;
                    }];
}
@end
