//
//  TwitterView.h
//  PeckApp
//
//  Created by Viresh Kumar Sharma on 8/19/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface PeckView : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *HeaderTitle;
@property (strong, nonatomic) IBOutlet UIWebView *peckwebivew;

-(IBAction)closepeckwebview;
@end
