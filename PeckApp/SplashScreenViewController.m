//
//  SplashScreenViewController.m
//  scheduudle
//
//  Created by gypsa agarwal on 2/11/13.
//  Copyright (c) 2013 stpl. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "AppDelegate.h"
#import "CustomUtility.h"
@implementation SplashScreenViewController
NSInteger i=1;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
     self.whatsonTap.font = [UIFont boldSystemFontOfSize:self.whatsonTap.font.pointSize];
    CGRect deviceDimension = [[UIScreen mainScreen] bounds];
    self.bgView.frame=CGRectMake(self.bgView.frame.origin.x, deviceDimension.size.height/2- self.bgView.frame.size.height/2-25, self.bgView.frame.size.width,  self.bgView.frame.size.height);
    DLog(@"height=%f",self.view.frame.size.height/2- self.bgView.frame.size.height/2);
[NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(sequence) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(goToMainScreen) userInfo:nil repeats:NO];

    
}
-(void) sequence
{
   
 imgView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]];
    i++;
    if (i>=6)
    {
        i=1;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-
#pragma mark timer methods
-(void)goToMainScreen
{
    AppDelegate *appDel=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDel hideSplashScreen];
}
#pragma mark-
#pragma mark animation methods
-(void)showAnimation1
{
    CGRect rect=label.frame;
    rect.origin.y=([[UIScreen mainScreen] bounds].size.height-60)/2;
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationDidStopSelector:@selector(showAnimation2)];
    [UIView setAnimationDelegate:self];
    [label setFrame:rect];
    [UIView commitAnimations];
}

-(void)showAnimation2
{
    //    CGRect rect=imgView.frame;
    //    rect.origin.y=rect.origin.y-100;
    //    [UIView beginAnimations:@"animation" context:nil];
    //    [UIView setAnimationDuration:0.5];
    //    [imgView setFrame:rect];
    //    [UIView setAnimationDidStopSelector:@selector(showAnimation3)];
    //    [UIView setAnimationDelegate:self];
    //    [UIView commitAnimations];
    
    CABasicAnimation *rotation;
    rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
    rotation.duration = 1.0; // Speed
    rotation.repeatCount = 1; // Repeat forever. Can be a finite number.
    [label.layer addAnimation:rotation forKey:@"Spin"];
}


- (void)viewDidUnload
{
    [self setBgView:nil];
    [self setWhatsonTap:nil];
    [super viewDidUnload];
}
@end
