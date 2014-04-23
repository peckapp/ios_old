//
//  SplashScreenViewController.h
//  scheduudle
//
//  Created by gypsa agarwal on 2/11/13.
//  Copyright (c) 2013 stpl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
@interface SplashScreenViewController : UIViewController
{
    IBOutlet UILabel *label;
    IBOutlet UIImageView *imgView,*imgVw1;
}
@property (strong, nonatomic) IBOutlet UILabel *whatsonTap;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@end
