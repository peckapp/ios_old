//
//  ViewController.h
//  PeckApp
//
//  Created by SRM Techsol Pvt. Ltd. on 5/3/13.
//  Copyright (c) 2013 STPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeScreen.h"
#import "Webservices.h"
#import "AppDelegate.h"

#import "Login.h"
#import "Registration.h"

@interface ViewController : UIViewController<UIScrollViewDelegate>{

  
}


@property (strong, nonatomic) IBOutlet UIScrollView *Backgroundscroller;


-(IBAction)loginscreen:(id)sender;
-(IBAction)registrationscreen:(id)sender;





@end
